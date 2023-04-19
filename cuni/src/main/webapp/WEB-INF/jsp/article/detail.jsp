<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageName" value="게시물 상세" />
<%@ include file="../part/head.jspf"%>

<style>
.article-reply-list-box tr .loading-delete-inline {
	display: none;
	font-weight: bold;
	color: red;
}
.article-reply-list-box tr[data-loading="Y"] .loading-none {
		display: none;
}
.article-reply-list-box tr[data-loading="Y"][data-loading-delete="Y"] .loading-delete-inline
	{
	display: inline;
}
.article-reply-list-box tr[data-modify-mode="Y"] .modify-mode-none {
	display: none;
}
.article-reply-list-box tr .modify-mode-inline {
	display: none;
}
.article-reply-list-box tr .modify-mode-block {
	display: none;
}
.article-reply-list-box tr[data-modify-mode="Y"] .modify-mode-block {
	display: block;
}
.article-reply-list-box tr[data-modify-mode="Y"] .modify-mode-inline {
	display: inline;
}
</style>

<script>
	var id = parseInt('${article.id}');
</script>

<script>

	var ArticleReply__loadListDelay = 1000;
	// 임시
	ArticleReply__loadListDelay = 5000;

	function ViewArticle1__updateLikePoint(newLikePoint) {
		$('.article--like-point').empty().append(newLikePoint);
	}
	function callDoLike() {
		if (confirm('추천 하시겠습니까?') == false) {
			return;
		}
		$.post('./doLikeAjax', {
			id : id
		}, function(data) {
			if (data.resultCode.substr(0, 2) == 'S-') {
				ViewArticle1__updateLikePoint(data.likePoint);
			} else {
				if (data.msg) {
					alert(data.msg);
				}
			}
		}, 'json');
	}
	function callDoCancelLike() {
		if (confirm('추천을 취소 하시겠습니까?') == false) {
			return;
		}
		$.post('./doCancelLikeAjax', {
			id : id
		}, function(data) {
			if (data.resultCode.substr(0, 2) == 'S-') {
				ViewArticle1__updateLikePoint(data.likePoint);
			} else {
				if (data.msg) {
					alert(data.msg);
				}
			}
		}, 'json');
	}
</script>

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
				<th>조회수</th>
				<td>${article.hit}</td>
			</tr>
			<tr>
				<th>제목</th>
				<td>${article.title}</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>${article.body}</td>
			</tr>
			<tr>
				<th>좋아요</th>
				<td><span class="article--like-point">${article.extra.likePoint}</span>
					/ <a href="#" onclick="callDoLike();">좋아요</a> <a href="#"
					onclick="callDoCancelLike();">좋아요취소</a></td>
			</tr>
			<tr>
								<th>비고</th>
				<td><a href="./doDelete?id=${article.id}"
					onclick="if ( confirm('삭제하시겠습니까?') == false ) { return false; }">삭제</a>
					
					<a href="./modify?id=${article.id}">수정</a></td>
			</tr>
		</tbody>
	</table>
</div>

<c:if test="${isLogined}">
	<h2 class="con">댓글 작성</h2>

	<script>
		function ArticleReply__submitWriteForm(form) {
			form.body.value = form.body.value.trim();
			if (form.body.value.length == 0) {
				alert('댓글을 입력해주세요.');
				form.body.focus();
				return;
			}
			$.post('./doWriteReplyAjax', {
				articleId : param.id,
				body : form.body.value
			}, function(data) {
				
			}, 'json');
			form.body.value = '';
		}
	</script>

	<form action=""
		onsubmit="ArticleReply__submitWriteForm(this); return false;">
		<div class="table-box con">
			<table>
				<tbody>
					<tr>
						<th>내용</th>
						<td><textarea maxlength="300" class="height-100px"
								name="body" placeholder="내용을 입력해주세요."></textarea></td>
					</tr>
					<tr>
						<th>작성</th>
						<td><input type="submit" value="작성"></td>
					</tr>
				</tbody>
			</table>
		</div>
	</form>

</c:if>

<h2 class="con">댓글 리스트</h2>

<script>
	var ArticleReply__lastLoadedArticleReplyId = 0;
	function ArticleReply__loadList() {
		$.get('./getForPrintArticleRepliesRs', {
			id : param.id,
			from : ArticleReply__lastLoadedArticleReplyId + 1,
			ajax : 'Y'
		}, function(data) {
			data.articleReplies = data.articleReplies.reverse();
			
			for (var i = 0; i < data.articleReplies.length; i++) {
				var articleReply = data.articleReplies[i];
				ArticleReply__drawReply(articleReply);
				
				ArticleReply__lastLoadedArticleReplyId = articleReply.id;
			}
			
			setTimeout(ArticleReply__loadList, ArticleReply__loadListDelay);
		}, 'json');
	}
	var ArticleReply__$listTbody;
	function ArticleReply__drawReply(articleReply) {
		var html = $('.template-box-1 tbody').html();
		html = replaceAll(html, "{$번호}", articleReply.id);
		html = replaceAll(html, "{$날짜}", articleReply.regDate);
		html = replaceAll(html, "{$작성자}", articleReply.extra.writer);
		html = replaceAll(html, "{$내용}", articleReply.body);
		/*
		var html = '';
		html = '<tr data-article-reply-id="' + articleReply.id + '">';
		html += '<td>' + articleReply.id + '</td>';
		html += '<td>' + articleReply.regDate + '</td>';
		html += '<td>' + articleReply.extra.writer + '</td>';
		html += '<td>' + articleReply.body + '</td>';
		html += '<td>';
		html += '<a href="#">삭제</a>';
		html += '<a href="#">수정</a>';
		html += '</td>';
		html += '</tr>';
		 */
		ArticleReply__$listTbody.prepend(html);
	}
	$(function() {
		ArticleReply__$listTbody = $('.article-reply-list-box > table tbody');
		ArticleReply__loadList();
		
	});
	
	function ArticleReply__enableModifyMode(obj) {
		var $clickedBtn = $(obj);
		var $tr = $clickedBtn.closest('tr');
		var $replyBodyText = $tr.find('.reply-body-text');
		var $textarea = $tr.find('form textarea');
		$textarea.val($replyBodyText.text().trim());
		$tr.attr('data-modify-mode', 'Y');
	}
	function ArticleReply__disableModifyMode(obj) {
		var $clickedBtn = $(obj);
		var $tr = $clickedBtn.closest('tr');
		$tr.attr('data-modify-mode', 'N');
	}
	function ArticleReply__submitModifyReplyForm(form) {
		var $tr = $(form).closest('tr');
		form.body.value = form.body.value.trim();
		if (form.body.value.length == 0) {
			alert('댓글내용을 입력 해주세요.');
			form.body.focus();
			return false;
		}
		var replyId = parseInt($tr.attr('data-article-reply-id'));
		var body = form.body.value;
		$tr.attr('data-loading', 'Y');
		$tr.attr('data-loading-modify', 'Y');
		$.post('./doModifyReplyAjax', {
			id : replyId,
			body : body
		}, function(data) {
			$tr.attr('data-loading', 'N');
			$tr.attr('data-loading-modify', 'N');
			ArticleReply__disableModifyMode(form);
			if (data.resultCode.substr(0, 2) == 'S-') {
				var $replyBodyText = $tr.find('.reply-body-text');
				var $textarea = $tr.find('form textarea');
				$replyBodyText.text($textarea.val());
			} else {
				if (data.msg) {
					alert(data.msg)
				}
			}
		});
	}


	function ArticleReply__delete(obj) {
		var $clickedBtn = $(obj);
		var $tr = $clickedBtn.closest('tr');
		var replyId = parseInt($tr.attr('data-article-reply-id'));
		$tr.attr('data-loading', 'Y');
		$tr.attr('data-loading-delete', 'Y');
		$.post('./doDeleteReplyAjax', {
			id : replyId
		}, function(data) {
			$tr.attr('data-loading', 'N');
			$tr.attr('data-loading-delete', 'N');
			if (data.resultCode.substr(0, 2) == 'S-') {
				$tr.remove();
			} else {
				if (data.msg) {
					alert(data.msg)
				}
			}
		}, 'json');
		
	}
</script>

<div class="template-box template-box-1">
	<table border="1">
		<tbody>
			<tr data-article-reply-id="{$번호}">
				<td>{$번호}</td>
				<td>{$날짜}</td>
				<td>{$작성자}</td>
				<td>
				 	<div class="reply-body-text modify-mode-none">{$내용}</div>

					<div class="modify-mode-block">
						<form
							onsubmit="ArticleReply__submitModifyReplyForm(this); return false;">
							<textarea name="body">{$내용}</textarea>
							<br /> <input class="loading-none" type="submit" value="수정" />
						</form>
					</div>
				</td>
				<td><span class="loading-delete-inline">삭제중입니다...</span> <a
					class="loading-none" href="#"
					onclick="if ( confirm('정말 삭제하시겠습니까?') ) { ArticleReply__delete(this); } return false;">삭제</a>
					<a class="loading-none modify-mode-none" href="#"
					onclick="ArticleReply__enableModifyMode(this); return false;">수정</a>
					<a class="loading-none modify-mode-inline" href="#"
					onclick="ArticleReply__disableModifyMode(this); return false;">수정취소</a>
				</td>
			</tr>
		</tbody>
	</table>
</div>

<div class="article-reply-list-box table-box con">
	<table>
		<colgroup>
			<col width="80">
			<col width="180">
			<col width="180">
			<col>
			<col width="200">
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>날짜</th>
				<th>작성자</th>
				<th>내용</th>
				<th>비고</th>
			</tr>
		</thead>
		<tbody>

		</tbody>
	</table>
</div>

<%@ include file="../part/foot.jspf"%> 