package control;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.BoardService;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

public class BoardController extends MultiActionController {
	private BoardService boardService;

	public BoardController(BoardService boardService) {
		super();
		this.boardService = boardService;
	}
	
	public ModelAndView insert(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		return new ModelAndView("insert.board", "test", boardService.insert());
	}

}
