package com.example.sbs.cuni.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.sbs.cuni.dto.Article;

@Controller
public class HomeController {
	@RequestMapping("/")
	public String showMain(Model model, HttpSession session) {
		return "home/main";
	}

	@RequestMapping("home/main")
	public String showMain2() {
		return "home/main";
	}

	@RequestMapping("home/testAjax1")
	public String showTestAjax1() {
		return "home/testAjax1";
	}

	@RequestMapping("home/getData1ForTestAjax1")
	@ResponseBody
	public Article getData1ForTestAjax1() {
		Article article = new Article(1, "2020-05-03 12:12:12", "안녕하세요 ^ ^!!!", "저를 소개..", 1, 1, 1, new HashMap<String, Object>());

		return article;
	}
}