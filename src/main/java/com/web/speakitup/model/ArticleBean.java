package com.web.speakitup.model;


import java.io.Serializable;
import java.sql.Blob;
import java.sql.Clob;
import java.sql.Timestamp;
import java.util.LinkedHashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.OrderBy;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.annotations.Expose;

@Entity
@Table(name = "Articles")
public class ArticleBean implements Serializable{

	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Expose
	private Integer articleId;
	@Expose
	private String title;
	@Expose
	private Integer authorId;
	@Expose
	private String authorName;
	@Expose
	private Timestamp publishTime;
	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "FK_ArticleCategoryBean_Category")
	@Expose
	private ArticleCategoryBean category;
	private Clob content;
	@Expose
	private String fileName;
	private Blob image;
	@Expose
	private Integer likes;
	private String status;
	@Transient
	private MultipartFile articleImage;
	
	@OneToMany(mappedBy = "article", cascade = CascadeType.ALL, fetch=FetchType.EAGER)
	@OrderBy(clause = "publishTime")
	@Expose
	Set<CommentBean> articleComments = new LinkedHashSet<>();

	public ArticleBean(Integer articleId, String title, Integer authorId, String authorName, Timestamp publishTime,
			ArticleCategoryBean category, Clob content, String fileName, Blob image, Integer likes, String status,
			Set<CommentBean> articleComments) {
		super();
		this.articleId = articleId;
		this.title = title;
		this.authorId = authorId;
		this.authorName = authorName;
		this.publishTime = publishTime;
		this.category = category;
		this.content = content;
		this.fileName = fileName;
		this.image = image;
		this.likes = likes;
		this.status = status;
		this.articleComments = articleComments;
	}

	public ArticleBean() {
		super();
	}

	public Integer getArticleId() {
		return articleId;
	}

	public void setArticleId(Integer articleId) {
		this.articleId = articleId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Integer getAuthorId() {
		return authorId;
	}

	public void setAuthorId(Integer authorId) {
		this.authorId = authorId;
	}

	public String getAuthorName() {
		return authorName;
	}

	public void setAuthorName(String authorName) {
		this.authorName = authorName;
	}

	public Timestamp getPublishTime() {
		return publishTime;
	}

	public void setPublishTime(Timestamp publishTime) {
		this.publishTime = publishTime;
	}

	public ArticleCategoryBean getCategory() {
		return category;
	}

	public void setCategory(ArticleCategoryBean category) {
		this.category = category;
	}

	public Clob getContent() {
		return content;
	}

	public void setContent(Clob content) {
		this.content = content;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public Blob getImage() {
		return image;
	}

	public void setImage(Blob image) {
		this.image = image;
	}

	public Integer getLikes() {
		return likes;
	}

	public void setLikes(Integer likes) {
		this.likes = likes;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public MultipartFile getArticleImage() {
		return articleImage;
	}

	public void setArticleImage(MultipartFile articleImage) {
		this.articleImage = articleImage;
	}


	public Set<CommentBean> getArticleComments() {
		return articleComments;
	}

	public void setArticleComments(Set<CommentBean> articleComments) {
		this.articleComments = articleComments;
	}

	
}
