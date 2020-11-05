package com.koi.pojo;

import java.io.Serializable;
import java.util.List;

public class UUserRole extends UUser implements Serializable {
	private static final long serialVersionUID = 2400605027010626685L;
	private List<URole> role;
	public List<URole> getRole() {
		return role;
	}
	public void setRole(List<URole> role) {
		this.role = role;
	}
}



