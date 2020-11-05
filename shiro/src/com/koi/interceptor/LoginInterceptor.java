package com.koi.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.koi.pojo.UUser;

public class LoginInterceptor implements HandlerInterceptor {

	@Override
	public void afterCompletion(HttpServletRequest arg0,
			HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {

	}

	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1,
			Object arg2, ModelAndView arg3) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object obj) throws Exception {
		String requestURI = request.getRequestURI();
		//当请求为登录或者注册时
		if (requestURI.indexOf("login") > 0
				|| requestURI.indexOf("register") > 0) {
			return true;
		}
		//如果user不为null时
		Subject subject = SecurityUtils.getSubject();
		UUser user = (UUser) subject.getPrincipal();
		if (user != null) {
			return true;
		}
		//否则重定向登录页面
		response.sendRedirect("/shiro/index.jsp");
		return false;
	}

}
