package model;

import java.sql.SQLException;

import model.vo.BoardVO;

public class BoardService {
	private BoardDao boardDao;

	public BoardService(BoardDao boardDao) {
		super();
		this.boardDao = boardDao;
	}

	public BoardVO test() throws SQLException {
		return boardDao.test();
	}
}
