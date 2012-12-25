package model;

import java.io.File;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import model.vo.BoardCommentVO;
import model.vo.BoardVO;
import model.vo.ListVO;
import model.vo.PagingBean;
import config.CommonConstants;

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
		String boardDate = boardDao.getBoardDate(boardNo);
		bvo.setBoardDate(boardDate);
	}

	// 게시물을 삭제 할 경우 댓글도 삭제
	public void delete(String boardNo) throws SQLException {
		boardDao.deleteComment(boardNo);
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
		System.out.println("3333333333333333333333333333333333" + page);
		int totalContent = boardDao.totalContent();
		PagingBean bean = new PagingBean(Integer.parseInt(page), totalContent, CommonConstants.BOARD_CONTENT_NUMBER_PER_PAGE, CommonConstants.BOARD_PAGEGROUP_NUMBER_PER_PAGE);
		
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
		String boardDate = boardDao.getBoardDate(boardNo);
		bvo.setBoardDate(boardDate);
	}

	public HashMap NextAndPreContent(String boardNo) throws SQLException {
		return boardDao.NextAndPreContent(boardNo);
	}

	public void commentContent(BoardCommentVO bcvo) throws SQLException {
		// 게시물에 댓글 달기 전 해당 게시물 commentCount 증가
		boardDao.updateCommentCount(bcvo.getBoardNo());
		// 댓글을 db에 저장하는 과정 commentNo 하고 commentDate 정보 추가
		int commentNo = boardDao.commentContent(bcvo);
		// 입력 되어진 해당 댓글의 commentDate 정보를 bcvo 에 setting 하는 과정(commentNo 의 경우는 insert 시에 setting)
		String commentDate = boardDao.getCommentDate(commentNo);
		bcvo.setCommentDate(commentDate);
		System.out.println("insert 후의 bcvo" + bcvo);
	}

	public ArrayList<BoardCommentVO> commentList(String boardNo) throws SQLException {
		return boardDao.commentList(boardNo);
	}
}
