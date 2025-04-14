package securitydb;

import java.io.IOException;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class SetLoginPage extends SimpleUrlAuthenticationSuccessHandler{
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		
		System.out.println("[/SetLoginPage] 체크박스 값 : "+ request.getParameter("rememberId"));

		//아이디 저장 cookie처리
		if(request.getParameter("rememberId") != null) {
			String memId = SecurityContextHolder.getContext().getAuthentication().getName();

            Cookie cookie = new Cookie("rememberId", memId);
            cookie.setPath("/");
            cookie.setMaxAge(60 * 60 * 24 * 30);
            response.addCookie(cookie);
		}
		else {
			Cookie cookie = new Cookie("rememberId", null);
			cookie.setValue("");
			cookie.setPath("/"); 
			cookie.setMaxAge(60 * 60 * 24 * 30); 
			response.addCookie(cookie);
		}
		
		
		if(authentication.getAuthorities().contains(new SimpleGrantedAuthority("ROLE_ADMIN"))) {
			response.sendRedirect("/admin");
		}
		else {
			response.sendRedirect("/home");

		}
	}
	
}