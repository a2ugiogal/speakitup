package com.web.speakitup.controller;

import java.io.IOException;
import java.io.Writer;
import java.sql.Blob;
import java.sql.Date;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.rowset.serial.SerialBlob;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.web.speakitup._00_init.GlobalService;
import com.web.speakitup._00_init.SendEmail;
import com.web.speakitup.model.MemberBean;
import com.web.speakitup.service.MemberService;
import com.web.speakitup.validate.RegisterValidator;

@Controller
@RequestMapping("/register")
public class RegisterController {

	@Autowired
	ServletContext context;

	@Autowired
	MemberService memberService;

	@GetMapping("/add")
	public String getAddMember(Model model) {
		MemberBean mb = new MemberBean();
		model.addAttribute("memberBean", mb);
		return "register/register";
	}

	@PostMapping("/add")
	public String addMember(@ModelAttribute("memberBean") MemberBean mb, BindingResult bindingResult,
			HttpServletRequest request, HttpServletResponse response) {

		new RegisterValidator(memberService).validate(mb, bindingResult);

		if (bindingResult.hasErrors()) {
			List<ObjectError> list = bindingResult.getAllErrors();
			for (ObjectError error : list) {
				System.out.println("有錯誤：" + error);
			}
			return "register/register";
		}

		// 日期轉換格式
		try {
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
			java.util.Date date = simpleDateFormat.parse(mb.getBirthday().toString());
			mb.setBirthday(new Date(date.getTime()));
		} catch (ParseException e) {
			e.printStackTrace();
		}

		// 密碼加密
		mb.setPassword(GlobalService.getMD5Endocing(GlobalService.encryptString(mb.getPassword())));

		// 信箱加密
		String authToken = GlobalService.getMD5Endocing(GlobalService.encryptString(mb.getEmail()));
		mb.setAuthToken(authToken);

		// 存入現在時間
		mb.setCreateTime(new Timestamp(System.currentTimeMillis()));

		// 存入預設資料
		mb.setPermission("一般會員");
		mb.setStatus("未驗證");

		// 存入圖片
		MultipartFile memberImage = mb.getMemberImage();
		if (memberImage != null && !memberImage.isEmpty()) {
			try {
				byte[] b = memberImage.getBytes();
				Blob blob = new SerialBlob(b);
				mb.setPicture(blob);
				mb.setFileName(memberImage.getOriginalFilename());
			} catch (Exception e) {
				e.printStackTrace();
				throw new RuntimeException("檔案上傳發生異常：" + e.getMessage());
			}
		}

		// 存入下拉式選單地址
		mb.setCity(request.getParameter("county"));
		mb.setArea(request.getParameter("district"));

		int n = memberService.saveMember(mb);

		if (n == 1) {
			// 寄信
			String subject = null;
			StringBuilder content = new StringBuilder();
			String[] memberEmail = { mb.getEmail() };
			subject = "歡迎你加入要抒啦的會員";
			content.setLength(0);
			content.append("<p>" + "請點選以下連結" + "</p>" + "<br>" + GlobalService.DOMAIN_PATTERN + "/register/emailVerify"
					+ "?" + "emailCode=" + authToken + "<br>" + "<p>" + "進入連結後即認證成功，可以去抒發一下了!" + "</p>");

			Thread sendEmail = new SendEmail(memberEmail, subject, content.toString(), "");
			sendEmail.start();

			return "redirect:../";
		} else {
			System.out.println("更新此筆資料有誤(RegisterServlet)");
			return "register/register";
		}

	}

	// 檢查信箱
	@GetMapping("/add/checkEmail")
	public void checkEmail(@RequestParam("email") String email, HttpServletResponse response) {
		response.setCharacterEncoding("UTF-8");
		Writer os = null;
		try {
			os = response.getWriter();
			if (email.trim().length() != 0) {
				boolean exist = memberService.emailExists(email);
				if (!exist) {
					os.write("此信箱可使用");
				} else {
					os.write("此信箱已被註冊");
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return;
	}

	// 檢查memberId
	@GetMapping("/add/checkUserName")
	public void checkUserName(@RequestParam("userName") String userName, HttpServletResponse response) {
		response.setCharacterEncoding("UTF-8");
		Writer os = null;
		try {
			os = response.getWriter();
			if (userName.trim().length() != 0) {
				boolean exist = memberService.idExists(userName);
				if (!exist) {
					os.write("此帳號已存在");
				} else {
					os.write("此帳號已被使用");
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return;
	}

	@GetMapping("/emailVerify")
	public String emailVerify(HttpServletRequest request, HttpSession session) {
		StringBuilder content = new StringBuilder();
		// 取得信件內連結的queryString
		String queryString = request.getQueryString();

		// 把搜尋字串前面的字拿掉，取得後面的字串方便與資料庫進行比對
		String emailVerifyCode = queryString.replaceAll("emailCode=", "");

		MemberBean mb = null;

		// 透過service的方法得到與驗證碼相同的MemberBean物件
		mb = memberService.getEmailValid(emailVerifyCode);

		// 如果有取得mb物件，就要把資料庫內的表格CheckAuthSuccess(是否驗證成功)改為y(yes)
		if (mb != null) {
			if (mb.getStatus().trim().equals("未驗證")) {
				mb.setStatus("正常");
				;
			}
			memberService.updateMember(mb);
			session.setAttribute("LoginOK", mb);
		} else {
			content.append("<li>" + "資料發生異常，請再試一次" + "</li>");
		}

		return "redirect:../";
	}

	@ModelAttribute
	public void commonData(Model model) {
		Map<String, String> genderMap = new HashMap<>();
		genderMap.put("男", "男");
		genderMap.put("女", "女");
		model.addAttribute("genderMap", genderMap);
	}

}
