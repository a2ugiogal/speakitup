package com.web.speakitup.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Blob;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.speakitup.model.MemberBean;
import com.web.speakitup.service.MemberService;

@Controller
@RequestMapping("/personPage")
public class PersonPageController {
	
	@Autowired
	MemberService MemberService;
	
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
	public String getPersonPic(@RequestParam int id,Model model,HttpServletRequest request,HttpServletResponse response) throws IOException {
		
	System.out.println("memberId:" + id);
	MemberBean mb = MemberService.getMember(id);
	try {
		
	if (mb != null) {
		blob = mb.getPicture();
		if (blob != null) {
			is = blob.getBinaryStream();
		}
		fileName = mb.getFileName();
	}
	// 如果圖片的來源有問題，就送回預設圖片(/images/NoImage.jpg)
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
}
