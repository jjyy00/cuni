package com.example.sbs.cuni.interceptor;

import java.net.URLEncoder;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.example.sbs.cuni.dto.Member;
import com.example.sbs.cuni.service.MemberService;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;

@Component("beforeActionInterceptor") // 컴포넌트 이름 설정
@Slf4j
public class BeforeActionInterceptor implements HandlerInterceptor {
	@Autowired
	MemberService memberService;

	@Autowired
	@Value("${custom.logoText}")
	String siteName;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		Map<String, Object> param = new HashMap<>();

		Enumeration<String> parameterNames = request.getParameterNames();

		while (parameterNames.hasMoreElements()) {
			String paramName = parameterNames.nextElement();
			Object paramValue = request.getParameter(paramName);

			param.put(paramName, paramValue);
		}

		ObjectMapper mapper = new ObjectMapper();
		String paramJson = mapper.writeValueAsString(param);

		String requestUri = request.getRequestURI();

		String queryString = request.getQueryString();

		String requestUriQueryString = requestUri;
		if (queryString != null && queryString.length() > 0) {
			requestUriQueryString += "?" + queryString;
		}

		String urlEncodedRequestUriQueryString = URLEncoder.encode(requestUriQueryString, "UTF-8");

		request.setAttribute("requestUriQueryString", requestUriQueryString);
		request.setAttribute("urlEncodedRequestUriQueryString", urlEncodedRequestUriQueryString);
		request.setAttribute("param", param);
		request.setAttribute("paramJson", paramJson);

		boolean isAjax = requestUri.endsWith("Ajax");
		
		if ( isAjax == false ) {
			if ( param.containsKey("ajax") && param.get("ajax").equals("Y") ) {
				isAjax = true;
			}
		}

		request.setAttribute("isAjax", isAjax);
		
		HttpSession session = request.getSession();

		boolean isLogined = false;
		int loginedMemberId = 0;
		Member loginedMember = null;

		if (session.getAttribute("loginedMemberId") != null) {
			loginedMemberId = (int) session.getAttribute("loginedMemberId");
			isLogined = true;
			loginedMember = memberService.getMemberById(loginedMemberId);
		}

		request.setAttribute("loginedMemberId", loginedMemberId);
		request.setAttribute("isLogined", isLogined);
		request.setAttribute("loginedMember", loginedMember);

		request.setAttribute("siteName", siteName);

		return HandlerInterceptor.super.preHandle(request, response, handler);
	}
}