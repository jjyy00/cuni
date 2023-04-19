<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageName" value="테스트 ajax 1" />
<%@ include file="../part/head.jspf"%>

<script>
function Article__loadArticleInfo() {
	$.get(
		'/home/getData1ForTestAjax1',
		{},
		function(data) {
			$('.article-title').empty().append(data.title);
			$('.article-body').empty().append(data.body);
		}
	);
}
</script>

<div class="con">
	<h2>데이터 가져오기</h2>
	<a href="/home/getData1ForTestAjax1">무식하게 가져오기</a>
	<a href="#" onclick="Article__loadArticleInfo(); return false;">우아하게 가져오기</a>

	<h2>회원정보</h2>
	<div>
		제목 : <span class="article-title"></span>
		<br>
		내용 : <span class="article-body"></span>
	</div>
</div>

<%@ include file="../part/foot.jspf"%> 