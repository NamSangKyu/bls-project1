package control;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.BookService;
import model.vo.BookVO;
import model.vo.ListVO;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

public class BookController extends MultiActionController{
	private String path;
	private BookService service;
	 
	public void setService(BookService service) {
		this.service = service;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public ModelAndView home(HttpServletRequest request, HttpServletResponse response){
		System.out.println("home");
		return new ModelAndView("home","test","홈화면 타일즈 테스트");
	}
	public ModelAndView bookinfo(HttpServletRequest request, HttpServletResponse response){
		System.out.println("bookinfo");
		return new ModelAndView("info.book","test","bookinfo타일즈 테스트");
	}
	public ModelAndView bookInsert(HttpServletRequest request, HttpServletResponse response){
		System.out.println("bookInsert");
		return new ModelAndView("insert.book","test","bookInsert타일즈 테스트");
	}
	//--------------------------------------------------
	private String fileUpload(MultipartFile mfile,int isbn) {
		System.out.println(mfile.getOriginalFilename());//파일 이름
		String fileName = String.valueOf(System.currentTimeMillis()) + "_"+String.valueOf(isbn)+".jpg";
		//업로드할 원본 파일을 이동시킬 파일 객체를 생성
		File copyFile = new File(path+fileName);
		try {
			mfile.transferTo(copyFile);
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("file upload ok~"+copyFile.getName());
		return fileName;
	}
	
	public ModelAndView insert(HttpServletRequest request, HttpServletResponse response, BookVO vo){
		System.out.println("insert");
		System.out.println(vo.toString());
		String filename=null;
		try {
			filename = service.checkBook(vo.getIsbn());
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		System.out.println(filename);
		if(filename==null){
			MultipartFile mfile = vo.getFile();
			filename = fileUpload(mfile , vo.getIsbn());
		}
		int bookno = 0;
		try {
			bookno = service.insert(vo, filename);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		HashMap map = new HashMap();
		try {
			map = service.getBookInfo(bookno);
			System.out.println(map.toString());
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return new ModelAndView("info.book","map",map);
	}
	public ModelAndView getBookAllList(HttpServletRequest request, HttpServletResponse response){
		ArrayList list = new ArrayList();
		try {
			list = service.getBookAllList();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return new ModelAndView("list.book","list",list);
	}
	public ModelAndView getBookInfoTitle(HttpServletRequest request, HttpServletResponse response){
		String title = request.getParameter("title");
		HashMap map = new HashMap();
		try {
			map = service.getBookInfoTitle(title);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return new ModelAndView("info.book","map",map);
	}
	public ModelAndView getBookList(HttpServletRequest request, HttpServletResponse response){
		String nowPage = request.getParameter("nowPage");
		ListVO list = service.getBookList(nowPage);
		System.out.println("paging 완료");
		System.out.println(list.getBean().getEndPageOfPageGroup());
		
		return new ModelAndView("list.book","list",list);
	}
	public ModelAndView updateSet(HttpServletRequest request, HttpServletResponse response){
		int isbn = Integer.parseInt(request.getParameter("isbn"));
		HashMap map = null;
		try {
			map = service.getBookInfoIsbn(isbn);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return new ModelAndView("update.book","map",map);
	}
	
	public ModelAndView updateBook(HttpServletRequest request, HttpServletResponse response){
		int isbn = Integer.parseInt(request.getParameter("isbn"));
		String title = request.getParameter("title");
		String writer = request.getParameter("writer");
		String loc = request.getParameter("loc");
		int publisherNo = Integer.parseInt(request.getParameter("publisherNo")) ;
		int subjectNo = Integer.parseInt(request.getParameter("subjectNo"));
		String cont = request.getParameter("cont");
		HashMap map = new HashMap();
		map.put("title", title);
		map.put("writer", writer);
		map.put("isbn", isbn);
		map.put("loc", loc);
		map.put("publisherNo", publisherNo);
		map.put("subjectNo", subjectNo);
		map.put("cont", cont);
		try {
			service.updateBookInfo(map);
			System.out.println("업데이트 완료");
			map = service.getBookInfoIsbn(isbn);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return new ModelAndView("info.book","map",map);
	}
	public ModelAndView getPblisherNo(HttpServletRequest request, HttpServletResponse response){
		String publisher = request.getParameter("publisher");
		int publisherNo=0;
		try {
			publisherNo = service.getPublisherNo(publisher);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(publisherNo);
		return new ModelAndView("JsonView","publisherNo",publisherNo); 
	}
	public ModelAndView getSubjectNo(HttpServletRequest request, HttpServletResponse response){
		String subject = request.getParameter("subject");
		int subjectNo=0;
		try {
			subjectNo = service.getSubjectNo(subject);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(subjectNo);
		return new ModelAndView("JsonView","subjectNo",subjectNo); 
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	// 여기서부터 호희 추가로직 
	// 북 정보 뽑아올때 해당 북에 대한 예약 목록 가져오는 로직
	public ModelAndView getBookInfoIsbn(HttpServletRequest request, HttpServletResponse response) throws SQLException{
		int isbn = Integer.parseInt(request.getParameter("isbn"));
		HashMap map = new HashMap();
		try {
			map = service.getBookInfoIsbn(isbn);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// 도서 info 볼 때 도서상태 보기위한 로직
		ArrayList list = service.getBookState(isbn);
		request.setAttribute("list", list);
		
		return new ModelAndView("info.book","map",map);
	}
	
	// 예약 버튼을 눌렀을 경우 도서상태 예약 취소 상태으로 바뀌는 Ajax
	public ModelAndView bookResolve(HttpServletRequest request, HttpServletResponse response) throws SQLException{
		String bookNo = request.getParameter("bookNo");
		service.bookResolve(bookNo);
		return new ModelAndView("JsonView"); 
	}
	
	// 예약 취소 버튼을 눌렀을 경우 도서상태 예약상태로 바뀌는 Ajax
	public ModelAndView bookResolveCancle(HttpServletRequest request, HttpServletResponse response)  throws SQLException{
		System.out.println("ㅎㅎ");
		String bookNo = request.getParameter("bookNo");
		service.bookResolveCancle(bookNo);
		return new ModelAndView("JsonView"); 
	}
	
	// 추가적인 로직인데 관리자가 로그인 하여 도서관리를 눌렀을 경우 도서전체에 대한 상태가 보여짐
	public ModelAndView adminBook(HttpServletRequest request, HttpServletResponse response) throws SQLException{
		ArrayList list = service.adminBook();
		return new ModelAndView("admin_list.book","list", list);
	}
	
	// 관리자 도서관리 에서 대여 할 경우 진행될 소스
	public ModelAndView bookRental(HttpServletRequest request, HttpServletResponse response) throws SQLException{
		String bookNo = request.getParameter("bookNo");
		String memberId = request.getParameter("memberId");
		service.bookRental(bookNo, memberId);
		return new ModelAndView("JsonView"); 
	}
	
	// 관리자 도서관리 에서 반납 할 경우 진행될 소스
	public ModelAndView bookRentalCancle(HttpServletRequest request, HttpServletResponse response)  throws SQLException{
		String bookNo = request.getParameter("bookNo");
		service.bookRentalCancle(bookNo);
		return new ModelAndView("JsonView"); 
	}
	
	
}
