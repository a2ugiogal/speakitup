package com.web.speakitup.model;

import java.io.Serializable;
import java.sql.Blob;
import java.sql.Date;
import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.GenericGenerator;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.annotations.Expose;

@Entity
@Table(name = "Members")
@Component
public class MemberBean implements Serializable{

	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(generator = "increment")
	@GenericGenerator(name = "increment", strategy = "native")
	@Expose
	private Integer id;
	@Expose
	private String memberId;
	private String password;
	@Expose
	private String gender;
	@Expose
	private Date birthday;
	@Expose
	private String email;
	@Expose
	private String phone;
	@Expose
	private String city;
	@Expose
	private String area;
	@Expose
	private String address;
	private String fileName;
	private Blob picture;
	private Timestamp createTime;
	private String status;
	@Expose
	private String permission;
	private String likeArticles;
	private String authToken;
	private String sendQuota;
	private String replyQuota;
	private Integer letterOftheDay;
	@Transient
	private MultipartFile memberImage;

	
	
	
	
	public MemberBean(Integer id, String memberId, String password, String gender, Date birthday, String email,
			String phone, String city, String area, String address, String fileName, Blob picture, Timestamp createTime,
			String status, String permission, String likeArticles, String authToken, String sendQuota,
			String replyQuota, Integer letterOftheDay) {
		super();
		this.id = id;
		this.memberId = memberId;
		this.password = password;
		this.gender = gender;
		this.birthday = birthday;
		this.email = email;
		this.phone = phone;
		this.city = city;
		this.area = area;
		this.address = address;
		this.fileName = fileName;
		this.picture = picture;
		this.createTime = createTime;
		this.status = status;
		this.permission = permission;
		this.likeArticles = likeArticles;
		this.authToken = authToken;
		this.sendQuota = sendQuota;
		this.replyQuota = replyQuota;
		this.letterOftheDay = letterOftheDay;
	}

	public MemberBean(Integer id, String email, String phone, String city, String area, String address,
			String fileName,Blob picture) {
		super();
		this.id = id;
		this.email = email;
		this.phone = phone;
		this.city = city;
		this.area = area;
		this.address = address;
		this.fileName = fileName;
		this.picture = picture;
	}

	public MemberBean(Integer id, String email, String phone, String city, String area, String address) {
		super();
		this.id = id;
		this.email = email;
		this.phone = phone;
		this.city = city;
		this.area = area;
		this.address = address;
		
	}

	public MemberBean() {
		super();
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public Blob getPicture() {
		return picture;
	}

	public void setPicture(Blob picture) {
		this.picture = picture;
	}

	public Timestamp getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getPermission() {
		return permission;
	}

	public void setPermission(String permission) {
		this.permission = permission;
	}

	public String getLikeArticles() {
		return likeArticles;
	}

	public void setLikeArticles(String likeArticles) {
		this.likeArticles = likeArticles;
	}

	public String getAuthToken() {
		return authToken;
	}

	public void setAuthToken(String authToken) {
		this.authToken = authToken;
	}

	public String getSendQuota() {
		return sendQuota;
	}

	public void setSendQuota(String sendQuota) {
		this.sendQuota = sendQuota;
	}


	public MultipartFile getMemberImage() {
		return memberImage;
	}

	public void setMemberImage(MultipartFile memberImage) {
		this.memberImage = memberImage;
	}



	public Integer getLetterOftheDay() {
		return letterOftheDay;
	}



	public void setLetterOftheDay(Integer letterOftheDay) {
		this.letterOftheDay = letterOftheDay;
	}

	public String getReplyQuota() {
		return replyQuota;
	}

	public void setReplyQuota(String replyQuota) {
		this.replyQuota = replyQuota;
	}

}
