package control;

import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.BoardService;
import model.vo.BoardVO;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

public class BoardController extends MultiActionController {
	private BoardService boardService;

	public BoardController(BoardService boardService) {
		super();
		this.boardService = boardService;
	}

	// 게시물 쓰기 화면
	public ModelAndView insertView(HttpServletRequest request,HttpServletResponse response) throws SQLException {
		return new ModelAndView("insert.board");
	}
	
	// 게시물 글쓰기 과정
	public ModelAndView insert(HttpServletRequest request, HttpServletResponse response, HttpSession session, BoardVO bvo) throws SQLException {
		boardService.insert(bvo);
		return new ModelAndView("show_content.board", "bvo", bvo);
	}
	
	// 게시물 보여줄 경우 count 증가 후 showContent
		public ModelAndView showContent(HttpServletRequest request, HttpServletResponse response) throws SQLException {
			String boardNo = request.getParameter("boardNo");
			BoardVO bvo = boardService.showContent(boardNo);
			return new ModelAndView("show_content.board", "bvo", bvo);
		}
	
	// 게시물 삭제 이후 목록 페이지로 이동
	public ModelAndView delete(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		String boardNo = request.getParameter("boardNo");
		boardService.delete(boardNo);
		ArrayList<BoardVO> lvo = boardService.list();
		return new ModelAndView("list.board", "lvo", lvo);
	}
	
	// 게시물 수정화면 보여주기 이런 경우는 count 증가 없이 showContent
	public ModelAndView updateView(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		String boardNo = request.getParameter("boardNo");
		BoardVO bvo = boardService.showContentNoCount(boardNo);
		return new ModelAndView("update.board", "bvo", bvo);
	}
	
	// 게시물 수정 작업을 끝내고 해당 게시물 보여주기
	public ModelAndView updateContent(HttpServletRequest request, HttpServletResponse response, BoardVO bvo) throws SQLException {
		String boardNo = request.getParameter("boardNo");
		boardService.updateContent(bvo);
		bvo = boardService.showContentNoCount(boardNo);
		return new ModelAndView("show_content.board", "bvo", bvo);
	}
	
	// 게시물 리스트 보기
	public ModelAndView list(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		ArrayList<BoardVO> lvo = boardService.list();
		return new ModelAndView("list.board", "lvo", lvo);
	}
	
	
	
}
