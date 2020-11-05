package com.koi.aop;

import java.lang.reflect.Method;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.beans.factory.annotation.Autowired;

import com.koi.annotation.LogAnnotation;
import com.koi.exception.CustomException;
import com.koi.pojo.Log;
import com.koi.pojo.UUser;
import com.koi.service.LogService;
import com.koi.utils.CustomUtils;
/**
 * 基于注解声明式AspectJ配置
 */
/*@Aspect
@Component//声明一个bean
public class LogAspect {
	@Autowired
	private LogService logService;//日志service
	//切入点
	@Pointcut("@annotation(com.koi.annotation.LogAnnotation)")
	public void myPointcut(){}
	//环绕通知 使用@LogAnnotation注解的方法
	@Around("myPointcut()")
	public Object aroundAdvice(ProceedingJoinPoint  pjp) throws Throwable{
		Signature signature = pjp.getSignature();//获取方法签名
		Method method = ( (MethodSignature)signature ).getMethod();//获取方法
		 //这个方法才是目标对象上有注解的方法
		Method declaredMethod = pjp.getTarget().getClass().getDeclaredMethod(signature.getName(), method.getParameterTypes());
		LogAnnotation annotation = declaredMethod.getAnnotation(LogAnnotation.class);//获取方法上的LogAnnotation注解
		String operateType = annotation.operateType();//获取操作说明
		//获取操作用户信息
		Subject subject = SecurityUtils.getSubject();
		UUser user = (UUser)subject.getPrincipal();
		// 创建一个日志对象(准备记录日志)
		Log log=new Log();
		log.setOperateType(operateType);//操作说明
		log.setOperateor(user.getNickname());//设置操作人
		Object obj=null;
		try {
			obj=pjp.proceed();
			log.setOperateResult("操作成功");//设置操作状态
		} catch (CustomException e) {
			log.setOperateResult("操作失败");//设置操作状态
			throw e;//抛给自定义异常处理器处理
		}finally{
			log.setOperateDate(new Date());//设置当前时间
			logService.addLog(log);
		}
		return obj;
	}
}*/
/**
 * 基于xml声明式AspectJ配置
 * @author ZLY
 *
 */
public class LogAspect{
	@Autowired
	private LogService logService;//日志service
	public Object aroundAdvice(ProceedingJoinPoint  pjp) throws Throwable{
		Signature signature = pjp.getSignature();//获取方法签名
		Method method = ( (MethodSignature)signature ).getMethod();//获取方法
		 //这个方法才是目标对象上有注解的方法
		Method declaredMethod = pjp.getTarget().getClass().getDeclaredMethod(signature.getName(), method.getParameterTypes());
		LogAnnotation annotation = declaredMethod.getAnnotation(LogAnnotation.class);//获取方法上的LogAnnotation注解
		String operateType = annotation.operateType();//获取操作说明
		//获取操作用户信息
		Subject subject = SecurityUtils.getSubject();
		UUser user = (UUser)subject.getPrincipal();
		//创建request对象
		HttpServletRequest request = CustomUtils.getHttpServletRequest();
		// 创建一个日志对象(准备记录日志)
		Log log=new Log();
		log.setOperateType(operateType);//操作说明
		log.setOperateor(user.getNickname());//设置操作人
	    log.setIp(CustomUtils.getIpAddr(request));//设置ip地址
		Object obj=null;
		try {
			obj=pjp.proceed();
			log.setOperateResult("操作成功");//设置操作状态
		} catch (CustomException e) {
			log.setOperateResult("操作失败");//设置操作状态
			throw e;//抛给自定义异常处理器处理
		}finally{
			log.setOperateDate(new Date());//设置当前时间
			logService.addLog(log);
		}
		return obj;
	}
}
