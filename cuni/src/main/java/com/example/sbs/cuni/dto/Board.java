package com.example.sbs.cuni.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Board{
	private int id;
	private String regDate;
	private String name;
	private String code;
}