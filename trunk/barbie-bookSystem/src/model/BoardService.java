package model;

import java.sql.SQLException;
import java.util.ArrayList;

import model.vo.BoardVO;

public class BoardService {
	private BoardDao boardDao;

	public BoardService(BoardDao boardDao) {
		super();
		this.boardDao = boardDao;
	}

	public void insert(BoardVO bvo) throws SQLException {
		// 게시물을 db에 저장하는 과정 boardNo 하고 boardDate 정보 추가
		int boardNo = boardDao.insert(bvo);
		// 입력 되어진 해당 게시물의 boardDate 정보를 bvo 에 setting 하는 과정(boardNo 의 경우는 insert 시에 setting)
		String date = boardDao.getDate(boardNo);
		bvo.setBoardDate(date);
	}

	public void delete(String boardNo) throws SQLException {
		boardDao.delete(boardNo);
	}

	public BoardVO showContent(String boardNo) throws SQLException {
		boardDao.updateCount(boardNo);
		return boardDao.showContent(boardNo);
	}

	public BoardVO showContentNoCount(String boardNo) throws SQLException {
		return boardDao.showContent(boardNo);
	}

	public void updateContent(BoardVO bvo) throws SQLException {
		boardDao.updateContent(bvo);
	}

	public ArrayList<BoardVO> list() throws SQLException {
		return boardDao.list();
	}
}