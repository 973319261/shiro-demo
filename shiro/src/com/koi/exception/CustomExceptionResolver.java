package com.koi.exception;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import cn.hutool.json.JSONObject;
@Component
public class CustomExceptionResolver implements HandlerExceptionResolver {
	// 自定义异常处理器
	@Override
	public ModelAndView resolveException(HttpServletRequest request,
			HttpServletResponse response, Object object, Exception exception) {
		// 判断是否ajax请求
		if (!(request.getHeader("accept").indexOf("application/json") > -1 || (request
				.getHeader("X-Requested-With") != null && request.getHeader(
				"X-Requested-With").indexOf("XMLHttpRequest") > -1))) {
			// 对于非ajax请求，我们都统一跳转到error.jsp页面
			// 如果抛出的是系统自定义异常则直接转换
			CustomException customException = null;
			if (exception instanceof CustomException) {
				customException = (CustomException) exception;
			} else {
				// 如果抛出的不是系统自定义异常则重新构造一个未知错误异常。
				customException = new CustomException("未知错误，请与系统管理 员联系！");
			}
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("message", customException.getMessage());
			modelAndView.setViewName("error");
			return modelAndView;
		} else {
			// 如果是ajax请求，JSON格式返回
			try {
				response.setContentType("application/json;charset=UTF-8");
				PrintWriter writer = response.getWriter();
				JSONObject json=new JSONObject();
			    json.put("success", false);
				// 为安全起见，只有业务异常我们对前端可见，否则统一归为系统异常
				if (exception instanceof CustomException) {
					json.put("msg", exception.getMessage());
				} else {
					//未知错误
					json.put("msg", "系统异常！");
				}
				writer.write(json.toString());
				writer.flush();
				writer.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
}
