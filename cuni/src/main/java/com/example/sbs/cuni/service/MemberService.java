package com.example.sbs.cuni.service;

import java.util.Map;

import com.example.sbs.cuni.dto.Member;

public interface MemberService {
	Map<String, Object> join(Map<String, Object> param);

	Member getMemberByLoginId(String loginId);

	Member getMemberById(int id);
}