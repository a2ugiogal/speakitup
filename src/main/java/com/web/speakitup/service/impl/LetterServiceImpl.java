package com.web.speakitup.service.impl;

import java.util.List;
import java.util.Map;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.speakitup.dao.LetterDao;
import com.web.speakitup.model.LetterBean;
import com.web.speakitup.service.LetterService;

@Transactional
@Service
public class LetterServiceImpl implements LetterService{
	
	@Autowired
	LetterDao dao;
	
	
	@Override
	public void saveLetter(LetterBean lb) {		
		dao.saveLetter(lb);
	}
	
	
	
	@Override
	public LetterBean getLetter(int letterId) {
		LetterBean bean = null;
		bean =  dao.getLetter(letterId);
		return bean;
	}

	
	
	@Override
	public Map<Integer,LetterBean> getUnfinishedLetter(String memberId,String category,String status) {
		Map<Integer,LetterBean> letters = null;
		letters = dao.getUnfinishedLetter(memberId,category,status);
		return letters;
	}


	@Override
	public void updateReply(LetterBean lb) {
		dao.updateReply(lb);
		
	}



//	@Override
//	public Map<String,LetterBean> getAllLettersByMemberSend(String memberId,String status) {
//		return dao.getAllLettersByMemberSend(memberId,status);
//	}
	
	@Override
	public List<LetterBean> getAllLettersByMemberSend(String memberId,String status,String letterCategory) {
		return dao.getAllLettersByMemberSend(memberId,status,letterCategory);
	}



	@Override
	public void updateLetterStatus(int letterId, String status) {
		dao.updateLetterStatus(letterId, status);
		
	}



	@Override
	public void updateLetterFeedback(int letterId, String feedback) {
		dao.updateLetterFeedback(letterId, feedback);
		
	}
}
