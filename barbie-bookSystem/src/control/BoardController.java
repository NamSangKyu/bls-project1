package control;

import model.BoardService;

import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

public class BoardController extends MultiActionController {
	private BoardService boardService;

	public BoardController(BoardService boardService) {
		super();
		this.boardService = boardService;
	}

}
