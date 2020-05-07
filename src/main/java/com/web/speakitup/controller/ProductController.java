package com.web.speakitup.controller;

import java.io.IOException;
import java.sql.Blob;
import java.sql.Clob;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.rowset.serial.SerialBlob;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.CacheControl;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.web.speakitup._00_init.GlobalService;
import com.web.speakitup.model.CategoryBean;
import com.web.speakitup.model.MemberBean;
import com.web.speakitup.model.ProductBean;
import com.web.speakitup.model.ProductFormatBean;
import com.web.speakitup.service.ProductService;

@Controller
@RequestMapping("/product")
public class ProductController {

	@Autowired
	ServletContext context;

	@Autowired
	ProductService productService;

	// ==================非管理員===================
	
	
	/* 查詢指定商品(搜尋、排序、頁碼) */
	@GetMapping("/showPageProducts")
	public String showPageProducts(Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		int pageNo = 1;
		int memberId = 0;

		MemberBean mb = (MemberBean) session.getAttribute("LoginOK");
		// 如果未登入，就memberId=0(訪客Id)
		if (mb == null) {
			memberId = 0;
		} else {
			// 登入成功後，Session範圍內才會有LoginOK對應的MemberBean物件
			// 取出使用者的memberId，後面的Cookie會用到
			memberId = mb.getId();
		}

		// 讀取瀏覽器送來的搜尋條件
		String pageNoStr = request.getParameter("pageNo");
		String arrange = request.getParameter("arrange") == null ? "" : request.getParameter("arrange");
		String searchStr = request.getParameter("search") == null ? "" : request.getParameter("search");
		String categoryTitle = request.getParameter("categoryTitle") == null ? ""
				: request.getParameter("categoryTitle");
		String categoryName = request.getParameter("categoryName") == null ? "" : request.getParameter("categoryName");
		Integer totalPages = productService.getTotalPages(searchStr, categoryTitle, categoryName);

		// 如果讀不到(之前沒點擊過商品區)
		if (pageNoStr == null) {
			pageNo = 1;
			// 讀取瀏覽器送來的所有 Cookies
			Cookie[] cookies = request.getCookies();
			if (cookies != null) {
				// 逐筆檢視Cookie內的資料
				for (Cookie c : cookies) {
					if (c.getName().equals(memberId + "pageNo")) {
						try {
							pageNo = Integer.parseInt(c.getValue().trim());
							if (totalPages < pageNo) {
								pageNo = 1;
							}
						} catch (NumberFormatException e) {
							;
						}
						break;
					}
				}
			}
		} else {
			try {
				pageNo = Integer.parseInt(pageNoStr.trim());
			} catch (NumberFormatException e) {
				pageNo = 1;
			}
		}
		// 有輸入搜尋字串或有選排序
		if (pageNo == -1) {
			pageNo = 1;
		}
		
		// 取得本頁商品資料(Map<Integer, ProductBean>)
		Map<ProductBean, String> productMap = productService.getPageProducts(pageNo, arrange, searchStr, categoryTitle,
				categoryName);

		model.addAttribute("searchStr", searchStr);
		model.addAttribute("arrange", arrange);
		model.addAttribute("categoryTitle", categoryTitle);
		model.addAttribute("categoryName", categoryName);
		model.addAttribute("pageNo", String.valueOf(pageNo));
		model.addAttribute("totalPages", totalPages);
		model.addAttribute("products_map", productMap);

		// 如果不是搜尋全部商品(沒有搜尋字串 and 沒有搜尋類別)=>不記錄到Cookie
		// 使用Cookie來儲存目前讀取的網頁編號，Cookie的名稱為memberId + "pageNo"
		// -----------------------
		if (searchStr == "" && categoryTitle == "" && categoryName == "") {
			Cookie pageNoCookie = new Cookie(memberId + "pageNo", String.valueOf(pageNo));
			// 設定Cookie的存活期為30天
			pageNoCookie.setMaxAge(30 * 24 * 60 * 60);
			// 設定Cookie的路徑為 Context Path
			pageNoCookie.setPath(request.getContextPath());
			// 將Cookie加入回應物件內
			response.addCookie(pageNoCookie);
		}

		return "product/productList";
	}

	/* 查詢商品詳細資料 */
	@GetMapping("/showProductInfo/{productId}")
	public String showProductInfo(Model model, @PathVariable("productId") Integer productId, HttpSession session) {

		Clob clob = null;
		String detail = "";
		ProductFormatBean firstProductFormat = null;

		// 取得商品資料(ProductBean)
		ProductBean pb = productService.getProduct(productId);

		// 取出規格
		Set<String> contentSet1 = new HashSet<String>();
		Set<String> contentSet2 = new HashSet<String>();
		if (pb != null) {
			// 取得商品詳細資料(ProductFormatBean)
			Set<ProductFormatBean> formats = pb.getProductFormat();
			// 使用iterator取出第一筆規格資料
			Iterator<ProductFormatBean> iterator = formats.iterator();
			if (iterator.hasNext()) {
				firstProductFormat = iterator.next();
			}
			// 取得第一項的titles
			String title1 = firstProductFormat.getFormatTitle1();
			String title2 = firstProductFormat.getFormatTitle2();
			for (ProductFormatBean pfb : formats) {
				// 利用set不重複性存入商品規格
				contentSet1.add(pfb.getFormatContent1());
				contentSet2.add(pfb.getFormatContent2());
			}
			// 取得detail並轉成字串輸出
			try {
				clob = pb.getDetail();
				if (clob != null) {
					detail = GlobalService.clobToString(clob);
				}
			} catch (SQLException | IOException ex) {
				ex.printStackTrace();
			}

			model.addAttribute("product", pb);
			model.addAttribute("title1", title1);
			model.addAttribute("content1", contentSet1);
			model.addAttribute("title2", title2);
			model.addAttribute("content2", contentSet2);
			model.addAttribute("detail", detail);
			session.setAttribute("productId", productId);

			return "product/productInfo";
		} else { // 如果找不到Id，回商城首頁
			return "redirect:index";
		}
	}

	/* 查詢熱門商品 */
	@GetMapping("/productHome")
	public String showFamousProducts(Model model) {
		int productIdTop;
		List<Integer> topProductList = new ArrayList<Integer>();
		List<Integer> botProductList = new ArrayList<Integer>();
		
		Map<Integer, ProductBean> angelProductMap = productService.getFamousProducts("天使");
		Map<Integer, ProductBean> evilProductMap = productService.getFamousProducts("惡魔");
		for(int i = 0;i<3;i++) {
			productIdTop = (int)(Math.random() * 10);
			topProductList.add(productIdTop);
			botProductList.add(productIdTop + 10);
		}
		System.out.println(topProductList);
		System.out.println(botProductList);
		model.addAttribute("angel_products_map", angelProductMap);
		model.addAttribute("evil_products_map", evilProductMap);
		
		model.addAttribute("top_product_list", topProductList);
		model.addAttribute("bot_product_list", botProductList);
		
		return "product/productHome";
	}

	/* 取得圖片 */
	@GetMapping("/getProductImage/{productId}")
	public ResponseEntity<byte[]> getProductImage(Model model, @PathVariable("productId") Integer productId) {
		/* 從webapp開始算 */
		String filePath = "/resources/images/NoImage.jpg";

		byte[] media = null;
		HttpHeaders headers = new HttpHeaders();
		String fileName = "";
		int len = 0;
		ProductBean bean = productService.getProduct(productId);
		if (bean != null) {
			Blob blob = bean.getImage();
			fileName = bean.getFileName();
			if (blob != null) {
				try {
					len = (int) blob.length();
					media = blob.getBytes(1, len);
				} catch (SQLException e) {
					throw new RuntimeException("ProductController的getProductImage()發生SQLException: " + e.getMessage());
				}
			} else {
				media = GlobalService.toByteArray(context, filePath);
				fileName = filePath;
			}
		} else {
			media = GlobalService.toByteArray(context, filePath);
			fileName = filePath;
		}

		headers.setCacheControl(CacheControl.noCache().getHeaderValue());
		String mimeType = context.getMimeType(fileName);
		MediaType mediaType = MediaType.valueOf(mimeType);
		headers.setContentType(mediaType);

		ResponseEntity<byte[]> responseEntity = new ResponseEntity<>(media, headers, HttpStatus.OK);
		return responseEntity;
	}

	@ModelAttribute("angelCategoryList")
	public List<String> getAngelCategory() {
		Set<CategoryBean> angelBeans = productService.getCategorys("天使");
		List<String> list = new ArrayList<String>();
		for (CategoryBean bean : angelBeans) {
			list.add(bean.getCategoryName());
		}
		return list;
	}

	@ModelAttribute("evilCategoryList")
	public List<String> getEvilCategory() {
		Set<CategoryBean> evilBeans = productService.getCategorys("惡魔");
		List<String> list = new ArrayList<String>();
		for (CategoryBean bean : evilBeans) {
			list.add(bean.getCategoryName());
		}
		return list;
	}

	// ==================管理員===================

	/* 查詢商品 */
	@GetMapping("/showProducts")
	public String showProducts(Model model, HttpServletRequest request) {
		String searchStr = request.getParameter("searchStr") == null ? "" : request.getParameter("searchStr");
		String categoryTitle = request.getParameter("categoryTitle") == null ? "天使"
				: request.getParameter("categoryTitle");

		Map<Integer, ProductBean> products = productService.getProducts(searchStr, categoryTitle);

		model.addAttribute("searchStr", searchStr);
		model.addAttribute("categoryTitle", categoryTitle);
		model.addAttribute("product_map", products);
		return "manager/product/allProducts";
	}

	/* 查詢商品詳細資料 */
	@GetMapping("/addProduct/{productId}")
	public String showManageProductInfo(Model model, HttpServletRequest request,
			@PathVariable("productId") Integer productId) {
		if (productId != 0 && productId != null) {
			// 修改商品
			String detail = "";
			String title1 = "";
			String title2 = "";
			Set<String> contentSet1 = new HashSet<String>();
			Set<String> contentSet2 = new HashSet<String>();

			ProductBean pb = productService.getProduct(productId);
			if (pb != null) {
				// 取得商品詳細資料(ProductFormatBean)
				Set<ProductFormatBean> formats = pb.getProductFormat();
				// 使用iterator取出第一筆規格資料
				Iterator<ProductFormatBean> iterator = formats.iterator();
				ProductFormatBean firstProductFormat = null;
				if (iterator.hasNext()) {
					firstProductFormat = iterator.next();
				}
				// 取得第一項的titles
				title1 = firstProductFormat.getFormatTitle1();
				title2 = firstProductFormat.getFormatTitle2();
				for (ProductFormatBean pfb : formats) {
					// 利用set不重複性存入商品規格
					contentSet1.add(pfb.getFormatContent1());
					contentSet2.add(pfb.getFormatContent2());
				}
				// 取得detail並轉成字串輸出
				try {
					Clob clob = pb.getDetail();
					if (clob != null) {
						detail = GlobalService.clobToString(clob).replace("<br>", "\n");
					}
				} catch (SQLException | IOException ex) {
					ex.printStackTrace();
				}
			}
			// ?
			model.addAttribute("product", pb);

			model.addAttribute("title1", title1);
			model.addAttribute("content1_set", contentSet1);
			model.addAttribute("title2", title2);
			model.addAttribute("content2_set", contentSet2);
			model.addAttribute("detail", detail);

			model.addAttribute("productBean", pb);
		} else {
			// 新增商品
			ProductBean pb = new ProductBean();
			model.addAttribute("productBean", pb);
		}
		Set<CategoryBean> angelProductCategorys = productService.getCategorys("天使");
		Set<CategoryBean> evilProductCategorys = productService.getCategorys("惡魔");

		model.addAttribute("angel_set", angelProductCategorys);
		model.addAttribute("evil_set", evilProductCategorys);
		model.addAttribute("productId", productId);

		return "manager/product/productInfo";
	}

	/* 新增or修改商品 */
	@PostMapping("/addProduct/{productId}")
	public String addProduct(Model model, HttpServletRequest request, @ModelAttribute("productBean") ProductBean pb,
			@PathVariable("productId") Integer productId) {
		Integer categoryId = Integer.parseInt(request.getParameter("categoryId").trim());
		String formatTitle1 = request.getParameter("formatTitle1");
		Set<String> formatContents1 = new LinkedHashSet<String>();
		for (String formatContent : request.getParameterValues("formatContent1")) {
			formatContents1.add(formatContent.trim());
		}
		String formatTitle2 = request.getParameter("formatTitle2");
		Set<String> formatContents2 = new LinkedHashSet<String>();
		for (String formatContent : request.getParameterValues("formatContent2")) {
			formatContents2.add(formatContent.trim());
		}
		List<Integer> stocks = new ArrayList<>();
		for (String stockStr : request.getParameterValues("stock")) {
			stocks.add(Integer.parseInt(stockStr.trim()));
		}
		String detail = request.getParameter("detailStr");

		// 存入圖片
		MultipartFile productImage = pb.getProductImage();
		if (productImage != null && !productImage.isEmpty()) {
			try {
				byte[] b = productImage.getBytes();
				Blob blob = new SerialBlob(b);
				pb.setImage(blob);
				pb.setFileName(productImage.getOriginalFilename());
			} catch (Exception e) {
				e.printStackTrace();
				throw new RuntimeException("檔案上傳發生異常：" + e.getMessage());
			}
		}

		try {
			pb.setCategory(productService.getCategory(categoryId));
			pb.setDetail(GlobalService.stringToClob(detail));
			if (productId != 0) {
				// 修改商品
				// 刪除原本規格，新增新的規格
				productService.deleteProductFormat(pb);
			} else {
				// 新增商品
				// 新增銷量
				pb.setSales(0);
			}
			int count = 0;
			Set<ProductFormatBean> productFormats = new LinkedHashSet<>();
			for (String formatContent1 : formatContents1) {
				for (String formatContent2 : formatContents2) {
					ProductFormatBean pfb = new ProductFormatBean(null, formatTitle1, formatContent1, formatTitle2,
							formatContent2, stocks.get(count), pb);
					productFormats.add(pfb);
					count++;
				}
			}
			pb.setProductFormat(productFormats);

			productService.insertProduct(pb);

			return "redirect:/product/showProducts";
		} catch (Exception e) {
			e.printStackTrace();
			return "forward:/product/showProducts";
		}
	}

	/* 刪除商品 */
	@GetMapping("/deleteProduct/{productId}")
	public String deleteProduct(Model model, HttpServletRequest request, @PathVariable("productId") Integer productId) {
		ProductBean bean = productService.getProduct(productId);
		// 如果刪除後重新整理(bean==null)，不做刪除
		if (bean != null) {
			productService.deleteProduct(productId);
		}

		return "redirect:/product/showProducts";
	}
}
