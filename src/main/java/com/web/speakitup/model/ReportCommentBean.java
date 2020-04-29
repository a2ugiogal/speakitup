package com.web.speakitup.model;

import java.io.Serializable;
import java.sql.Timestamp;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "ReportComments")
public class ReportCommentBean implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer reportId;
	private Integer commentId;
	private String authorName;
	private Timestamp commentPublishTime;
	private String commentContent;
	private String reporterId;
	private String reportItem;

	public ReportCommentBean(Integer reportId, Integer commentId, String authorName, Timestamp commentPublishTime,
			String commentContent, String reporterId, String reportItem) {
		super();
		this.reportId = reportId;
		this.commentId = commentId;
		this.authorName = authorName;
		this.commentPublishTime = commentPublishTime;
		this.commentContent = commentContent;
		this.reporterId = reporterId;
		this.reportItem = reportItem;
	}

	public ReportCommentBean() {
		super();
	}

	public Integer getReportId() {
		return reportId;
	}

	public void setReportId(Integer reportId) {
		this.reportId = reportId;
	}

	public Integer getCommentId() {
		return commentId;
	}

	public void setCommentId(Integer commentId) {
		this.commentId = commentId;
	}

	public String getAuthorName() {
		return authorName;
	}

	public void setAuthorName(String authorName) {
		this.authorName = authorName;
	}

	public Timestamp getCommentPublishTime() {
		return commentPublishTime;
	}

	public void setCommentPublishTime(Timestamp commentPublishTime) {
		this.commentPublishTime = commentPublishTime;
	}

	public String getCommentContent() {
		return commentContent;
	}

	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
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
