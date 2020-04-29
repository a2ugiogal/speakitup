package com.web.speakitup.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Blob;
import java.util.Collection;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.web.speakitup._00_init.GlobalService;
import com.web.speakitup.model.MemberBean;
import com.web.speakitup.service.MemberService;

@Controller
@RequestMapping("/personPage")
public class PersonPageController {
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	ServletContext context;
	
	OutputStream os = null;
	InputStream is = null;
	String fileName = null;
	String mimeType = null;
	Blob blob = null;
	
	@GetMapping("/")
	public String personPage() {
		return "personPage/personPage";
	}
	
	@GetMapping("/getUserImage")
	public String getPersonPic(@RequestParam int id,
								Model model,
								HttpServletRequest request,
								HttpServletResponse response) throws IOException 
	{
		
	System.out.println("memberId:" + id);
	MemberBean mb = memberService.getMember(id);
	try {
		
	if (mb != null) {
		blob = mb.getPicture();
		if (blob != null) {
			is = blob.getBinaryStream();
		}
		fileName = mb.getFileName();
	}
	// 如果圖片的來源有問題，就送回預設圖片(/image/NoImage.jpg)
	if (is == null) {
		fileName = "NoImage.jpg";
		is = context.getResourceAsStream("/image/personPage/" + fileName);
	}
			// 由圖片檔的檔名來得到檔案的MIME型態
			mimeType = context.getMimeType(fileName);
			// 設定輸出資料的MIME型態
			response.setContentType(mimeType);
			// 取得能寫出非文字資料的OutputStream物件
			os = response.getOutputStream();
			// 由InputStream讀取位元組，然後由OutputStream寫出
			int len = 0;
			byte[] bytes = new byte[8192];
			while ((len = is.read(bytes)) != -1) {
				os.write(bytes, 0, len);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			throw new RuntimeException("_00_init.util.GetUserImageServlet#doGet()發生SQLException: " + ex.getMessage());
			} finally {
					if (is != null)
						is.close();
					if (os != null)
						os.close();
			}
		return "personPage/personPage";
			
	}
	
	
	//更新會員資料
	@PostMapping("/updatePersonPage")
	public String updatePersonPage(HttpSession session,Model model,HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException {
		
		MemberBean oldMember = (MemberBean) session.getAttribute("LoginOK");
		int id = oldMember.getId();
		String email = "";
		String city = "";
		String area = "";
		String address = "";
		String phone = "";
		String fileName = oldMember.getFileName();
		Blob blob = oldMember.getPicture();
		long sizeInBytes = 0;
		InputStream is = null;

		// 取出HTTP request內所有的parts
		Collection<Part> parts = request.getParts();
		// 由parts != null來判斷此上傳資料是否為上傳資料的表單(HTTP multipart request)
		if (parts != null) {
			// 逐項讀取使用者輸入資料
			for (Part p : parts) {
				String fldName = p.getName(); // 取得欄位名稱(name)
				String value = request.getParameter(fldName); // 取得欄位值(value)

				if (p.getContentType() == null) {
					if (fldName.equals("cancel")) {
						return "redircet:personPage";
					}
					if (fldName.equals("email")) {
						email = value;
					} else if (fldName.equals("phone")) {
						phone = value;
					} else if (fldName.equals("county")) {
						city = value;
					} else if (fldName.equals("district")) {
						area = value;
					} else if (fldName.equals("address")) {
						address = value;
					}
				} else { // p.getContentType() = application/octet-stream
					// 如果有選擇圖片 => 取得檔名&inputStream
					if (p.getSubmittedFileName().trim().length() != 0) {
						// 取出圖片檔的檔名
						fileName = p.getSubmittedFileName();
						// 調整圖片檔檔名的長度，需要檔名中的附檔名，所以調整主檔名以免檔名太長無法寫入表格
						fileName = GlobalService.adjustFileName(fileName, GlobalService.IMAGE_FILENAME_LENGTH);
						sizeInBytes = p.getSize();
						is = p.getInputStream();
					}
				}
			}
		} else {
			System.out.println("此表單不是上傳檔案的表單(UpdatePersonPageServlet)");
		}
		try {
			// 將圖片轉換成Blob
			if (is != null) {
				blob = GlobalService.fileToBlob(is, sizeInBytes);
			}
			MemberBean mem = new MemberBean(id, null, null, null, null, email, phone, city, area, address, fileName,
					blob, null, null, null, null, null,null,null);

			memberService.updateMember(mem);

			// 更新session內的使用者資料
			MemberBean mb = memberService.getMember(id);
			session.setAttribute("LoginOK", mb);
			return "redirect:/personPage/";
			
		} catch (Exception e) {
			System.out.println("UpdatePersonPageServlet類別的#fileToBlob()例外: " + e.getMessage());
			return "personPage/personPage";
		}
		
	}
}
