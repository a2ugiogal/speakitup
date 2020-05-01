package com.web.speakitup.model;


import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "ProductFormat")
public class ProductFormatBean{
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer productFormatId;
	private String formatTitle1;
	private String formatContent1;
	private String formatTitle2;
	private String formatContent2;
	private Integer stock;
	@ManyToOne
	@JoinColumn(name = "FK_ProductBean_productId")
	private ProductBean product;

	public ProductFormatBean(Integer productFormatId, String formatTitle1, String formatContent1, String formatTitle2,
			String formatContent2, Integer stock, ProductBean product) {
		super();
		this.productFormatId = productFormatId;
		this.formatTitle1 = formatTitle1;
		this.formatContent1 = formatContent1;
		this.formatTitle2 = formatTitle2;
		this.formatContent2 = formatContent2;
		this.stock = stock;
		this.product = product;
	}

	public ProductFormatBean() {
	}

	public Integer getProductFormatId() {
		return productFormatId;
	}

	public void setProductFormatId(Integer productFormatId) {
		this.productFormatId = productFormatId;
	}

	public String getFormatTitle1() {
		return formatTitle1;
	}

	public void setFormatTitle1(String formatTitle1) {
		this.formatTitle1 = formatTitle1;
	}

	public String getFormatContent1() {
		return formatContent1;
	}

	public void setFormatContent1(String formatContent1) {
		this.formatContent1 = formatContent1;
	}

	public String getFormatTitle2() {
		return formatTitle2;
	}

	public void setFormatTitle2(String formatTitle2) {
		this.formatTitle2 = formatTitle2;
	}

	public String getFormatContent2() {
		return formatContent2;
	}

	public void setFormatContent2(String formatContent2) {
		this.formatContent2 = formatContent2;
	}

	public Integer getStock() {
		return stock;
	}

	public void setStock(Integer stock) {
		this.stock = stock;
	}

	public ProductBean getProduct() {
		return product;
	}

	public void setProduct(ProductBean product) {
		this.product = product;
	}

}
