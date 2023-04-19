package com.example.sbs.cuni.dto;

import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Article{
	private int id;
	private String regDate;
	private String title;
	private String body;
	private int boardId;
	private int memberId;
	private int hit;
	private Map<String, Object> extra;
}