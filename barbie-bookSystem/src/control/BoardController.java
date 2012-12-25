package control;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.BoardService;
import model.vo.BoardCommentVO;
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

	// 게시물 쓰기 화면 (Tiles 적용을 위한)
	public ModelAndView insertView(HttpServletRequest request,HttpServletResponse response) throws SQLException {
		return new ModelAndView("insert.board");
	}
	
	// 게시물 글쓰기 과정(파일업로드 추가 -> 업로드시 중복된 파일명 구분을 위해 현재시간 추가. db 에는 원본/사본 파일명 따로 저장)
	public ModelAndView insert(HttpServletRequest request, HttpServletResponse response, HttpSession session, BoardVO bvo) throws SQLException, IllegalStateException, IOException {
		// 업로드 파일로 만드는 과정
		MultipartFile mfile = bvo.getUploadFile();
		// 업로드 파일의 상태가 false 인 경우는 존재한다는 의미
		if(mfile.isEmpty() == false){
			// 원본파일명을 db 에 저장하기 위한 과정
			String fileName = mfile.getOriginalFilename();				
			bvo.setOrgFileName(fileName);
			// 사본파일명을 시간_파일명으로 저장
			String newfilename = System.currentTimeMillis()+"_"+fileName;
			bvo.setNewFileName(newfilename);
			// 업로드 파일 경로 설정
			File copyFile = new File(path+newfilename);
			// 업로드
			mfile.transferTo(copyFile);
		}		
		// DB 에 게시물 Insert
		boardService.insert(bvo);
		// 글쓰기를 하고 나서 목록 page 이동을 위한 default 값 설정
		request.setAttribute("page", 1);
		// 현재 게시물의 이전, 다음 게시물 현황(최초 게시물이므로 이전 게시물은 없지만 다음 게시물은 존재 가능)
		HashMap map = boardService.NextAndPreContent(Integer.toString(bvo.getBoardNo()));
		request.setAttribute("nextpre", map);
		// 글쓰기가 완료된 게시물을 보여준다
		return new ModelAndView("show_content.board", "bvo", bvo);
	}
	
	// 게시물 보여줄 경우 count 증가 후 showContent
	public ModelAndView showContent(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		String boardNo = request.getParameter("boardNo");
		String page = request.getParameter("page");
		// 목록 page 유지 위한 설정
		request.setAttribute("page", page);
		// 현재 게시물의 이전, 다음 게시물 현황
		HashMap map = boardService.NextAndPreContent(boardNo);
		request.setAttribute("nextpre", map);
		// 현재 게시물의 댓글 현황
		ArrayList<BoardCommentVO> cList = boardService.commentList(boardNo);
		request.setAttribute("cList", cList);
		// boardNo 에 해당하는 게시물을 보여준다
		return new ModelAndView("show_content.board", "bvo", boardService.showContent(boardNo));
	}
	
	// 게시물 수정화면을 보여줄 경우 count 증가 없이 showContent
	public ModelAndView updateView(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		String boardNo = request.getParameter("boardNo");
		String page = request.getParameter("page");
		// 수정 이후에도 page 상태 유지
		request.setAttribute("page", page);
		// boardNo 에 해당하는 게시물을 보여준다
		return new ModelAndView("update.board", "bvo", boardService.showContentNoCount(boardNo));
	}
	
	// 게시물 수정(이후 해당 게시물 보여주기)
	public ModelAndView updateContent(HttpServletRequest request, HttpServletResponse response, BoardVO bvo) throws SQLException, IllegalStateException, IOException {
		// 업로드 파일로 만드는 과정
		MultipartFile mfile=bvo.getUploadFile();
		// uploadFile 의 존재유무 확인(null 인 경우는 해당 게시물에 파일이 등록되어 있고, 파일수정이 이루어지지 않을 때)
		if (bvo.getUploadFile() != null) {
			// 수정한 게시물의 업로드 파일의 상태가 false 인 경우는 존재한다는 의미
			if(mfile.isEmpty()==false){
				// 원본파일명을 db 에 저장하기 위한 과정
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
		// null 인 경우 게시물 수정시 원본/사본 파일명을 유지시키기 위해 default 값으로 setting
		} else {
			bvo.setOrgFileName(request.getParameter("default1"));
			bvo.setNewFileName(request.getParameter("default2"));
		}
		String boardNo = request.getParameter("boardNo");
		String page = request.getParameter("page");
		// 게시물 수정
		boardService.updateContent(bvo);
		// 수정 이후에도 page 상태 유지
		request.setAttribute("page", page);
		// 현재 게시물의 이전, 다음 게시물 현황
		HashMap map = boardService.NextAndPreContent(boardNo);
		request.setAttribute("nextpre", map);
		// 현재 게시물의 댓글 현황
		ArrayList<BoardCommentVO> cList = boardService.commentList(boardNo);
		request.setAttribute("cList", cList);
		// boardNo 에 해당하는 게시물을 보여준다
		return new ModelAndView("show_content.board", "bvo", boardService.showContentNoCount(boardNo));
	}
	
	// 게시물 삭제(이후 목록 page 이동)
	public ModelAndView delete(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		String boardNo = request.getParameter("boardNo");
		String newFileName = request.getParameter("newFileName");
		String page = request.getParameter("page");
		// 게시물 삭제시 해당 게시물에 파일이 존재 한다면 파일까지 삭제
		if(!newFileName.equals("")){
			boardService.deleteFile(path+newFileName);
		}
		// boardNo 에 해당하는 게시물을 삭제한다
		boardService.delete(boardNo);
		// 삭제한 게시물의 현 page 상태를 유지(관리자모드의 경우 게시물 list 에서 삭제가 가능하기 때문에)
		request.setAttribute("page", page);
		// 목록 page 이동(page 유지)
		return new ModelAndView("list.board", "lvo", boardService.list(page));
	}
	
	// 파일삭제
	public ModelAndView deleteFile(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String newFileName=request.getParameter("newFileName");
		boardService.deleteFile(path+newFileName);
		return new ModelAndView("JsonView");
	}
	
	// 게시물 리스트 보기
	public ModelAndView list(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		String page = request.getParameter("page");
		// 현 page 상태를 유지
		request.setAttribute("page", page);
		// 목록 page 이동(page 유지)
		return new ModelAndView("list.board", "lvo", boardService.list(page));
	}
	
	// 파일 다운로드
	public ModelAndView fileDownload(HttpServletRequest request, HttpServletResponse response) throws Exception{		
		// util.DownloadView class 에서 필요로 하는 path 정보 Map 에 담아 전달
		HashMap map=new HashMap();
		map.put("path", path);
		return new ModelAndView("downloadView",map);
	}
	
	// 게시물 답글화면을 보여줄 경우 count 증가 없이 showContent
	public ModelAndView replyView(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		String boardNo = request.getParameter("boardNo");
		String page = request.getParameter("page");
		// 답글 등록 이후에도 page 상태 유지
		request.setAttribute("page", page);
		return new ModelAndView("reply_insert.board", "bvo", boardService.showContentNoCount(boardNo));
	}
	
	// 게시물 답글 과정(파일업로드 추가 -> 업로드시 중복된 파일명 구분을 위해 현재시간 추가. db 에는 원본/사본 파일명 따로 저장)
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
		String page = request.getParameter("page");
		// DB 에 게시물 답글 Insert
		boardService.replyContent(bvo);
		// 답글 등록 이후에도 page 상태 유지
		request.setAttribute("page", page);
		// 현재 게시물의 이전, 다음 게시물 현황
		HashMap map = boardService.NextAndPreContent(Integer.toString(bvo.getBoardNo()));
		request.setAttribute("nextpre", map);
		// 현재 게시물의 댓글 현황
		ArrayList<BoardCommentVO> cList = boardService.commentList(Integer.toString(bvo.getBoardNo()));
		request.setAttribute("cList", cList);
		// 게시물 답글이 완료된 게시물을 보여준다
		return new ModelAndView("show_content.board", "bvo", bvo);
	}
	
	// 게시물 댓글 쓰기 과정(입력시 마다 전체 리스트 비동기 통신)
	public ModelAndView commentContent(HttpServletRequest request, HttpServletResponse response, BoardCommentVO bcvo) throws IllegalStateException, IOException, SQLException {
		String boardNo = request.getParameter("boardNo");
		String page = request.getParameter("page");
		// DB 에 게시물 댓글 Insert
		boardService.commentContent(bcvo);
		// 목록 page 유지 위한 설정
		request.setAttribute("page", page);
		// 현재 게시물의 이전, 다음 게시물 현황
		HashMap map = boardService.NextAndPreContent(boardNo);
		request.setAttribute("nextpre", map);
		// 현재 게시물의 댓글 현황
		ArrayList<BoardCommentVO> cList = boardService.commentList(boardNo);
		request.setAttribute("cList", cList);
		// boardNo 에 해당하는 게시물을 보여준다
		return new ModelAndView("show_content.board", "bvo", boardService.showContent(Integer.toString(bcvo.getBoardNo())));
	}
	
	// 관리자 게시물 checked 삭제 과정
	public ModelAndView adminDelete(HttpServletRequest request, HttpServletResponse response, BoardCommentVO bcvo) throws IllegalStateException, IOException, SQLException {
		// 관리자가 checked 한 게시물 boardNo 를 배열로 받아온다
		String checked[] = request.getParameterValues("boardList");
		String page = request.getParameter("page");

		for(int i = 0; checked.length > i; i++) {
			String boardNo = checked[i];
			// checked 한 게시물의 boardNo 를 name 으로 갖고 있는 hidden 값 가져와서 파일 삭제
			String newFileName = request.getParameter(boardNo);
			if(!newFileName.equals("")){
				boardService.deleteFile(path+newFileName);
			}
			// boardNo 에 해당하는 게시물을 삭제한다
			boardService.delete(boardNo);
		}
		// 현 page 상태를 유지
		request.setAttribute("page", page);
		// 목록 page 이동(page 유지)
		return new ModelAndView("list.board", "lvo", boardService.list(page));
	}
}