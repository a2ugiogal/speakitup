package com.web.speakitup.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.web.speakitup.model.ArticleBean;
import com.web.speakitup.model.CommentBean;
import com.web.speakitup.model.MemberBean;
import com.web.speakitup.service.ArticleService;
import com.web.speakitup.service.MemberService;

@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired
	ServletContext context;

	@Autowired
	MemberService memberService;

	@Autowired
	ArticleService articleService;

	// ==================非管理員===================

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
