package com.web.speakitup.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.Clob;
import java.sql.SQLException;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.CacheControl;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.web.speakitup._00_init.GlobalService;
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
	@GetMapping("/ShowPageProducts")
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
		Map<Integer, ProductBean> productMap = productService.getPageProducts(pageNo, arrange, searchStr, categoryTitle,
				categoryName);

		model.addAttribute("searchStr", searchStr);
		model.addAttribute("arrange", arrange);
		model.addAttribute("categoryTitle", categoryTitle);
		model.addAttribute("categoryName", categoryName);
		model.addAttribute("pageNo", String.valueOf(pageNo));
		model.addAttribute("totalPages", productService.getTotalPages(searchStr, categoryTitle, categoryName));
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

	/* 查詢熱門商品 */
	@GetMapping("/ShowFamousProducts")
	public String showFamousProducts(Model model) {
		Map<Integer, ProductBean> angelProductMap = productService.getFamousProducts("天使");
		Map<Integer, ProductBean> evilProductMap = productService.getFamousProducts("惡魔");

		model.addAttribute("angel_products_map", angelProductMap);
		model.addAttribute("evil_products_map", evilProductMap);

		return "product/productFamous";
	}

	/* 查詢商品詳細資料 */
	@GetMapping("/ShowProductInfo/{productId}")
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

	/* 取得圖片 */
	@GetMapping("/getProductImage/{productId}")
	public ResponseEntity<byte[]> getProductImage(Model model, @PathVariable("productId") Integer productId) {
		/* 從webapp開始算 */
		String filePath = "/resources/images/NoImage.jpg";

		Blob blob = null;
		String fileName = "";
		byte[] media = null;
		int len = 0;
		HttpHeaders headers = new HttpHeaders();
		ProductBean bean = productService.getProduct(productId);

		if (bean != null) {
			blob = bean.getImage();
			fileName = bean.getFileName();
			if (blob != null) {
				try {
					len = (int) blob.length();
					media = blob.getBytes(1, len);
				} catch (SQLException e) {
					throw new RuntimeException("ProductController的getProductImage()發生SQLException: " + e.getMessage());
				}
			}
			media = toByteArray(filePath);
			fileName = filePath;
		} else {
			media = toByteArray(filePath);
			fileName = filePath;
		}
		headers.setCacheControl(CacheControl.noCache().getHeaderValue());
		String mimeType = context.getMimeType(fileName);
		MediaType mediaType = MediaType.valueOf(mimeType);
		headers.setContentType(mediaType);

		ResponseEntity<byte[]> responseEntity = new ResponseEntity<>(media, headers, HttpStatus.OK);
		return responseEntity;
	}

	private byte[] toByteArray(String filepath) {
		byte[] b = null;
		String realPath = context.getRealPath(filepath);
		try {
			File file = new File(realPath);
			long size = file.length();
			b = new byte[(int) size];
			InputStream fis = context.getResourceAsStream(filepath);
			fis.read(b);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return b;
	}
	// ==================管理員===================

}
