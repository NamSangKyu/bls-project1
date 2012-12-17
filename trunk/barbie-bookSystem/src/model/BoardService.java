package model;

import java.io.File;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import config.CommonConstants;

import model.vo.BoardVO;
import model.vo.ListVO;
import model.vo.PagingBean;

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
		System.out.println("insert 후의 bvo" + bvo);
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

	public ListVO list(String page) throws SQLException {
		
		int totalContent = boardDao.totalContent();
		PagingBean bean = new PagingBean(Integer.parseInt(page), totalContent);
		
		HashMap map = new HashMap();
		map.put("page", page);
		map.put("num", CommonConstants.BOARD_CONTENT_NUMBER_PER_PAGE);
		ArrayList list = boardDao.list(map);
		ListVO lvo = new ListVO(list, bean);
	
		return lvo;
	}

	public void deleteFile(String newFileName) {
		File f=new File(newFileName);
		System.out.println(newFileName+" file remove:"+f.delete());
	}

	public void replyContent(BoardVO bvo) throws SQLException {
		boardDao.updateRestep(bvo);
		bvo.setRestep(bvo.getRestep() + 1);
		bvo.setRelevel(bvo.getRelevel() + 1);
		// 게시물을 db에 저장하는 과정 boardNo 하고 boardDate 정보 추가
		int boardNo = boardDao.replyContent(bvo);
		// 입력 되어진 해당 게시물의 boardDate 정보를 bvo 에 setting 하는 과정(boardNo 의 경우는 insert 시에 setting)
		String date = boardDao.getDate(boardNo);
		bvo.setBoardDate(date);
	}
}
