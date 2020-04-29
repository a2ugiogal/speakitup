package com.web.speakitup.dao;

import java.util.Map;
import java.util.Set;

import com.web.speakitup.model.CategoryBean;
import com.web.speakitup.model.OrderBean;
import com.web.speakitup.model.ProductBean;

public interface ProductDao {

	void insertProduct(ProductBean pb);

	int getTotalPages(String searchStr, String categoryTitle, String categoryName);

	long getRecordCounts();

	Map<Integer, ProductBean> getPageProducts(int pageNo, String arrange, String searchStr, String categoryTitle,
			String categoryName);

	Map<Integer, ProductBean> getFamousProducts(String categoryTitle);

	Map<Integer, ProductBean> getProducts(String searchStr, String categoryTitle);

	Set<CategoryBean> getCategorys(String categoryTitle);

//	String getCategoryTag();
//
//	int updateBook(BookBean bean, long sizeInBytes);
//
	int deleteProduct(int productId);

	int deleteProductFormat(ProductBean pb);
//
//	int saveBook(BookBean bean);

	int addSales(OrderBean pb);

	ProductBean getProduct(int productId);

	CategoryBean getCategory(int categoryId);

}