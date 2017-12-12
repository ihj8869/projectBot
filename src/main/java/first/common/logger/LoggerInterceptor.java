package first.common.logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoggerInterceptor extends HandlerInterceptorAdapter {
    protected Log log = LogFactory.getLog(LoggerInterceptor.class);
     
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        if (log.isDebugEnabled()) {
            log.debug("======================================          START         ======================================");
            log.debug(" Request URI \t:  " + request.getRequestURI());
        }

        String email=request.getParameter("email"); //다오로 바꿔줘야된다.
		String password=request.getParameter("password"); 
		
		if(email != null && password != null) { //로그인 창에서 id/pw 입력 시
			System.out.println(email+" "+password); //manageMember.do에서 인터셉터가 또 불리는데 email, password가 존재하지 않아 null이 찍히기 때문
			
			if(email.equals("admin@naver.com")&&password.equals("1234")){ //로그인 성공
				request.getSession().setAttribute("email", email);
				request.getSession().setMaxInactiveInterval(3); //초단위
				return true; 
				
			}else {
				response.sendRedirect("/first/index.jsp"); //로그인 실패
				return false;
			}
		}
		return true;
    }
     
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        if (log.isDebugEnabled()) {
            log.debug("======================================           END          ======================================\n");
        }
    }
}


