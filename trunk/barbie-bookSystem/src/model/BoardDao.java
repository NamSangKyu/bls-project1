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

	public BoardVO insert() throws SQLException {
		return (BoardVO) sqlMapClient.queryForObject("board.insert");
	}

}
