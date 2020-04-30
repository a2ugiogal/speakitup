package com.web.speakitup.dao;

import com.web.speakitup.model.OrderItemBean;
import com.web.speakitup.model.ProductBean;
import com.web.speakitup.model.ShoppingCart;

public interface OrderItemDao {

	Integer updateProductStock(OrderItemBean oib, ProductBean pb, ShoppingCart cart);

	Integer updateProductStock(OrderItemBean oib, ProductBean pb);

}
