package com.web.speakitup.model;


import java.util.LinkedHashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "ArticleCategory")
public class ArticleCategoryBean {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer categoryId;
	private String categoryTitle;
	private String categoryName;
	@OneToMany(mappedBy = "category", cascade = CascadeType.ALL)
	private Set<ArticleBean> articles = new LinkedHashSet<>();

	public ArticleCategoryBean(Integer categoryId, String categoryTitle, String categoryName,
			Set<ArticleBean> articles) {
		super();
		this.categoryId = categoryId;
		this.categoryTitle = categoryTitle;
		this.categoryName = categoryName;
		this.articles = articles;
	}

	public ArticleCategoryBean() {
		super();
	}

	public Integer getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(Integer categoryId) {
		this.categoryId = categoryId;
	}

	public String getCategoryTitle() {
		return categoryTitle;
	}

	public void setCategoryTitle(String categoryTitle) {
		this.categoryTitle = categoryTitle;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public Set<ArticleBean> getArticles() {
		return articles;
	}

	public void setArticles(Set<ArticleBean> articles) {
		this.articles = articles;
	}

}
