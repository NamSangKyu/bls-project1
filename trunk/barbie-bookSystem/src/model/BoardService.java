package model;

public class BoardService {
	private BoardDao boardDao;

	public BoardService(BoardDao boardDao) {
		super();
		this.boardDao = boardDao;
	}

}
