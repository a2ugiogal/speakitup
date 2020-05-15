package com.web.speakitup.model;

import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentSkipListMap;

public class ShoppingCart {

	/* ConcurrentSkipListMap: 為了遍歷整個map */
	private Map<Integer, Map<OrderItemBean, Set<ProductFormatBean>>> cart = new ConcurrentSkipListMap<>();
	private Map<Integer, String> checkedMap = new ConcurrentSkipListMap<>();

	public ShoppingCart() {
	}

	public Map<Integer, Map<OrderItemBean, Set<ProductFormatBean>>> getContent() {
		return cart;
	}

	// 檢查有沒有勾起來(productFormatId, "y" or "n")
	public Map<Integer, String> getCheckedMap() {
		return checkedMap;
	}

	// 加入購物車(Map)
	public void addToCart(int productFormatId, OrderItemBean oib, Set<ProductFormatBean> formats) {
		if (oib.getQuantity() <= 0) {
			return;
		}
		// 如果購物車裡沒有此規格商品 => 加進購物車的map
		if (cart.get(productFormatId) == null) {
			Map<OrderItemBean, Set<ProductFormatBean>> orderMap = new LinkedHashMap<OrderItemBean, Set<ProductFormatBean>>();
			orderMap.put(oib, formats);
			checkedMap.put(productFormatId, "y");
			cart.put(productFormatId, orderMap);
		} else {
			// 如果有的話 取得在購物車裡該商品的ID
			Map<OrderItemBean, Set<ProductFormatBean>> orderMap = cart.get(productFormatId);
			OrderItemBean oiBean = orderMap.keySet().iterator().next();
			// 並把原有的數量加進來
			oiBean.setQuantity(oib.getQuantity() + oiBean.getQuantity());
		}
	}

	// 更動購物車內的商品數量
	public boolean changeQty(int productFormatId, int newQty) {
		System.out.println("changeQty");
		if (cart.get(productFormatId) != null) {
			System.out.println("changeQtyIN");
			Map<OrderItemBean, Set<ProductFormatBean>> orderMap = cart.get(productFormatId);
			OrderItemBean bean = orderMap.keySet().iterator().next();
			bean.setQuantity(newQty);
			return true;
		} else {
			return false;
		}
	}

	// 更動購物車內的商品規格
	public boolean changeFormat(int productFormatId, String content1, String content2) {
		if (cart.get(productFormatId) != null) {
			Map<OrderItemBean, Set<ProductFormatBean>> orderMap = cart.get(productFormatId);
			OrderItemBean bean = orderMap.keySet().iterator().next();
			if (content1 != null) {
				bean.setFormatContent1(content1);
			}
			if (content2 != null) {
				bean.setFormatContent2(content2);
			}
			return true;
		} else {
			return false;
		}

	}

	// 更動購物車內的商品選取項(單項)
	public boolean changeChecked(int productFormatId, String choose) {
		if (cart.get(productFormatId) != null) {
			// 如果有勾單選，就把checkMap裡此productFormatId的value改成y
			if (choose.equals("true")) {
				checkedMap.put(productFormatId, "y");
			} else {
				checkedMap.put(productFormatId, "n");
			}
			return true;
		} else {
			return false;
		}
	}

	// 更動購物車內的商品選取項(全選)
	public void changeAllChecked(String chooseAll) {
		Set<Integer> productFormatIds = checkedMap.keySet();
		for (int productFormatId : productFormatIds) {
			// 如果有勾全選，就把所有的checkMap裡的value改成y
			if (chooseAll.equals("true")) {
				checkedMap.put(productFormatId, "y");
			} else {
				checkedMap.put(productFormatId, "n");
			}
		}
	}

	// 刪除購物車內的商品
	public int deleteProduct(int productFormatId) {
		if (cart.get(productFormatId) != null) {
			// checkedMap要記得一並刪除
			if (checkedMap.get(productFormatId) != null) {
				checkedMap.remove(productFormatId);
			}
			cart.remove(productFormatId);
			return 1;
		} else {
			return 0;
		}
	}

	// 計算結帳時的商品價格加總
	public int getFinalSubtotal() {
		Integer finalTotal = 0;
		Set<Integer> set = cart.keySet();
		Set<Integer> checkedSet = checkedMap.keySet();
		for (Integer n : set) {
			for (Integer j : checkedSet) {
				if (n.equals(j) && checkedMap.get(j).equals("y")) {
					Map<OrderItemBean, Set<ProductFormatBean>> orderMap = cart.get(n);
					OrderItemBean oib = orderMap.keySet().iterator().next();
					Integer price = oib.getUnitPrice();
					Integer quantity = oib.getQuantity();
					finalTotal += price * quantity;
				}
			}
		}
		return finalTotal;
	}

	// 計算購物車內的商品價格加總
	public int getSubtotal() {
		Integer subTotal = 0;
		Set<Integer> set = cart.keySet();
		for (Integer n : set) {
			Map<OrderItemBean, Set<ProductFormatBean>> orderMap = cart.get(n);
			OrderItemBean oib = orderMap.keySet().iterator().next();
			Integer price = oib.getUnitPrice();
			Integer quantity = oib.getQuantity();
			subTotal += price * quantity;
		}
		return subTotal;
	}

}
