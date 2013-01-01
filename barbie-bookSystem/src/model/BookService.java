package model;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import model.vo.BookCommentVO;
import model.vo.BookVO;
import model.vo.ListVO;
import model.vo.PagingBean;
import model.vo.PublisherVO;
import model.vo.SubjectVO;

import com.ibatis.sqlmap.client.SqlMapClient;

import config.CommonConstants;

public class BookService {
	private BookDao dao;
	private SqlMapClient sqlMapClient;
	public BookService() {
		super();
		// TODO Auto-generated constructor stub
	}
	public void setSqlMapClient(SqlMapClient sqlMapClient){
		this.sqlMapClient = sqlMapClient;
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
	public ListVO getBookAllList() throws SQLException {
		// TODO Auto-generated method stub
		ListVO vo = new ListVO();
		vo.setBean(new PagingBean(1, dao.getContentAllCountAdmin(),10,10 ));
		System.out.println(dao.getContentAllCount());
		vo.setList(dao.getBookAllList());
		return vo;
	}
	public ListVO getBookAllList(String page) throws SQLException {
		// TODO Auto-generated method stub
		ListVO vo = new ListVO();
		vo.setBean(new PagingBean(Integer.parseInt(page), dao.getContentAllCountAdmin(),10,10 ));
		System.out.println(dao.getContentAllCount());
		vo.setList(dao.getBookAllListAdmin(page));
		return vo;
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
		System.out.println("commentList : " + dao.getCommentList(isbn));
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
	public ArrayList<PublisherVO> getPublisherList() throws SQLException {
		// TODO Auto-generated method stub
		return dao.getPublisherList();
	}
	public ArrayList<PublisherVO> insertPublisher(String publisher) throws SQLException {
		// TODO Auto-generated method stub
		dao.insertPublisher(publisher);
		return dao.getPublisherList();
	}
	public ArrayList<SubjectVO> getSubjectList() throws SQLException {
		// TODO Auto-generated method stub
		return dao.getSubjectList();
	}
	public ArrayList<SubjectVO> insertSubject(String subject) throws SQLException {
		// TODO Auto-generated method stub
		dao.insertSubject(subject);
		return dao.getSubjectList();
	}
	public ArrayList<PublisherVO> getPublisher(String publisher) throws SQLException {
		// TODO Auto-generated method stub
		return dao.getPublisher(publisher);
	}
	public ArrayList<SubjectVO> getSubjectAdmin(String subject) throws SQLException {
		// TODO Auto-generated method stub
		return dao.getSubjectAdmin(subject);
	}
	public void deletePublisher(int publisherNo) throws SQLException {
		// TODO Auto-generated method stub
		dao.updateBookPublisher(publisherNo);
		dao.deletePublisher(publisherNo);
	}
	public void deleteSubject(int subjectNo) throws SQLException {
		// TODO Auto-generated method stub
		dao.updateBookSubject(subjectNo);
		dao.deleteSubject(subjectNo);
		
	}
	/*
	 *  호희 & 전기 코드
	 */
	//		예약
	public void bookReserve(HashMap map) throws SQLException {
		map.put("state", "예약중");
		try{
			sqlMapClient.startTransaction();
			dao.changeBookState(map);									// 책 상태 정보 수정
			dao.insertBookReesrve(map);								// 예약 테이블 데이터 삽입
			sqlMapClient.commitTransaction();
		}finally{
			sqlMapClient.endTransaction();						// 트렌잭션 무조건 닫아줘야 한다.
		}
	}

	//		예약취소
	public void bookReserveCancel(HashMap map) throws SQLException {
		map.put("state", "대여가능");
		try{
			sqlMapClient.startTransaction();
			dao.changeBookState(map);									// 책 상태 수정
			dao.deleteBookReserve(map);								// 예약 테이블 데이터 삭제
			sqlMapClient.commitTransaction();
		}finally{
			sqlMapClient.endTransaction();						// 트렌잭션 무조건 닫아줘야 한다.
		}
	}

	//		관리자가 접근하여 도서관리 View
	public ListVO adminBook(String nowPage) throws SQLException {
		if(nowPage == null)
			nowPage="1";
		HashMap map = new HashMap();
		map.put("nowPage", nowPage);
		map.put("num",CommonConstants.BOOK_CONTENT_NUMBER_PER_PAGE);
		ArrayList list = dao.adminBook(map);
		int total = dao.getAllBookCount();
		PagingBean pb = new PagingBean(Integer.parseInt(nowPage),total,CommonConstants.BOOK_CONTENT_NUMBER_PER_PAGE,CommonConstants.BOOK_PAGEGROUP_NUMBER_PER_PAGE);
		return new ListVO(list,pb);
	}

	//		예약-대여 하기전 예약 테이블에 데이터 존재 여부
	public boolean isReserveData(String bookNo,String memberId) throws SQLException{
		HashMap map = new HashMap();
		map.put("memberId",memberId);
		map.put("bookNo",bookNo);
		Object obj = dao.isReserveData(map);
		boolean flag=false;
		if(obj !=null)
			flag=true;
		return flag;
	}

	//		예약
	public void bookRental(String bookNo, String memberId, boolean state) throws SQLException {
		HashMap map = new HashMap();
		map.put("bookNo", bookNo);
		map.put("memberId", memberId);
		map.put("state", "대여중");
		try{
			sqlMapClient.startTransaction();
			dao.changeBookState(map);								// 도서 상태 변화
			dao.bookRental(map);										// 대여 테이블 데이터 삽입
			if(state)
				dao.deleteBookReserve(map);						// 예약 테이블 데이터 삭제
			sqlMapClient.commitTransaction();
		}finally{
			sqlMapClient.endTransaction();						// 트렌잭션 무조건 닫아줘야 한다.
		}
	}

	// 	반납
	public void bookRentalCancel(String bookNo) throws SQLException {
		HashMap map = new HashMap();
		map.put("bookNo", bookNo);
		map.put("state","대여가능");
		try{
			sqlMapClient.startTransaction();
			dao.changeBookState(map);
			dao.bookRentalCancel(bookNo);
			sqlMapClient.commitTransaction();
		}finally{
			sqlMapClient.endTransaction();
		}
	}
	//도서 검색
	public ArrayList<HashMap> getBookListBySubject(HashMap value) throws SQLException {
		// TODO Auto-generated method stub
		return dao.getBookListBySubject(value);
	}
	public int getBookListBySubjectCount(String value) throws SQLException {
		// TODO Auto-generated method stub
		return dao.getBookListBySubjectCount(value);
	}
	public ArrayList<HashMap> getBookListByPublisher(HashMap value) throws SQLException {
		// TODO Auto-generated method stub
		return dao.getBookListByPublisher(value);
	}
	public int getBookListByPublisherCount(String value) throws SQLException {
		// TODO Auto-generated method stub
		return dao.getBookListByPublisherCount(value);
	}
	public ArrayList<HashMap> getBookListByTitle(HashMap value) throws SQLException {
		// TODO Auto-generated method stub
		return dao.getBookListByTitle(value);
	}
	public int getBookListByTitleCount(String value) throws SQLException {
		// TODO Auto-generated method stub
		return dao.getBookListByTitleCount(value);
	}
	public ArrayList<HashMap> getBookListByWriter(HashMap value) throws SQLException {
		// TODO Auto-generated method stub
		return dao.getBookListByWriter(value);
	}
	public int getBookListByWriterCount(String value) throws SQLException {
		// TODO Auto-generated method stub
		return dao.getBookListByWriterCount(value);
	}
}
