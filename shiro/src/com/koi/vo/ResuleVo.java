package com.koi.vo;
public class  ResuleVo {
	private  Integer code;
	private  String msg;
	private  Long count;
	private  Object data;
	/**
	 * 返回layui表格数据格式
	 * @param count
	 * @param data
	 */
	public static ResuleVo toLayui(Long count,Object data){
		return new ResuleVo(count, data);
		
	}
	public  ResuleVo (Long count, Object data) {
		this.code = 0;
		this.msg = "";
		this.count = count;
		this.data = data;
	}
	public Integer getCode() {
		return code;
	}
	public void setCode(Integer code) {
		this.code = code;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public Long getCount() {
		return count;
	}
	public void setCount(Long count) {
		this.count = count;
	}
	public Object getData() {
		return data;
	}
	public void setData(Object data) {
		this.data = data;
	}
	
}
