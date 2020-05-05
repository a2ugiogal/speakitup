package com.web.speakitup.model;

import java.io.Serializable;
import java.sql.Blob;
import java.sql.Clob;
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

import org.springframework.web.multipart.MultipartFile;

@Entity
@Table(name = "Products")
public class ProductBean implements Serializable{

	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer productId;
	private String productName;
	@ManyToOne(cascade = CascadeType.PERSIST)
	@JoinColumn(name = "FK_CategoryBean_Category")
	private CategoryBean category;
	private Integer price;
	private String fileName;
	private Blob image;
	private Clob detail;
	private Integer sales;
	@Transient
	private MultipartFile productImage;
	@OneToMany(mappedBy = "product", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
	Set<ProductFormatBean> productFormat = new LinkedHashSet<>();

	public ProductBean(Integer productId, String productName, CategoryBean category, Integer price, String fileName,
			Blob image, Clob detail, Integer sales, Set<ProductFormatBean> productFormat) {
		super();
		this.productId = productId;
		this.productName = productName;
		this.category = category;
		this.price = price;
		this.fileName = fileName;
		this.image = image;
		this.detail = detail;
		this.sales = sales;
		this.productFormat = productFormat;
	}

	public ProductBean() {
	}

	public Integer getProductId() {
		return productId;
	}

	public void setProductId(Integer productId) {
		this.productId = productId;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public CategoryBean getCategory() {
		return category;
	}

	public void setCategory(CategoryBean category) {
		this.category = category;
	}

	public Integer getPrice() {
		return price;
	}

	public void setPrice(Integer price) {
		this.price = price;
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

	public Clob getDetail() {
		return detail;
	}

	public void setDetail(Clob detail) {
		this.detail = detail;
	}

	public Integer getSales() {
		return sales;
	}

	public void setSales(Integer sales) {
		this.sales = sales;
	}

	public Set<ProductFormatBean> getProductFormat() {
		return productFormat;
	}

	public void setProductFormat(Set<ProductFormatBean> productFormat) {
		this.productFormat = productFormat;
	}

	public MultipartFile getProductImage() {
		return productImage;
	}

	public void setProductImage(MultipartFile productImage) {
		this.productImage = productImage;
	}

}
