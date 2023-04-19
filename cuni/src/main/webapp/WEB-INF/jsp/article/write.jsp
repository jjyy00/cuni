<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageName" value="${board.name} 게시물 작성" />
<%@ include file="../part/head.jspf"%>

<form action="./doWrite" method="POST">
	<input type="hidden" name="boardId" value="${board.id}" />
	<div class="table-box con">
		<table>
			<tbody>
				<tr>
					<th>제목</th>
					<td><input type="text" name="title" placeholder="제목을 입력해주세요." /></td>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea name="body" placeholder="내용을 입력해주세요."></textarea>
					</td>
				</tr>
				<tr>
					<th>작성</th>
					<td><input type="submit" value="작성"></td>
				</tr>
			</tbody>
		</table>
	</div>
</form>

<%@ include file="../part/foot.jspf"%> 