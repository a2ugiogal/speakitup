package com.web.speakitup.service;

import java.util.List;

import com.web.speakitup.model.OrderBean;
import com.web.speakitup.model.ShoppingCart;

public interface OrderService {

	void insertOrder(OrderBean ob);

	void persistOrder(OrderBean ob);

	void persistOrder(OrderBean ob, ShoppingCart cart);

	List<OrderBean> getMemberOrders(Integer memberId);

	String checkOrderStatus(Integer orderNo);

	List<OrderBean> getAllOrders(String searchStr);

	OrderBean getOrder(int orderNo);

}
