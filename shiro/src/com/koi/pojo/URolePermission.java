package com.koi.pojo;

import java.io.Serializable;
import java.util.List;

public class URolePermission extends URole implements Serializable {
	private static final long serialVersionUID = -2536084217774994896L;

	private List<UPermission> permission;

	public List<UPermission> getPermission() {
		return permission;
	}

	public void setuPermission(List<UPermission> permission) {
		this.permission = permission;
	}
}