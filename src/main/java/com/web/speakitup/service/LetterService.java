package com.web.speakitup.service;


import java.util.List;
import java.util.Map;

import com.web.speakitup.model.LetterBean;

public interface LetterService {
	
	public void saveLetter(LetterBean lb);
	
	public LetterBean getLetter(int letterId);
	
	public Map<Integer,LetterBean> getUnfinishedLetter(String memberId,String category,String status);
	
	public void updateReply(LetterBean lb);
	
	public void updateLetterStatus(int letterId,String status);
	
	public void updateLetterFeedback(int letterId,String feedback);
	
//	public Map<String,LetterBean> getAllLettersByMemberSend(String memberId,String status);
	public List<LetterBean> getAllLettersByMemberSend(String memberId,String status,String letterCategory);
	
	
	
	
}
