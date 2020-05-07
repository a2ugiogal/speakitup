package com.web.speakitup.service;

import java.util.Map;
import java.util.Set;

import com.web.speakitup.model.CategoryBean;
import com.web.speakitup.model.ProductBean;

public interface ProductService {

	void insertProduct(ProductBean pb);

	int getTotalPages(String searchStr, String categoryTitle, String categoryName);

	long getRecordCounts();

	Map<ProductBean, String> getPageProducts(int pageNo, String arrange, String searchStr, String categoryTitle,
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

	ProductBean getProduct(int productId);

	CategoryBean getCategory(int categoryId);

}
