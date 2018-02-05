package first.common.logger;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import first.shopping.admin.service.AdminService;

public class LoggerInterceptor extends HandlerInterceptorAdapter {
    protected Log log = LogFactory.getLog(LoggerInterceptor.class);
     
    @Resource(name="adminService")
	private AdminService adminService;
    
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        if (log.isDebugEnabled()) {
            log.debug("======================================          LoggerInterceptor  Start      ======================================");
            log.debug(" Request URI \t:  " + request.getRequestURI());
        }

        String id=request.getParameter("id"); //다오로 바꿔줘야된다.
		String password=request.getParameter("password"); 
		
		if(id != null && password != null) { //로그인 창에서 id/pw 입력 시
			System.out.println(id+" "+password); //*.do에서 인터셉터가 또 불리는데 id, password가 존재하지 않아 null이 찍히기 때문
			
			String checkPw = adminService.checkPw(id);
			
			if(password.equals(checkPw)){ //로그인 성공
				request.getSession().setAttribute("id", id);
				request.getSession().setMaxInactiveInterval(60*60); //초단위
				return true; 
				
			}else {
				response.sendRedirect("/index.jsp"); //로그인 실패
				return false;
			}
		}
		return true;
    }
     
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        if (log.isDebugEnabled()) {
            log.debug("======================================         LoggerInterceptor   END          ======================================\n");
        }
    }
}


