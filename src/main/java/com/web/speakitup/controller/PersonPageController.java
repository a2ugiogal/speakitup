package com.web.speakitup.controller;

import java.io.IOException;
import java.sql.Blob;
import java.sql.SQLException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
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
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.web.speakitup._00_init.GlobalService;
import com.web.speakitup.model.MemberBean;
import com.web.speakitup.service.MemberService;


@Controller
@RequestMapping("/personPage")
@MultipartConfig(location = "", fileSizeThreshold = 5 * 1024 * 1024, maxFileSize = 1024 * 1024
* 500, maxRequestSize = 1024 * 1024 * 500 * 5)
public class PersonPageController {
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	ServletContext context;
	
//	@Autowired
//	ArticleService articleService;
	
	//給會員的舊表單
	@GetMapping("/personPage")
	public String personPage(Model model,HttpSession session) {
		
		MemberBean mb = (MemberBean)session.getAttribute("LoginOK");
		model.addAttribute("memberBean", mb);
		return "personPage/personPage";
	}
	
	//修改會員資料
	@PostMapping("/personPage")
	public String updateMember(@ModelAttribute("memberBean")MemberBean mb, Model model,HttpServletRequest request,HttpSession session,BindingResult result) throws IOException, ServletException {
		
		MemberBean mbOld = (MemberBean)session.getAttribute("LoginOK");

		String cancel = request.getParameter("cancel");
		
		//如果沒有取消的話代表新增 就去抓資料
		if(cancel == null) {
			
			//取得檔名及照片
			MultipartFile memberImage = mb.getMemberImage();
			String originalFilename = memberImage.getOriginalFilename();
			Blob memPic;
			//如果檔名跟照片都不是空的 就存起來 
			if (memberImage != null && !memberImage.isEmpty()) {
				try {
					byte[] b = memberImage.getBytes();
					Blob blob = new SerialBlob(b);
					mb.setPicture(blob);
				} catch (Exception e) {
					e.printStackTrace();
					throw new RuntimeException("檔案上傳發生異常：" + e.getMessage());
				}
			}
			
			
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		//城市
		String city = request.getParameter("county");
		//地區
		String area = request.getParameter("district");
		//地址
		String address = request.getParameter("address");
		
		memPic = mb.getPicture();
		System.out.println("000" + memPic);
		MemberBean	mbNew = new MemberBean();
		//先用個笨方法XDD 如果都沒改就一樣更新 但是不要擺檔名跟blob 因為如果原本就有照片會被洗掉
		if(memPic == null) {
			mbNew = new MemberBean(mbOld.getId(),email, phone, city, area, address);
			memberService.updateMemberNoBlob(mbNew);
			mb = memberService.getMember(mbOld.getId());
			session.setAttribute("LoginOK", mb);
			return "redirect:/personPage/personPage";
			
		}else {
		
		mbNew = new MemberBean(mbOld.getId(),email, phone, city, area, address, originalFilename,memPic);
				
		//先更新 再取出新的mb物件  重新裝入LoginOK裡面
		memberService.updateMember(mbNew);
		mb = memberService.getMember(mbOld.getId());
		session.setAttribute("LoginOK", mb);
		
		return "redirect:/personPage/personPage";
		}
		
		}else {
			return "/personPage/personPage";
		}
	}
	

	//取得會員的照片
	@GetMapping("/getUserImage/{id}")
	public ResponseEntity<byte[]> getUserImage(@PathVariable int id,Model model,HttpServletRequest request,
								HttpServletResponse response) throws IOException {
		
		String filepath = "/resources/images/NoImage.jpg";
		byte[] media = null;
		HttpHeaders headers = new HttpHeaders();
		String filename = "";
		int len = 0;
		MemberBean mb = memberService.getMember(id);
	
		
		if (mb != null) {
			Blob blob = mb.getPicture();
			filename = mb.getFileName();
			if (blob != null) {
				try {
					len = (int) blob.length();
					media = blob.getBytes(1, len);
				}catch(SQLException e) {
					throw new RuntimeException("getUserImage發生SQLException"  + e.getMessage());
				}
			}else {
				media = GlobalService.toByteArray(context, filepath);
				filename = filepath;
			}
			
		}else {
			media = GlobalService.toByteArray(context, filepath);
			filename = filepath;
		}
			headers.setCacheControl(CacheControl.noCache().getHeaderValue());
			String mimeType = context.getMimeType(filename);
			MediaType mediaType = MediaType.valueOf(mimeType);
			ResponseEntity<byte[]> responseEntity = new ResponseEntity<byte[]>(media,headers,HttpStatus.OK);
			return responseEntity;
		}
	
	//個人文章
	@GetMapping("/showMyArticles")
	public String getmyArticles(Model model,HttpSession session,HttpServletRequest request) {
		
		String arrange = request.getParameter("arrange") == null ? "" : request.getParameter("arrange");
		String searchStr = request.getParameter("search") == null ? "" : request.getParameter("search");
		
		MemberBean mb = (MemberBean) session.getAttribute("LoginOK");
//		Map<Integer, ArticleBean> articleMap = articleService.getPersonArticles(arrange, searchStr, mb);
		
		request.setAttribute("searchStr", searchStr);
		request.setAttribute("arrange", arrange);
//		request.setAttribute("articles_map", articleMap);
		
		
		return "personPage/myArticles";
	}
}
