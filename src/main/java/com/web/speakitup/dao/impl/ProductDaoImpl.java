package com.web.speakitup.dao.impl;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.web.speakitup._00_init.GlobalService;
import com.web.speakitup.dao.ProductDao;
import com.web.speakitup.model.CategoryBean;
import com.web.speakitup.model.OrderBean;
import com.web.speakitup.model.OrderItemBean;
import com.web.speakitup.model.ProductBean;

@Repository
public class ProductDaoImpl implements ProductDao {

	// 預設值：每頁6筆
	private int recordsPerPage = GlobalService.RECORDS_PER_PAGE;
	private int recordsPerFamous = GlobalService.RECORDS_PER_FAMOUS;

	@Autowired
	SessionFactory factory;

	public ProductDaoImpl() {
	}

	// 新增文章資料
	@Override
	public void insertProduct(ProductBean pb) {
		Session session = factory.getCurrentSession();
		session.save(pb);
	}

	// 計算搜尋的商品總共有幾頁
	@Override
	public int getTotalPages(String searchStr, String categoryTitle, String categoryName) {
		String hql = "SELECT pb FROM ProductBean pb, CategoryBean cb WHERE pb.category=cb.categoryId "
				+ "AND pb.productName LIKE :searchStr " + "AND cb.categoryTitle LIKE :categoryTitle "
				+ "AND cb.categoryName LIKE :categoryName ";
		Session session = factory.getCurrentSession();
		int count = session.createQuery(hql).setParameter("searchStr", "%" + searchStr + "%")
				.setParameter("categoryTitle", "%" + categoryTitle + "%")
				.setParameter("categoryName", "%" + categoryName + "%").getResultList().size();
		return (int) (Math.ceil(count / (double) recordsPerPage));
	}

	// 計算總共有多少商品
	@SuppressWarnings("unchecked")
	@Override
	public long getRecordCounts() {
		String hql = "SELECT count(*) FROM ProductBean";
		Session session = factory.getCurrentSession();

		long count = 0; // 必須使用 long 型態
		List<Long> list = session.createQuery(hql).getResultList();
		if (list.size() > 0) {
			count = list.get(0);
		}
		return count;
	}

	// 查詢某一頁的商品資料(頁數, 排序, 搜尋字串)
	@SuppressWarnings("unchecked")
	@Override
	public Map<ProductBean, String> getPageProducts(int pageNo, String arrange, String searchStr, String categoryTitle,
			String categoryName) {
		// 預設的搜尋
		String hql = "SELECT pb FROM ProductBean pb, CategoryBean cb WHERE pb.category=cb.categoryId "
				+ "AND pb.productName LIKE :searchStr " + "AND cb.categoryTitle LIKE :categoryTitle "
				+ "AND cb.categoryName LIKE :categoryName " + "ORDER BY pb.productId DESC";
		Session session = factory.getCurrentSession();
		String[] arranges = GlobalService.PRODUCT_ARRANGE; // "time", "popular", "price"
		Map<ProductBean, String> map = new LinkedHashMap<>();
		int startRecordNo = (pageNo - 1) * recordsPerPage;
		List<ProductBean> list = new ArrayList<ProductBean>();

		// 判斷要如何排列
		if (arrange != "") {
			if (arrange.equals(arranges[1])) {
				hql = "SELECT pb FROM ProductBean pb, CategoryBean cb WHERE pb.category=cb.categoryId "
						+ "AND pb.productName LIKE :searchStr " + "AND cb.categoryTitle LIKE :categoryTitle "
						+ "AND cb.categoryName LIKE :categoryName " + "ORDER BY pb.sales DESC";
			} else if (arrange.equals(arranges[2])) {
				hql = "SELECT pb FROM ProductBean pb, CategoryBean cb WHERE pb.category=cb.categoryId "
						+ "AND pb.productName LIKE :searchStr " + "AND cb.categoryTitle LIKE :categoryTitle "
						+ "AND cb.categoryName LIKE :categoryName " + "ORDER BY pb.price DESC";
			}
		}
		// 只取此頁的商品
		list = session.createQuery(hql).setParameter("searchStr", "%" + searchStr + "%")
				.setParameter("categoryTitle", "%" + categoryTitle + "%")
				.setParameter("categoryName", "%" + categoryName + "%").setFirstResult(startRecordNo)
				.setMaxResults(recordsPerPage).getResultList();
		for (ProductBean bean : list) {
			try {
				map.put(bean, GlobalService.clobToString(bean.getDetail()));
			} catch (IOException | SQLException e) {
				e.printStackTrace();
			}
		}
		return map;
	}

	// 查詢熱門商品(天使or惡魔)
	@SuppressWarnings("unchecked")
	@Override
	public Map<Integer, ProductBean> getFamousProducts(String categoryTitle) {
		String hql = "SELECT pb FROM ProductBean pb,CategoryBean cb WHERE pb.category=cb.categoryId AND cb.categoryTitle= :categoryTitle ORDER BY pb.sales DESC";
		Session session = factory.getCurrentSession();

		Map<Integer, ProductBean> map = new LinkedHashMap<Integer, ProductBean>();
		List<ProductBean> list = new ArrayList<ProductBean>();
		list = session.createQuery(hql).setParameter("categoryTitle", categoryTitle).setMaxResults(recordsPerFamous)
				.getResultList();
		for (ProductBean bean : list) {
			map.put(bean.getProductId(), bean);
		}
		return map;
	}

	// 取得所有商品
	@SuppressWarnings("unchecked")
	@Override
	public Map<Integer, ProductBean> getProducts(String searchStr, String categoryTitle) {
		String hql = "SELECT pb FROM ProductBean pb, CategoryBean cb WHERE pb.category=cb.categoryId "
				+ "AND pb.productName LIKE :searchStr " + "AND cb.categoryTitle= :categoryTitle "
				+ "ORDER BY pb.productId";
		Session session = factory.getCurrentSession();
		Map<Integer, ProductBean> map = new LinkedHashMap<Integer, ProductBean>();
		List<ProductBean> list = new ArrayList<ProductBean>();
		list = session.createQuery(hql).setParameter("searchStr", "%" + searchStr + "%")
				.setParameter("categoryTitle", categoryTitle).getResultList();
		for (ProductBean bean : list) {
			map.put(bean.getProductId(), bean);
		}
		return map;
	}

	// 查詢商品副類別(天使or惡魔)
	@SuppressWarnings("unchecked")
	@Override
	public Set<CategoryBean> getCategorys(String categoryTitle) {
		String hql = "FROM CategoryBean cb WHERE cb.categoryTitle= :categoryTitle ";
		Session session = factory.getCurrentSession();
		List<CategoryBean> beans = null;
		Set<CategoryBean> categorySet = new LinkedHashSet<>();
		beans = session.createQuery(hql).setParameter("categoryTitle", categoryTitle).getResultList();
		for (CategoryBean bean : beans) {
			categorySet.add(bean);
		}
		return categorySet;
	}

//	@Override
//	public String getCategoryTag() {
//		String ans = "";
//		List<String> list = getCategory();
//		ans += "<SELECT name='category'>";
//		for (String cate : list) {
//			if (cate.equals(selected)) {
//				ans += "<option value='" + cate + "' selected>" + cate + "</option>";
//			} else {
//				ans += "<option value='" + cate + "'>" + cate + "</option>";
//			}
//		}
//		ans += "</SELECT>";
//		return ans;
//	}

	// 修改一筆書籍資料
//	@Override
//	public int updateBook(BookBean bean, long sizeInBytes) {
//		int n = 0;
//		if (bean.getCompanyBean() == null) {
//			CompanyDao dao = new CompanyDaoImpl_Hibernate();
//			dao.setId(bean.getCompanyId());
//			CompanyBean cb = dao.getCompanyById();
//			bean.setCompanyBean(cb);
//		}
//		if (sizeInBytes == -1) { // 不修改圖片
//			n = updateBook(bean);
//			return n;
//		}
//		Session session = factory.getCurrentSession();
//		session.saveOrUpdate(bean);
//		n++;
//		return n;
//	}

	// 修改一筆書籍資料，不改圖片
//	public int updateBook(BookBean bean) {
//		int n = 0;
//		BookBean b0 = null;
//		Session session = factory.getCurrentSession();
//		b0 = session.get(BookBean.class, bean.getBookId());
//		bean.setStock(b0.getStock());
//		bean.setPriceStr(b0.getPriceStr());
//		bean.setCoverImage(b0.getCoverImage());
//		bean.setFileName(b0.getFileName());
//		session.evict(b0);
//		session.saveOrUpdate(bean);
//		n++;
//		return n;
//	}

	// 刪除商品
	@Override
	public int deleteProduct(int productId) {
		Session session = factory.getCurrentSession();
		int n = 0;
		ProductBean pb = getProduct(productId);
		session.delete(pb);
		n++;
		return n;
	}

	// 刪除某商品的所有規格
	@Override
	public int deleteProductFormat(ProductBean pb) {
		String hql = "DELETE FROM ProductFormatBean pfb WHERE pfb.product= :ProductBean ";
		Session session = factory.getCurrentSession();
		int n = 0;
		n = session.createQuery(hql).setParameter("ProductBean", pb).executeUpdate();
		return n;
	}

	// 新增一筆記錄---
//	@Override
//	public int saveBook(BookBean bean) {
//		int n = 0;
//		Session session = factory.getCurrentSession();
//		if (bean.getCompanyBean() == null) {
//			CompanyDao dao = new CompanyDaoImpl_Hibernate();
//			dao.setId(bean.getCompanyId());
//			CompanyBean cb = dao.getCompanyById();
//			bean.setCompanyBean(cb);
//		}
//		session.save(bean);
//		n++;
//		return n;
//	}

	// 更新銷售量
	@Override
	public int addSales(OrderBean ob) {
		int n = 0;
		Session session = factory.getCurrentSession();
		Set<OrderItemBean> orderItems = ob.getOrderItems();
		for (OrderItemBean oib : orderItems) {
			ProductBean pb = getProduct(oib.getProductId());
			String hql = "UPDATE ProductBean pb SET pb.sales = :sales WHERE pb.productId = :productId";
			session.createQuery(hql).setParameter("sales", pb.getProductId())
					.setParameter("productId", pb.getSales() + 1).executeUpdate();
			n++;
		}
		return n;
	}

	// 取得商品資料
	@Override
	public ProductBean getProduct(int productId) {
		Session session = factory.getCurrentSession();
		ProductBean bean = null;
		bean = session.get(ProductBean.class, productId);
		return bean;
	}

	// 取得分類資料
	@Override
	public CategoryBean getCategory(int categoryId) {
		Session session = factory.getCurrentSession();
		CategoryBean bean = null;
		bean = session.get(CategoryBean.class, categoryId);
		return bean;
	}

}