package com.web.speakitup.service.impl;

import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.web.speakitup.dao.ProductDao;
import com.web.speakitup.model.CategoryBean;
import com.web.speakitup.model.ProductBean;
import com.web.speakitup.service.ProductService;

@Service
public class ProductServiceImpl implements ProductService {

	@Autowired
	ProductDao dao;

	public ProductServiceImpl() {
	}

	@Transactional
	@Override
	public void insertProduct(ProductBean pb) {
		dao.insertProduct(pb);
	}

	@Transactional
	@Override
	public int getTotalPages(String searchStr, String categoryTitle, String categoryName) {
		int n = 0;
		n = dao.getTotalPages(searchStr, categoryTitle, categoryName);
		return n;
	}

	@Override
	public long getRecordCounts() {
		return dao.getRecordCounts();
	}

	@Transactional
	@Override
	public Map<ProductBean, String> getPageProducts(int pageNo, String arrange, String searchStr, String categoryTitle,
			String categoryName) {
		Map<ProductBean, String> map = null;
		map = dao.getPageProducts(pageNo, arrange, searchStr, categoryTitle, categoryName);
		return map;
	}

	@Transactional
	@Override
	public Map<Integer, ProductBean> getFamousProducts(String categoryTitle) {
		Map<Integer, ProductBean> map = null;
		map = dao.getFamousProducts(categoryTitle);
		return map;
	}

	@Transactional
	@Override
	public Map<Integer, ProductBean> getProducts(String searchStr, String categoryTitle) {
		Map<Integer, ProductBean> map = null;
		map = dao.getProducts(searchStr, categoryTitle);
		return map;
	}

	@Transactional
	@Override
	public Set<CategoryBean> getCategorys(String categoryTitle) {
		Set<CategoryBean> set = null;
		set = dao.getCategorys(categoryTitle);
		return set;
	}

//	@Override
//	public String getCategoryTag() {
//		Session session = factory.getCurrentSession();
//		Transaction tx = null;
//		String tag = "";
//		try {
//			tx = session.beginTransaction();
//			tag = dao.getCategoryTag();
//			tx.commit();
//		} catch (Exception ex) {
//			if (tx != null)
//				tx.rollback();
//			ex.printStackTrace();
//			throw new RuntimeException(ex);
//		}
//		return tag;
//	}

//	@Override
//	public int updateBook(BookBean bean, long sizeInBytes) {
//		Session session = factory.getCurrentSession();
//		Transaction tx = null;
//		int n = 0;
//		try {
//			tx = session.beginTransaction();
//			n = dao.updateBook(bean, sizeInBytes);
//			tx.commit();
//		} catch (Exception ex) {
//			if (tx != null)
//				tx.rollback();
//			ex.printStackTrace();
//			throw new RuntimeException(ex);
//		}
//		return n;
//	}

	@Transactional
	@Override
	public int deleteProduct(int productId) {
		int n = 0;
		n = dao.deleteProduct(productId);
		return n;
	}

	@Transactional
	@Override
	public int deleteProductFormat(ProductBean pb) {
		int n = 0;
		n = dao.deleteProductFormat(pb);
		return n;
	}

//	@Override
//	public int saveBook(BookBean bean) {
//		Session session = factory.getCurrentSession();
//		Transaction tx = null;
//		int n = 0;
//		try {
//			tx = session.beginTransaction();
//			n = dao.saveBook(bean);
//			tx.commit();
//		} catch (Exception ex) {
//			if (tx != null)
//				tx.rollback();
//			ex.printStackTrace();
//			throw new RuntimeException(ex);
//		}
//		return n;
//	}

	@Transactional
	@Override
	public ProductBean getProduct(int productId) {
		ProductBean bean = null;
		bean = dao.getProduct(productId);
		return bean;
	}

	@Transactional
	@Override
	public CategoryBean getCategory(int categoryId) {
		CategoryBean bean = null;
		bean = dao.getCategory(categoryId);
		return bean;
	}

}
