package com.web.speakitup.controller;

import java.io.IOException;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.CacheControl;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.web.speakitup._00_init.GlobalService;
import com.web.speakitup.model.ArticleBean;
import com.web.speakitup.model.MemberBean;
import com.web.speakitup.service.ArticleService;

@Controller
@RequestMapping("article")
public class ArticleController {

	@Autowired
	ServletContext context;

	@Autowired
	ArticleService articleService;

	// 所有的文章
	@GetMapping("/ShowPageArticles")
	public String ShowPageArticles(HttpServletRequest request) {
		String arrange = request.getParameter("arrange") == null ? "" : request.getParameter("arrange");
		String searchStr = request.getParameter("search") == null ? "" : request.getParameter("search");
		String categoryTitle = request.getParameter("categoryTitle") == null ? ""
				: request.getParameter("categoryTitle");
		String categoryName = request.getParameter("categoryName") == null ? "" : request.getParameter("categoryName");

		Map<Integer, ArticleBean> articleMap = articleService.getArticles(arrange, searchStr, categoryTitle,
				categoryName);

		request.setAttribute("searchStr", searchStr);
		request.setAttribute("arrange", arrange);
		request.setAttribute("categoryTitle", categoryTitle);
		request.setAttribute("categoryName", categoryName);
		request.setAttribute("articles_map", articleMap);

		return "/article/articlePage";
	}

	@GetMapping("/getArticleImage/{articleId}")
	public ResponseEntity<byte[]> getUserImage(@PathVariable int articleId, Model model, HttpServletRequest request,
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
