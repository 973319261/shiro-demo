package com.koi.shiro;

import java.util.List;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;

import com.koi.mapper.UUserMapper;
import com.koi.pojo.UPermission;
import com.koi.pojo.URole;
import com.koi.pojo.UUser;
import com.koi.pojo.UUserExample;
import com.koi.pojo.UUserExample.Criteria;
import com.koi.service.UUserService;
import com.koi.service.UserPermissonService;
import com.koi.service.UserRoleService;

public class CustomRealm extends AuthorizingRealm{
	@Autowired private UUserService userService;
	@Autowired private UserRoleService userRoleService;
	@Autowired private UserPermissonService userPermissonService;
	@Autowired private UUserMapper userMapper;
	//授权方法
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
		System.out.println("授权中。。。");
		//获取当前登录的用户
		SimpleAuthorizationInfo info=new SimpleAuthorizationInfo();
		UUser user= (UUser) principalCollection.getPrimaryPrincipal();
		Long userId=user.getId();
		//查询角色
		List<URole> selectRoleByUserId = userRoleService.selectRoleByUserId(userId);
		for (URole uRole : selectRoleByUserId) {
			info.addRole(uRole.getType());
		}
		//获取用户的所有权限
		List<UPermission> selectPermissionByUserId = userPermissonService.selectPermissionByUserId(userId);
		for (UPermission uPermission : selectPermissionByUserId) {
			info.addStringPermission(uPermission.getUrl());
		}
		return info;
	}
	//认证方法
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(
			AuthenticationToken authenticationToken) throws AuthenticationException {
		System.out.println("认证中。。。");
		UsernamePasswordToken token=(UsernamePasswordToken) authenticationToken;
		String username=token.getUsername();
		UUserExample example=new UUserExample();
		Criteria criteria=example.createCriteria();
		criteria.andNicknameEqualTo(username);
		List<UUser> list = userMapper.selectByExample(example);
		//验证成功
		if(list.size() > 0){
			SimpleAuthenticationInfo simpleAuthenticationInfo = new SimpleAuthenticationInfo(list.get(0),list.get(0).getPswd(),getName());
			//设置盐，用来核对密码
			simpleAuthenticationInfo.setCredentialsSalt(ByteSource.Util.bytes(list.get(0).getSalt()));
			return simpleAuthenticationInfo; 
		}
		return null;
	}
}
