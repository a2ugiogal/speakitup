package com.web.speakitup.controller;

import java.io.IOException;
import java.io.Writer;
import java.sql.Blob;
import java.sql.Date;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

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

	// ==================非管理員(註冊)===================

	@GetMapping("/register")
	public String getAddMember(Model model) {
		MemberBean mb = new MemberBean();
		model.addAttribute("memberBean", mb);
		return "register/register";
	}

	@PostMapping("/register")
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
			content.append(
					"<p>" + "請點選以下連結" + "</p>" + "<br>" + GlobalService.DOMAIN_PATTERN + "/member/register/emailVerify"
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
	@GetMapping("/register/checkEmail")
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
	@GetMapping("/register/checkUserName")
	public void checkUserName(@RequestParam("userName") String userName, HttpServletResponse response) {
		response.setCharacterEncoding("UTF-8");
		Writer os = null;
		try {
			os = response.getWriter();
			if (userName.trim().length() != 0) {
				boolean exist = memberService.idExists(userName);
				if (!exist) {
					os.write("此帳號可使用");
				} else {
					os.write("此帳號已存在");
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return;
	}

	@GetMapping("/register/emailVerify")
	public String emailVerify(HttpServletRequest request, HttpSession session) {
		StringBuilder content = new StringBuilder();
		String emailVerifyCode = request.getParameter("emailCode");

		// 透過service的方法得到與驗證碼相同的MemberBean物件
		MemberBean mb = null;
		mb = memberService.getEmailValid(emailVerifyCode);

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
		return "redirect:/";
	}

	// ==================非管理員(註冊)===================

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
	@GetMapping("/showManageMemberInfo/{id}")
	public String showManageMemberInfo(Model model, HttpServletRequest request, @PathVariable("id") Integer id) {
		String cmd = request.getParameter("cmd") == null ? "article" : request.getParameter("cmd");
		String reportTimes = request.getParameter("reportTimes");

		MemberBean mb = memberService.getMember(id);
		if (cmd.equals("article")) {
			// 查詢文章
			Map<ArticleBean, Integer> articles = articleService.getPersonArticle(id);
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
		}
		model.addAttribute("id", id);
		model.addAttribute("mb", mb);
		model.addAttribute("reportTimes", reportTimes);

		return "manager/member/memberInfo";
	}

	/* 封鎖帳號or解除封鎖 */
	@GetMapping("/changeMemberStatus/{id}")
	public String changeMemberStatus(HttpServletRequest request, @PathVariable("id") Integer id) {
		String memberLock = request.getParameter("memberLock");
		String reportTimes = request.getParameter("reportTimes");

		MemberBean mb = memberService.getMember(id);

		if (memberLock.equals("封鎖帳號")) {
			mb.setStatus("封鎖");
			memberService.saveMember(mb);
		} else if (memberLock.equals("解除封鎖")) {
			mb.setStatus("正常");
			memberService.saveMember(mb);
		}

		return "redirect:/manager/showMemberInfo/{id}?reportTimes=" + reportTimes;
	}
}
