package com.example.sbs.cuni.service;

import java.util.List;
import java.util.Map;

import com.example.sbs.cuni.dto.Article;
import com.example.sbs.cuni.dto.ArticleReply;
import com.example.sbs.cuni.dto.Board;

public interface ArticleService {
	List<Article> getArticles();

	Article getArticle(int id);

	Map<String, Object> deleteArticle(int id);

	List<Article> getArticles(String boardCode);

	Board getBoard(String boardCode);

	Map<String, Object> write(Map<String, Object> param);

	Board getBoard(int boardId);

	Map<String, Object> modify(Map<String, Object> param);

	Map<String, Object> getArticleModifyAvailable(int id, int actorMemberId);

	Map<String, Object> getArticleDeleteAvailable(int id, int actorMemberId);

	void increaseArticleHit(int id);

	Article getForPrintArticle(int id, int actorMemberId);

	Map<String, Object> getArticleLikeAvailable(int id, int actorMemberId);

	Map<String, Object> likeArticle(int id, int actorMemberId);


	Map<String, Object> getArticleCancelLikeAvailable(int id, int actorMemberId);

	Map<String, Object> cancelLikeArticle(int id, int actorMemberId);

	List<Article> getForPrintArticles(String boardCode, int actorMemberId);

	int getLikePoint(int id);

	Map<String, Object> writeReply(Map<String, Object> param);

	List<ArticleReply> getForPrintArticleReplies(int articleId);

	Map<String, Object> getArticleReplyDeleteAvailable(int id, int actorMemberId);

	ArticleReply getArticleReply(int id);

	Map<String, Object> deleteArticleReply(int id);

	Map<String, Object> getArticleModifyReplyAvailable(int id, int actorMemberId);

	ArticleReply getForPrintArticleReply(int id, int actorMemberId);

	Map<String, Object> modifyReply(Map<String, Object> param);

	List<ArticleReply> getForPrintArticleReplies(int articleId, int from);

	List<Article> getForPrintArticlesByParam(Map<String, Object> param);

	int getArticlesCount(Map<String, Object> param);
}