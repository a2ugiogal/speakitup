package com.web.speakitup.model;

import java.io.Serializable;
import java.util.LinkedHashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

// 本類別封裝單筆書籍資料
@Entity
@Table(name = "ProductCategory")
public class CategoryBean implements Serializable{

	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer categoryId;
	private String categoryTitle;
	private String categoryName;
	@OneToMany(mappedBy = "category", cascade = CascadeType.ALL)
	private Set<ProductBean> products = new LinkedHashSet<>();

	public CategoryBean(Integer categoryId, String categoryTitle, String categoryName, Set<ProductBean> products) {
		super();
		this.categoryId = categoryId;
		this.categoryTitle = categoryTitle;
		this.categoryName = categoryName;
		this.products = products;
	}

	public CategoryBean() {
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

	public Set<ProductBean> getProducts() {
		return products;
	}

	public void setProducts(Set<ProductBean> products) {
		this.products = products;
	}

}
