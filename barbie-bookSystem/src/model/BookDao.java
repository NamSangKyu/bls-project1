package model;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import model.vo.BookVO;

import org.springframework.web.multipart.MultipartFile;

import com.ibatis.sqlmap.client.SqlMapClient;

public class BookDao {
	private SqlMapClient sqlMapClient;

	public void setSqlMapClient(SqlMapClient sqlMapClient) {
		this.sqlMapClient = sqlMapClient;
	}

	public int newBookNo() throws SQLException {
		return (int) sqlMapClient.queryForObject("book.bookno");
	}

	public int insert(BookVO vo, String filename) throws SQLException {
		// TODO Auto-generated method stub
		HashMap map = new HashMap();
		MultipartFile mfile = vo.getFile();
		map.put("bookno", newBookNo());
		map.put("vo", vo);
		map.put("file", filename);
		System.out.println(map.get("file"));
		sqlMapClient.insert("book.insert", map);
		System.out.println("삽입성공");
		return (int) map.get("bookno");
	}

	public HashMap getBookInfo(int bookno) throws SQLException {
		// TODO Auto-generated method stub
		return (HashMap) sqlMapClient.queryForObject("book.getBookInfoNum",
				bookno);
	}

	public ArrayList getBookAllList() throws SQLException {
		// TODO Auto-generated method stub
		return (ArrayList) sqlMapClient.queryForList("book.getBookAllList");
	}

	public HashMap getBookInfoTitle(String title) throws SQLException {
		// TODO Auto-generated method stub
		return (HashMap) sqlMapClient.queryForObject("book.getBookInfoTitle",
				title);
	}

	public String checkBook(int isbn) throws SQLException {
		// TODO Auto-generated method stub
		HashMap map = null;
		map = (HashMap) sqlMapClient.queryForObject("book.checkBook", isbn);
		if (map == null)
			return null;
		System.out.println("checkBook" + map.toString());
		return (String) map.get("IMG");
	}

	public int getContentAllCount() throws SQLException {
		// TODO Auto-generated method stub
		return (int) sqlMapClient.queryForObject("book.getContentAllCount");
	}

	public ArrayList<HashMap> getBookList(String pageNum) throws SQLException {
		// TODO Auto-generated method stub
		return (ArrayList<HashMap>) sqlMapClient.queryForList(
				"book.getBookList", pageNum);
	}

	public HashMap getBookInfoIsbn(int isbn) throws SQLException {
		// TODO Auto-generated method stub
		return (HashMap) sqlMapClient.queryForObject("book.getBookInfoIsbn",
				isbn);
	}

	public void updateBookInfo(HashMap map) throws SQLException {
		// TODO Auto-generated method stub
		sqlMapClient.update("book.updateBookInfo", map);
	}

	public int getPublisherNo(String publisher) throws SQLException {
		// TODO Auto-generated method stub
		return (int) sqlMapClient.queryForObject("book.getPublisherNo",
				publisher);
	}

	public int getSubjectNo(String subject) throws SQLException {
		// TODO Auto-generated method stub
		return (int) sqlMapClient.queryForObject("book.getSubjectNo", subject);
	}

	
	
	
	
	
	
	
	
	
	
	public ArrayList getBookState(int isbn) throws SQLException {
		return (ArrayList) sqlMapClient.queryForList("book.getBookState", isbn);
	}

	public void bookResolve(String bookNo) throws SQLException {
		sqlMapClient.update("book.bookResolve", bookNo);
	}

	public void bookResolveCancle(String bookNo) throws SQLException {
		sqlMapClient.update("book.bookResolveCancle", bookNo);
	}

	public ArrayList adminBook() throws SQLException {
		return (ArrayList) sqlMapClient.queryForList("book.adminBook");
	}

	public void bookRental(HashMap map) {
	}

	public void bookRentalCancle(String bookNo) {
	}
}
