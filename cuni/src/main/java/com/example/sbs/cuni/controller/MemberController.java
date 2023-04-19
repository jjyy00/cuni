package com.example.sbs.cuni.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.sbs.cuni.dto.Member;
import com.example.sbs.cuni.service.MemberService;

@Controller
public class MemberController {
	@Autowired
	private MemberService memberService;

	@RequestMapping("member/login")
	public String showLogin() {
		return "member/login";
	}

	@RequestMapping("member/join")
	public String showJoin() {
		return "member/join";
	}
	
	@RequestMapping("member/doLogout")
	public String doLogout(Model model, HttpSession session) {
		session.removeAttribute("loginedMemberId");

		model.addAttribute("locationReplace", "/");

		return "common/redirect";
	}

	@RequestMapping("member/doJoin")
	public String doJoin(Model model, @RequestParam Map<String, Object> param) {
		Map<String, Object> rs = memberService.join(param);

		String resultCode = (String) rs.get("resultCode");

		String msg = (String) rs.get("msg");

		model.addAttribute("alertMsg", msg);

		if (resultCode.startsWith("S-")) {
			String redirectUrl = "/member/login";
			model.addAttribute("locationReplace", redirectUrl);
		} else {
			model.addAttribute("historyBack", true);
		}

		return "common/redirect";
	}

	@RequestMapping("member/doLogin")
	public String doLogin(Model model, @RequestParam Map<String, Object> param, HttpSession session) {
		String loginId = (String) param.get("loginId");
		String loginPw = (String) param.get("loginPw");
		Member member = memberService.getMemberByLoginId(loginId);

		if (member == null) {
			model.addAttribute("alertMsg", "존재하지 않는 로그인 아이디 입니다.");
			model.addAttribute("historyBack", true);
		} else if (member.getLoginPw().equals(loginPw) == false) {
			model.addAttribute("alertMsg", "비밀번호가 일하지 않습니다.");
			model.addAttribute("historyBack", true);
		} else {
			session.setAttribute("loginedMemberId", member.getId());
			String redirectUrl = "/home/main";
			model.addAttribute("alertMsg", "환영합니다.");
			model.addAttribute("locationReplace", redirectUrl);
		}

		return "common/redirect";
	}
}