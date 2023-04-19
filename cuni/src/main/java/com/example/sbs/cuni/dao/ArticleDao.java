package com.example.sbs.cuni.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.ResultType;

import com.example.sbs.cuni.dto.Article;
import com.example.sbs.cuni.dto.ArticleReply;
import com.example.sbs.cuni.dto.Board;

@Mapper
public interface ArticleDao {
	List<Article> getArticles();

	Article getArticle(@Param("id") int id);

	void deleteArticle(@Param("id") int id);
	
	List<Article> getArticlesByBoardCode(@Param("boardCode") String boardCode);

	Board getBoardByBoardCode(@Param("boardCode") String boardCode);

	void writeArticle(Map<String, Object> param);

	Board getBoard(@Param("boardId") int boardId);

	void modifyArticle(Map<String, Object> param);

	void increaseArticleHit(@Param("id") int id);

	Article getForPrintArticle(int id);
	
	int getLikePointByMemberId(@Param("id") int id, @Param("memberId") int memberId);

	void likeArticle(@Param("id") int id, @Param("memberId") int memberId);

	void cancelLikeArticle(@Param("id") int id, @Param("memberId") int memberId);

	int getLikePoint(@Param("id") int id);

	void writeArticleReply(Map<String, Object> param);

	List<ArticleReply> getForPrintArticleReplies(@Param("articleId") int articleId);

	ArticleReply getArticleReply(@Param("id") int id);

	void deleteArticleReply(@Param("id") int id);

	ArticleReply getForPrintArticleReply(@Param("id") int id);

	void modifyArticleReply(Map<String, Object> param);

	List<ArticleReply> getForPrintArticleRepliesFrom(@Param("articleId") int articleId, @Param("from") int from);

	List<Article> getForPrintArticles(Map<String, Object> param);

	int getArticlesCount(Map<String, Object> param);
}