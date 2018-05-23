package com.smart.common.bean;

import java.util.HashMap;
import java.util.Map;

/**
 * 通用的返回的类
 * @author zhengxianyou
 *
 */
public class ResponseModel {

	//状态码   200-成功    999-失败
		private int code;
		//提示信息
		private String msg;
		
		//用户要返回给浏览器的数据
		private Map<String, Object> extend = new HashMap<String, Object>();

		public static ResponseModel success(){
			ResponseModel result = new ResponseModel();
			result.setCode(200);
			result.setMsg("处理成功！");
			return result;
		}
		
		public static ResponseModel failed(){
			ResponseModel result = new ResponseModel();
			result.setCode(999);
			result.setMsg("处理失败！");
			return result;
		}


		public ResponseModel add(String key,Object value){
			this.getExtend().put(key, value);
			return this;
		}
		
		public int getCode() {
			return code;
		}

		public void setCode(int code) {
			this.code = code;
		}

		public String getMsg() {
			return msg;
		}

		public void setMsg(String msg) {
			this.msg = msg;
		}

		public Map<String, Object> getExtend() {
			return extend;
		}

		public void setExtend(Map<String, Object> extend) {
			this.extend = extend;
		}
	
}
