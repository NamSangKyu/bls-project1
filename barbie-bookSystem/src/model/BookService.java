package model;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import model.vo.BookVO;

public class BookService {
	private BookDao dao;
	public BookService() {
		super();
		// TODO Auto-generated constructor stub
	}
	public void setDao(BookDao dao) {
		this.dao = dao;
	}
	public int insert(BookVO vo,String filename) throws SQLException{
		return dao.insert(vo,filename);
	}
	public HashMap getBookInfo(int bookno) throws SQLException {
		// TODO Auto-generated method stub
		return dao.getBookInfo(bookno);
	}
	public ArrayList getBookAllList() throws SQLException {
		// TODO Auto-generated method stub
		return dao.getBookAllList();
	}
	public HashMap getBookInfoTitle(String title) throws SQLException {
		// TODO Auto-generated method stub
		return dao.getBookInfoTitle(title);
	}
	public String checkBook(int isbn) throws SQLException {
		// TODO Auto-generated method stub
		return dao.checkBook(isbn);
	}

}
