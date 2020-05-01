package com.web.speakitup.model;


import java.sql.Timestamp;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "Comments")
public class CommentBean {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer commentId;
	private Integer authorId;
	private String authorName;
	private Timestamp publishTime;
	private String content;
	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "FK_ArticleBean_Article")
	private ArticleBean article;
	private String status;

	public CommentBean(Integer commentId, Integer authorId, String authorName, Timestamp publishTime, String content,
			ArticleBean article, String status) {
		super();
		this.commentId = commentId;
		this.authorId = authorId;
		this.authorName = authorName;
		this.publishTime = publishTime;
		this.content = content;
		this.article = article;
		this.status = status;
	}

	public CommentBean() {
		super();
	}

	public Integer getCommentId() {
		return commentId;
	}

	public void setCommentId(Integer commentId) {
		this.commentId = commentId;
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

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public ArticleBean getArticle() {
		return article;
	}

	public void setArticle(ArticleBean article) {
		this.article = article;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

}
