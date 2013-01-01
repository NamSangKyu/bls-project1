package model;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import model.vo.BookCommentVO;
import model.vo.BookVO;
import model.vo.PublisherVO;
import model.vo.SubjectVO;

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
		System.out.println("map="+map.toString());
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


	public int getCommentNO() throws SQLException {
		return (int) sqlMapClient.queryForObject("book.getCommentNo");
	}
	public void insertComment(BookCommentVO vo) throws SQLException {
		sqlMapClient.insert("book.insertComment", vo);
	}
	public ArrayList getCommentList(String isbn) throws SQLException {
	return (ArrayList) sqlMapClient.queryForList("book.getCommentList", isbn);
	}
	public  double getAvgScore(int isbn) throws SQLException{
		System.out.println("Dao avgScore  isbn : " + isbn );
	return (double) sqlMapClient.queryForObject("book.getAvgScore",isbn);
	}
	public ArrayList recommandBook() throws SQLException {
	return (ArrayList) sqlMapClient.queryForList("book.recommandBook");
	}
	public ArrayList recommandBook(String subject) throws SQLException {
	return (ArrayList) sqlMapClient.queryForList("book.recommandBookBySubject", subject);
	}

	public ArrayList getSubject() throws SQLException {
	return (ArrayList) sqlMapClient.queryForList("book.getSubject");

	}
	public ArrayList<PublisherVO> getPublisherList() throws SQLException {
		// TODO Auto-generated method stub
		return (ArrayList<PublisherVO>) sqlMapClient.queryForList("book.getPublisherList");
	}
	public void insertPublisher(String publisher) throws SQLException {
		// TODO Auto-generated method stub
		sqlMapClient.insert("book.insertPublisher", publisher);
	}
	public ArrayList<SubjectVO> getSubjectList() throws SQLException {
		// TODO Auto-generated method stub
		return (ArrayList<SubjectVO>) sqlMapClient.queryForList("book.getSubjectList");
	}
	public void insertSubject(String subject) throws SQLException {
		// TODO Auto-generated method stub
		sqlMapClient.insert("book.insertSubject", subject);
	}

	/*
	 * 		호희 & 전기 코드
	 */
	// 책 상태
	public ArrayList getBookState(int isbn) throws SQLException {
		return (ArrayList) sqlMapClient.queryForList("book.getBookState", isbn);
	}
	// 예약
	public void bookReserve(String  bookNo) throws SQLException {
		sqlMapClient.update("book.bookReserve", bookNo);				// 책 상태 정보 수정
	}
	public void insertBookReesrve(HashMap map) throws SQLException{
		sqlMapClient.insert("book.insertBookReserve",map);			// 예약테이블 데이터 삽입
	}
	// 예약 취소
	public void deleteBookReserve(HashMap map) throws SQLException{
		sqlMapClient.delete("book.deleteBookReserve",map);			// 예약 테이블 데이터 삭제
	}
	public ArrayList adminBook(HashMap map) throws SQLException {
		return (ArrayList) sqlMapClient.queryForList("book.adminBook",map);
	}
	public Object isReserveData(HashMap map) throws SQLException{
		return sqlMapClient.queryForObject("book.isReserveData",map);
	}
	public void bookStateRental(String bookNo) throws SQLException {
		sqlMapClient.update("book.bookStateRental",bookNo);				// rental
	}
	public void bookRental(HashMap map) throws SQLException {
		sqlMapClient.insert("book.bookRental",map);
	}
	 public void bookRentalCancel(String bookNo) throws SQLException {
		 sqlMapClient.update("book.bookRentalCancel",bookNo);
	}
	public void changeBookState(HashMap map) throws SQLException{
		sqlMapClient.update("book.changeBookState",map);			// 북 상태 변화
	}
	public int getAllBookCount() throws SQLException{
		return (Integer)sqlMapClient.queryForObject("book.getAllBookCount");		// 전체 글수
	}
}
