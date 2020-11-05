package com.koi.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.hutool.core.collection.CollUtil;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.koi.annotation.LogAnnotation;
import com.koi.exception.CustomException;
import com.koi.mapper.UserPermissionMapper;
import com.koi.pojo.UPermission;
import com.koi.pojo.URolePermission;
import com.koi.service.UserPermissonService;
import com.koi.utils.ResultInfo;
import com.koi.vo.ResuleVo;

@Service
public class UserPermissonServiceImpl implements UserPermissonService {
	@Autowired
	private UserPermissionMapper userPermissionMapper;
	@Override
	public List<UPermission> selectPermissionByUserId(Long userId) {
		return userPermissionMapper.selectPermissionByUserId(userId);
	}

	@Override
	public List<UPermission> selectPermissonList(String info) {
		return userPermissionMapper.selectPermissonList(info);
	}
	@LogAnnotation(operateType="添加权限")
	@Override
	public ResultInfo addPermissonList(UPermission uPermission) throws CustomException {
		try {
			userPermissionMapper.addPermissonList(uPermission);
		} catch (Exception e) {
			throw new CustomException("新增失败");
		}
		return ResultInfo.setResultInfo(true, "新增成功");
	}
	@LogAnnotation(operateType="删除权限")
	@Override
	public ResultInfo deletePermissonListById(int[] ids) throws CustomException {
		try {
			userPermissionMapper.deletePermissonListById(ids);
		} catch (Exception e) {
			throw new CustomException("删除失败");
		}
		return ResultInfo.setResultInfo(true, "删除成功");
	}

	@Override
	public ResuleVo selectPerAllocation(String info, Integer page, Integer limit) {
		//page 当前页 limit代表页面的大小 boolean代表是否开启分页
		PageHelper.startPage(page, limit, true);
		List<URolePermission> list = userPermissionMapper.selectPerAllocation(info);
		PageInfo<URolePermission> pageInfo = new PageInfo<URolePermission>(list);
		long count = pageInfo.getTotal();//总数
		return ResuleVo.toLayui(count, list);
	}
	
	@LogAnnotation(operateType="权限分配保存")
	@Override
	public ResultInfo savePerAllocation(Integer rId, Integer[] perIds)
			throws CustomException {
		try {
			List<Integer> oneRIds = CollUtil.toList(perIds);
			List<Integer> towRIds = CollUtil.toList(perIds);
			List<Integer> oldRIds = userPermissionMapper
					.selectPermissionByRoleId(rId);// 查询原来的角色分配列表
			oneRIds.removeAll(oldRIds);// oneRIds返回的是要新增的集合
			oldRIds.removeAll(towRIds);// oldRIds返回的是要删除的集合
			if (oneRIds.size() > 0) {
				userPermissionMapper.addPerAllocation(rId, oneRIds);
			}
			if (oldRIds.size() > 0) {
				userPermissionMapper.deletePerAllocation(rId, oldRIds);
			}
			
		} catch (Exception e) {
			throw new CustomException("保存失败");
		}
		return ResultInfo.setResultInfo(true, "保存成功");
		
	}
}
