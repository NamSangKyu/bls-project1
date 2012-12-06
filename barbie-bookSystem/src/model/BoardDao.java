package model;

import java.sql.SQLException;

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

	public String getDate(int boardNo) throws SQLException {
		return (String) sqlMapClient.queryForObject("board.getDate", boardNo);
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

}
