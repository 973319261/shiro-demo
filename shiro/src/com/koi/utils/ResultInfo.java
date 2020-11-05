package com.koi.utils;

public class ResultInfo {
	// 响应业务状态码
	private Boolean success;
	// 响应消息
	private String msg;
	// 响应数据
	private Object data;

	public static ResultInfo setResultInfo(Boolean success) {
		return new ResultInfo(success, "OK", "");
	}

	public static ResultInfo setResultInfo(Object data) {
		return new ResultInfo(true, "OK", data);
	}

	public static ResultInfo setResultInfo(Boolean success, String msg) {
		return new ResultInfo(success, msg, null);
	}

	public static ResultInfo setResultInfo(Boolean success, String msg,
			Object data) {
		return new ResultInfo(success, msg, data);
	}

	public ResultInfo(Boolean success, String msg, Object data) {
		super();
		this.success = success;
		this.msg = msg;
		this.data = data;
	}

	public Boolean getSuccess() {
		return success;
	}

	public void setSuccess(Boolean success) {
		this.success = success;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Object getData() {
		return data;
	}

	public void setData(Object data) {
		this.data = data;
	}

}
