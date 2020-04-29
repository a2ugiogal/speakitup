package com.web.speakitup.controller;

import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.web.speakitup.model.ArticleBean;
import com.web.speakitup.service.ArticleService;

@Controller
@RequestMapping("article")
public class ArticleController {
	
	@Autowired
	ServletContext context;
	
	@Autowired
	ArticleService articleService;
	
	
	@GetMapping("/ShowPageArticles")
	public String ShowPageArticles(HttpServletRequest request) {
		String arrange = request.getParameter("arrange") == null ? "" : request.getParameter("arrange");
		String searchStr = request.getParameter("search") == null ? "" : request.getParameter("search");
		String categoryTitle = request.getParameter("categoryTitle") == null ? "": request.getParameter("categoryTitle");
		String categoryName = request.getParameter("categoryName") == null ? "" : request.getParameter("categoryName");

		Map<Integer, ArticleBean> articleMap = articleService.getArticles(arrange, searchStr, categoryTitle,categoryName);

		request.setAttribute("searchStr", searchStr);
		request.setAttribute("arrange", arrange);
		request.setAttribute("categoryTitle", categoryTitle);
		request.setAttribute("categoryName", categoryName);
		request.setAttribute("articles_map", articleMap);
		
		return "/article/articlePage";
	}
	
	
	
}
