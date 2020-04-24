package _01_register.controller;

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
import org.springframework.web.multipart.MultipartFile;

import _00_init.util.GlobalService;
import _00_init.util.SendEmail;
import _01_register.model.MemberBean;
import _01_register.service.MemberService;
import _01_register.validate.RegisterValidator;

@Controller
@RequestMapping("/_01_register")
public class MemberController {

	@Autowired
	ServletContext context;

	public void setContext(ServletContext context) {
		this.context = context;
	}

	@Autowired
	MemberService service;

	public void setService(MemberService service) {
		this.service = service;
	}

//	@GetMapping("/checkEmail")
//	public void checkEmail(Model model, HttpServletRequest request, HttpServletResponse response) {
//		Writer os = null;
//		try {
//			os = response.getWriter();
//			String email = request.getParameter("email");
//			if (email.trim().length() != 0) {
//				boolean exist = service.emailExists(email);
//				if (!exist) {
//					os.write("此信箱可使用");
//				} else {
//					os.write("此信箱已被使用");
//				}
//			}
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
//	}

	@GetMapping("/add")
	public String getAddMember(Model model) {
		MemberBean mb = new MemberBean();
		model.addAttribute("memberBean", mb);
		return "_01_register/register";
	}

	@PostMapping("/add")
	public String addMember(@ModelAttribute("memberBean") MemberBean mb, BindingResult bindingResult,
			HttpServletRequest request, HttpServletResponse response) {

		new RegisterValidator().validate(mb, bindingResult);

		if (bindingResult.hasErrors()) {
			List<ObjectError> list = bindingResult.getAllErrors();
			for (ObjectError error : list) {
				System.out.println("有錯誤：" + error);
			}
			return "_01_register/register";
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

		// 存入圖片
		MultipartFile memberImage = mb.getMemberImage();
		String originalFilename = memberImage.getOriginalFilename();
		mb.setFileName(originalFilename);
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

		// 存入下拉式選單地址
		mb.setCity(request.getParameter("county"));
		mb.setArea(request.getParameter("district"));

		int n = service.saveMember(mb);
		if (n == 1) {
			String subject = null;
			StringBuilder content = new StringBuilder();
			String[] memberEmail = { mb.getEmail() };
			subject = "歡迎你加入要抒啦的會員";
			content.setLength(0);
			content.append("<p>" + "請點選以下連結" + "</p>" + "<br>" + GlobalService.DOMAIN_PATTERN + "/EmailVerify" + "?"
					+ "emailCode=" + authToken + "<br>" + "<p>" + "進入連結後即認證成功，可以去抒發一下了!" + "</p>");

			Thread sendEmail = new SendEmail(memberEmail, subject, content.toString(), "");
//			System.out.println(memberEmail[0]);
			sendEmail.start();

			request.setAttribute("registerOK", "registerOK");

			return "redirect:../index";
		} else {
			System.out.println("更新此筆資料有誤(RegisterServlet)");
			return "_01_register/register";
		}

	}

	@ModelAttribute
	public void commonData(Model model) {
		Map<String, String> genderMap = new HashMap<>();
		genderMap.put("M", "男");
		genderMap.put("F", "女");
		model.addAttribute("genderMap", genderMap);
	}

}
