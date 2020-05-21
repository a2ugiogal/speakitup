package com.web.speakitup.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Blob;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
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
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.web.speakitup._00_init.GlobalService;
import com.web.speakitup._00_init.SendEmail;
import com.web.speakitup.model.ArticleBean;
import com.web.speakitup.model.CommentBean;
import com.web.speakitup.model.MemberBean;
import com.web.speakitup.service.ArticleService;
import com.web.speakitup.service.MemberService;
import com.web.speakitup.validate.RegisterValidator;

@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired
	ServletContext context;

	@Autowired
	MemberService memberService;

	@Autowired
	ArticleService articleService;

	/* 取得會員的照片 */
	@GetMapping("/getUserImage/{id}")
	public ResponseEntity<byte[]> getUserImage(@PathVariable int id, Model model, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String filepath = "/resources/images/personPage/headPicture.jpg";
		byte[] media = null;
		HttpHeaders headers = new HttpHeaders();
		String filename = "";
		int len = 0;
		MemberBean mb = memberService.getMember(id);

		// 取得照片跟檔名
		if (mb != null) {
			Blob blob = mb.getPicture();
			filename = mb.getFileName();
			if (blob != null) {
				try {
					len = (int) blob.length();
					media = blob.getBytes(1, len);
				} catch (SQLException e) {
					throw new RuntimeException("getUserImage發生SQLException" + e.getMessage());
				}
			} else {
				media = GlobalService.toByteArray(context, filepath);
				filename = filepath;
			}

		} else {
			media = GlobalService.toByteArray(context, filepath);
			filename = filepath;
		}
		headers.setCacheControl(CacheControl.noCache().getHeaderValue());
		String mimeType = context.getMimeType(filename);
		MediaType mediaType = MediaType.valueOf(mimeType);
		headers.setContentType(mediaType);
		ResponseEntity<byte[]> responseEntity = new ResponseEntity<byte[]>(media, headers, HttpStatus.OK);
		return responseEntity;
	}

	// ==================非管理員(註冊)===================

	/* 前往註冊 */
	@GetMapping("/register")
	public String getAddMember(Model model) {
		MemberBean mb = new MemberBean();
		model.addAttribute("memberBean", mb);
		return "register/register";
	}

	/* 存入會員資料 */
	@PostMapping("/register")
	public String addMember(@ModelAttribute("memberBean") MemberBean mb, BindingResult bindingResult,
			HttpServletRequest request, HttpServletResponse response, RedirectAttributes rad, HttpSession session,
			Model model) {

		new RegisterValidator(memberService).validate(mb, bindingResult);

		if (bindingResult.hasErrors()) {
//			List<ObjectError> list = bindingResult.getAllErrors();
//			for (ObjectError error : list) {
//				System.out.println("有錯誤：" + error);
//			}
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
		mb.setSendQuota("true");
		mb.setReplyQuota("true");
		int n = memberService.saveMember(mb);

		if (n == 1) {
			// 寄信
			String subject = null;
			StringBuilder content = new StringBuilder();
			String memberEmail = mb.getEmail();
			subject = "歡迎你加入要抒啦的會員";
			content.setLength(0);
			content.append("<p>" + "請點選以下連結" + "</p>" + "<br>" + "<a href='" + GlobalService.DOMAIN_PATTERN
					+ "/member/register/emailVerify" + "/" + authToken + "'>請點我</a>" + "<br>" + "<p>"
					+ "進入連結後即認證成功，可以去抒發一下了!" + "</p>");

			Thread sendEmail = new SendEmail(memberEmail, subject, content.toString(), "");
			sendEmail.start();
			session.setAttribute("verifyAlert", "verifyAlert");
			return "redirect:../";
		} else {
			System.out.println("更新此筆資料有誤(RegisterServlet)");
			return "register/register";
		}

	}

	/* 檢查信箱 */
	@GetMapping("/register/checkEmail")
	public void checkEmail(@RequestParam("email") String email, HttpServletResponse response) {
		response.setCharacterEncoding("UTF-8");
		try (PrintWriter out = response.getWriter();) {
			if (email.trim().length() != 0) {
				boolean exist = memberService.emailExists(email);
				if (!exist) {
					out.write("此信箱可使用");
					out.flush();
				} else {
					out.write("此信箱已被註冊");
					out.flush();
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return;
	}

	/* 檢查帳號 */
	@GetMapping("/register/checkUserName")
	public void checkUserName(@RequestParam("userName") String userName, HttpServletResponse response) {
		response.setCharacterEncoding("UTF-8");
		try (PrintWriter out = response.getWriter();) {
			if (userName.trim().length() != 0) {
				boolean exist = memberService.idExists(userName);
				if (!exist) {
					out.write("此帳號可使用");
					out.flush();
				} else {
					out.write("此帳號已存在");
					out.flush();
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return;
	}

	/* 驗證帳號(信) */
	@GetMapping("/register/emailVerify/{emailVerifyCode}")
	public String emailVerify(@PathVariable("emailVerifyCode") String emailVerifyCode, HttpSession session) {

		StringBuilder content = new StringBuilder();
		// 透過service的方法得到與驗證碼相同的MemberBean物件
		MemberBean mb = memberService.getEmailValid(emailVerifyCode);
		if (mb != null) {
			if (mb.getStatus().trim().equals("未驗證")) {
				mb.setStatus("正常");
				memberService.updateMember(mb);

				session.setAttribute("LoginOK", mb);
			}

		} else {
			content.append("<li>" + "資料發生異常，請再試一次" + "</li>");
			return "/";
		}

		return "redirect:/";
	}

	// 聯絡我們
	@PostMapping("/contactUs")
	public String contactUs(@RequestParam("name") String name, @RequestParam("email") String email,
			@RequestParam("guestSubject") String guestSubject, @RequestParam("message") String message,
			HttpSession session) {

		System.out.println("name" + name);
		System.out.println("email" + email);
		System.out.println("guestSubject" + guestSubject);
		System.out.println("message" + message);

		// 寄信給官方
		StringBuilder contentToUs = new StringBuilder();
		contentToUs.setLength(0);
		contentToUs
				.append("<p>" + message + "</p>" + "<br>" + "<p>" + "Letter from " + name + "email: " + email + "</p>");
		Thread sendEmailToUs = new SendEmail(GlobalService.NOREPLY_EMAIL, guestSubject.toString(),
				contentToUs.toString(), "");
		sendEmailToUs.start();

		// 寄信回去
		StringBuilder content = new StringBuilder();
		String subject = "要抒啦謝謝你的回覆";
		content.setLength(0);
		content.append("<p>" + name + " 感謝你給予我們回饋，我們會盡快派專人與你聯繫 😀" + "</p>" + "<br>" + "<a href='"
				+ GlobalService.DOMAIN_PATTERN + "'>點我回要抒啦首頁</a>" + "<br>");
		Thread sendEmail = new SendEmail(email, subject, content.toString(), "");
		sendEmail.start();

		session.setAttribute("sendSuccess", "寄信成功");
		return "redirect:/aboutUs/contact";
	}

	// ==================非管理員(登入)===================

	/* 前往登入 */
	@GetMapping("/login")
	public String loginForm(HttpSession session, HttpServletRequest request) {

		
		if (request.getAttribute("loginFilter") == null) {
			session.removeAttribute("target");
		}
		String target = request.getParameter("target");
		session.setAttribute("target", target);
		
		MemberBean mb = (MemberBean) session.getAttribute("LoginOK");
		if (mb != null) {
			
			if(target.equals("/letter/letterHome")) {
				return "redirect:" + target;
			}
			return "redirect:/";
		}
		
		return "login/login";
	}

	/* 前往信箱驗證 */
	@GetMapping("/enterEmail")
	public String enterEmail() {
		return "login/enterEmail";
	}

	/* 檢查登入帳號密碼 */
	@PostMapping("/checkLogin")
	public String checkData(@RequestParam("memberId") String memberId, @RequestParam("password") String password,
			Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) {

		MemberBean LoginOK = (MemberBean) session.getAttribute("LoginOK");
		if (LoginOK != null) {
			return "redirect:/";
		}

		// 準備存放錯誤訊息的Map物件
		Map<String, String> errorMsgMap = new HashMap<String, String>();
		request.setAttribute("ErrorMsgKey", errorMsgMap); // 顯示錯誤訊息

		String password2 = GlobalService.getMD5Endocing(GlobalService.encryptString(password));
		MemberBean mb = null;
		// 檢查帳號密碼是否正確
		try {
			mb = memberService.checkIdPassword(memberId, password2);
			if (mb != null) {
				if (mb.getStatus().equals("未驗證")) {
					errorMsgMap.put("memberNotAuthError", "會員尚未驗證成功!請先透過email去認證!");
					// 先暫時這樣 如果會員認證欄位是N 一樣先給LoginOK 只是要完成認證
//						session.setAttribute("LoginOK", mb);
				} else if (mb.getStatus().equals("封鎖")) {
					errorMsgMap.put("LoginBlockError", "此帳號已被封鎖");
				} 
			} else {
				errorMsgMap.put("LoginError", "帳號或密碼錯誤唷");
			}
		} catch (RuntimeException ex) {
			ex.printStackTrace();
			errorMsgMap.put("LoginError", ex.getMessage());
		}
		if (errorMsgMap.isEmpty()) {
			// 存入LoginOK=登入成功
			session.setAttribute("LoginOK", mb);
			
//			session.setAttribute("sendQuota", mb.getSendQuota());
//			session.setAttribute("replyQuota", mb.getReplyQuota());
			
			// 因為如果沒勾會是null 用@RequestParam註釋一定要傳值進來 如果沒有值會當掉 所以需要用過去request的方式去抓
			String rm = request.getParameter("rememberMe");
			Cookie cookieUser = null;
			Cookie cookiePassword = null;
			Cookie cookieRememberMe = null;
			if (rm != null) {
				// 如果選擇記住帳密
				cookieUser = new Cookie("memberId", memberId);
				cookieUser.setMaxAge(30 * 24 * 60 * 60); // cookie存活期一個月
				cookieUser.setPath(context.getContextPath());

				String encodePassword = GlobalService.encryptString(password);
				cookiePassword = new Cookie("password", encodePassword);
				cookiePassword.setMaxAge(30 * 24 * 60 * 60);
				cookiePassword.setPath(context.getContextPath());

				cookieRememberMe = new Cookie("rememberMe", "true");
				cookieRememberMe.setMaxAge(30 * 24 * 60 * 60);
				cookieRememberMe.setPath(context.getContextPath());
			} else {
				// 如果使用者沒有按下記住帳密 就不會保存帳號密碼的cookie
				cookieUser = new Cookie("memberId", memberId);
				cookieUser.setMaxAge(0);
				cookieUser.setPath(context.getContextPath());

				String encodePassword = GlobalService.encryptString(password);
				cookiePassword = new Cookie("password", encodePassword);
				cookiePassword.setMaxAge(0);
				cookiePassword.setPath(context.getContextPath());

				cookieRememberMe = new Cookie("rememberMe", "true");
				cookieRememberMe.setMaxAge(0);
				cookieRememberMe.setPath(context.getContextPath());
			}
			response.addCookie(cookieUser);
			response.addCookie(cookiePassword);
			response.addCookie(cookieRememberMe);

			String target = (String) session.getAttribute("target");
			// 如果是從別的地方來的就回去
			if (target != null) {
				return "redirect:" + target;
			} else {
				return "redirect:/";
			}
		} else {
			return "login/login";
		}
	}

	@GetMapping("/logout")
	public String custLogout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}

	/* 忘記密碼的寄信 */
	@PostMapping("/findPassword")
	public String findPassword(HttpServletRequest request) {
		String memberEmailStr = request.getParameter("email");
		if (memberService.emailExists(memberEmailStr) == true) {
			String memberEmail = memberEmailStr;
			String authToken = GlobalService.getMD5Endocing(GlobalService.encryptString(memberEmailStr));
			String subject = null;
			StringBuilder content = new StringBuilder();
			subject = "請點選連結修改密碼";
			content.setLength(0);
			content.append(
					"<p>" + "請點選以下連結修改密碼" + "</p>" + "<br>" + "<a href='" + GlobalService.DOMAIN_PATTERN + "/member"
							+ "/changepswd" + "/" + authToken + "'>點我</a>" + "<br>" + "<p>" + "下次不要再弄丟密碼了啦" + "</p>");
			Thread sendEmail = new SendEmail(memberEmail, subject, content.toString(), "");
			sendEmail.start();
			return "redirect:/";
		} else {

			System.out.println("假裝有寄啦，但其實沒寄");
		}

		return "redirect:/";
	}

	/* 忘記密碼的檢查信箱 */
	@GetMapping("/checkEmail")
	public void checkEmail(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/plain; charset=UTF-8");
		try (PrintWriter out = response.getWriter();) {
			String memberEmailStr = request.getParameter("email");
			if (memberService.emailExists(memberEmailStr)) {
				out.print("true");
				out.flush();
			} else {
				out.print("false");
				out.flush();
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@GetMapping("/changepswd/{emailVerifyCode}")
	public String changepswd(@PathVariable("emailVerifyCode") String emailVerifyCode, HttpSession session) {
		// 透過service的方法得到與驗證碼相同的MemberBean物件
		MemberBean mb = memberService.getEmailValid(emailVerifyCode);
		session.setAttribute("mb", mb);
		return "login/enterNewPassword";
	}

	@PostMapping("/changepswd")
	public String enterNewPassword(HttpSession session, HttpServletRequest request) {

		MemberBean mb = (MemberBean) session.getAttribute("mb");
		String memberId = mb.getMemberId();
		String password = request.getParameter("password");
		String passwordNew = GlobalService.getMD5Endocing(GlobalService.encryptString(password));

		int n = memberService.updateMemberPassword(memberId, passwordNew);
		if (n == 1) {
			return "redirect:/member/login";
		} else {
			return "redirect:/";
		}
	}
	// ==================非管理員(個人頁面)===================

	/* 給會員的舊表單，前往個人頁面 */
	@GetMapping("/personPage")
	public String personPage(Model model, HttpSession session) {
//		MemberBean mb = new MemberBean();
//		model.addAttribute("memberBean", mb);
		return "personPage/personPage";
	}

	/* 修改會員資料 */
	@PostMapping("/personPage")
	public void updateMember(Model model, HttpServletRequest request, HttpSession session, HttpServletResponse response)
			throws IOException {
		response.setContentType("application/json; charset=utf-8");
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;

		String cancel = multipartRequest.getParameter("cancel");
		MemberBean oldmb = (MemberBean) session.getAttribute("LoginOK");
		// 如果沒有取消的話代表新增 就去抓資料
		if (cancel.equals("")) {
			String phone = multipartRequest.getParameter("phone");
			String city = multipartRequest.getParameter("county");
			String area = multipartRequest.getParameter("district");
			String address = multipartRequest.getParameter("address");
			oldmb.setPhone(phone);
			oldmb.setCity(city);
			oldmb.setArea(area);
			oldmb.setAddress(address);

			// 取得檔名及照片
			MultipartFile memberImage = multipartRequest.getFile("file1");
			if (memberImage != null && !memberImage.isEmpty()) {
				// 如果有填照片，就存起來
				try {
					byte[] b = memberImage.getBytes();
					Blob blob = new SerialBlob(b);
					oldmb.setPicture(blob);
					oldmb.setFileName(memberImage.getOriginalFilename());
				} catch (Exception e) {
					e.printStackTrace();
					throw new RuntimeException("檔案上傳發生異常：" + e.getMessage());
				}
			}
			memberService.saveMember(oldmb);
		}
		// 更新session內的使用者資料
		MemberBean bean = memberService.getMember(oldmb.getId());
		session.setAttribute("LoginOK", bean);
		try (PrintWriter out = response.getWriter();) {
			/* 重新排成方便JSON的型態 */
			Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").excludeFieldsWithoutExposeAnnotation().create();
			out.write(gson.toJson(bean));
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return;
	}

	/* 個人文章 */
	@GetMapping("/showMyArticles")
	public String getmyArticles(Model model, HttpSession session, HttpServletRequest request) {
		// 取得搜尋字串或是篩選的字串 點擊我的文章時會先進來一次，所以第一次會是空字串，代表回傳所有的文章
		String arrange = request.getParameter("arrange") == null ? "" : request.getParameter("arrange");
		String searchStr = request.getParameter("search") == null ? "" : request.getParameter("search");

		MemberBean mb = (MemberBean) session.getAttribute("LoginOK");
		Map<ArticleBean, String> articleMap = articleService.getPersonArticles(arrange, searchStr, mb);

		model.addAttribute("searchStr", searchStr);
		model.addAttribute("articles_map", articleMap);

		return "personPage/myArticles";
	}

	/* 個人文章(ajax) */
	@GetMapping("/showMyArticlesAjax")
	public void getmyArticlesAjax(Model model, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		response.setContentType("application/json; charset=utf-8");

		try (PrintWriter out = response.getWriter();) {
			// 取得搜尋字串或是篩選的字串 點擊我的文章時會先進來一次，所以第一次會是空字串，代表回傳所有的文章
			String arrange = request.getParameter("arrange") == null ? "" : request.getParameter("arrange");
			String searchStr = request.getParameter("search") == null ? "" : request.getParameter("search");

			MemberBean mb = (MemberBean) session.getAttribute("LoginOK");
			Map<ArticleBean, String> articleMap = articleService.getPersonArticles(arrange, searchStr, mb);

			/* 重新排成方便JSON的型態 */
			List<Map<String, Object>> articles = new ArrayList<Map<String, Object>>();

			for (ArticleBean bean : articleMap.keySet()) {
				Map<String, Object> map = new LinkedHashMap<String, Object>();
				map.put("article", bean);
				map.put("content", articleMap.get(bean));
				articles.add(map);
			}
			Gson gson = new GsonBuilder().excludeFieldsWithoutExposeAnnotation().create();
			out.write(gson.toJson(articles));
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	// ==================管理員===================

	/* 查詢會員 */
	@GetMapping("/showMembers")
	public String showMembers(Model model, HttpServletRequest request) {
		// 必須是空字串
		String searchStr = request.getParameter("searchStr") == null ? "" : request.getParameter("searchStr");

		Map<MemberBean, Integer> membersTime = memberService.getMembers(searchStr);
		Map<MemberBean, Integer> membersNum = new LinkedHashMap<>();
		// 整理map的順序(依照value排序)
		List<Entry<MemberBean, Integer>> list = new ArrayList<Map.Entry<MemberBean, Integer>>(membersTime.entrySet());
		Collections.sort(list, new Comparator<Map.Entry<MemberBean, Integer>>() {
			public int compare(Map.Entry<MemberBean, Integer> o1, Map.Entry<MemberBean, Integer> o2) {
				return (o2.getValue() - o1.getValue());
			}
		});
		for (Map.Entry<MemberBean, Integer> items : list) {
			membersNum.put(items.getKey(), items.getValue());
		}

		model.addAttribute("searchStr", searchStr);
		model.addAttribute("member_map", membersNum);

		return "manager/member/allMembers";
	}

	/* 查詢會員詳細資料(傳入會員id) */
	@PostMapping("/showManageMemberInfo/{id}")
	public void showManageMemberInfo(Model model, HttpServletRequest request, @PathVariable("id") Integer id,
			HttpServletResponse response) throws IOException {

		response.setContentType("application/json; charset=utf-8");

		try (PrintWriter out = response.getWriter()) {
			String cmd = request.getParameter("cmd") == null ? "article" : request.getParameter("cmd");

			Map<ArticleBean, Integer> articlesNum = new LinkedHashMap<>();
			Map<CommentBean, Integer> commentsNum = new LinkedHashMap<>();

//		MemberBean mb = memberService.getMember(id);
			if (cmd.equals("article")) {
				// 查詢文章
				Map<ArticleBean, Integer> articles = articleService.getPersonArticle(id);
				// 照value值排序
				List<Entry<ArticleBean, Integer>> list = new ArrayList<Map.Entry<ArticleBean, Integer>>(
						articles.entrySet());
				Collections.sort(list, new Comparator<Map.Entry<ArticleBean, Integer>>() {
					public int compare(Map.Entry<ArticleBean, Integer> o1, Map.Entry<ArticleBean, Integer> o2) {
						return (o2.getValue() - o1.getValue());
					}
				});
				for (Map.Entry<ArticleBean, Integer> t : list) {
					articlesNum.put(t.getKey(), t.getValue());
				}
			} else if (cmd.equals("comment")) {
				// 查詢留言
				Map<CommentBean, Integer> comments = articleService.getPersonComment(id);
				// 照value值排序
				commentsNum = new LinkedHashMap<>();
				List<Entry<CommentBean, Integer>> list = new ArrayList<Map.Entry<CommentBean, Integer>>(
						comments.entrySet());
				Collections.sort(list, new Comparator<Map.Entry<CommentBean, Integer>>() {
					public int compare(Map.Entry<CommentBean, Integer> o1, Map.Entry<CommentBean, Integer> o2) {
						return (o2.getValue() - o1.getValue());
					}
				});
				for (Map.Entry<CommentBean, Integer> t : list) {
					commentsNum.put(t.getKey(), t.getValue());
				}
			} else if (cmd.equals("deleteArticle")) {
				// 查詢檢舉文章
				Map<ArticleBean, Integer> articles = articleService.getPersonDeleteArticle(id);
				// 照value值排序
				List<Entry<ArticleBean, Integer>> list = new ArrayList<Map.Entry<ArticleBean, Integer>>(
						articles.entrySet());
				Collections.sort(list, new Comparator<Map.Entry<ArticleBean, Integer>>() {
					public int compare(Map.Entry<ArticleBean, Integer> o1, Map.Entry<ArticleBean, Integer> o2) {
						return (o2.getValue() - o1.getValue());
					}
				});
				for (Map.Entry<ArticleBean, Integer> t : list) {
					articlesNum.put(t.getKey(), t.getValue());
				}
			} else if (cmd.equals("deleteComment")) {
				// 查詢檢舉留言
				Map<CommentBean, Integer> comments = articleService.getPersonDeleteComment(id);
				// 照value值排序
				List<Entry<CommentBean, Integer>> list = new ArrayList<Map.Entry<CommentBean, Integer>>(
						comments.entrySet());
				Collections.sort(list, new Comparator<Map.Entry<CommentBean, Integer>>() {
					public int compare(Map.Entry<CommentBean, Integer> o1, Map.Entry<CommentBean, Integer> o2) {
						return (o2.getValue() - o1.getValue());
					}
				});
				for (Map.Entry<CommentBean, Integer> t : list) {
					commentsNum.put(t.getKey(), t.getValue());
				}
			}
			if (cmd.equals("article") || cmd.equals("deleteArticle")) {

				List<Map<String, Object>> articles = new ArrayList<Map<String, Object>>();
				for (ArticleBean bean : articlesNum.keySet()) {
					Map<String, Object> map = new LinkedHashMap<String, Object>();
					map.put("article", bean);
					map.put("reportNum", articlesNum.get(bean));
					articles.add(map);
				}
				Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").excludeFieldsWithoutExposeAnnotation()
						.create();
				out.write(gson.toJson(articles));
				out.flush();
			}
			if (cmd.equals("comment") || cmd.equals("deleteComment")) {

				List<Map<String, Object>> comments = new ArrayList<Map<String, Object>>();
				for (CommentBean bean : commentsNum.keySet()) {
					Map<String, Object> map = new LinkedHashMap<String, Object>();
					map.put("comment", bean);
					map.put("reportNum", commentsNum.get(bean));
					comments.add(map);
				}
				Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").excludeFieldsWithoutExposeAnnotation()
						.create();
				out.write(gson.toJson(comments));
				out.flush();
			}

		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	/* 查詢會員詳細資料(傳入會員id) */
	@GetMapping("/showManageMemberInfo/{id}")
	public String showManageMemberInfo(Model model, HttpServletRequest request, @PathVariable("id") Integer id) {
		String cmd = request.getParameter("cmd") == null ? "article" : request.getParameter("cmd");
		String reportTimes = request.getParameter("reportTimes");

		MemberBean mb = memberService.getMember(id);
		if (cmd.equals("article")) {

			Map<ArticleBean, Integer> articles = articleService.getPersonArticle(id);

			Map<ArticleBean, Integer> articlesNum = new LinkedHashMap<>();
			List<Entry<ArticleBean, Integer>> list = new ArrayList<Map.Entry<ArticleBean, Integer>>(
					articles.entrySet());
			Collections.sort(list, new Comparator<Map.Entry<ArticleBean, Integer>>() {
				public int compare(Map.Entry<ArticleBean, Integer> o1, Map.Entry<ArticleBean, Integer> o2) {
					return (o2.getValue() - o1.getValue());
				}
			});
			for (Map.Entry<ArticleBean, Integer> t : list) {
				articlesNum.put(t.getKey(), t.getValue());
			}
			model.addAttribute("article_map", articlesNum);
			model.addAttribute("cmd", cmd);
		} else if (cmd.equals("comment")) {
			// 查詢留言
			Map<CommentBean, Integer> comments = articleService.getPersonComment(id);
			// 照value值排序
			Map<CommentBean, Integer> commentsNum = new LinkedHashMap<>();
			List<Entry<CommentBean, Integer>> list = new ArrayList<Map.Entry<CommentBean, Integer>>(
					comments.entrySet());
			Collections.sort(list, new Comparator<Map.Entry<CommentBean, Integer>>() {
				public int compare(Map.Entry<CommentBean, Integer> o1, Map.Entry<CommentBean, Integer> o2) {
					return (o2.getValue() - o1.getValue());
				}
			});
			for (Map.Entry<CommentBean, Integer> t : list) {
				commentsNum.put(t.getKey(), t.getValue());
			}
			model.addAttribute("comment_map", commentsNum);
			model.addAttribute("cmd", cmd);
		} else if (cmd.equals("deleteArticle")) {
			// 查詢檢舉文章
			Map<ArticleBean, Integer> articles = articleService.getPersonDeleteArticle(id);
			// 照value值排序
			Map<ArticleBean, Integer> articlesNum = new LinkedHashMap<>();
			List<Entry<ArticleBean, Integer>> list = new ArrayList<Map.Entry<ArticleBean, Integer>>(
					articles.entrySet());
			Collections.sort(list, new Comparator<Map.Entry<ArticleBean, Integer>>() {
				public int compare(Map.Entry<ArticleBean, Integer> o1, Map.Entry<ArticleBean, Integer> o2) {
					return (o2.getValue() - o1.getValue());
				}
			});
			for (Map.Entry<ArticleBean, Integer> t : list) {
				articlesNum.put(t.getKey(), t.getValue());
			}
			model.addAttribute("article_map", articlesNum);
			model.addAttribute("cmd", "article");
		} else if (cmd.equals("deleteComment")) {
			// 查詢檢舉留言
			Map<CommentBean, Integer> comments = articleService.getPersonDeleteComment(id);
			// 照value值排序
			Map<CommentBean, Integer> commentsNum = new LinkedHashMap<>();
			List<Entry<CommentBean, Integer>> list = new ArrayList<Map.Entry<CommentBean, Integer>>(
					comments.entrySet());
			Collections.sort(list, new Comparator<Map.Entry<CommentBean, Integer>>() {
				public int compare(Map.Entry<CommentBean, Integer> o1, Map.Entry<CommentBean, Integer> o2) {
					return (o2.getValue() - o1.getValue());
				}
			});
			for (Map.Entry<CommentBean, Integer> t : list) {
				commentsNum.put(t.getKey(), t.getValue());
			}
			model.addAttribute("comment_map", commentsNum);
			model.addAttribute("cmd", "comment");
		}
		model.addAttribute("id", id);
		model.addAttribute("mb", mb);
		model.addAttribute("reportTimes", reportTimes);
		model.addAttribute("cmd", cmd);

		return "manager/member/memberInfo";
	}

	/* 封鎖帳號or解除封鎖 */
	@PostMapping("/changeMemberStatus/{id}")
	public void changeMemberStatus(HttpServletRequest request, @PathVariable("id") Integer id,
			HttpServletResponse response) {
		response.setCharacterEncoding("UTF-8");
		String memberLock = request.getParameter("memberLock");

		MemberBean mb = memberService.getMember(id);

		if (memberLock.equals("封鎖帳號")) {
			mb.setStatus("封鎖");
			memberService.saveMember(mb);
		} else if (memberLock.equals("解除封鎖")) {
			mb.setStatus("正常");
			memberService.saveMember(mb);
		}

		try {
			PrintWriter out = response.getWriter();
			out.print("");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return;

	}

}
