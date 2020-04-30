package com.web.speakitup.controller;

import java.io.IOException;
import java.sql.Blob;
import java.sql.Clob;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.LinkedHashSet;
import java.util.Map;
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

import com.web.speakitup._00_init.GlobalService;
import com.web.speakitup.model.ArticleBean;
import com.web.speakitup.model.ArticleCategoryBean;
import com.web.speakitup.model.CommentBean;
import com.web.speakitup.model.MemberBean;
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
	
	// 所有的文章
	@GetMapping("/ShowPageArticles")
	
	public String ShowPageArticles(HttpServletRequest request,Model model) {
		String arrange = request.getParameter("arrange") == null ? "" : request.getParameter("arrange");
		String searchStr = request.getParameter("search") == null ? "" : request.getParameter("search");
		String categoryTitle = request.getParameter("categoryTitle") == null ? ""
				: request.getParameter("categoryTitle");
		String categoryName = request.getParameter("categoryName") == null ? "" : request.getParameter("categoryName");

		Map<Integer, ArticleBean> articleMap = articleService.getArticles(arrange, searchStr, categoryTitle,categoryName);
//		request.setAttribute("searchStr", searchStr);
//		request.setAttribute("arrange", arrange);
//		request.setAttribute("categoryTitle", categoryTitle);
//		request.setAttribute("categoryName", categoryName);
//		request.setAttribute("articles_map", articleMap);

		model.addAttribute("searchStr", searchStr);
		model.addAttribute("arrange", arrange);
		model.addAttribute("categoryTitle", categoryTitle);
		model.addAttribute("categoryName", categoryName);
		model.addAttribute("articles_map", articleMap);
		
		return "article/articlePage";
	}
	
	@GetMapping("/addArticle")
	public String addArticle(Model model) {
		
		ArticleBean articleBean = new ArticleBean();
		model.addAttribute("articleBean", articleBean);
		return "article/addArticle";
	}
	
	//從addArticle.jsp過來的 新增文章
	@PostMapping("/addArticle")
	public String addArticle(@ModelAttribute("articleBean")ArticleBean ab,HttpServletRequest request,
			RedirectAttributes rda,HttpSession session) throws IOException, SQLException {
		
		MemberBean mb = (MemberBean) session.getAttribute("LoginOK");
		
		String categoryTitle = request.getParameter("categoryTitle");
		String categoryName = request.getParameter("categoryName");
		String content = request.getParameter("contentStr");
		String title = ab.getTitle();
		//把文章存成clob
		Clob clobContent = GlobalService.stringToClob(content);
		ab.setAuthorId(mb.getId());
		ab.setAuthorName(mb.getMemberId());
		ab.setContent(clobContent);
		System.out.println("memberId" + mb.getMemberId());
		
		ArticleCategoryBean acb = articleService.getCategory(categoryTitle, categoryName);
		//把種類的外鍵存進去
		ab.setCategory(acb);
		//存文章標題
		ab.setTitle(title);
		
		System.out.println("categoryTitle" + categoryTitle);
		System.out.println("categoryName: " + categoryName);
		System.out.println("content: " + content);
		System.out.println("title: " + title);
		
		//取得照片
		MultipartFile articleImage = ab.getArticleImage();
		String originalFilename = articleImage.getOriginalFilename();
		if (articleImage != null && !articleImage.isEmpty()) {
			try {
				byte[] b = articleImage.getBytes();
				Blob blob = new SerialBlob(b);
				//把文章照片的blob存進去
				ab.setImage(blob);
				//把文章照片的名稱存進去
				ab.setFileName(originalFilename);
				//儲存文章
				
			} catch (Exception e) {
				e.printStackTrace();
				throw new RuntimeException("檔案上傳發生異常：" + e.getMessage());
				
			}
		}
		
		articleService.insertArticle(ab);
		Integer articleId = ab.getArticleId();
		session.setAttribute("mb", mb);
		rda.addFlashAttribute("articleId", articleId);
		
		return "redirect:/article/addSuccess";		
		
	}
		
	//文章新增成功 轉跳這
	@GetMapping("/addSuccess")
	public String addSuccess(@ModelAttribute("articleId")int articleId,Model model) throws IOException, SQLException {
		System.out.println("222articleId: " + articleId);
		ArticleBean ab =  articleService.getArticle(articleId);
		String content = GlobalService.clobToString(ab.getContent());
		model.addAttribute("article", ab);
		model.addAttribute("content", content);
		return "article/articleContent";
	}
	
	//新增留言POST
	@PostMapping("/addComment/{articleId}")
	public String addComment(@PathVariable("articleId") int articleId, HttpServletRequest request,HttpSession session) {	
		
		String comment = request.getParameter("content");
		if(comment == null) {
			return "redirect:/article/showArticleContent/{articleId}";
		}
		MemberBean mb = (MemberBean) session.getAttribute("LoginOK");
		//抓留言
		
		//留言時間
		Timestamp ts = new java.sql.Timestamp(System.currentTimeMillis());
		ArticleBean ab = articleService.getArticle(articleId);
		
		CommentBean cb = new CommentBean(null, mb.getId(), mb.getMemberId(), ts, comment, ab, "正常");
		articleService.insertComment(cb);
		return "redirect:/article/showArticleContent/{articleId}";
	}
	
	//新增留言Get
		@GetMapping("/addComment/{articleId}")
		public String addCommentGet(@PathVariable("articleId") int articleId, HttpServletRequest request,HttpSession session) {
			return "redirect:/article/showArticleContent/{articleId}";
		}
	
	//取得文章內容
	@GetMapping("/showArticleContent/{articleId}")
	public String ShowArticleContent(@PathVariable int articleId,Model model) throws IOException, SQLException {
		
		ArticleBean ab =  articleService.getArticle(articleId);
		Set<CommentBean> allComments = ab.getArticleComments();
		Set<CommentBean> comments = new LinkedHashSet<>();
		for (CommentBean bean : allComments) {
			if (bean.getStatus().equals("正常")) {
				comments.add(bean);
			}
		}
		
		String content = GlobalService.clobToString(ab.getContent());
		model.addAttribute("article", ab);
		model.addAttribute("content", content);
		model.addAttribute("comments_set", comments);
		
		
		return "article/articleContent";
	}
	
	//喜歡文章
	@GetMapping("/likeArticle/{articleId}")
	public String likeArticle(@PathVariable("articleId")int articleId,HttpSession session,HttpServletRequest request) {
		
		String loginTrue = request.getParameter("login");
		if(loginTrue == null) {
			return "redirect:/article/showArticleContent/{articleId}";
		}
		
		MemberBean mb = (MemberBean) session.getAttribute("LoginOK");
		ArticleBean ab = articleService.getArticle(articleId);
		articleService.likeArticle(ab, mb);
		
		MemberBean newMb = memberService.getMember(mb.getId());
		session.setAttribute("LoginOK", newMb);
		
		return "redirect:/article/showArticleContent/{articleId}";
	}
	
	@GetMapping("/showFamousArticles")
	public String showFamousArticles(Model model){
		
		Map<Integer, ArticleBean> angelArticleMap = articleService.getFamousArticles("天使");
		Map<Integer, ArticleBean> evilArticleMap = articleService.getFamousArticles("惡魔");

		model.addAttribute("angel_articles_map", angelArticleMap);
		model.addAttribute("evil_articles_map", evilArticleMap);
		
		return "article/articleFamous";
	}
	
	
	
	//取得文章照片
	@GetMapping("/getArticleImage/{articleId}")
	public ResponseEntity<byte[]> getArticleImage(@PathVariable int articleId, Model model, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		
		String filepath = "/resources/images/NoImage.jpg";
		byte[] media = null;
		HttpHeaders headers = new HttpHeaders();
		String filename = "";
		int len = 0;
		ArticleBean articleBean = articleService.getArticle(articleId);

		//取得照片跟檔名
		if (articleBean != null) {
			Blob blob = articleBean.getImage();
			filename = articleBean.getFileName();
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
		ResponseEntity<byte[]> responseEntity = new ResponseEntity<byte[]>(media, headers, HttpStatus.OK);
		return responseEntity;
	}

}
