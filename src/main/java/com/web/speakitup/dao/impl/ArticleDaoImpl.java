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
import com.web.speakitup.dao.ArticleDao;
import com.web.speakitup.model.ArticleBean;
import com.web.speakitup.model.ArticleCategoryBean;
import com.web.speakitup.model.CommentBean;
import com.web.speakitup.model.MemberBean;
import com.web.speakitup.model.ReportArticleBean;
import com.web.speakitup.model.ReportCommentBean;

/* 查詢熱門文章: 是否要有 天使-時事 、熱門文章個數*/

@Repository
public class ArticleDaoImpl implements ArticleDao {

	private int recordsPerFamous = GlobalService.RECORDS_PER_FAMOUS;
	@Autowired
	SessionFactory factory;

	public ArticleDaoImpl() {
	}

	// 新增文章資料
	@Override
	public void insertArticle(ArticleBean ab) {
		Session session = factory.getCurrentSession();
		session.saveOrUpdate(ab);
	}

	// 新增留言資料
	@Override
	public void insertComment(CommentBean cb) {
		Session session = factory.getCurrentSession();
		session.saveOrUpdate(cb);
	}

	// 新增檢舉文章資料
	@Override
	public void insertReportArticle(ReportArticleBean rab) {
		Session session = factory.getCurrentSession();
		session.saveOrUpdate(rab);
	}

	// 新增檢舉留言資料
	@Override
	public void insertReportComment(ReportCommentBean rcb) {
		Session session = factory.getCurrentSession();
		session.saveOrUpdate(rcb);
	}

	// 刪除檢舉文章資料
	@Override
	public void deleteReportArticle(Integer articleId) {
		String hql = "DELETE FROM ReportArticleBean rab WHERE rab.articleId= :articleId";
		Session session = factory.getCurrentSession();
		session.createQuery(hql).setParameter("articleId", articleId).executeUpdate();
	}

	// 刪除檢舉留言資料
	@Override
	public void deleteReportComment(Integer commentId) {
		String hql = "DELETE FROM ReportCommentBean rcb WHERE rcb.commentId= :commentId";
		Session session = factory.getCurrentSession();
		session.createQuery(hql).setParameter("commentId", commentId).executeUpdate();
	}

	// 計算所有商品總共有幾頁
//	@Override
//	public int getTotalPages(String searchStr, String categoryTitle, String categoryName) {
//		if (searchStr == "" && categoryTitle == "" && categoryName == "") {
//			// 總共幾頁=無條件進位(共有幾個商品/一頁的商品數)
//			int totalPages = (int) (Math.ceil(getRecordCounts() / (double) recordsPerPage));
//			return totalPages;
//		} else {
//			return nowTotalPages;
//		}
//	}

	// 計算總共有多少商品
//	@SuppressWarnings("unchecked")
//	@Override
//	public long getRecordCounts() {
//		String hql = "SELECT count(*) FROM ProductBean";
//		Session session = factory.getCurrentSession();
//
//		long count = 0; // 必須使用 long 型態
//		List<Long> list = session.createQuery(hql).getResultList();
//		if (list.size() > 0) {
//			count = list.get(0);
//		}
//		return count;
//	}

	// 查詢文章
	@SuppressWarnings("unchecked")
	@Override
	public Map<ArticleBean, String> getArticles(String arrange, String searchStr, String categoryTitle,
			String categoryName) {
		// 預設的搜尋
		String hql = "SELECT ab FROM ArticleBean ab, ArticleCategoryBean acb WHERE ab.category=acb.categoryId "
				+ "AND ab.title LIKE :searchStr " + "AND acb.categoryTitle LIKE :categoryTitle "
				+ "AND acb.categoryName LIKE :categoryName " + "AND ab.status= :status " + "ORDER BY ab.likes DESC";
		Session session = factory.getCurrentSession();
		String[] arranges = GlobalService.ARTICLE_ARRANGE; // "popular", "time"
		Map<ArticleBean, String> map = new LinkedHashMap<>();
		List<ArticleBean> list = new ArrayList<ArticleBean>();

		// 判斷要如何排列
		if (arrange != "") {
			if (arrange.equals(arranges[1])) {
				hql = "SELECT ab FROM ArticleBean ab, ArticleCategoryBean acb WHERE ab.category=acb.categoryId "
						+ "AND ab.title LIKE :searchStr " + "AND acb.categoryTitle LIKE :categoryTitle "
						+ "AND acb.categoryName LIKE :categoryName " + "AND ab.status= :status "
						+ "ORDER BY ab.publishTime DESC";
			}
		}
		// 只取此頁的商品
		list = session.createQuery(hql).setParameter("searchStr", "%" + searchStr + "%")
				.setParameter("categoryTitle", "%" + categoryTitle + "%")
				.setParameter("categoryName", "%" + categoryName + "%").setParameter("status", "正常").getResultList();
		for (ArticleBean bean : list) {
			try {
				String content = GlobalService.clobToString(bean.getContent());
				map.put(bean, content);
			} catch (IOException | SQLException e) {
				e.printStackTrace();
			}
		}
		return map;
	}

	// 查詢個人文章
	@SuppressWarnings("unchecked")
	@Override
	public Map<ArticleBean, String> getPersonArticles(String arrange, String searchStr, MemberBean mb) {
		// 預設的搜尋
		String hql = "FROM ArticleBean ab WHERE ab.authorName = :memberId AND ab.title LIKE :searchStr AND ab.status= :status ORDER BY ab.articleId DESC";
		Session session = factory.getCurrentSession();
		String[] arranges = GlobalService.ARTICLE_ARRANGE; // "popular", "time"
		Map<ArticleBean, String> map = new LinkedHashMap<>();
		List<ArticleBean> list = new ArrayList<ArticleBean>();

		// 判斷要如何排列
		if (arrange.equals(arranges[0])) {
			hql = "FROM ArticleBean ab WHERE ab.authorName = :memberId AND ab.title LIKE :searchStr AND ab.status= :status ORDER BY ab.likes DESC";
		}
		// 只取此頁的商品
		list = session.createQuery(hql).setParameter("memberId", mb.getMemberId())
				.setParameter("searchStr", "%" + searchStr + "%").setParameter("status", "正常").getResultList();
		for (ArticleBean bean : list) {
			try {
				String content = GlobalService.clobToString(bean.getContent());
				map.put(bean, content);
			} catch (IOException | SQLException e) {
				e.printStackTrace();
			}
		}
		return map;
	}

	// 查詢熱門文章(天使or惡魔)
	@SuppressWarnings("unchecked")
	@Override
	public Map<Integer, ArticleBean> getFamousArticles(String categoryTitle) {
		String hql = "SELECT ab FROM ArticleBean ab,ArticleCategoryBean acb "
				+ "WHERE ab.category=acb.categoryId AND acb.categoryTitle= :categoryTitle "
				+ "AND ab.status= :status ORDER BY ab.likes DESC";
		Session session = factory.getCurrentSession();

		Map<Integer, ArticleBean> map = new LinkedHashMap<Integer, ArticleBean>();
		List<ArticleBean> list = new ArrayList<ArticleBean>();
		list = session.createQuery(hql).setParameter("categoryTitle", categoryTitle).setParameter("status", "正常")
				.setMaxResults(recordsPerFamous).getResultList();
		for (ArticleBean bean : list) {
			map.put(bean.getArticleId(), bean);
		}
		return map;
	}

	// 查詢文章類別
	@Override
	public ArticleCategoryBean getCategory(String categoryTitle, String categoryName) {
		String hql = "FROM ArticleCategoryBean acb " + "WHERE acb.categoryTitle like :categoryTitle "
				+ "AND acb.categoryName like :categoryName";
		Session session = factory.getCurrentSession();
		ArticleCategoryBean bean = null;
		bean = (ArticleCategoryBean) session.createQuery(hql).setParameter("categoryTitle", categoryTitle)
				.setParameter("categoryName", categoryName).getSingleResult();
		return bean;
	}

	// 查詢文章副板(天使or惡魔)
	@SuppressWarnings("unchecked")
	@Override
	public Set<String> getCategorys(String categoryTitle) {
		String hql = "FROM ArticleCategoryBean acb WHERE acb.categoryTitle= :categoryTitle ";
		Session session = factory.getCurrentSession();
		List<ArticleCategoryBean> beans = null;
		Set<String> categorySet = new LinkedHashSet<>();
		beans = session.createQuery(hql).setParameter("categoryTitle", categoryTitle).getResultList();
		for (ArticleCategoryBean bean : beans) {
			categorySet.add(bean.getCategoryName());
		}
		return categorySet;
	}

	// 喜歡文章
	@Override
	public Integer likeArticle(ArticleBean ab, MemberBean mb) {
		int n = 0;
		Session session = factory.getCurrentSession();
		// 更新文章愛心數
		String hql1 = "UPDATE ArticleBean ab SET ab.likes = likes + 1 WHERE ab.articleId = :articleId";
		n = session.createQuery(hql1).setParameter("articleId", ab.getArticleId()).executeUpdate();
		// 更新會員喜歡文章
		String hql2 = "SELECT mb.likeArticles FROM MemberBean mb WHERE mb.id = :id";
		String oldLikeArticles = (String) session.createQuery(hql2).setParameter("id", mb.getId()).getSingleResult();
		if (oldLikeArticles == null) {
			oldLikeArticles = ab.getArticleId().toString();
		} else {
			oldLikeArticles += "," + ab.getArticleId().toString();
		}
		String hql3 = "UPDATE MemberBean mb SET mb.likeArticles = :likeArticles WHERE mb.id = :id";
		session.createQuery(hql3).setParameter("likeArticles", oldLikeArticles).setParameter("id", mb.getId())
				.executeUpdate();
		return n;
	}

	// 查詢被檢舉文章
	@SuppressWarnings("unchecked")
	@Override
	public Map<ArticleBean, Integer> getReportArticles(String searchStr) {
		Session session = factory.getCurrentSession();
		Map<ArticleBean, Integer> map = new LinkedHashMap<>();
		List<ArticleBean> list = new ArrayList<ArticleBean>();

		String hql1 = "FROM ArticleBean ab WHERE ab.title LIKE :searchStr" + " AND ab.status= :status ";
		list = session.createQuery(hql1).setParameter("searchStr", "%" + searchStr + "%").setParameter("status", "正常")
				.getResultList();
		for (ArticleBean bean : list) {
			String hql2 = "FROM ReportArticleBean rab WHERE rab.articleId= :articleId";
			int count = session.createQuery(hql2).setParameter("articleId", bean.getArticleId()).getResultList().size();
			map.put(bean, count);
		}
		return map;
	}

	// 查詢被檢舉留言
	@SuppressWarnings("unchecked")
	@Override
	public Map<CommentBean, Integer> getReportComments(String searchStr) {
		Session session = factory.getCurrentSession();
		Map<CommentBean, Integer> map = new LinkedHashMap<>();
		List<CommentBean> list = new ArrayList<CommentBean>();

		String hql1 = "FROM CommentBean cb WHERE cb.content LIKE :searchStr" + " AND cb.status= :status ";
		list = session.createQuery(hql1).setParameter("searchStr", "%" + searchStr + "%").setParameter("status", "正常")
				.getResultList();
		for (CommentBean bean : list) {
			String hql2 = "FROM ReportCommentBean rcb WHERE rcb.commentId= :commentId";
			int count = session.createQuery(hql2).setParameter("commentId", bean.getCommentId()).getResultList().size();
			map.put(bean, count);
		}
		return map;
	}

	// 查詢被檢舉項目個數
	@Override
	public Integer getReportItemCount(String cmd, Integer id, String item) {
		String hql = "";
		Session session = factory.getCurrentSession();
		int count = 0;
		if (cmd.equals("article")) {
			hql = "FROM ReportArticleBean rab WHERE rab.articleId= :id AND reportItem= :item";
		} else if (cmd.equals("comment")) {
			hql = "FROM ReportCommentBean rcb WHERE rcb.commentId= :id AND reportItem= :item";
		}
		count = session.createQuery(hql).setParameter("id", id).setParameter("item", item).getResultList().size();

		return count;
	}

	// 查詢個人文章(含檢舉數)
	@SuppressWarnings("unchecked")
	@Override
	public Map<ArticleBean, Integer> getPersonArticle(Integer id) {
		Session session = factory.getCurrentSession();
		Map<ArticleBean, Integer> map = new LinkedHashMap<>();
		List<ArticleBean> list = new ArrayList<ArticleBean>();

		String hql1 = "FROM ArticleBean ab WHERE ab.authorId= :authorId" + " AND ab.status= :status ";
		list = session.createQuery(hql1).setParameter("authorId", id).setParameter("status", "正常").getResultList();
		for (ArticleBean bean : list) {
			String hql2 = "FROM ReportArticleBean rab WHERE rab.articleId= :articleId";
			int count = session.createQuery(hql2).setParameter("articleId", bean.getArticleId()).getResultList().size();
			map.put(bean, count);
		}
		return map;
	}

	// 查詢個人留言(含檢舉數)
	@SuppressWarnings("unchecked")
	@Override
	public Map<CommentBean, Integer> getPersonComment(Integer id) {
		Session session = factory.getCurrentSession();
		Map<CommentBean, Integer> map = new LinkedHashMap<>();
		List<CommentBean> list = new ArrayList<CommentBean>();

		String hql1 = "FROM CommentBean cb WHERE cb.authorId= :authorId" + " AND cb.status= :status ";
		list = session.createQuery(hql1).setParameter("authorId", id).setParameter("status", "正常").getResultList();
		for (CommentBean bean : list) {
			String hql2 = "FROM ReportCommentBean rcb WHERE rcb.commentId= :commentId";
			int count = session.createQuery(hql2).setParameter("commentId", bean.getCommentId()).getResultList().size();
			map.put(bean, count);
		}
		return map;
	}

	// 查詢個人被刪除文章(含檢舉數)
	@SuppressWarnings("unchecked")
	@Override
	public Map<ArticleBean, Integer> getPersonDeleteArticle(Integer id) {
		Session session = factory.getCurrentSession();
		Map<ArticleBean, Integer> map = new LinkedHashMap<>();
		List<ArticleBean> list = new ArrayList<ArticleBean>();

		String hql1 = "FROM ArticleBean ab WHERE ab.authorId= :authorId" + " AND ab.status= :status ";
		list = session.createQuery(hql1).setParameter("authorId", id).setParameter("status", "刪除").getResultList();
		for (ArticleBean bean : list) {
			String hql2 = "FROM ReportArticleBean rab WHERE rab.articleId= :articleId";
			int count = session.createQuery(hql2).setParameter("articleId", bean.getArticleId()).getResultList().size();
			map.put(bean, count);
		}
		return map;
	}

	// 查詢個人被刪除留言(含檢舉數)
	@SuppressWarnings("unchecked")
	@Override
	public Map<CommentBean, Integer> getPersonDeleteComment(Integer id) {
		Session session = factory.getCurrentSession();
		Map<CommentBean, Integer> map = new LinkedHashMap<>();
		List<CommentBean> list = new ArrayList<CommentBean>();

		String hql1 = "FROM CommentBean cb WHERE cb.authorId= :authorId" + " AND cb.status= :status ";
		list = session.createQuery(hql1).setParameter("authorId", id).setParameter("status", "刪除").getResultList();
		for (CommentBean bean : list) {
			String hql2 = "FROM ReportCommentBean rcb WHERE rcb.commentId= :commentId";
			int count = session.createQuery(hql2).setParameter("commentId", bean.getCommentId()).getResultList().size();
			map.put(bean, count);
		}
		return map;
	}

//	@SuppressWarnings("unchecked")
//	@Override
//	public List<String> getCategory() {
//		String hql = "SELECT DISTINCT category FROM ProductBean";
//		Session session = factory.getCurrentSession();
//		List<String> list = null;
//		list = session.createQuery(hql).getResultList();
//		return list;
//	}

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

	// 依bookId來刪除單筆記錄
//	@Override
//	public int deleteBook(int no) {
//		int n = 0;
//		Session session = factory.getCurrentSession();
//		BookBean bb = new BookBean();
//		bb.setBookId(no);
//		session.delete(bb);
//		n++;
//		return n;
//	}

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

	// 取得文章資料
	@Override
	public ArticleBean getArticle(int articleId) {
		Session session = factory.getCurrentSession();
		ArticleBean bean = null;
		bean = session.get(ArticleBean.class, articleId);
		return bean;
	}

	// 取得留言資料
	@Override
	public CommentBean getComment(int commentId) {
		Session session = factory.getCurrentSession();
		CommentBean bean = null;
		bean = session.get(CommentBean.class, commentId);
		return bean;
	}

}