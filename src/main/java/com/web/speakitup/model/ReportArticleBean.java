package com.web.speakitup.model;

import java.io.Serializable;
import java.sql.Timestamp;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "ReportArticles")
public class ReportArticleBean implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer reportId;
	private Integer articleId;
	private String authorName;
	private Timestamp articlePublishTime;
	private String articleTitle;
	private String reporterId;
	private String reportItem;

	public ReportArticleBean(Integer reportId, Integer articleId, String authorName, Timestamp articlePublishTime,
			String articleTitle, String reporterId, String reportItem) {
		super();
		this.reportId = reportId;
		this.articleId = articleId;
		this.authorName = authorName;
		this.articlePublishTime = articlePublishTime;
		this.articleTitle = articleTitle;
		this.reporterId = reporterId;
		this.reportItem = reportItem;
	}

	public ReportArticleBean() {
		super();
	}

	public Integer getReportId() {
		return reportId;
	}

	public void setReportId(Integer reportId) {
		this.reportId = reportId;
	}

	public Integer getArticleId() {
		return articleId;
	}

	public void setArticleId(Integer articleId) {
		this.articleId = articleId;
	}

	public String getAuthorName() {
		return authorName;
	}

	public void setAuthorName(String authorName) {
		this.authorName = authorName;
	}

	public Timestamp getArticlePublishTime() {
		return articlePublishTime;
	}

	public void setArticlePublishTime(Timestamp articlePublishTime) {
		this.articlePublishTime = articlePublishTime;
	}

	public String getArticleTitle() {
		return articleTitle;
	}

	public void setArticleTitle(String articleTitle) {
		this.articleTitle = articleTitle;
	}

	public String getReporterId() {
		return reporterId;
	}

	public void setReporterId(String reporterId) {
		this.reporterId = reporterId;
	}

	public String getReportItem() {
		return reportItem;
	}

	public void setReportItem(String reportItem) {
		this.reportItem = reportItem;
	}

}
