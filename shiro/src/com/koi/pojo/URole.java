package com.koi.pojo;

import java.io.Serializable;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

public class URole implements Serializable {
	private static final long serialVersionUID = 3003085654812154471L;
	private Long id;
	@Size(min = 1, max = 32, message = "{urole.name.size.error}")
	@NotNull(message = "{urole.name.notNull.error}")
	private String name;
	@Size(min = 1, max = 32, message = "{urole.type.size.error}")
	@NotNull(message = "{urole.type.notNull.error}")
	private String type;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name == null ? null : name.trim();
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type == null ? null : type.trim();
	}
}