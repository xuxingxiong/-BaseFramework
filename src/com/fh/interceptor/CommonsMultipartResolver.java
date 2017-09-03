package com.fh.interceptor;

import javax.servlet.http.HttpServletRequest;

public class CommonsMultipartResolver extends org.springframework.web.multipart.commons.CommonsMultipartResolver {
	@Override
	public boolean isMultipart(HttpServletRequest request) {
		String url = request.getRequestURI();
		if(url.indexOf("wxapi/imgupload") >0 ){
			return false;
		}
		return super.isMultipart(request);
	}
}
