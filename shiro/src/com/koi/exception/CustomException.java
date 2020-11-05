package com.koi.exception;

public class CustomException extends Exception {

	private static final long serialVersionUID = -940735128639411704L;
	// 异常信息
	private String message;

	public CustomException(String message) {
		super(message);
		this.message = message;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	@Override
	public String toString() {
		return "CustomException [message=" + message + "]";
	}
	
}
