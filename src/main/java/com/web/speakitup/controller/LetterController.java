package com.web.speakitup.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TimeZone;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.web.speakitup._00_init.GlobalService;
import com.web.speakitup.model.LetterBean;
import com.web.speakitup.model.MemberBean;
import com.web.speakitup.service.LetterService;
import com.web.speakitup.service.MemberService;

@Controller
@RequestMapping("/letter")
public class LetterController {

	@Autowired
	MemberService memberService;

	@Autowired
	LetterService letterService;
	
	//及時刷新寄信的時間，萬一倒數計時到的話
	@GetMapping("/letterHomeForUpdate")
	public String letterHomeForUpdate(HttpSession session) {
		
		MemberBean mbOld = (MemberBean) session.getAttribute("LoginOK");
		MemberBean mb = memberService.getMember(mbOld.getId());
		session.removeAttribute("sendError");
		session.removeAttribute("replyError");
		session.setAttribute("LoginOK", mb);
		
		return "forward:/letter/letterHome"; 
	}
	
	// 漂流信首頁
	@GetMapping("/letterHome")
	public String letterHome(HttpSession session,HttpServletRequest request) {

		MemberBean mb = (MemberBean) session.getAttribute("LoginOK");
		String sendQuota = mb.getSendQuota();
		sendQuota = mb.getSendQuota();
		String replyQuota = mb.getReplyQuota();
		// 如果當天寄過信或是寄信欄是不是空的 就不能寄
		if (sendQuota.equals("false")) {
			session.setAttribute("sendError", "不能寄信");
		}
		if(replyQuota.equals("false")) {
			session.setAttribute("replyError", "不能回信");
		}
		return "driftLetter/letterInfo";
		
	}

	// 寄信區
	@GetMapping("/send")
	public String sendLetter() {
		return "driftLetter/send";
	}

	// 回信區
	@GetMapping("/reply")
	public String replyLetter(HttpSession session) {
		
		//先檢查會員的資料庫有沒有當天還沒回完的信 有的話直接轉跳
		MemberBean mb = (MemberBean) session.getAttribute("LoginOK");
		Integer letterIdoftheDay =  mb.getLetterOftheDay();
		if(letterIdoftheDay != null) {
			
		LetterBean lb = letterService.getLetter(letterIdoftheDay);
			session.setAttribute("lb", lb);
			
			return "driftLetter/replyLetters";
		}else {
			return "driftLetter/reply";
		}
	}

	@GetMapping("/sendAngelZone")
	public String sendAngel() {
		return "driftLetter/sendAngel";
	}

	@GetMapping("/sendDevilZone")
	public String sendDevil() {
		return "driftLetter/sendDevil";
	}

	@PostMapping("/sendAngel")
	public String sendAngel(HttpSession session, @RequestParam("title") String title,
			@RequestParam("letterContent") String content) {

		MemberBean mb = (MemberBean) session.getAttribute("LoginOK");
		//做個簡單的防止別人按上一頁重新寄信
		String SendQuota = mb.getSendQuota();
		if(SendQuota.equals("false")) {
			session.setAttribute("sendAgainError", "sendAgainError");
			return "redirect:/letter/letterHome";
		}
		String memberId = mb.getMemberId();
		// 取得現在日期 擺入信件資訊
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String sendDay = simpleDateFormat.format(new java.util.Date());
		
		LetterBean lb = new LetterBean(null, title, memberId, content, sendDay, GlobalService.LETTER_TYPE_ANGEL, "n");
		letterService.saveLetter(lb);
		
		mb.setSendQuota("false");
		memberService.updateSendQuota(memberId, mb.getSendQuota());
		System.out.println("mb.getSendQuota: "+mb.getSendQuota());
		return "redirect:/letter/letterHome";
	}

	// 寄信
	@PostMapping("/sendDevil")
	public String sendDevil(HttpSession session, @RequestParam("title") String title,
			@RequestParam("letterContent") String content) {

		MemberBean mb = (MemberBean) session.getAttribute("LoginOK");
		//做個簡單的防止別人按上一頁重新寄信
		String SendQuota = mb.getSendQuota();
		if(SendQuota.equals("false")) {
			session.setAttribute("sendAgainError", "sendAgainError");
			return "driftLetter/letterInfo";
		}
		
		//如果沒問題的話就存資料庫
		String memberId = mb.getMemberId();
		// 取得現在日期 擺入信件資訊
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String sendDay = simpleDateFormat.format(new java.util.Date());
		
		LetterBean lb = new LetterBean(null, title, memberId, content, sendDay, GlobalService.LETTER_TYPE_DEVIL, "n");
		letterService.saveLetter(lb);
		
		mb.setSendQuota("false");
		memberService.updateSendQuota(memberId, mb.getSendQuota());
		return "redirect:/letter/letterHome";

	}

	@GetMapping("/replyLetters/{type}")
	public String replyLetterAngel(@PathVariable("type")String type,HttpSession session,Model model) {
		
		MemberBean mb = (MemberBean) session.getAttribute("LoginOK");
		String memberId = mb.getMemberId();
		
		System.out.println("type:   " + type);
		LetterBean lb = null;
		// 去看當天有沒有撈過信了 有的話直接前往
		Integer letterIdoftheDay = mb.getLetterOftheDay();
		
		if(type.equals("天使")) {
			// 如果選擇的是天使主題
			if (letterIdoftheDay == null) {
				Map<Integer, LetterBean> letterMap = letterService.getUnfinishedLetter(memberId, "天使", "n");

				Integer mapSize = letterMap.size();
				Set<Integer> letterNo = letterMap.keySet();

				// 隨機取得信件編號的index值
				try {
					int randomNo = (int) (Math.random() * mapSize);
					Integer letterId = (Integer) letterNo.toArray()[randomNo];

					System.out.println("隨機index值:" + randomNo + "隨機數的key:" + letterId);
					lb = letterService.getLetter(letterId);

					// 把取得的letterId傳進mb物件裡面並更新
					mb.setLetterOftheDay(letterId);
					memberService.updateLetterOftheDay(memberId, letterId);
					letterService.updateLetterStatus(letterId, GlobalService.LETTER_STATUS_OCCUPIED);

					session.setAttribute("lb", lb);

				} catch (ArrayIndexOutOfBoundsException e) {
					System.out.println("無天使信可回");
					session.setAttribute("noLettersAngel", "noLetters");
					return "redirect:/letter/letterHome";

				} catch (Exception e) {
					e.printStackTrace();
				}

			} 

		}	
		//如果選擇的是回覆惡魔信件
		else {
			if (letterIdoftheDay == null) {

				//如果該信件的狀態是'n'(還沒被回過的話)
				Map<Integer, LetterBean> letterMap = letterService.getUnfinishedLetter(memberId, "惡魔", "n");
				//先取得那些信件的資訊(id,letter物件) 再把此map的key(也就是信件的id)取出
				Integer mapSize = letterMap.size();
				Set<Integer> letterNo = letterMap.keySet();
				System.out.println("有" + mapSize + " 封" + "信件編號為" + letterNo);

				// 隨機取得信件編號的index值
				try {
					int randomNo = (int) (Math.random() * mapSize);
					Integer letterId = (Integer) letterNo.toArray()[randomNo];
					System.out.println("隨機index值:" + randomNo + "隨機數的key:" + letterId);
					
					//取得此index值的信件
					lb = letterService.getLetter(letterId);
					session.setAttribute("lb", lb);

					// 更新信件狀態('o') 讓信件無法被其他會員取得 會員在同一天也只能拿到同樣的一封
					mb.setLetterOftheDay(letterId);
					memberService.updateLetterOftheDay(memberId, letterId);
					letterService.updateLetterStatus(letterId, GlobalService.LETTER_STATUS_OCCUPIED);

				} catch (ArrayIndexOutOfBoundsException e) {
					//沒信的話會進到此處
					System.out.println("無惡魔信可回");
					session.setAttribute("noLettersDevil", "noLetters");
					return "redirect:/letter/letterHome";
				} catch (Exception e) {
					e.printStackTrace();
				}
			} 

		}
		//最後再把取得的資訊送回給前端
		return "driftLetter/replyLetters";
	}
	
	//寄回信出去
	@PostMapping("/sendReplyContent")
	public String sendReplyContent(HttpSession session, @RequestParam("id") int letterId,
			@RequestParam("replyContent") String replyContent) {
		MemberBean mb = (MemberBean) session.getAttribute("LoginOK");

		String replyQuota = mb.getReplyQuota();
		if(replyQuota.equals("false")) {
			session.setAttribute("replyAgainError", "replyAgainError");
			return "driftLetter/letterInfo";
		}
		String replyierId = mb.getMemberId();
		LetterBean lb = letterService.getLetter(letterId);
		// 把資訊存入原本的信件裡
		lb = new LetterBean(letterId, replyierId, replyContent, "y");
		letterService.updateReply(lb);
		
		//把會員的寄信扣打改成false(不能寄信)
		mb.setReplyQuota("false");
		memberService.updateReplyQuota(replyierId, mb.getReplyQuota());
		return "redirect:/letter/letterHome";
	}


	//剛進來我的信件時，預設先給他天使類型的信件
	@GetMapping("/myLetters")
	public String myLetters(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		response.setCharacterEncoding("UTF-8");
		MemberBean mb = (MemberBean) session.getAttribute("LoginOK");
		String memberId = mb.getMemberId();
		String letterCategory = "天使";
		//取得已完成的信件(有寄信內容也有回信內容)
		List<LetterBean> letters = letterService.getAllLettersByMemberSend(memberId, GlobalService.LETTER_STATUS_DONE,
				letterCategory);
		if(letters.size() == 0) {
			model.addAttribute("noLetters", "noLetters");
		}else {
			model.addAttribute("letters", letters);
		}
		model.addAttribute("letterCategory", letterCategory);
		return "driftLetter/letters";
	}
	
	//進去頁面後 要切換信件類型時就採取AJAX的方式變換
	@PostMapping("/myLetters/{category}")
	public void myLetters(@PathVariable("category") String category, HttpSession session, HttpServletResponse response,HttpServletRequest request)
			throws IOException {
		response.setCharacterEncoding("UTF-8");
		MemberBean mb = (MemberBean) session.getAttribute("LoginOK");
		String memberId = mb.getMemberId();
		String letterCategory;
		
		//看前端送來的是何種類別的信件
		if (category.equals("devil")) {
			letterCategory = GlobalService.LETTER_TYPE_DEVIL;
		} else {
			letterCategory = GlobalService.LETTER_TYPE_ANGEL;
		}
		//取出該種類的信件 並把他轉成json資料送給前端去處理
		List<LetterBean> letters = letterService.getAllLettersByMemberSend(memberId, GlobalService.LETTER_STATUS_DONE,
				letterCategory);
		Gson gson = new GsonBuilder().excludeFieldsWithoutExposeAnnotation().create();
		try (PrintWriter out = response.getWriter()) {
			if(letters.size() == 0) {
				out.write("noLetters");
				out.flush();
			}else {
				out.write(gson.toJson(letters));
				out.flush();
				
			}
			
		}
	}
	
	//不喜歡的信
	@PostMapping("/deleteLetter")
	public void deleteLetters(@RequestParam("id") int letterId,HttpSession session,HttpServletResponse response) {
		response.setCharacterEncoding("UTF-8");
		LetterBean lb = letterService.getLetter(letterId);
		String feedBack = lb.getFeedback();
		if(feedBack == null || feedBack.equals("") || feedBack.equals("like")) {
			letterService.updateLetterFeedback(letterId, GlobalService.LETTER_BADFEEDBACK);
			System.out.println("不喜歡");
		}if(feedBack.equals("dislike")) {
			letterService.updateLetterFeedback(letterId, "");
			System.out.println("收回不喜歡");
		}
		try {
			PrintWriter out = response.getWriter();
			out.print("");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return;
	}	
	
	
	//在信件上按下正面回饋鈕 送回資料庫 回信的作者可以知道自己獲得正面回饋的數量
	@PostMapping("/likeLetter")
	public void likeLetters(@RequestParam("id") int letterId,HttpSession session,HttpServletResponse response) {
		response.setCharacterEncoding("UTF-8");
		//更新信件的回饋欄位
		
		LetterBean lb = letterService.getLetter(letterId);
		String feedBack = lb.getFeedback();
		if(feedBack == null || feedBack.equals("") || feedBack.equals("dislike")) {
			letterService.updateLetterFeedback(letterId, GlobalService.LETTER_FEEDBACK);
			System.out.println("喜歡");
		}if(feedBack.equals("like")) {
			letterService.updateLetterFeedback(letterId, "");
			System.out.println("收回喜歡");
		}
		try {
			PrintWriter out = response.getWriter();
			out.print("");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return;
	}
	
	}
