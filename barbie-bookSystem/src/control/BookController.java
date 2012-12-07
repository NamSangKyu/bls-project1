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
	
}
