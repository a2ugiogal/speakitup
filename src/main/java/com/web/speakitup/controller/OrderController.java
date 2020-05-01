package com.web.speakitup.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.web.speakitup.model.MemberBean;
import com.web.speakitup.model.OrderBean;
import com.web.speakitup.model.OrderItemBean;
import com.web.speakitup.model.ProductBean;
import com.web.speakitup.model.ProductFormatBean;
import com.web.speakitup.model.ShoppingCart;
import com.web.speakitup.service.OrderService;
import com.web.speakitup.service.ProductService;

@Controller
@RequestMapping("/order")
public class OrderController {

	@Autowired
	ServletContext context;

	@Autowired
	OrderService orderService;

	@Autowired
	ProductService productService;

	// ==================非管理員===================

	/* 直接購買 */
	@GetMapping("/checkOrder")
	public String checkOrder(Model model, HttpServletRequest request, HttpSession session) {
		// 準備存放錯誤訊息的Map物件
		Map<String, String> errorMsg = new HashMap<String, String>();
		request.setAttribute("errorMsg", errorMsg); // 顯示錯誤訊息

		// 準備新購物車
		ShoppingCart cart = new ShoppingCart();

		// 透過productInfoServlet取得product的session
		String productIdStr = session.getAttribute("productId").toString();
		Integer productId = Integer.parseInt(productIdStr.trim());

		// 透過 service & productId 取得商品資訊
		ProductBean pb = productService.getProduct(productId);

		// 檢查有沒有取得選取規格的值
		String content1 = request.getParameter("content1") == null ? "" : request.getParameter("content1");
		String content2 = request.getParameter("content2") == null ? "" : request.getParameter("content2");
		String qtytr = request.getParameter("qty");

		// 如果沒有的話要再回去商品詳細的頁面
		if (qtytr == null) {
			return "forward:/product/showProductInfo/" + productId;
		}
		Integer qty = Integer.parseInt(qtytr.trim());

		Set<ProductFormatBean> formats = pb.getProductFormat();
		Integer productFormatId = 0;
		for (ProductFormatBean pfb : formats) {
			if (pfb.getFormatContent1().equals(content1) && pfb.getFormatContent2().equals(content2)) {
				// 正確規格，則把productFormatId存下來
				productFormatId = pfb.getProductFormatId();
				// 檢查庫存(不夠=>return)
				if (pfb.getStock() - qty < 0) {
					errorMsg.put("stock", pfb.getFormatContent1() + "  " + pfb.getFormatContent2() + " 庫存量不足!<br>庫存："
							+ pfb.getStock());
					return "forward:/product/showProductInfo/" + productId;
				}
			}
		}

		// 加入此購物車(request)
		OrderItemBean oib = new OrderItemBean(null, productId, pb.getProductName(), content1, content2, pb.getPrice(),
				qty, null);

		cart.addToCart(productFormatId, oib, formats);
		model.addAttribute("ShoppingCart", cart);
		model.addAttribute("buyCartStr", "true");
		session.setAttribute("buyCart", cart);

		return "order/checkOrder";
	}

	/* 前往訂單確認 */
	@GetMapping("/orderList")
	public String orderList() {
		return "order/checkOrder";
	}

	/* 加入購物車 */
	@GetMapping("/shoppingCart")
	public String shoppingCart(Model model, HttpServletRequest request, HttpSession session) {
		// 取出session物件裡的購物車資料
		ShoppingCart cart = (ShoppingCart) session.getAttribute("ShoppingCart");

		// 如果session內沒有購物車物件 就新建一個session物件
		if (cart == null) {
			cart = new ShoppingCart();
			session.setAttribute("ShoppingCart", cart);
		}

		// 取得瀏覽器傳來的資料
		String productIdStr = session.getAttribute("productId").toString();
		Integer productId = Integer.parseInt(productIdStr.trim());

		// 如果無規格讓content的值為空字串，以便與資料庫進行比對
		String content1 = request.getParameter("content1") == null ? "" : request.getParameter("content1");
		String content2 = request.getParameter("content2") == null ? "" : request.getParameter("content2");
		String qtyStr = request.getParameter("qty");
		if (qtyStr == null) {
			return "forward:/product/showProductInfo/" + productId;
		}
		Integer qty = Integer.parseInt(qtyStr.trim());

		// 透過 service & productId 取得商品資訊
		ProductBean pb = productService.getProduct(productId);
		// 取得商品的productFormat，進行比對
		Set<ProductFormatBean> formats = pb.getProductFormat();
		Integer productFormatId = 0;
		for (ProductFormatBean pfb : formats) {
			if (pfb.getFormatContent1().equals(content1) && pfb.getFormatContent2().equals(content2)) {
				// 正確規格，則把productFormatId存下來
				productFormatId = pfb.getProductFormatId();

			}
		}
		// 如果找不到規格相同的商品，就不做事
		if (productFormatId == 0) {
			return "forward:/product/showProductInfo/" + productId;
		}
		// 把資料封裝進OrderItemBean
		OrderItemBean oib = new OrderItemBean(null, productId, pb.getProductName(), content1, content2, pb.getPrice(),
				qty, null);
		// 為了之後能抓選取的勾勾(預設為勾起來)[y, n]
		cart.addToCart(productFormatId, oib, formats);

		return "forward:/product/showProductInfo/" + productId;
	}

	/* 前往購物車 */
	@GetMapping("/shoppingCartList")
	public String shoppingCartList() {
		return "order/shoppingCart";
	}

	/* 修改購物車內的商品資料(刪除商品、修改數量、修改規格、修改單選、修改全選) */
	@PostMapping("/updateShoppingCart")
	public String updateShoppingCart(HttpServletRequest request, HttpSession session) {
		// 如果找不到購物車(通常是Session逾時)，回到首頁
		ShoppingCart sc = (ShoppingCart) session.getAttribute("ShoppingCart");
		if (sc == null) {
			return "redirect:/";
		}

		// cmd可能是DEL或是QTY或是FMT或是CHS或是CSA
		String cmd = request.getParameter("cmd");
		String productFormatIdStr = request.getParameter("productFormatId");
		int productFormatId = 0;
		if (productFormatIdStr != null) {
			productFormatId = Integer.parseInt(productFormatIdStr);
		}

		if (cmd.equalsIgnoreCase("DEL")) {
			// 刪除購物車內的某項商品
			sc.deleteProduct(productFormatId);
		} else if (cmd.equalsIgnoreCase("QTY")) {
			// 修改某項商品的數量
			String newQtyStr = request.getParameter("newQty");
			int newQty = Integer.parseInt(newQtyStr.trim());
			sc.changeQty(productFormatId, newQty);
		} else if (cmd.equalsIgnoreCase("FMT")) {
			// 修改某項商品的規格
			String[] newFmt = request.getParameter("newFmt").split(",");
			String content1 = null;
			String content2 = null;
			if (newFmt.length == 2) {
				content1 = newFmt[0];
				content2 = newFmt[1];
			} else if (newFmt.length == 1) {
				content1 = newFmt[0];
			}
			sc.changeFormat(productFormatId, content1, content2);
		} else if (cmd.equalsIgnoreCase("CHS")) {
			// 修改某項商品的選擇項
			String choose = request.getParameter("choose");
			sc.changeChecked(productFormatId, choose);
		} else if (cmd.equalsIgnoreCase("CSA")) {
			// 修改全部商品的選擇項
			String chooseAll = request.getParameter("chooseAll");
			sc.changeAllChecked(chooseAll);
		}
		return "order/shoppingCart";
	}

	/* 儲存會員的訂單 */
	@GetMapping("/orderCheck")
	public String orderCheck(Model model, HttpServletRequest request, HttpSession session) {
		// 準備存放錯誤訊息的Map物件
		Map<String, String> errorMsg = new HashMap<String, String>();
		request.setAttribute("errorMsg", errorMsg); // 顯示錯誤訊息

		MemberBean mb = (MemberBean) session.getAttribute("LoginOK");
		String buyCartStr = request.getParameter("buyCartStr");
		ShoppingCart cart = (ShoppingCart) session.getAttribute("ShoppingCart");

		// 篩選cart，如果是按直接購買
		if (buyCartStr.equals("true")) {
			cart = (ShoppingCart) session.getAttribute("buyCart");
		}

		// 如果購物車是空的 跳轉回首頁 但到時候可能在刪除時直接跳轉首頁
		if (cart == null) {
			return "redirect:/";
		}

		// 從瀏覽器取得訂購資料
		Integer memberId = mb.getId();
		String memberName = request.getParameter("name"); // 訂購人姓名 跟資料庫的不一樣
		Integer totalPrice = cart.getFinalSubtotal();
		String city = request.getParameter("county"); // 訂購人地址
		String area = request.getParameter("district"); // 訂購人地址
		String address = request.getParameter("address"); // 訂購人地址
		String phone = request.getParameter("phone"); // 訂購人電話
		String note = request.getParameter("note"); // 訂單備註
		Date today = new Date();
		// 封裝進OrderBean
		OrderBean ob = new OrderBean(null, memberId, memberName, totalPrice, city + area + address, phone, note, today,
				null, null, "待出貨", null);

		Map<Integer, Map<OrderItemBean, Set<ProductFormatBean>>> content = cart.getContent();
		Map<Integer, String> finalContent = cart.getCheckedMap();
		Set<Integer> set = content.keySet();
		Set<Integer> checkedSet = cart.getCheckedMap().keySet();

		// 篩選有被勾選的OrderItemBean裝入set內
		Set<OrderItemBean> items = new LinkedHashSet<>();
		for (Integer i : set) {
			for (Integer j : checkedSet) {
				if (i.equals(j) && finalContent.get(j).equals("y")) {
					Map<OrderItemBean, Set<ProductFormatBean>> orderMap = content.get(i);
					OrderItemBean oib = orderMap.keySet().iterator().next();
					// 檢查庫存
					ProductBean pb = productService.getProduct(oib.getProductId());
					Set<ProductFormatBean> formats = pb.getProductFormat();
					for (ProductFormatBean pfb : formats) {
						if (pfb.getFormatContent1().equals(oib.getFormatContent1())
								&& pfb.getFormatContent2().equals(oib.getFormatContent2())) {
							if (pfb.getStock() - oib.getQuantity() < 0) {
								errorMsg.put("stock", pb.getProductName() + "的" + pfb.getFormatContent1() + " "
										+ pfb.getFormatContent2() + " 庫存量不足!<br>庫存：" + pfb.getStock());

								return "order/shoppingCart";
							}
						}
					}
					oib.setOrderBean(ob);
					items.add(oib);
				}
			}

		}
		// 裝入OrderBean
		ob.setOrderItems(items);

		try {
			// 儲存OrderBean
			// 如果是按直接購買=>刪除購物車(假)
			if (buyCartStr.equals("true")) {
				orderService.persistOrder(ob);
				session.removeAttribute("buyCart");
			} else {
				orderService.persistOrder(ob, cart);
			}
//			return "forward:/order/creditCard";
			return "redirect:/order/orderSuccessPage";
		} catch (RuntimeException ex) {
			ex.printStackTrace();
			String message = ex.getMessage();
			String shortMessage = "";
			shortMessage = message.substring(message.indexOf(":") + 1);
			session.setAttribute("OrderErrorMsg", "訂單發生異常" + shortMessage + "請更正訂單內容");

			return "redirect:/";
		}
	}

	/* 前往訂單成功 */
	@GetMapping("/orderSuccessPage")
	public String orderSuccessPage() {
		return "order/orderSuccess";
	}

	/* 查詢歷史訂單 */
	@GetMapping("/showHistoryOrder")
	public String showHistoryOrder(Model model, HttpSession session) {
		// 取得使用者資料(MemberBean)
		MemberBean mb = (MemberBean) session.getAttribute("LoginOK");
		Integer memberId = mb.getId();
		// 取得使用者的訂單資料(OrderBean)
		List<OrderBean> orders = orderService.getMemberOrders(memberId);

		// 取出訂單詳細資料(OrderItemBean)
		Map<Integer, Set<OrderItemBean>> orderItemGroup = new HashMap<Integer, Set<OrderItemBean>>();
		for (OrderBean ob : orders) {
			int orderNo = ob.getOrderNo();
			Set<OrderItemBean> OrderItemBeans = ob.getOrderItems();
			orderItemGroup.put(orderNo, OrderItemBeans);
		}

		model.addAttribute("order_list", orders);
		model.addAttribute("orderItem_map", orderItemGroup);

		return "order/historyOrder";
	}

	// ==================管理員===================

	/* 查詢訂單 */
	@GetMapping("/showOrders")
	public String showOrders(Model model, HttpServletRequest request) {
		// 必須是空字串
		String searchStr = request.getParameter("searchStr") == null ? "" : request.getParameter("searchStr");

		List<OrderBean> orders = orderService.getAllOrders(searchStr);
		// 取出訂單詳細資料(OrderItemBean)
		Map<Integer, Set<OrderItemBean>> orderItemGroup = new HashMap<Integer, Set<OrderItemBean>>();
		for (OrderBean ob : orders) {
			int orderNo = ob.getOrderNo();
			Set<OrderItemBean> OrderItemBeans = ob.getOrderItems();
			orderItemGroup.put(orderNo, OrderItemBeans);
		}

		model.addAttribute("searchStr", searchStr);
		model.addAttribute("order_list", orders);
		model.addAttribute("orderItem_map", orderItemGroup);

		return "manager/order/allOrders";
	}

	/* 新增出貨日期or到貨日期 */
	@GetMapping("/addOrderDate")
	public String addOrderDate(HttpServletRequest request) {
		// 必須是空字串
		String searchStr = request.getParameter("searchStr").equals("undefined") ? ""
				: request.getParameter("searchStr");
		String cmd = request.getParameter("cmd");
		String idStr = request.getParameter("id");
		int id = Integer.parseInt(idStr);

		OrderBean ob = orderService.getOrder(id);
		Date today = new Date();
		// 更新狀態
		if (cmd.equals("shippingDate")) {
			ob.setShippingDate(today);
			ob.setStatus("已出貨");
			orderService.insertOrder(ob);
		} else if (cmd.equals("arriveDate")) {
			ob.setArriveDate(today);
			ob.setStatus("完成");
			orderService.insertOrder(ob);
		}
		return "redirect:/order/showOrders?searchStr=" + searchStr;
	}
}