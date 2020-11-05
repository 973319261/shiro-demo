package com.koi.pojo;

import java.io.Serializable;
import java.util.Date;

import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.Email;
import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.koi.validate.RegisterGroup;
import com.koi.validate.UpdateInfGroup;

public class UUser implements Serializable {
	private static final long serialVersionUID = -8757762651413120035L;
	private Long id;
	@Size(min = 1, max = 20, message = "{uuser.nickname.size.error}", groups = {
			RegisterGroup.class, UpdateInfGroup.class })
	private String nickname;
	@Size(min = 1, max = 30, message = "{uuser.email.size.error}", groups = { RegisterGroup.class })
	@Email(groups = { RegisterGroup.class }, message = "{uuser.email.format.error}")
	private String email;
	@Size(min = 1, max = 32, message = "{uuser.pswd.size.error}", groups = { RegisterGroup.class })
	private String pswd;
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date createTime;
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date lastLoginTime;

	private Long status;

	private String salt;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname == null ? null : nickname.trim();
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email == null ? null : email.trim();
	}

	public String getPswd() {
		return pswd;
	}

	public void setPswd(String pswd) {
		this.pswd = pswd == null ? null : pswd.trim();
	}

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Date getLastLoginTime() {
		return lastLoginTime;
	}

	public void setLastLoginTime(Date lastLoginTime) {
		this.lastLoginTime = lastLoginTime;
	}

	public Long getStatus() {
		return status;
	}

	public void setStatus(Long status) {
		this.status = status;
	}

	public String getSalt() {
		return salt;
	}

	public void setSalt(String salt) {
		this.salt = salt == null ? null : salt.trim();
	}

	@Override
	public String toString() {
		return "UUser [id=" + id + ", nickname=" + nickname + ", email="
				+ email + ", pswd=" + pswd + ", createTime=" + createTime
				+ ", lastLoginTime=" + lastLoginTime + ", status=" + status
				+ ", salt=" + salt + "]";
	}

}