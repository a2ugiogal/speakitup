package com.web.speakitup.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.web.speakitup.dao.OrderDao;
import com.web.speakitup.model.OrderBean;

@Repository
public class OrderDaoImpl implements OrderDao {

	@Autowired
	SessionFactory factory;

	public OrderDaoImpl() {
	}

	// 新增訂單資料
	@Override
	public void insertOrder(OrderBean ob) {
		Session session = factory.getCurrentSession();
		session.saveOrUpdate(ob);
	}

	// 取得某個會員的訂單資料
	@SuppressWarnings("unchecked")
	@Override
	public List<OrderBean> getMemberOrders(Integer memberId) {
		List<OrderBean> list = null;
		Session session = factory.getCurrentSession();
		String hql = "FROM OrderBean ob Where ob.memberId = :mid";
		list = session.createQuery(hql).setParameter("mid", memberId).getResultList();
		return list;
	}

	// 查詢訂單狀態
	public String checkOrderStatus(Integer orderNo) {
		OrderBean orderBean = null;
		String status = null;
		Session session = factory.getCurrentSession();
		String hql = "From OrderBean ob where ob.orderNo = :orderNo";
		orderBean = (OrderBean) session.createQuery(hql).setParameter("orderNo", orderNo).getSingleResult();
		if (orderBean.getShippingDate() == null) {
			status = "待出貨";
		} else if (orderBean.getArriveDate() == null) {
			status = "已出貨";
		} else {
			status = "完成";
		}
		return status;
	}

	// 取得所有訂單
	@SuppressWarnings("unchecked")
	@Override
	public List<OrderBean> getAllOrders(String searchStr) {
		List<OrderBean> list = null;
		Session session = factory.getCurrentSession();
		String hql = "FROM OrderBean ob WHERE ob.orderNo= :searchStr";

		if (searchStr.equals("")) {
			hql = "FROM OrderBean ob";
			list = session.createQuery(hql).getResultList();
		} else {
			hql = "FROM OrderBean ob WHERE ob.orderNo= :search";
			int search = 0;
			try {
				search = Integer.parseInt(searchStr);
			} catch (NumberFormatException e) {
				;
			}
			list = session.createQuery(hql).setParameter("search", search).getResultList();
		}
		return list;
	}

	// 取得訂單資料
	@Override
	public OrderBean getOrder(int orderNo) {
		Session session = factory.getCurrentSession();
		OrderBean bean = null;
		bean = session.get(OrderBean.class, orderNo);
		return bean;
	}

}
