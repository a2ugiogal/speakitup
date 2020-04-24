package _01_register.controller;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.Date;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import _00_init.util.GlobalService;
import _00_init.util.SendEmail;
import _01_register.model.MemberBean;
import _01_register.service.MemberService;

/* 未完成: 網址列上顯示.jsp */

@MultipartConfig(location = "", fileSizeThreshold = 5 * 1024 * 1024, maxFileSize = 1024 * 1024
		* 500, maxRequestSize = 1024 * 1024 * 500 * 5)
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		// 使用逾時，回首頁
		HttpSession session = request.getSession(false);
		if (session == null) {
			response.sendRedirect(getServletContext().getContextPath() + "/index.jsp");
			return;
		}

		// 準備存放錯誤訊息的Map物件
		Map<String, String> errorMsg = new HashMap<String, String>();
		request.setAttribute("errorMsg", errorMsg); // 顯示錯誤訊息

		String memberId = "";
		String password = "";
		String gender = "";
		String city = "";
		String area = "";
		String address = "";
		Date birthday = null;
		String email = "";
		String phone = "";
		String fileName = "";
		long sizeInBytes = 0;
		InputStream is = null;

		// 取出HTTP multipart request內所有的parts
		Collection<Part> parts = request.getParts();
		// 由parts != null來判斷此上傳資料是否為HTTP multipart request
		if (parts != null) { // 如果這是一個上傳資料的表單
			for (Part p : parts) {
				String fldName = p.getName();
				String value = request.getParameter(fldName);
				// 逐項讀取使用者輸入資料
				if (p.getContentType() == null) {
					if (fldName.equals("memberId")) {
						memberId = value;
					} else if (fldName.equals("password")) {
						password = value;
					} else if (fldName.equals("gender")) {
						gender = value;
					} else if (fldName.equals("county")) {
						city = value;
					} else if (fldName.equals("district")) {
						area = value;
					} else if (fldName.equals("address")) {
						address = value;
					} else if (fldName.equals("birthday")) {
						try {
							SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
							java.util.Date date = simpleDateFormat.parse(value);
							birthday = new Date(date.getTime());
						} catch (ParseException e) {
							e.printStackTrace();
						}
					} else if (fldName.equals("email")) {
						email = value;
					} else if (fldName.equals("phone")) {
						phone = value;
					}
				} else {
					// 取出圖片檔的檔名
					fileName = p.getSubmittedFileName();
					// 調整圖片檔檔名的長度，需要檔名中的附檔名，所以調整主檔名以免檔名太長無法寫入表格
					fileName = GlobalService.adjustFileName(fileName, GlobalService.IMAGE_FILENAME_LENGTH);
					if (fileName != null && fileName.trim().length() > 0) {
						sizeInBytes = p.getSize();
						is = p.getInputStream();
					}
				}
			}

		} else {
			System.out.println("此表單不是上傳檔案的表單(RegisterServlet)");
		}
		// 呼叫MemberDao的idExists方法(經由MemberService)
		// 檢查帳號是否已經存在，已存在的帳號不能使用，回傳相關訊息通知使用者修改
		WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(getServletContext());
		MemberService service = ctx.getBean(MemberService.class);
		if (service.idExists(memberId)) {
			memberId = "";
			errorMsg.put("errorId", "此帳號已存在");
		}
		// 檢查信箱是否已經存在，已存在的帳號不能使用，回傳相關訊息通知使用者修改
		if (service.emailExists(email)) {
			email = "";
			errorMsg.put("errorEmail", "此信箱已被註冊");
		}
		try {
			// 為了配合Hibernate的版本。要在此加密，不要在 dao.saveMember(mem)進行加密
			password = GlobalService.getMD5Endocing(GlobalService.encryptString(password));
			Timestamp ts = new java.sql.Timestamp(System.currentTimeMillis());
			
			String authToken = GlobalService.getMD5Endocing(GlobalService.encryptString(email));
			Blob blob = null;
			if (is != null) {
				blob = GlobalService.fileToBlob(is, sizeInBytes);
			}
			// 將所有會員資料封裝到MemberBean(類別的)物件

			MemberBean mb = new MemberBean(null, memberId, password, gender, birthday, email, phone, city, area,
					address, fileName, blob, ts, "未驗證", "一般會員", null, authToken,null,null);

			// 如果有錯誤
			if (!errorMsg.isEmpty()) {
				request.setAttribute("mb", mb);
				// 導向原來輸入資料的畫面，這次會顯示錯誤訊息
				RequestDispatcher rd = request.getRequestDispatcher("/_01_register/register.jsp");
				rd.forward(request, response);
				return;
			}
			// 呼叫MemberDao的saveMember方法
			int n = service.saveMember(mb);
			
			if (n == 1) {
				String subject = null;
				StringBuilder content = new StringBuilder();
				String[] memberEmail = {mb.getEmail()};
				subject = "歡迎你加入要抒啦的會員";
				content.setLength(0);
				content.append("<p>" + "請點選以下連結" + "</p>" + "<br>" + 
				GlobalService.DOMAIN_PATTERN + "/EmailVerify" + "?" + "emailCode=" + authToken  +"<br>"
				+"<p>" + "進入連結後即認證成功，可以去抒發一下了!" + "</p>");
							
				Thread sendEmail = new SendEmail(memberEmail, subject,content.toString(),"");
				System.out.println(memberEmail[0]);
				sendEmail.start();
				
				request.setAttribute("registerOK", "registerOK");
				response.sendRedirect(getServletContext().getContextPath() + "/index.jsp");
				
			} else {
				System.out.println(n);
				System.out.println("更新此筆資料有誤(RegisterServlet)");
				RequestDispatcher rd = request.getRequestDispatcher("/_01_register/register.jsp");
				rd.forward(request, response);
				return;
			}
		} catch (Exception e) {
			e.printStackTrace();
			RequestDispatcher rd = request.getRequestDispatcher("/_01_register/register.jsp");
			rd.forward(request, response);
			return;
		}

	}

}