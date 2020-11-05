package com.koi.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import cn.hutool.core.net.NetUtil;

import com.koi.exception.CustomException;
import com.koi.mapper.UUserMapper;
import com.koi.pojo.UUser;
import com.koi.service.UUserService;
import com.koi.utils.ResultInfo;
import com.koi.validate.RegisterGroup;
import com.koi.validate.UpdateInfGroup;
import com.koi.vo.ResuleVo;

@Controller
@RequestMapping("/user")
public class UserController {
	@Autowired
	private UUserService userService;
	@Autowired
	private UUserMapper userMapper;

	// 登陆验证
	@RequestMapping("/login")
	public @ResponseBody
	ResultInfo login(String username, String password, HttpSession session)
			throws CustomException {
		try {
			// 创建令牌
			UsernamePasswordToken token = new UsernamePasswordToken(username,
					password);
			Subject subject = SecurityUtils.getSubject();
			// 执行login方法
			subject.login(token);

			// 获取到返回的用户信息
			UUser user = (UUser) subject.getPrincipal();

			session.setAttribute("user", user);
			// 修改最后登录时间
			user.setLastLoginTime(new Date());
			userMapper.updateByPrimaryKeySelective(user);
			return ResultInfo.setResultInfo(true);
		} catch (AuthenticationException e) {
			return ResultInfo.setResultInfo(false, "账号或密码错误");
		} catch (Exception e) {
			throw new CustomException("登录时间创建失败！");
		}
	}

	// 注册
	@RequestMapping("/register")
	public @ResponseBody
	ResultInfo register(
			@Validated(value = { RegisterGroup.class }) @ModelAttribute("user") UUser user,
			BindingResult result) throws Exception {
		// 判断数据校验是否有错误信息
		if (result.hasErrors()) {
			// 获取错误信息
			List<ObjectError> allErrors = result.getAllErrors();
			// 遍历错误信息
			for (ObjectError objectError : allErrors) {
				return ResultInfo.setResultInfo(false,
						objectError.getDefaultMessage());
			}
		}
		return userService.register(user);
	}

	// 资料修改
	@RequestMapping("/updateInfo")
	public @ResponseBody
	ResultInfo updateInfo(
			@Validated(value = { UpdateInfGroup.class }) @ModelAttribute("user") UUser user,
			BindingResult result) throws Exception {
		// 判断数据校验是否有错误信息
		if (result.hasErrors()) {
			// 获取错误信息
			List<ObjectError> allErrors = result.getAllErrors();
			// 遍历错误信息
			for (ObjectError objectError : allErrors) {
				// 把错误信息返回到页面
				return ResultInfo.setResultInfo(false,
						objectError.getDefaultMessage());
			}
		}
		return userService.updateInfo(user);
	}

	// 修改密码
	@RequestMapping("/updatePassword")
	public @ResponseBody
	ResultInfo updatePassword(@Validated @ModelAttribute("user") UUser user,
			String oldPassword, BindingResult result) throws Exception {
		if (result.hasErrors()) {
			// 获取错误信息
			List<ObjectError> allErrors = result.getAllErrors();
			// 遍历错误信息
			for (ObjectError objectError : allErrors) {
				return ResultInfo.setResultInfo(false,
						objectError.getDefaultMessage());
			}
		}
		return userService.updatePassword(user, oldPassword);

	}

	// 查询用户列表

	@RequestMapping("/selectUserList")
	public @ResponseBody
	ResuleVo selectUserList(String info, Integer page, Integer limit) {
		return userService.selectUserList(info, page, limit);
	}

	// 修改用户状态
	@RequestMapping("/updateUserStatuByUserId")
	public @ResponseBody
	ResultInfo updateUserStatuByUserId(UUser user) throws CustomException {
		return userService.updateUserStatuByUserId(user);
	}

	// 删除用户
	@RequestMapping("/deleteUserByUserId")
	public @ResponseBody
	ResultInfo deleteUserByUserId(Integer[] userIds) throws CustomException {
		return userService.deleteUserByUserId(userIds);
	}

	// 退出
	@RequestMapping("/logout")
	public ModelAndView logout() {
		Subject subject = SecurityUtils.getSubject();
		// 判断用户是否验证成功
		if (subject.isAuthenticated()) {
			subject.logout();
		}
		// 返回登录页面
		return new ModelAndView("login");
	}

	// 偷懒一下，通用页面跳转
	@RequestMapping(value = "{page}")
	public String toPage(String page) {
		return String.format("%s", page);
	}
}
