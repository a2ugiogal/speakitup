package com.web.speakitup.service.impl;

import java.io.IOException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.web.speakitup._00_init.GlobalService;
import com.web.speakitup.dao.MemberDao;
import com.web.speakitup.model.MemberBean;
import com.web.speakitup.service.MemberService;

@Transactional
@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberDao dao;

	public MemberServiceImpl() {
	}

	@Override
	public int saveMember(MemberBean mb) {
		int count = 0;
		dao.saveMember(mb);
		count++;
		return count;
	}

	@Override
	public Map<MemberBean, Integer> getMembers(String searchStr) {
		Map<MemberBean, Integer> map = null;
		map = dao.getMembers(searchStr);
		return map;
	}


	@Override
	public boolean idExists(String id) {
		boolean result;
		result = dao.idExists(id);
		return result;
	}

	@Override
	public boolean emailExists(String email) {
		boolean result;
		result = dao.emailExists(email);
		return result;

	}

	@Override
	public int updateMember(MemberBean mb) {
		int count = 0;
		dao.updateMember(mb);
		count++;
		return count;
	}

	@Override
	public MemberBean checkIdPassword(String memberId, String password) {
		MemberBean mb = null;
		mb = dao.checkIdPassword(memberId, password);
		return mb;
	}

	@Override
	public MemberBean getEmailValid(String emailCode) {
		MemberBean mb = null;
		mb = dao.getEmailValid(emailCode);
		return mb;
	}

	@Override
	public int updateMemberPassword(String memberId, String passwordNew) {
		int count = 0;
		dao.updateMemberPassword(memberId, passwordNew);
		count++;
		return count;
	}

	@Override
	public void updateSendQuota(String memberId, String sendQuota) {
		dao.updateSendQuota(memberId, sendQuota);

	}

	@Override
	public void updateReplyQuota(String memberId, String replyQuota) {
		dao.updateReplyQuota(memberId, replyQuota);
	}

	
	@Override
	public MemberBean getMember(int id) {
		MemberBean mb = null;
		mb = dao.getMember(id);
		return mb;
	}

	@Override
	public void updateMemberNoBlob(MemberBean mb) {
		dao.updateMemberNoBlob(mb);
		
	}
	
	@Override
	public void updateLetterOftheDay(String memberId, int letterId) {
		dao.updateLetterOftheDay(memberId, letterId);
	}

	
	@Override
	public void clearLetteroftheday() {
		System.out.println("clear的Service區域");
		dao.clearLetteroftheday();
	}
	
	@Override
	public void clearSendReplyQuota() {
		dao.clearSendReplyQuota();
	}
	
	@Override
	@Scheduled(cron = "30 28 16 * * *")
	public void letterScheduleWork() throws IOException{
		System.out.println("執行定期工作"); 
		String [] cmds = {"curl", "http://localhost:8080/speakitup/scheduledWork"};
		ProcessBuilder process = new ProcessBuilder(cmds);
		process.start();
	
	}

	


}
