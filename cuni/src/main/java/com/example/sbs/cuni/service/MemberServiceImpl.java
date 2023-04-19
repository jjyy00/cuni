package com.example.sbs.cuni.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.sbs.cuni.dao.MemberDao;
import com.example.sbs.cuni.dto.Member;
import com.example.sbs.cuni.util.CUtil;

@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	MemberDao memberDao;

	@Override
	public Map<String, Object> join(Map<String, Object> param) {
		Map<String, Object> rs = new HashMap<>();

		String loginId = (String) param.get("loginId");

		Member member = memberDao.getMemberByLoginId(loginId);

		if (member != null) {
			rs.put("resultCode", "F-1");
			rs.put("msg", String.format("입력하신 로그인 아이디(%s)는 이미 사용중 입니다.", loginId));

			return rs;
		}

		memberDao.joinMember(param);
		int id = CUtil.getAsInt(param.get("id"));

		rs.put("resultCode", "S-1");
		rs.put("msg", String.format("%d번 회원이 생성되었습니다.", id));

		return rs;
	}
	
	@Override
	public Member getMemberByLoginId(String loginId) {
		return memberDao.getMemberByLoginId(loginId);
	}
	
	@Override
	public Member getMemberById(int id) {
		return memberDao.getMemberById(id);
	}
}