package com.web.speakitup.dao;

import java.util.List;

import com.web.speakitup.model.OrderBean;

public interface OrderDao {

	void insertOrder(OrderBean ob);

	List<OrderBean> getMemberOrders(Integer memberId);

	String checkOrderStatus(Integer orderNo);

	List<OrderBean> getAllOrders(String searchStr);

	OrderBean getOrder(int orderNo);

}
