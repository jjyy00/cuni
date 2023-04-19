<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageName" value="게시물 수정" />
<%@ include file="../part/head.jspf"%>

<form method="POST" action="./doModify">
	<input type="hidden" name="id" value="${article.id}" />
	<div class="table-box con">
		<table>
			<colgroup>
				<col width="180">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th>번호</th>
					<td>${article.id}</td>
				</tr>
				<tr>
					<th>날짜</th>
					<td>${article.regDate}</td>
				</tr>
				<tr>
					<th>작성자</th>
					<td>${article.extra.writer}</td>
				</tr>
				<tr>
					<th>제목</th>
					<td><input type="text" name="title" placeholder="제목을 입력해주세요."
						value="${article.title}" /></td>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea name="body" placeholder="내용을 입력해주세요.">${article.body}</textarea>
					</td>
				</tr>
				<tr>
					<th>수정</th>
					<td><input type="submit" value="수정하기" /></td>
				</tr>
			</tbody>
		</table>
	</div>
</form>

<%@ include file="../part/foot.jspf"%> 