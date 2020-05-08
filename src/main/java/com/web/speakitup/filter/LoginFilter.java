package com.web.speakitup.filter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.web.speakitup.model.MemberBean;

@WebFilter(urlPatterns = { "/*" }, initParams = { @WebInitParam(name = "url_2", value = "/member/showMyArticles"),
		@WebInitParam(name = "url_3", value = "/member/personPage"), @WebInitParam(name = "url_4", value = "/order/*"),
		@WebInitParam(name = "url_5", value = "/article/likeArticle/*"),
		@WebInitParam(name = "url_6", value = "/article/addComment/*"),
		@WebInitParam(name = "url_7", value = "/article/addArticle"),
		@WebInitParam(name = "url_8", value = "/article/showReports"),
		@WebInitParam(name = "url_9", value = "/letter/*") })
public class LoginFilter implements Filter {

	List<String> url = new ArrayList<String>();
	String contextPath;
	String queryString;

	public LoginFilter() {
	}

	public void init(FilterConfig fConfig) throws ServletException {
		Enumeration<String> e = fConfig.getInitParameterNames();
		while (e.hasMoreElements()) {
			String name = e.nextElement();
			String value = fConfig.getInitParameter(name);
			url.add(value);
		}
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		if (request instanceof HttpServletRequest && response instanceof HttpServletResponse) {
			HttpServletRequest req = (HttpServletRequest) request;
			HttpServletResponse resp = (HttpServletResponse) response;

			String servletPath = req.getServletPath();

			req.isRequestedSessionIdValid();
			contextPath = req.getContextPath();
			HttpSession session = req.getSession();
			if (mustLogin(servletPath)) {
				if (checkLogin(req)) {
					// 需要登入 但已經登入
					chain.doFilter(request, response);
				} else {
					session = req.getSession();
					session.setAttribute("target", servletPath);
					req.setAttribute("loginFilter", "true");
					RequestDispatcher rd = request.getRequestDispatcher("/member/login");
					rd.forward(request, response);
					return;
				}
			} else { // 如果不用登入 就直接交棒給要執行的程式
				chain.doFilter(request, response);
				// 通知瀏覽器必須先以 Last-Modified or ETag送出請求來詢問Server，本網頁是否有較新的版本，
				// 如果Server回應沒有，才可以使用快取區內的網頁，否則必須再次送出請求取得更新的版本
				resp.setHeader("Cache-Control", "no-cache");
				// 通知瀏覽器絕對不要將本網頁儲存在快取區內
				resp.setHeader("Cache-Control", "no-store");
				// Causes the proxy cache to see the page as "stale",
				// 0 表示該網頁的有效期限為 1970/01/01 00:00:00 GMT，若現在時間超過它，就不能再使用
				// 快取出內的網頁
				resp.setDateHeader("Expires", 0);
				// 為了與 HTTP 1.0 相容，加入此回應標頭
				resp.setHeader("Pragma", "no-cache");
				resp.addHeader("Cache-Control", "must-revalidate");
			}

		} else {
			throw new ServletException("Request/Response 型態錯誤(極不可能發生)");
		}

	}

	// 檢查是否在登入的狀態
	private boolean checkLogin(HttpServletRequest req) {
		HttpSession session = req.getSession();
		MemberBean loginToken = (MemberBean) session.getAttribute("LoginOK");
		if (loginToken == null) {
			return false;
		} else {
			return true;
		}
	}

	// 如果請求的ServletPath的前導字是以某個必須登入才能使用之資源的路徑，那就必須登入。
	private boolean mustLogin(String servletPath) {
		boolean login = false;
		for (String sURL : url) {
			if (sURL.endsWith("*")) {
				sURL = sURL.substring(0, sURL.length() - 1);
				if (servletPath.startsWith(sURL)) {
					login = true;
					break;
				}
			} else {
				if (servletPath.equals(sURL)) {
					login = true;
					break;
				}
			}
		}
		return login;
	}

	@Override
	public void destroy() {
	}
}
