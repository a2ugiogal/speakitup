package com.web.speakitup.model;


import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;




@Entity
@Table(name="Letters")
public class LetterBean {

	@Id
	@GeneratedValue(generator = "increment")
	@GenericGenerator(name = "increment", strategy = "native")
	private Integer letterId;
	private String 	letterTitle;
	private String 	letterWriter;
	private String sendTime;
	private String letterContent;
	private String letterCategory;
	private String letterReplier;
	private String replyContent;
	private String status;
	private String feedBack;
	
	
	
	public LetterBean(Integer letterId, String letterTitle, String letterWriter, String sendTime, String letterContent,
			String letterCategory, String letterReplier, String replyContent, String status, String feedBack) {
		super();
		this.letterId = letterId;
		this.letterTitle = letterTitle;
		this.letterWriter = letterWriter;
		this.sendTime = sendTime;
		this.letterContent = letterContent;
		this.letterCategory = letterCategory;
		this.letterReplier = letterReplier;
		this.replyContent = replyContent;
		this.status = status;
		this.feedBack = feedBack;
	}
	
	
	
	
	//寄信用
	public LetterBean(Integer letterId, String letterTitle, String letterWriter, String letterContent,String sendTime,
			String letterCategory,String status) {
		super();
		this.letterId = letterId;
		this.letterTitle = letterTitle;
		this.letterWriter = letterWriter;
		this.letterContent = letterContent;
		this.sendTime = sendTime;
		this.letterCategory = letterCategory;
		this.status = status;
	}




	//回信用
	public LetterBean(Integer letterId,String letterReplier, String replyContent, String status) {
		super();
		this.letterId = letterId;
		this.letterReplier = letterReplier;
		this.replyContent = replyContent;
		this.status = status;
	}


	public LetterBean() {
		
	}




	public Integer getLetterId() {
		return letterId;
	}
	public void setLetterId(Integer letterId) {
		this.letterId = letterId;
	}
	public String getLetterTitle() {
		return letterTitle;
	}
	public void setLetterTitle(String letterTitle) {
		this.letterTitle = letterTitle;
	}
	public String getLetterWriter() {
		return letterWriter;
	}
	public void setLetterWriter(String letterWriter) {
		this.letterWriter = letterWriter;
	}
	public String getSendTime() {
		return sendTime;
	}
	public void setSendTime(String sendTime) {
		this.sendTime = sendTime;
	}
	public String getLetterContent() {
		return letterContent;
	}
	public void setLetterContent(String letterContent) {
		this.letterContent = letterContent;
	}
	public String getLetterCategory() {
		return letterCategory;
	}
	public void setLetterCategory(String letterCategory) {
		this.letterCategory = letterCategory;
	}
	public String getLetterReplier() {
		return letterReplier;
	}
	public void setLetterReplier(String letterReplier) {
		this.letterReplier = letterReplier;
	}
	public String getReplyContent() {
		return replyContent;
	}
	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getFeedBack() {
		return feedBack;
	}
	public void setFeedBack(String feedBack) {
		this.feedBack = feedBack;
	}
	
	
	
	
	
}
