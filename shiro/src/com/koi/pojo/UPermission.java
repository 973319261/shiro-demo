package com.koi.pojo;

import java.io.Serializable;

import javax.validation.constraints.Size;

public class UPermission implements Serializable{
	private static final long serialVersionUID = -983056784269935942L;

	private Long id;
	@Size(min=1,max=64,message="{permission.url.size.error}")
    private String url;
    @Size(min=1,max=256,message="{permission.name.size.error}")
    private String name;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url == null ? null : url.trim();
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }
}