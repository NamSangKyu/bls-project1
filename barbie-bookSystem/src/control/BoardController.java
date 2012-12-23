package control;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.BoardService;
import model.vo.BoardVO;
import model.vo.ListVO;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

public class BoardController extends MultiActionController {
	private BoardService boardService;
	private String path;

	public BoardController(BoardService boardService) {
		super();
		this.boardService = boardService;
	}
	
	public void setPath(String path) {
		this.path = path;
	}

	// 게시물 쓰기 화면
	public ModelAndView insertView(HttpServletRequest request,HttpServletResponse response) throws SQLException {
		return new ModelAndView("insert.board");
	}
	
	// 게시물 글쓰기 과정(파일업로드 추가 -> 업로드시 중복된 파일명 구분을 위해 현재시간 추가. db에는 원본/사본 파일명 따로 저장)
	public ModelAndView insert(HttpServletRequest request, HttpServletResponse response, HttpSession session, BoardVO bvo) throws SQLException, IllegalStateException, IOException {
		// 업로드 파일로 만드는 과정
		MultipartFile mfile=bvo.getUploadFile();
		// 업로드 파일의 상태가 false 인 경우는 존재한다는 의미
		if(mfile.isEmpty()==false){
			// 원본파일명을 db에 저장하기 위한 과정
			String fileName=mfile.getOriginalFilename();				
			bvo.setOrgFileName(fileName);
			// 사본파일명을 시간_파일명으로 저장
			String newfilename=System.currentTimeMillis()+"_"+fileName;
			bvo.setNewFileName(newfilename);
			// 업로드 파일 경로 설정
			File copyFile=new File(path+newfilename);
			// 업로드
			mfile.transferTo(copyFile);
		}		
		boardService.insert(bvo);
		// 글쓰기를 하는 경우는 page 값을 1 으로 지정
		request.setAttribute("page", 1);
		HashMap map = boardService.NextAndPreContent(Integer.toString(bvo.getBoardNo()));
		request.setAttribute("nextpre", map);
		return new ModelAndView("show_content.board", "bvo", bvo);
	}
	
	// 게시물 보여줄 경우 count 증가 후 showContent
	public ModelAndView showContent(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		String boardNo = request.getParameter("boardNo");
		String page = request.getParameter("page");
		request.setAttribute("page", page);
		BoardVO bvo = boardService.showContent(boardNo);
		HashMap map = boardService.NextAndPreContent(boardNo);
		request.setAttribute("nextpre", map);
		return new ModelAndView("show_content.board", "bvo", bvo);
	}
	
	// 게시물 삭제 이후 목록 페이지로 이동
	public ModelAndView delete(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		String boardNo = request.getParameter("boardNo");
		String newFileName = request.getParameter("newFileName");
		String page = request.getParameter("page");
		System.out.println(page);
		if(!newFileName.equals("")){
			boardService.deleteFile(path+newFileName);
		}
		
		boardService.delete(boardNo);
		ListVO lvo = boardService.list(page);
		return new ModelAndView("list.board", "lvo", lvo);
	}
	
	// 게시물 수정화면 보여주기 이런 경우는 count 증가 없이 showContent
	public ModelAndView updateView(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		String boardNo = request.getParameter("boardNo");
		String page = request.getParameter("page");
		BoardVO bvo = boardService.showContentNoCount(boardNo);
		request.setAttribute("page", page);
		return new ModelAndView("update.board", "bvo", bvo);
	}
	
	// 게시물 수정 작업을 끝내고 해당 게시물 보여주기
	public ModelAndView updateContent(HttpServletRequest request, HttpServletResponse response, BoardVO bvo) throws SQLException, IllegalStateException, IOException {
		// 업로드 파일로 만드는 과정
		MultipartFile mfile=bvo.getUploadFile();
		// 수정한 게시물의 업로드 파일의 상태가 false 인 경우는 존재한다는 의미
		if (bvo.getUploadFile() != null) {
			if(mfile.isEmpty()==false){
				// 원본파일명을 db에 저장하기 위한 과정
				String fileName=mfile.getOriginalFilename();				
				bvo.setOrgFileName(fileName);
				// 사본파일명을 시간_파일명으로 저장
				String newFileName=System.currentTimeMillis()+"_"+fileName;
				bvo.setNewFileName(newFileName);
				// 업로드 파일 경로 설정
				File copyFile=new File(path+newFileName);
				// 업로드
				mfile.transferTo(copyFile);
			}	
		} else {
			bvo.setOrgFileName(request.getParameter("default1"));
			bvo.setNewFileName(request.getParameter("default2"));
		}
		String boardNo = request.getParameter("boardNo");
		String page = request.getParameter("page");
		boardService.updateContent(bvo);
		System.out.println("업데이트 bvo 상태 : " + bvo);
		bvo = boardService.showContentNoCount(boardNo);
		request.setAttribute("page", page);
		HashMap map = boardService.NextAndPreContent(boardNo);
		request.setAttribute("nextpre", map);
		return new ModelAndView("show_content.board", "bvo", bvo);
	}
	
	// 게시물 리스트 보기
	public ModelAndView list(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		String page = request.getParameter("page");
		ListVO lvo = boardService.list(page);
		return new ModelAndView("list.board", "lvo", lvo);
	}
	
	// 게시물 내 파일 다운로드
	public ModelAndView fileDownload(HttpServletRequest request, HttpServletResponse response) throws Exception{		
		// util.DownloadView class 에서 필요로 하는 path 정보 Map 에 담아 전달
		HashMap map=new HashMap();
		map.put("path", path);
		return new ModelAndView("downloadView",map);
	}
	
	// 게시물 수정 및 삭제에서 파일삭제 부분
	public ModelAndView deleteFile(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String newFileName=request.getParameter("newFileName");
		System.out.println("deleteFile 입장 newFileName : " + newFileName);
		if(!newFileName.equals("")){
			boardService.deleteFile(path+newFileName);
		}		
		return new ModelAndView("JsonView");
	}
	
	// 게시물 답글 화면 보여주기 이런 경우는 count 증가 없이 showContent
	public ModelAndView replyView(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		String boardNo = request.getParameter("boardNo");
		String page = request.getParameter("page");
		BoardVO bvo = boardService.showContentNoCount(boardNo);
		request.setAttribute("page", page);
		System.out.println("나는 리플뷰의 bvo" + bvo);
		return new ModelAndView("reply_insert.board", "bvo", bvo);
	}
	
	public ModelAndView replyContent(HttpServletRequest request, HttpServletResponse response, BoardVO bvo) throws IllegalStateException, IOException, SQLException {
		// 업로드 파일로 만드는 과정
		MultipartFile mfile=bvo.getUploadFile();
		// 업로드 파일의 상태가 false 인 경우는 존재한다는 의미
		if(mfile.isEmpty()==false){
			// 원본파일명을 db에 저장하기 위한 과정
			String fileName=mfile.getOriginalFilename();				
			bvo.setOrgFileName(fileName);
			// 사본파일명을 시간_파일명으로 저장
			String newfilename=System.currentTimeMillis()+"_"+fileName;
			bvo.setNewFileName(newfilename);
			// 업로드 파일 경로 설정
			File copyFile=new File(path+newfilename);
			// 업로드
			mfile.transferTo(copyFile);
		}		
		boardService.replyContent(bvo);
		String page = request.getParameter("page");
		request.setAttribute("page", page);
		HashMap map = boardService.NextAndPreContent(Integer.toString(bvo.getBoardNo()));
		request.setAttribute("nextpre", map);
		return new ModelAndView("show_content.board", "bvo", bvo);
	}
}
