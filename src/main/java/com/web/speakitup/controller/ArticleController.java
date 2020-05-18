package com.web.speakitup.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Blob;
import java.sql.Clob;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.servlet.ServletContext;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.web.speakitup._00_init.GlobalService;
import com.web.speakitup.model.ArticleBean;
import com.web.speakitup.model.ArticleCategoryBean;
import com.web.speakitup.model.CommentBean;
import com.web.speakitup.model.MemberBean;
import com.web.speakitup.model.ReportArticleBean;
import com.web.speakitup.model.ReportCommentBean;
import com.web.speakitup.service.ArticleService;
import com.web.speakitup.service.MemberService;

@Controller
@RequestMapping("/article")
public class ArticleController {

	@Autowired
	ServletContext context;

	@Autowired
	ArticleService articleService;

	@Autowired
	MemberService memberService;

	/*----------------------------------所有的文章-----------------------------------------------------*/

	@GetMapping("/showPageArticles")
	public String ShowPageArticles(HttpServletRequest request, Model model) {
		// 先取得所有的篩選條件 預設是空的 不管有沒有條件都會來run這個方法
		String arrange = request.getParameter("arrange") == null ? "" : request.getParameter("arrange");
		String searchStr = request.getParameter("search") == null ? "" : request.getParameter("search");
		String categoryTitle = request.getParameter("categoryTitle") == null ? "天使"
				: request.getParameter("categoryTitle");
		String categoryName = request.getParameter("categoryName") == null ? "" : request.getParameter("categoryName");

		Map<ArticleBean, String> articleMap = articleService.getArticles(arrange, searchStr, categoryTitle,
				categoryName);

		model.addAttribute("searchStr", searchStr);
		model.addAttribute("arrange", arrange);
		model.addAttribute("categoryTitle", categoryTitle);
		model.addAttribute("categoryName", categoryName);
		model.addAttribute("articles_map", articleMap);

		return "article/articlePage";
	}

	/*----------------------------------所有的文章(ajax)-----------------------------------------------------*/

	@GetMapping("/showPageArticlesAjax")
	public void ShowPageArticlesAjax(HttpServletRequest request, Model model, HttpServletResponse response) {
		response.setContentType("application/json; charset=utf-8");

		try (PrintWriter out = response.getWriter();) {
			// 先取得所有的篩選條件 預設是空的 不管有沒有條件都會來run這個方法
			String arrange = request.getParameter("arrange") == null ? "" : request.getParameter("arrange");
			String searchStr = request.getParameter("search") == null ? "" : request.getParameter("search");
			String categoryTitle = request.getParameter("categoryTitle") == null ? "天使"
					: request.getParameter("categoryTitle");
			String categoryName = request.getParameter("categoryName") == null ? ""
					: request.getParameter("categoryName");

			Map<ArticleBean, String> articleMap = articleService.getArticles(arrange, searchStr, categoryTitle,
					categoryName);

			/* 重新排成方便JSON的型態 */
			List<Map<String, Object>> articles = new ArrayList<Map<String, Object>>();

			for (ArticleBean bean : articleMap.keySet()) {
				Map<String, Object> map = new LinkedHashMap<String, Object>();
				map.put("article", bean);
				map.put("content", articleMap.get(bean));
				articles.add(map);
			}
			Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").excludeFieldsWithoutExposeAnnotation().create();
			out.write(gson.toJson(articles));
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/*--------------------------------新增文章空白表單---------------------------------------------------*/
	@GetMapping("/addArticle")
	public String addArticle(Model model) {
		ArticleBean articleBean = new ArticleBean();
		model.addAttribute("articleBean", articleBean);
		return "article/addArticle";
	}

	/*-----------------------------------從addArticle.jsp過來的 新增文章----------------------------------------------------*/

	@PostMapping("/addArticle")
	public String addArticle(@ModelAttribute("articleBean") ArticleBean ab, HttpServletRequest request,
			RedirectAttributes rda, HttpSession session) throws IOException, SQLException {

		MemberBean mb = (MemberBean) session.getAttribute("LoginOK");

		String categoryTitle = request.getParameter("categoryTitle");
		String categoryName = request.getParameter("categoryName");
		String content = request.getParameter("contentStr");
		String title = ab.getTitle();
		// 把文章存成clob
		Clob clobContent = GlobalService.stringToClob(content);
		ab.setAuthorId(mb.getId());
		ab.setAuthorName(mb.getMemberId());
		ab.setContent(clobContent);

		ArticleCategoryBean acb = articleService.getCategory(categoryTitle, categoryName);
		// 把種類的外鍵存進去
		ab.setCategory(acb);
		// 存文章標題
		ab.setTitle(title);

		// 取得照片
		MultipartFile articleImage = ab.getArticleImage();
		String originalFilename = articleImage.getOriginalFilename();
		if (articleImage != null && !articleImage.isEmpty()) {
			try {
				byte[] b = articleImage.getBytes();
				Blob blob = new SerialBlob(b);
				// 把文章照片的blob存進去
				ab.setImage(blob);
				// 把文章照片的名稱存進去
				ab.setFileName(originalFilename);
				// 儲存文章

			} catch (Exception e) {
				e.printStackTrace();
				throw new RuntimeException("檔案上傳發生異常：" + e.getMessage());

			}
		}
		ab.setLikes(0);
		ab.setStatus("正常");
		Timestamp ts = new java.sql.Timestamp(System.currentTimeMillis());
		ab.setPublishTime(ts);

		articleService.insertArticle(ab);
		Integer articleId = ab.getArticleId();
		session.setAttribute("mb", mb);
		rda.addFlashAttribute("articleId", articleId);

		return "redirect:/article/addSuccess";

	}

	// 文章新增成功 轉跳這
	@GetMapping("/addSuccess")
	public String addSuccess(@ModelAttribute("articleId") int articleId, Model model) throws IOException, SQLException {
		ArticleBean ab = articleService.getArticle(articleId);
		String content = GlobalService.clobToString(ab.getContent());
		model.addAttribute("article", ab);
		model.addAttribute("content", content);
		return "article/articleContent";
	}
	/*-----------------------------------新增留言POST----------------------------------------------------*/

	@PostMapping("/addComment/{articleId}")
	public void addComment(@PathVariable("articleId") int articleId, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		response.setContentType("application/json; charset=utf-8");
		// 抓留言
		String comment = request.getParameter("content");

		MemberBean mb = (MemberBean) session.getAttribute("LoginOK");

		// 留言時間
		Timestamp ts = new java.sql.Timestamp(System.currentTimeMillis());
		ArticleBean ab = articleService.getArticle(articleId);

		CommentBean cb = new CommentBean(null, mb.getId(), mb.getMemberId(), ts, comment, ab, "正常");
		articleService.insertComment(cb);

		try {
			PrintWriter out = response.getWriter();
			Gson gson = new GsonBuilder().excludeFieldsWithoutExposeAnnotation().create();
			out.write(gson.toJson(cb));
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	// 新增留言Get
//	@GetMapping("/addComment/{articleId}")
//	public String addCommentGet(@PathVariable("articleId") int articleId, HttpServletRequest request,
//			HttpSession session) {
//		return "redirect:/article/showArticleContent/{articleId}";
//	}

	/*---------------------------------------------------------------------------------------*/
	// 取得文章內容
	@GetMapping("/showArticleContent/{articleId}")
	public String ShowArticleContent(@PathVariable int articleId, Model model, HttpSession session,
			HttpServletRequest request) throws IOException, SQLException {

		ArticleBean ab = articleService.getArticle(articleId);
		Set<CommentBean> allComments = ab.getArticleComments();
		Set<CommentBean> comments = new LinkedHashSet<>();
		for (CommentBean bean : allComments) {
			if (bean.getStatus().equals("正常")) {
				comments.add(bean);
			}
		}

		String content = GlobalService.clobToString(ab.getContent());
		session.setAttribute("article", ab);
		model.addAttribute("content", content);
		model.addAttribute("comments_set", comments);

		return "article/articleContent";
	}

	/*-----------------------------------喜歡文章----------------------------------------------------*/

	@GetMapping("/likeArticle/{articleId}")
	public void likeArticle(@PathVariable("articleId") int articleId, HttpSession session,
			HttpServletResponse response) {

		MemberBean mb = (MemberBean) session.getAttribute("LoginOK");
		ArticleBean ab = articleService.getArticle(articleId);
		articleService.likeArticle(ab, mb);

		MemberBean newMb = memberService.getMember(mb.getId());
		session.setAttribute("LoginOK", newMb);

		ArticleBean newAb = articleService.getArticle(articleId);
		int likes = newAb.getLikes();
		response.setCharacterEncoding("UTF-8");
		try (PrintWriter out = response.getWriter();) {
			out.print(likes);
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/*---------------------------------檢舉文章或留言------------------------------------------------------*/

	@GetMapping("/report")
	public void addReport(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		MemberBean mb = (MemberBean) session.getAttribute("LoginOK");
		String commentIdStr = request.getParameter("commentId") == null ? "" : request.getParameter("commentId");
		// 檢舉項目
		String reportItem = request.getParameter("reportItem");
		if (commentIdStr.trim() == "") {
			// 檢舉文章
			ArticleBean ab = (ArticleBean) session.getAttribute("article");
			ReportArticleBean bean = new ReportArticleBean(null, ab.getArticleId(), ab.getAuthorName(),
					ab.getPublishTime(), ab.getTitle(), mb.getMemberId(), reportItem);

			articleService.insertReportArticle(bean);
		} else {
			// 檢舉留言
			int commentId = Integer.parseInt(commentIdStr);
			CommentBean cb = articleService.getComment(commentId);

			ReportCommentBean bean = new ReportCommentBean(null, commentId, cb.getAuthorName(), cb.getPublishTime(),
					cb.getContent(), mb.getMemberId(), reportItem);
			articleService.insertReportComment(bean);
		}
		try (PrintWriter out = response.getWriter();){
			out.print("");
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}

		return;

	}

	/*---------------------------------熱門文章------------------------------------------------------*/

	@GetMapping("/showFamousArticles")
	public String showFamousArticles(Model model) {

		Map<Integer, ArticleBean> angelArticleMap = articleService.getFamousArticles("天使");
		Map<Integer, ArticleBean> evilArticleMap = articleService.getFamousArticles("惡魔");

		model.addAttribute("angel_articles_map", angelArticleMap);
		model.addAttribute("evil_articles_map", evilArticleMap);

		return "article/articleFamous";
	}

	// ==================管理員===================================================

	@GetMapping("/showReports")
	public String showReports(HttpServletRequest request, Model model) {

		String searchStr = request.getParameter("searchStr") == null ? "" : request.getParameter("searchStr");
		String cmd = request.getParameter("cmd") == null ? "article" : request.getParameter("cmd");

		if (cmd.equals("article")) {
			Map<ArticleBean, Integer> articles = articleService.getReportArticles(searchStr);
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
			Map<CommentBean, Integer> comments = articleService.getReportComments(searchStr);
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
		model.addAttribute("searchStr", searchStr);
		model.addAttribute("cmd", cmd);

		return "manager/report/allReports";
	}

	// 看檢舉的詳細內容
	@GetMapping("/showReportInfo/{id}/{cmd}")
	public String showReportInfo(@PathVariable("cmd") String cmd, @PathVariable("id") int id,
			HttpServletRequest request, Model model) throws IOException {
		String[] reportItems = GlobalService.REPORT_ITEM;
		if (cmd != null) {
			// ("item0", 5)
			for (Integer i = 0; i < reportItems.length; i++) {
				int count = articleService.getReportItemCount(cmd, id, reportItems[i]);
				request.setAttribute("item" + i, count);
			}
			ArticleBean ab = null;
			if (cmd.equals("article") || (cmd.equals("deleteArticle"))) {
				ab = articleService.getArticle(id);
			}
			if (cmd.equals("comment") || cmd.equals("deleteComment")) {
				CommentBean cb = articleService.getComment(id);
				ab = cb.getArticle();

				model.addAttribute("comment", cb);
			}

			String content = "";
			Clob clob = null;
			if (ab != null) {
				try {
					clob = ab.getContent();
					if (clob != null) {
						content = GlobalService.clobToString(clob);
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

			model.addAttribute("article", ab);
			model.addAttribute("content", content);
			model.addAttribute("cmd", cmd);
			model.addAttribute("id", id);
		}
		return "manager/report/reportInfo";
	}

	// 刪除檢舉的文章或留言
	@GetMapping("/deleteArticle/{cmd}/{id}")
	public String deleteArticle(@PathVariable("cmd") String cmd, @PathVariable("id") int id) {

		if (cmd.equals("article")) {
			ArticleBean ab = articleService.getArticle(id);
			ab.setStatus("刪除");
			articleService.insertArticle(ab);
		} else if (cmd.equals("comment")) {
			CommentBean cb = articleService.getComment(id);
			cb.setStatus("刪除");
			articleService.insertComment(cb);
		}

		return "forward:/article/showReports";
	}

	// 保留文章
	@GetMapping("/reserveArticle/{cmd}/{id}")
	public String reserveArticle(@PathVariable("cmd") String cmd, @PathVariable("id") int id) {

		if (cmd.equals("article")) {
			articleService.deleteReportArticle(id);
		} else if (cmd.equals("comment")) {
			articleService.deleteReportComment(id);
		}
		return "forward:/article/showReports";
	}

	/*---------------------------------	取得文章照片------------------------------------------------------*/

	@GetMapping("/getArticleImage/{articleId}")
	public ResponseEntity<byte[]> getArticleImage(@PathVariable int articleId, Model model, HttpServletRequest request,
			HttpServletResponse response) throws IOException {

		byte[] media = null;
		HttpHeaders headers = new HttpHeaders();
		String filename = "";
		int len = 0;
		ArticleBean articleBean = articleService.getArticle(articleId);

		// 取得照片跟檔名
		if (articleBean != null) {
			Blob blob = articleBean.getImage();
			filename = articleBean.getFileName();
			if (blob != null) {
				try {
					len = (int) blob.length();
					media = blob.getBytes(1, len);
					String mimeType = context.getMimeType(filename);
					MediaType mediaType = MediaType.valueOf(mimeType);
					headers.setContentType(mediaType);
				} catch (SQLException e) {
					throw new RuntimeException("getUserImage發生SQLException" + e.getMessage());
				}
			}
		}
		headers.setCacheControl(CacheControl.noCache().getHeaderValue());
		ResponseEntity<byte[]> responseEntity = new ResponseEntity<byte[]>(media, headers, HttpStatus.OK);
		return responseEntity;
	}

}
