package control;

import java.sql.SQLException;

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

	public ModelAndView insert(HttpServletRequest request,
			HttpServletResponse response, HttpSession session, BoardVO bvo)
			throws SQLException {
		boardService.insert(bvo);
		return new ModelAndView("board/show_content", "bvo", bvo);
	}
}
