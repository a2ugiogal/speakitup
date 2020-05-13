package com.web.speakitup.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;
import java.util.Set;

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

	// 漂流信首頁
	@GetMapping("/letterHome")
	public String letterHome(HttpSession session) {

		MemberBean mb = (MemberBean) session.getAttribute("LoginOK");

		System.out.println("memberId : " + mb.getMemberId());

		String sendQuota = mb.getSendQuota();
		String replyQuota = mb.getReplyQuota();
		System.out.println("本日寄信扣打:" + sendQuota);
		// 如果當天寄過信或是寄信欄是不是空的 就不能寄
		if (sendQuota.equals("false")) {
			System.out.println("不能寄信");
			session.setAttribute("sendError", "不能寄信");

		}
		if(replyQuota.equals("false")) {
			System.out.println("本日已寄");
			session.setAttribute("replyError", "不能寄信");
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
	public String replyLetter() {
		return "driftLetter/reply";
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
			@RequestParam("content") String content) {

		MemberBean mb = (MemberBean) session.getAttribute("LoginOK");
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
			@RequestParam("content") String content) {

		MemberBean mb = (MemberBean) session.getAttribute("LoginOK");
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

	@GetMapping("/replyLetterDevil")
	public String replyLetterDevil(HttpSession session) {

		MemberBean mb = (MemberBean) session.getAttribute("LoginOK");
		String memberId = mb.getMemberId();

		// 看mb物件裡有沒有當日信件
		LetterBean lb = null;
		Integer letterIdoftheDay = mb.getLetterOftheDay();
		if (letterIdoftheDay == null) {

			// 隨機取得信件編號的index值
			Map<Integer, LetterBean> letterMap = letterService.getUnfinishedLetter(memberId, "惡魔", "n");
			Integer mapSize = letterMap.size();
			Set<Integer> letterNo = letterMap.keySet();
			System.out.println("有" + mapSize + " 封" + "信件編號為" + letterNo);

			try {
				int randomNo = (int) (Math.random() * mapSize);
				Integer letterId = (Integer) letterNo.toArray()[randomNo];
				System.out.println("隨機index值:" + randomNo + "隨機數的key:" + letterId);

				lb = letterService.getLetter(letterId);
				session.setAttribute("lb", lb);

				// 更新信件狀態 讓信件無法被其他會員取得 會員在同一天也只能拿到同樣的一封
				mb.setLetterOftheDay(letterId);
				memberService.updateLetterOftheDay(memberId, letterId);
				letterService.updateLetterStatus(letterId, GlobalService.LETTER_STATUS_OCCUPIED);

			} catch (ArrayIndexOutOfBoundsException e) {
				System.out.println("無惡魔信可回");
				session.setAttribute("noLetters", "noLetters");
				return "redirect:/letter/letterHome";
			} catch (Exception e) {
				e.printStackTrace();
			}

			// 如果會員表格內已經有每天更新一次的信件ID 就會直接去撈取該信件
		} else {
			lb = letterService.getLetter(letterIdoftheDay);
			session.setAttribute("lb", lb);
			return "driftLetter/replyDevil";
		}

		return "driftLetter/replyDevil";
	}

	@GetMapping("/replyLetterAngel")
	public String replyLetterAngel(HttpSession session) {

		MemberBean mb = (MemberBean) session.getAttribute("LoginOK");
		String memberId = mb.getMemberId();

		// 去看當天有沒有撈過信了 有的話直接前往
		Integer letterIdoftheDay = mb.getLetterOftheDay();
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
				LetterBean lb = letterService.getLetter(letterId);

				// 把取得的letterId傳進mb物件裡面並更新
				mb.setLetterOftheDay(letterId);
				memberService.updateLetterOftheDay(memberId, letterId);
				letterService.updateLetterStatus(letterId, GlobalService.LETTER_STATUS_OCCUPIED);

				session.setAttribute("lb", lb);

			} catch (ArrayIndexOutOfBoundsException e) {
				System.out.println("無天使信可回");
				session.setAttribute("noLetters", "noLetters");
				return "redirect:/letter/letterHome";

			} catch (Exception e) {
				e.printStackTrace();
			}

		} else {
			LetterBean lb = letterService.getLetter(letterIdoftheDay);
			session.setAttribute("lb", lb);

			return "driftLetter/replyAngel";

		}

		return "driftLetter/replyAngel";
	}

	@PostMapping("/sendReplyContent")
	public String sendReplyContent(HttpSession session, @RequestParam("id") int letterId,
			@RequestParam("replyContent") String replyContent) {
		MemberBean mb = (MemberBean) session.getAttribute("LoginOK");
		String replyierId = mb.getMemberId();

		LetterBean lb = letterService.getLetter(letterId);
		// 把資訊存入原本的信件裡
		lb = new LetterBean(letterId, replyierId, replyContent, "y");
		letterService.updateReply(lb);
		
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
		List<LetterBean> letters = letterService.getAllLettersByMemberSend(memberId, GlobalService.LETTER_STATUS_DONE,
				letterCategory);
		model.addAttribute("letters", letters);
		model.addAttribute("letterCategory", letterCategory);
		return "driftLetter/letters";
	}
	
	//進去頁面後 要切換信件類型時就採取AJAX的方式變換
	@GetMapping("/myLetters/{category}")
	public void myLetters(@PathVariable("category") String category, HttpSession session, HttpServletResponse response,HttpServletRequest request)
			throws IOException {
		response.setCharacterEncoding("UTF-8");
		MemberBean mb = (MemberBean) session.getAttribute("LoginOK");
		String memberId = mb.getMemberId();
		String letterCategory;
		if (category.equals("devil")) {
			letterCategory = "惡魔";
		} else {
			letterCategory = "天使";
		}
		List<LetterBean> letters = letterService.getAllLettersByMemberSend(memberId, GlobalService.LETTER_STATUS_DONE,
				letterCategory);
		Gson gson = new GsonBuilder().excludeFieldsWithoutExposeAnnotation().create();
		try (PrintWriter out = response.getWriter()) {
			System.out.println(gson.toJson(letters));
			out.write(gson.toJson(letters));
			out.flush();
			
		}
	}
	
	@PostMapping("/deleteLetter")
	public void deleteLetters(@RequestParam("id") int letterId,HttpSession session,HttpServletResponse response) {
		System.out.println("不喜歡的信件ID" + letterId);
		response.setCharacterEncoding("UTF-8");
		letterService.updateLetterFeedback(letterId, GlobalService.LETTER_BADFEEDBACK);
		try {
			PrintWriter out = response.getWriter();
			out.print("");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return;
	}	
	
	
	@PostMapping("/likeLetter")
	public void likeLetters(@RequestParam("id") int letterId,HttpSession session,HttpServletResponse response) {
		System.out.println("喜歡的信件ID" + letterId);
		response.setCharacterEncoding("UTF-8");
		letterService.updateLetterFeedback(letterId, GlobalService.LETTER_FEEDBACK);
		try {
			PrintWriter out = response.getWriter();
			out.print("");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return;
	}
	
	

}
