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

}
