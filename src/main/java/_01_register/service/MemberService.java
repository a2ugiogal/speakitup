package _01_register.service;

import java.util.Map;

import _01_register.model.MemberBean;

public interface MemberService {

	public int saveMember(MemberBean mb);

	public Map<MemberBean, Integer> getMembers(String searchStr);

	public boolean idExists(String id);

	public boolean emailExists(String email);

	public int updateMember(MemberBean mb);

	public MemberBean checkIdPassword(String memberId, String password);

	public MemberBean getEmailValid(String emailCode);
	
	public void updateSendDate(String memberId,String sendDate);
	
	public void updateReplyDate(String memberId,String replyDate);
	

	public int updateMemberPassword(String memberId, String passwordNew);

	public MemberBean getMember(int id);

}
