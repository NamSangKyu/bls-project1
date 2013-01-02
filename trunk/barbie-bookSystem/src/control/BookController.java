package control;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.BookService;
import model.vo.BookCommentVO;
import model.vo.BookVO;
import model.vo.ListVO;
import model.vo.PagingBean;
import model.vo.PublisherVO;
import model.vo.SubjectVO;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

public class BookController extends MultiActionController {
	private String path;
	private BookService service;

	public void setService(BookService service) {
		this.service = service;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public ModelAndView home(HttpServletRequest request,
			HttpServletResponse response) {
		System.out.println("home");
		return new ModelAndView("home", "test", "홈화면 타일즈 테스트");
	}

	public ModelAndView bookinfo(HttpServletRequest request,
			HttpServletResponse response) {
		System.out.println("bookinfo");
		return new ModelAndView("info.book", "test", "bookinfo타일즈 테스트");
	}

	public ModelAndView bookInsert(HttpServletRequest request,
			HttpServletResponse response) {
		System.out.println("bookInsert");
		return new ModelAndView("insert.book", "test", "bookInsert타일즈 테스트");
	}

	// --------------------------------------------------
	private String fileUpload(MultipartFile mfile, int isbn) {
		System.out.println(mfile.getOriginalFilename());// 파일 이름
		String fileName = String.valueOf(System.currentTimeMillis()) + "_"
				+ String.valueOf(isbn) + ".jpg";
		// 업로드할 원본 파일을 이동시킬 파일 객체를 생성
		File copyFile = new File(path + fileName);
		try {
			mfile.transferTo(copyFile);
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("file upload ok~" + copyFile.getName());
		return fileName;
	}
	public ModelAndView getBookInfoNo(HttpServletRequest request,
			HttpServletResponse response) {
		String bookno = request.getParameter("no");
		HashMap map = null;
		try {
			map = service.getBookInfo(Integer.parseInt(bookno));
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return new ModelAndView("book_info.admin","map",map);
	}
	public ModelAndView insert(HttpServletRequest request,
			HttpServletResponse response, BookVO vo) {
		System.out.println("insert");
		System.out.println(vo.toString());
		String filename = null;
		try {
			filename = service.checkBook(vo.getIsbn());
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		System.out.println(filename);
		if (filename == null) {
			MultipartFile mfile = vo.getFile();
			filename = fileUpload(mfile, vo.getIsbn());
		}
		int bookno = 0;
		try {
			bookno = service.insert(vo, filename);
			System.out.println("bookNo" + bookno);
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

		return new ModelAndView("info.book", "map", map);
	}


	public ModelAndView getBookAllList(HttpServletRequest request,
			HttpServletResponse response) {
		ListVO vo = null;
		String page = request.getParameter("nowPage");
		try {
			if(page!=null)
				vo = service.getBookAllList(page);
			else
				vo = service.getBookAllList();
			System.out.println(vo.toString());
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return new ModelAndView("book_delete.admin", "lvo", vo);
	}

	public ModelAndView getBookInfoTitle(HttpServletRequest request,
			HttpServletResponse response) {
		String title = request.getParameter("title");
		HashMap map = new HashMap();
		try {
			map = service.getBookInfoTitle(title);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return new ModelAndView("info.book", "map", map);
	}

	public ModelAndView getBookList(HttpServletRequest request,
			HttpServletResponse response) {
		String nowPage = request.getParameter("nowPage");
		ListVO list = service.getBookList(nowPage);
		System.out.println("paging 완료");
		System.out.println(list.getBean().getEndPageOfPageGroup());
		request.setAttribute("flag", false);
		return new ModelAndView("list.book", "list", list);
	}

	public ModelAndView updateSet(HttpServletRequest request,
			HttpServletResponse response) {
		int isbn = Integer.parseInt(request.getParameter("isbn"));
		HashMap map = null;
		try {
			map = service.getBookInfoIsbn(isbn);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return new ModelAndView("update.book", "map", map);
	}

	public ModelAndView updateBook(HttpServletRequest request,
			HttpServletResponse response) {
		int isbn = Integer.parseInt(request.getParameter("isbn"));
		String title = request.getParameter("title");
		String writer = request.getParameter("writer");
		String loc = request.getParameter("loc");
		int publisherNo = Integer.parseInt(request.getParameter("publisherNo"));
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
		return new ModelAndView("info.book", "map", map);
	}

	public ModelAndView getPblisherNo(HttpServletRequest request,
			HttpServletResponse response) {
		String publisher = request.getParameter("publisher");
		int publisherNo = 0;
		try {
			publisherNo = service.getPublisherNo(publisher);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(publisherNo);
		return new ModelAndView("JsonView", "publisherNo", publisherNo);
	}

	public ModelAndView getSubjectNo(HttpServletRequest request,
			HttpServletResponse response) {
		String subject = request.getParameter("subject");
		int subjectNo = 0;
		try {
			subjectNo = service.getSubjectNo(subject);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(subjectNo);
		return new ModelAndView("JsonView", "subjectNo", subjectNo);
	}

	// list 로 넣어야지!!
	public ModelAndView insertComment(HttpServletRequest request,
			HttpServletResponse response, BookCommentVO vo) {
		HashMap map = new HashMap();
		ArrayList list = null;
		try {
			map = service.insertComment(vo); // insertCommentf를 하고나면 list가 채워지므로
												// null해도 오케
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return new ModelAndView("JsonView", "map", map);

	}

	public ModelAndView getCommentList(HttpServletRequest request,
			HttpServletResponse response) {
		String isbn = request.getParameter("isbn");
		HashMap map = new HashMap();
		ArrayList list = new ArrayList();
		try {
			map = service.getCommentList(isbn);
			System.out.println("list=" + map.get("list"));
		} catch (SQLException e) {

			e.printStackTrace();
		}
		return new ModelAndView("JsonView", "map", map);
	}

	public ModelAndView recommandBook(HttpServletRequest request,
			HttpServletResponse response) {
		System.out.println("추천도서 컨트롤러 입성완료@@");
		String subject = request.getParameter("subject");
		ArrayList list = new ArrayList();
		try {
			if (subject == null || subject.equals("")) {
				list = service.recommandBook();
				return new ModelAndView("recommand.book", "list", list);
			} else {
				list = service.recommandBook(subject);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println("list=" + list);
		return new ModelAndView("JsonView", "list", list);

	}

	public ModelAndView getSubject(HttpServletRequest request,
			HttpServletResponse response) {
		System.out.println("getSubjectController입성완료");
		ArrayList list = new ArrayList();
		try {
			list = service.getSubject();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println(list.toString());
		return new ModelAndView("JsonView", "list", list);
	}

	public ModelAndView getPublisherList(HttpServletRequest request,
			HttpServletResponse response, BookCommentVO vo) {
		ArrayList<PublisherVO> list = null;
		try {
			list = service.getPublisherList();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(list.toString());
		return new ModelAndView("JsonView", "list", list);
	}

	public ModelAndView insertPublusher(HttpServletRequest request,
			HttpServletResponse response, BookCommentVO vo) {
		ArrayList<PublisherVO> list = null;
		String publisher = request.getParameter("publisher");
		System.out.println(publisher);
		try {
			list = service.insertPublisher(publisher);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(list.toString());
		return new ModelAndView("JsonView", "list", list);
	}

	public ModelAndView getSubjectList(HttpServletRequest request,
			HttpServletResponse response, BookCommentVO vo) {
		ArrayList<SubjectVO> list = null;
		try {
			list = service.getSubjectList();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(list.toString());
		return new ModelAndView("JsonView", "list", list);
	}

	public ModelAndView insertSubject(HttpServletRequest request,
			HttpServletResponse response, BookCommentVO vo) {
		System.out.println("subjecinsert");
		ArrayList<SubjectVO> list = null;
		String subject = request.getParameter("subject");
		System.out.println(subject);
		try {
			list = service.insertSubject(subject);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(list.toString());
		return new ModelAndView("JsonView", "list", list);
	}

	public ModelAndView publisher(HttpServletRequest request,
			HttpServletResponse response) {
		return new ModelAndView("publisher.admin");
	}

	public ModelAndView subject(HttpServletRequest request,
			HttpServletResponse response) {
		return new ModelAndView("subject.admin");
	}

	/*
	 * 여기서부터 호희 추가로직
	 */
	// 북 정보 뽑아올때 해당 북에 대한 예약 목록 가져오는 로직 ( 상규 공용 로직)
	public ModelAndView getBookInfoIsbn(HttpServletRequest request,
			HttpServletResponse response) throws SQLException {
		int isbn = Integer.parseInt(request.getParameter("isbn"));
		HashMap map = new HashMap();
		try {
			map = service.getBookInfoIsbn(isbn);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		ArrayList list = service.getBookState(isbn);			// 도서 info 볼 때 도서상태 보기위한 로직
		request.setAttribute("list", list);
		return new ModelAndView("info.book", "map", map);
	}

	// 관리자가 로그인 하여 도서관리를 눌렀을 경우 도서전체에 대한 상태가 보여짐
	public ModelAndView adminBook(HttpServletRequest request,
			HttpServletResponse response) throws SQLException {
		ListVO listvo = service.adminBook(request.getParameter("nowPage"));
		PagingBean pb = listvo.getBean();
		return new ModelAndView("admin_list.admin", "listvo", listvo);
	}

	// 예약 버튼을 눌렀을 경우 도서상태 예약 취소 상태으로 바뀌는 Ajax
	// 1. 도서상태 변경 2. 예약테이블 테이터 삽입
	public ModelAndView bookReserve(HttpServletRequest request,
			HttpServletResponse response) throws SQLException {
		String bookNo = request.getParameter("bookNo");
		String memberId = request.getParameter("memberId");
		HashMap map = new HashMap();
		map.put("bookNo", bookNo);			map.put("memberId", memberId);
		System.out.println("reserve call : " +map);											// Test
		service.bookReserve(map);
		return new ModelAndView("JsonView");
	}

	// 예약 취소 버튼을 눌렀을 경우 도서상태 예약상태로 바뀌는 Ajax
	// 1. 도서 상태 변경 2. 예약테이블 데이터 삭제
	public ModelAndView bookReserveCancel(HttpServletRequest request,
			HttpServletResponse response) throws SQLException {
		String bookNo = request.getParameter("bookNo");
		String memberId = request.getParameter("memberId");
		HashMap map = new HashMap();
		map.put("bookNo", bookNo);			map.put("memberId", memberId);
		System.out.println("reserve cancle call : " + map);								// Test
		service.bookReserveCancel(map);
		return new ModelAndView("JsonView");
	}

	// 관리자 도서관리 에서 대여 할 경우 진행될 소스  Rental
	// 예약중 - 1. 예약 테이블에 데이터 존재하는지 검사 2. 예약 테이블 데이터 삭제 3. 책 상태 변경 4. 대여테이블 데이터 삽입
	// 대여가능 - 1. 책 상태 변경 2. 대여 테이블 데이터 삽입
	public ModelAndView bookRental(HttpServletRequest request,
			HttpServletResponse response) throws SQLException {
		String bookNo = request.getParameter("bookNo");
		String memberId = request.getParameter("memberId");
		String bookState = request.getParameter("bookState");
		System.out.println("bookState !!! " +bookState );									// Test
		boolean flag=false;	// default 값
		if(bookState.equals("예약중")){
			flag= service.isReserveData(bookNo,memberId);				// 둘다 스트링으로 받았는데 가능하는지 궁금
			if(flag)// 존재할때
				service.bookRental(bookNo, memberId, true);
		}else{
			service.bookRental(bookNo, memberId, false);
			flag=true;
		}
		return new ModelAndView("JsonView","isReserve",flag);		// 여기 flag 값은 대여성공 여부 false = 아이디 값을 잘못 넣음
	}

	// 관리자 도서관리 에서 반납 할 경우 진행될 소스	Return
	// 반납 - 1. 도서 상태 변경 2. 대여테이블 데이터 returnDate 추가
	public ModelAndView bookRentalCancel(HttpServletRequest request,
			HttpServletResponse response) throws SQLException {
		String bookNo = request.getParameter("bookNo");
		service.bookRentalCancel(bookNo);
		return new ModelAndView("JsonView","isReserve",true);
	}
	//admin 도서분류, 출판사 코드 삭제 부분
		public ModelAndView getPublisher(HttpServletRequest request, HttpServletResponse response){
			String publisher = request.getParameter("publisher");
			ArrayList<PublisherVO> list = null;
			try {
				list = service.getPublisher(publisher);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			System.out.println(list.toString());
			return new ModelAndView("JsonView", "list", list);

		}
		public ModelAndView deletePublisher(HttpServletRequest request, HttpServletResponse response){
			int publisherNo = Integer.parseInt(request.getParameter("publisherNo"));
			try {
				service.deletePublisher(publisherNo);
				return new ModelAndView("JsonView","result","삭제 성공");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return new ModelAndView("JsonView","result","삭제 실패");
			}
		}
		public ModelAndView getSubjectAdmin(HttpServletRequest request, HttpServletResponse response){
			String subject = request.getParameter("subject");
			ArrayList<SubjectVO> list = null;
			try {
				list = service.getSubjectAdmin(subject);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			System.out.println(list.toString());
			return new ModelAndView("JsonView", "list", list);

		}
		public ModelAndView deleteSubjectAdmin(HttpServletRequest request, HttpServletResponse response){
			int subjectNo = Integer.parseInt(request.getParameter("subjectNo"));
			try {
				service.deleteSubject(subjectNo);
				return new ModelAndView("JsonView","result","삭제 성공");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return new ModelAndView("JsonView","result","삭제 실패");
			}
		}
		//도서 검색 모듈
		public ModelAndView findBook(HttpServletRequest request, HttpServletResponse response) {
			String find = request.getParameter("serach");
			HashMap value = new HashMap();
			value.put("value", request.getParameter("searchValue").toString());
			
			ArrayList<HashMap> listVO = null;
			ListVO list = null;
			int count=0;
			int page = 0;
			if(request.getParameter("page")!=null)
				page = Integer.parseInt(request.getParameter("page"));
			if(page==0)
				page=1;
			value.put("page", page);
			System.out.println(value.toString());
			System.out.println(find);
			try{
			switch(find){
			case "subject":
				listVO = service.getBookListBySubject(value);
				count = service.getBookListBySubjectCount(value.get("value").toString());
				break;
			case "publisher":
				listVO = service.getBookListByPublisher(value);
				count = service.getBookListByPublisherCount(value.get("value").toString());
				break;
			case "title":
				listVO = service.getBookListByTitle(value);
				count = service.getBookListByTitleCount(value.get("value").toString());
				break;
			case "writer":
				listVO = service.getBookListByWriter(value);
				count = service.getBookListByWriterCount(value.get("value").toString());
				break;
			}
			}catch(SQLException e){
				System.out.println(e.getMessage());
			}
			list = new ListVO(listVO, new PagingBean(page, count, 5, 5));
			System.out.println("ListVO : "+list.getList().toString());
			System.out.println("Count : "+count);
			request.setAttribute("flag", true);
			request.setAttribute("serachValue", value.get("value").toString());
			request.setAttribute("serach", find);
			return new ModelAndView("list.book","list",list);
		}
		public ModelAndView newBook(HttpServletRequest request,
				HttpServletResponse response){
		System.out.println("new Book Controller입성완료");
		String pageNo=request.getParameter("pageNo");
		ListVO lvo=new ListVO();
		try {
			lvo=service.getNewBook(pageNo);
			System.out.println("newBookList"+lvo);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return new ModelAndView("newbook.book", "lvo", lvo);
			
		}
}
