package com.web.speakitup.service;

import java.util.Map;
import java.util.Set;

import com.web.speakitup.model.ArticleBean;
import com.web.speakitup.model.ArticleCategoryBean;
import com.web.speakitup.model.CommentBean;
import com.web.speakitup.model.MemberBean;
import com.web.speakitup.model.ReportArticleBean;
import com.web.speakitup.model.ReportCommentBean;

public interface ArticleService {

	void insertArticle(ArticleBean ab);

	void insertComment(CommentBean cb);

	void insertReportArticle(ReportArticleBean rab);

	void insertReportComment(ReportCommentBean rcb);

	void deleteReportArticle(Integer articleId);

	void deleteReportComment(Integer commentId);

//	int getTotalPages(String searchStr, String categoryTitle, String categoryName);

//	long getRecordCounts();

	Map<Integer, ArticleBean> getArticles(String arrange, String searchStr, String categoryTitle, String categoryName);

	Map<Integer, ArticleBean> getPersonArticles(String arrange, String searchStr, MemberBean mb);

	Map<Integer, ArticleBean> getFamousArticles(String categoryTitle);

	ArticleCategoryBean getCategory(String categoryTitle, String categoryName);

	Set<String> getCategorys(String categoryTitle);

	Integer likeArticle(ArticleBean ab, MemberBean mb);

	Map<ArticleBean, Integer> getReportArticles(String searchStr);

	Map<CommentBean, Integer> getReportComments(String searchStr);

	Integer getReportItemCount(String cmd, Integer id, String item);

	Map<ArticleBean, Integer> getPersonArticle(Integer id);

	Map<CommentBean, Integer> getPersonComment(Integer id);

	Map<ArticleBean, Integer> getPersonDeleteArticle(Integer id);

	Map<CommentBean, Integer> getPersonDeleteComment(Integer id);

//	List<String> getCategory();

//	String getCategoryTag();

//	int updateBook(BookBean bean, long sizeInBytes);

//	int deleteBook(int no);

//	int saveBook(BookBean bean);

	ArticleBean getArticle(int articleId);

	CommentBean getComment(int commentId);
}
