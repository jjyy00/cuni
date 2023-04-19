<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageName" value="회원가입" />
<%@ include file="../part/head.jspf"%>

<form action="./doJoin" method="POST">
	<div class="table-box con">
		<table>
			<tbody>
				<tr>
					<th>로그인 아이디</th>
					<td><input type="text" name="loginId"
						placeholder="로그인 아이디를 입력해주세요." autofocus="autofocus" /></td>
				</tr>
				<tr>
					<th>로그인 비번</th>
					<td><input type="password" name="loginPw"
						placeholder="로그인 비번을 입력해주세요." /></td>
				</tr>
				<tr>
					<th>이름</th>
					<td><input type="text" name="name" placeholder="이름을 입력해주세요." /></td>
				</tr>
				<tr>
					<th>회원가입</th>
					<td><input type="submit" value="회원가입"></td>
				</tr>
			</tbody>
		</table>
	</div>
</form>

<%@ include file="../part/foot.jspf"%> 