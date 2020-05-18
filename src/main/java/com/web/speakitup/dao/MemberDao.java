package com.web.speakitup.dao;

import java.util.Map;

import com.web.speakitup.model.MemberBean;

public interface MemberDao {

	public int saveMember(MemberBean mb);

	public Map<MemberBean, Integer> getMembers(String searchStr);

	public boolean idExists(String id);

	public boolean emailExists(String email);

	public int updateMember(MemberBean mb);
	
	public void updateMemberNoBlob(MemberBean mb);

	public MemberBean checkIdPassword(String memberId, String password);

	public MemberBean getEmailValid(String emailCode);

	public void updateSendQuota(String memberId,String sendQuota);
	
	public void updateReplyQuota(String memberId,String replyQuota);
	
	public void updateLetterOftheDay(String memberId,int letterId);

	public int updateMemberPassword(String memberId, String passwordNew);

	public MemberBean getMember(int id);
	
	public void clearLetteroftheday();
	
	public void clearSendReplyQuota();

}