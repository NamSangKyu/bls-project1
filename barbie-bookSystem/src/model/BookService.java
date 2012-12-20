package model;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import model.vo.BookCommentVO;
import model.vo.BookVO;
import model.vo.ListVO;
import model.vo.PagingBean;

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
	public ListVO getBookList(String nowPage) {
		// TODO Auto-generated method stub
		ListVO vo=null;
		PagingBean paging = null;
		try {
			int totContents = dao.getContentAllCount();
			paging = new PagingBean(Integer.parseInt(nowPage),totContents,5,5 );
			ArrayList<HashMap> list = dao.getBookList(nowPage);
			vo = new ListVO(list, paging);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return vo;
	}
	public HashMap getBookInfoIsbn(int isbn) throws SQLException {
		// TODO Auto-generated method stub
		return dao.getBookInfoIsbn(isbn);
	}
	public void updateBookInfo(HashMap map) throws SQLException {
		// TODO Auto-generated method stub
		dao.updateBookInfo(map);
	}
	public int getPublisherNo(String publisher) throws SQLException {
		// TODO Auto-generated method stub
		return dao.getPublisherNo(publisher);
	}
	public int getSubjectNo(String subject) throws SQLException {
		// TODO Auto-generated method stub
		return dao.getSubjectNo(subject);
	}
	
	public HashMap insertComment(BookCommentVO vo) throws SQLException {
		vo.setNo(dao.getCommentNO());
		dao.insertComment(vo);
		HashMap map=new HashMap();
		ArrayList list= dao.getCommentList(String.valueOf(vo.getIsbn()));
		map.put("list", list );
		map.put("avgscore",dao.getAvgScore(vo.getIsbn()));
		return map;
		
		}
		
		public HashMap getCommentList(String isbn) throws SQLException {
		HashMap map=new HashMap();
		map.put("list", dao.getCommentList(isbn));
		map.put("avgscore",dao.getAvgScore(Integer.parseInt(isbn)));
		return map;
		}
		public ArrayList recommandBook() throws SQLException {
		return dao.recommandBook();
			
		}
		public ArrayList recommandBook(String subject) throws SQLException {
		return dao.recommandBook(subject);
		}
		public ArrayList getSubject() throws SQLException {
		return dao.getSubject();		
		}
	
	
	
	
	
	
	
	
	
	
	
	public ArrayList getBookState(int isbn) throws SQLException {
		return dao.getBookState(isbn);
	}
	public void bookResolve(String bookNo) throws SQLException {
		dao.bookResolve(bookNo);
	}
	public void bookResolveCancle(String bookNo) throws SQLException {
		dao.bookResolveCancle(bookNo);
	}
	public ArrayList adminBook() throws SQLException {
		return dao.adminBook();
	}
	public void bookRental(String bookNo, String memberId) {
		HashMap map = new HashMap();
		map.put("bookNo", bookNo);
		map.put("memberId", memberId);
		dao.bookRental(map);
	}
	public void bookRentalCancle(String bookNo) {
		dao.bookRentalCancle(bookNo);
	}

}
