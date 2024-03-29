package model;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import model.vo.BoardCommentVO;
import model.vo.BoardVO;

import com.ibatis.sqlmap.client.SqlMapClient;

public class BoardDao {
	private SqlMapClient sqlMapClient;

	public BoardDao(SqlMapClient sqlMapClient) {
		super();
		this.sqlMapClient = sqlMapClient;
	}

	public int insert(BoardVO bvo) throws SQLException {
		return (int) sqlMapClient.insert("board.insert", bvo);
	}

	public String getBoardDate(int boardNo) throws SQLException {
		return (String) sqlMapClient.queryForObject("board.getBoardDate", boardNo);
	}

	public void delete(String boardNo) throws SQLException {
		sqlMapClient.delete("board.delete", boardNo);
	}

	public BoardVO showContent(String boardNo) throws SQLException {
		return (BoardVO) sqlMapClient.queryForObject("board.showContent", boardNo);
	}

	public void updateCount(String boardNo) throws SQLException {
		sqlMapClient.update("board.updateCount", boardNo);
	}

	public void updateContent(BoardVO bvo) throws SQLException {
		sqlMapClient.update("board.updateContent", bvo);
	}

	public ArrayList list(Map map) throws SQLException {
		return (ArrayList) sqlMapClient.queryForList("board.list", map);
	}

	public int totalContent()  throws SQLException{
		return (int) sqlMapClient.queryForObject("board.totalContent");
	}

	public void updateRestep(BoardVO bvo) throws SQLException {
		sqlMapClient.update("board.updateRestep", bvo);
	}

	public int replyContent(BoardVO bvo) throws SQLException {
		return (int) sqlMapClient.insert("board.replyContent", bvo);
	}

	public HashMap NextAndPreContent(String boardNo) throws SQLException {
		return (HashMap) sqlMapClient.queryForObject("board.NextAndPreContent", boardNo);
	}

	public int commentContent(BoardCommentVO bcvo) throws SQLException {
		return (int) sqlMapClient.insert("board.commentContent", bcvo);
	}

	public String getCommentDate(int commentNo) throws SQLException {
		return (String) sqlMapClient.queryForObject("board.getCommentDate", commentNo);
	}

	public void deleteComment(String boardNo) throws SQLException {
		sqlMapClient.delete("board.deleteComment", boardNo);
	}

	public void plusCommentCount(int boardNo) throws SQLException {
		sqlMapClient.update("board.plusCommentCount", boardNo);
	}
	
	public void minusCommentCount(int boardNo) throws SQLException {
		sqlMapClient.update("board.minusCommentCount", boardNo);
	}

	public void commentUpdate(BoardCommentVO bcvo) throws SQLException {
		sqlMapClient.update("board.commentUpdate", bcvo);
	}

	public void commentDelete(int commentNo) throws SQLException {
		sqlMapClient.delete("board.commentDelete", commentNo);
	}

	public int totalComment(String boardNo) throws SQLException {
		return (int) sqlMapClient.queryForObject("board.totalComment", boardNo);
	}

	public ArrayList commentList(HashMap map) throws SQLException {
		return (ArrayList) sqlMapClient.queryForList("board.commentList", map);
	}
	public ArrayList getNewBook(String pageNo) throws SQLException {
		return (ArrayList) sqlMapClient.queryForList("book.getNewBook",pageNo);
		}


		public int getNewBookCount() throws SQLException {
		return (int) sqlMapClient.queryForObject("book.getNewBookCount");
		}
}
