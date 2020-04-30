package com.web.speakitup.dao.impl;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.NoResultException;

import org.hibernate.NonUniqueResultException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.web.speakitup.dao.MemberDao;
import com.web.speakitup.model.MemberBean;

@Repository
public class MemberDaoImpl implements MemberDao {

	@Autowired
	SessionFactory factory;

	public MemberDaoImpl() {
	}

	// 新增會員資料
	public int saveMember(MemberBean mb) {
		int n = 0;
		Session session = factory.getCurrentSession();
		session.saveOrUpdate(mb);
		n++;
		return n;
	}

	// 查詢全部會員
	@SuppressWarnings("unchecked")
	@Override
	public Map<MemberBean, Integer> getMembers(String searchStr) {
		Session session = factory.getCurrentSession();
		Map<MemberBean, Integer> map = new LinkedHashMap<>();
		List<MemberBean> list = new ArrayList<MemberBean>();

		String hql1 = "FROM MemberBean mb WHERE mb.memberId LIKE :searchStr " + " OR  mb.permission LIKE :searchStr "
				+ " OR  mb.status LIKE :searchStr ";
		list = session.createQuery(hql1).setParameter("searchStr", "%" + searchStr + "%").getResultList();

		for (MemberBean bean : list) {
			String hql2 = "FROM ArticleBean ab WHERE ab.authorId= :authorId " + " AND ab.status= :status";
			int count1 = session.createQuery(hql2).setParameter("authorId", bean.getId()).setParameter("status", "刪除")
					.getResultList().size();
			String hql3 = "FROM CommentBean cb WHERE cb.authorId= :authorId " + " AND cb.status= :status";
			int count2 = session.createQuery(hql3).setParameter("authorId", bean.getId()).setParameter("status", "刪除")
					.getResultList().size();
			int totalCount = count1 + count2;
			map.put(bean, totalCount);
		}
		return map;
	}

	// 判斷帳號是否已經被使用，如果是傳回true， 否則傳回false
	@Override
	public boolean idExists(String id) {
		boolean exist = false;
		String hql = "FROM MemberBean m WHERE m.memberId = :id";
		Session session = factory.getCurrentSession();
		try {
			session.createQuery(hql).setParameter("id", id).getSingleResult();
			exist = true;
		} catch (NonUniqueResultException e) {
			exist = true;
		} catch (NoResultException e) {
			exist = false;
		}
		return exist;
	}

	// 判斷信箱是否已經被使用，如果是傳回true， 否則傳回false
	@Override
	public boolean emailExists(String email) {
		boolean exist = false;
		String hql = "FROM MemberBean m WHERE m.email = :email";
		Session session = factory.getCurrentSession();
		try {
			session.createQuery(hql).setParameter("email", email).getSingleResult();
			exist = true;
		} catch (NoResultException ex) {
			exist = false;
		}
		return exist;

	}

	// 更新會員資料
	@Override
	public int updateMember(MemberBean mb) {
		int n = 0;
		Session session = factory.getCurrentSession();
		String hql0 = "UPDATE MemberBean m SET m.email = :email, m.phone = :phone, m.city = :city, "
				+ "m.area = :area, m.address = :address, m.fileName = :fileName, "
				+ "m.picture = :picture ,m.lastSendDate = :sendDate,"
				+ "m.lastReplyDate = :replyDate  WHERE m.id = :id";
		session.createQuery(hql0).setParameter("email", mb.getEmail()).setParameter("phone", mb.getPhone())
				.setParameter("city", mb.getCity()).setParameter("area", mb.getArea())
				.setParameter("address", mb.getAddress()).setParameter("fileName", mb.getFileName())
				.setParameter("picture", mb.getPicture()).setParameter("id", mb.getId())
				.setParameter("sendDate", mb.getLastSendDate()).setParameter("replyDate", mb.getLastReplyDate())
				.executeUpdate();
		n++;
		return n;
	}

	// 檢查使用者在登入時輸入的帳號與密碼是否正確
	@SuppressWarnings("unchecked")
	@Override
	public MemberBean checkIdPassword(String memberId, String password) {
		MemberBean mb = null;
		List<MemberBean> beans = null;
		String hql = "FROM MemberBean m WHERE m.memberId = :id and m.password = :password";
		Session session = factory.getCurrentSession();
		beans = session.createQuery(hql).setParameter("id", memberId).setParameter("password", password)
				.getResultList();
		if (beans.size() > 0) {
			mb = beans.get(0);
		}
		return mb;
	}

	@SuppressWarnings("unchecked")
	@Override
	public MemberBean getEmailValid(String emailCode) {
		MemberBean mb = null;
		List<MemberBean> beans = null;
		String hql = "FROM MemberBean m WHERE m.authToken = :emailCode";
		Session session = factory.getCurrentSession();

		beans = session.createQuery(hql).setParameter("emailCode", emailCode).getResultList();
		if (beans.size() > 0) {
			mb = beans.get(0);
		}
		return mb;
	}

	@Override
	public int updateMemberPassword(String memberId, String passwordNew) {
		int n = 0;
		Session session = factory.getCurrentSession();
		String hql = "UPDATE MemberBean m SET m.password = :password WHERE m.memberId = :memberId";
		session.createQuery(hql).setParameter("memberId", memberId).setParameter("password", passwordNew)
				.executeUpdate();
		n++;
		return n;
	}

	@Override
	public void updateSendDate(String memberId, String sendDate) {
		Session session = factory.getCurrentSession();
		String hql = "UPDATE MemberBean m SET m.lastSendDate = :sendDate WHERE m.memberId = :memberId";
		session.createQuery(hql).setParameter("sendDate", sendDate).setParameter("memberId", memberId).executeUpdate();
	}

	@Override
	public void updateReplyDate(String memberId, String replyDate) {
		Session session = factory.getCurrentSession();
		String hql = "UPDATE MemberBean m SET m.lastReplyDate = :replyDate WHERE m.memberId = :memberId";
		session.createQuery(hql).setParameter("replyDate", replyDate).setParameter("memberId", memberId)
				.executeUpdate();

	}

	// 取得會員資料
	@Override
	public MemberBean getMember(int id) {
		Session session = factory.getCurrentSession();
		MemberBean mb = null;
		mb = session.get(MemberBean.class, id);
		return mb;

	}

	@Override
	public void updateMemberNoBlob(MemberBean mb) {
		Session session = factory.getCurrentSession();
		System.out.println("new");
		String hql0 = "UPDATE MemberBean m SET m.email = :email, m.phone = :phone, m.city = :city, "
				+ "m.area = :area, m.address = :address WHERE m.id = :id";
		session.createQuery(hql0).setParameter("email", mb.getEmail()).setParameter("phone", mb.getPhone())
				.setParameter("city", mb.getCity()).setParameter("area", mb.getArea())
				.setParameter("address", mb.getAddress()).setParameter("id", mb.getId()).executeUpdate();

	}

}
