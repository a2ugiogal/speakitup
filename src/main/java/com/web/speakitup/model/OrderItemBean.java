package com.web.speakitup.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "OrderItems")
public class OrderItemBean {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	Integer seqno;
	Integer productId;
	String productName;
	String formatContent1;
	String formatContent2;
	Integer unitPrice;
	Integer quantity;

	@ManyToOne
	@JoinColumn(name = "FK_OrderBean_orderNo")
	OrderBean orderBean;

	public OrderItemBean() {

	}

	public OrderItemBean(Integer seqno, Integer productId, String productName, String formatContent1,
			String formatContent2, Integer unitPrice, Integer quantity, OrderBean orderBean) {
		super();
		this.seqno = seqno;
		this.productId = productId;
		this.productName = productName;
		this.formatContent1 = formatContent1;
		this.formatContent2 = formatContent2;
		this.unitPrice = unitPrice;
		this.quantity = quantity;
		this.orderBean = orderBean;
	}

	public Integer getSeqno() {
		return seqno;
	}

	public void setSeqno(Integer seqno) {
		this.seqno = seqno;
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

	public String getFormatContent1() {
		return formatContent1;
	}

	public void setFormatContent1(String formatContent1) {
		this.formatContent1 = formatContent1;
	}

	public String getFormatContent2() {
		return formatContent2;
	}

	public void setFormatContent2(String formatContent2) {
		this.formatContent2 = formatContent2;
	}

	public Integer getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(Integer unitPrice) {
		this.unitPrice = unitPrice;
	}

	public Integer getQuantity() {
		return quantity;
	}

	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}

	public OrderBean getOrderBean() {
		return orderBean;
	}

	public void setOrderBean(OrderBean orderBean) {
		this.orderBean = orderBean;
	}
}
