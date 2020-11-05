package com.koi.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.koi.pojo.UPermission;
import com.koi.service.UserPermissonService;
import com.koi.utils.ResultInfo;
import com.koi.vo.ResuleVo;

@Controller
@RequestMapping("/permisson")
public class PermissonController {
	@Autowired
	private UserPermissonService userPermissonService;

	// 查询当前用户权限
	@RequestMapping("/selectPermissonById")
	public ModelAndView selectPermissonById(Long userId) {
		List<UPermission> list = userPermissonService
				.selectPermissionByUserId(userId);
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("list", list);
		modelAndView.setViewName("permission/myPermission");
		return modelAndView;
	}

	// 查询权限列表selectPermisson
	@RequestMapping("/selectPermissonList")
	public @ResponseBody
	ResuleVo selectPermissonList(
			@RequestParam(value = "info", required = false) String info,
			@RequestParam(value = "page", required = false) Integer page,
			@RequestParam(value = "limit", required = false) Integer limit) {
		long count =0;
		List<UPermission> list;
		if (info != null) {//分页查询
			PageHelper.startPage(page, limit, true);
			list = userPermissonService.selectPermissonList(info);
			PageInfo<UPermission> pageInfo = new PageInfo<UPermission>(list);
			count= pageInfo.getTotal();
		}else{//查询permission所有权限
			list = userPermissonService.selectPermissonList(info);
		}
		ResuleVo resuleVo = ResuleVo.toLayui(count, list);
		return resuleVo;
	}

	// 新增权限列表
	@RequestMapping("/addPermissonList")
	public @ResponseBody
	ResultInfo addPermissonList(
			@Validated @ModelAttribute("uPermission") UPermission uPermission,
			BindingResult result) throws Exception {
		if (result.hasErrors()) {
			List<ObjectError> allErrors = result.getAllErrors();
			for (ObjectError objectError : allErrors) {
				return ResultInfo.setResultInfo(false,
						objectError.getDefaultMessage());
			}
		}
		return userPermissonService.addPermissonList(uPermission);
	}

	// 删除权限列表
	@RequestMapping("/deletePermissonListById")
	public @ResponseBody
	ResultInfo deletePermissonListById(int[] ids) throws Exception {
		if (ids.length > 0) {
			return userPermissonService.deletePermissonListById(ids);
		} else {
			return ResultInfo.setResultInfo(false, "请选择要删除的数据");
		}
	}

	// 查询权限分配列表
	@RequestMapping("/selectPerAllocation")
	public @ResponseBody
	ResuleVo selectPerAllocation(String info, Integer page, Integer limit) {
		return userPermissonService.selectPerAllocation(info, page, limit);
	}

	// 权限分配保存
	@RequestMapping("/savePerAllocation")
	public @ResponseBody
	ResultInfo savePerAllocation(Integer rId, Integer[] perIds)
			throws Exception {
		return userPermissonService.savePerAllocation(rId, perIds);
	}
}
