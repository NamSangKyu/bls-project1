package control;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.MemberService;
import model.vo.ListVO;
import model.vo.MemberVO;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

public class MemberController extends MultiActionController {
	private MemberService memberService;
	private String memberPath;
	private String memberWorkPath;
	public MemberController(MemberService memberService){
		System.out.println("[Check] : controller 생성자 호출");
		this.memberService = memberService;
	}
	public void setMemberPath(String memberPath){
		this.memberPath = memberPath;
	}
	public void setMemberWorkPath(String memberWorkPath) {
		this.memberWorkPath = memberWorkPath;
	}

	/*
	 * 			가입 전 ID 체크
	 */
	public ModelAndView checkIdForInsert(HttpServletRequest request, HttpServletResponse response){
		boolean  flag = true;
		try {
			flag = memberService.checkIdForInsert(request.getParameter("memberId"));
			System.out.println("[MemberController] : "+flag);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return new ModelAndView("JsonView","flag",flag);
	}

	/*
	 * 			로그아웃
	 */
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response,HttpSession session, MemberVO membervo){
		if(session !=null || session.getAttribute("membervo") != null){
			session.invalidate();
		}
		return new ModelAndView("index");
	}

	/*
	 * 			탈퇴 전 화면
	 */
	public ModelAndView viewDrop(HttpServletRequest request,HttpServletResponse response){
		return new ModelAndView("member/drop");
	}

	/*
	 * 			탈퇴
	 */
	public ModelAndView checkMemberForDrop(HttpServletRequest request,HttpServletResponse response,HttpSession session){
		System.out.println("checkMemberForDrop");
		HashMap map = new HashMap();
		map.put("memberId",((MemberVO)session.getAttribute("membervo")).getMemberId());
		map.put("password", request.getParameter("password"));
		String state="";
		try {
			state = memberService.dropMember(map);
			System.out.println(state);
			if(state.equals("탈퇴"))
				session.invalidate();						// 로그아웃
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return new ModelAndView("JsonView","state",state);
	}

	/*
	 * 			로그인 전 체크 (AJAX)
	 */
	public ModelAndView checkLogin(HttpServletRequest request, HttpServletResponse response, MemberVO membervo){
		System.out.println("[MemberController]checkLogin :"+membervo);
		boolean flag=false;
		try {
			flag = memberService.checkLogin(membervo);
			System.out.println(flag);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return new ModelAndView("JsonView","flag",flag);
	}

	/*
	 * 			로그인
	 */
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response, MemberVO membervo){
		MemberVO mvo=null;
		String path="main.book";					// 기본 회원 로그인시
		HashMap map=null;

		try {
			mvo = memberService.login(membervo);
			System.out.println("[MemberController]login: "+mvo);
			mvo.setMemberId(membervo.getMemberId());
			mvo.setPass(membervo.getPass());
			// mvo 완성 후 session 에 저장
			HttpSession session = request.getSession();
			session.setAttribute("membervo", mvo);
			map=memberService.recommand(mvo);
			System.out.println("map="+map.toString());
			if(mvo.getMemberId().equals("java"))			// 이름이 같을시에 관리자 로그인
				path= "list.admin";
				ListVO listvo = memberService.list(null);
				request.setAttribute("listvo", listvo);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return new ModelAndView(path,"subject",map);
	}

	/*
	 *			회원 사진 삭제 (AJAX)
	 */
	public ModelAndView deleteFile(HttpServletRequest request, HttpServletResponse response, MemberVO membervo){
		String fileName = membervo.getmImg();
		if(fileName !=null ){
			//	memberService.deleteFile(membervo.getNewfilename());
			File file = new File(memberPath+fileName);
			//File file1 = new Fiile(workPath+newfilename);
			System.out.println(file.delete() + " delete status" + fileName + file.isFile());
		}
		return new ModelAndView("JsonView");
	}

	/*
	 * 			회원수정 페이지 보기
	 */
	public ModelAndView updateView(HttpServletRequest request, HttpServletResponse response,MemberVO membervo){
		MemberVO updateInfo=null;
		HashMap map = new HashMap();
		List list =null;
		try {
			updateInfo = memberService.info(membervo.getMemberId());
			list = memberService.getBookSbjList();
			map.put("membervo",updateInfo);
			map.put("sbjList", list);
			System.out.println(list);
			System.out.println(updateInfo);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return new ModelAndView("update.member","map",map);
	}

	/*
	 * 			회원 정보
	 */
	public ModelAndView info(HttpServletRequest request, HttpServletResponse response){
		return new ModelAndView("info.member");
	}

	/*
	 * 			 한명 회원정보
	 */
	public ModelAndView memberInfo(HttpServletRequest request, HttpServletResponse response,MemberVO membervo){
		System.out.println("[CheckController] : info 호출");
		MemberVO infoOfMembervo=null;
		System.out.println(request.getParameter("isSearch") + "is");
		try {
			infoOfMembervo = memberService.info(membervo.getMemberId());
			System.out.println(infoOfMembervo);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return new ModelAndView("memberInfo.admin","membervo",infoOfMembervo);
	}

	/*
	 *  			회원가입 전 가입 page 호출
	 */
	public ModelAndView insertView(HttpServletRequest request, HttpServletResponse response){
		System.out.println("[CheckController] : insertView 호출");
		List list = null;
		try {
			list = memberService.getBookSbjList();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return new ModelAndView("insert.member","sbjList",list);
	}

	/*
	 * 				회원 가입
	 */
	public ModelAndView insert(HttpServletRequest request, HttpServletResponse response, MemberVO membervo){
		System.out.println("[CheckController] : insert 메서드 호출");
		subject(request, membervo);				// 관심사항 다 넣음
		try {
			if(memberService.info(membervo.getMemberId()) !=null)
				return new ModelAndView("info.member");
			System.out.println(memberPath);
			MultipartFile mfile=membervo.getUploadFile();
			System.out.println("getOriginalFilename() :"+mfile.getOriginalFilename());
			if(mfile.isEmpty() == false){
				String fileName = System.currentTimeMillis()+"_"+mfile.getOriginalFilename();
				membervo.setmImg(fileName);
				File copyFile = new File(memberWorkPath+fileName);						// server
				//File copyFile2 = new File(workPath+newfilename);			// workspace
				mfile.transferTo(copyFile);
				//mfile.transferTo(copyFile2);
			}
			System.out.println("membervo" + membervo);
			memberService.insert(membervo);
			HttpSession session = request.getSession();			// session
			session.setAttribute("membervo", membervo);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return new ModelAndView("info.member");
	}

	/*
	 * 			 회원수정
	 */
	public ModelAndView update(HttpServletRequest request,HttpServletResponse response,HttpSession session,MemberVO membervo){
		System.out.println("[CheckController] : update 호출");
		MultipartFile mfile = membervo.getUploadFile();
		String path="memberInfo.admin";
		try {
			if(mfile!=null){
				if(mfile.isEmpty() ==false){
					String fileName = System.currentTimeMillis()+"_"+mfile.getOriginalFilename();
					File copyFile = new File(memberWorkPath+fileName);
					membervo.setmImg(fileName);
					System.out.println(membervo + " " + fileName );
					mfile.transferTo(copyFile);
				}else{
					membervo.setmImg(null);
				}
			}
			if(!membervo.getMemberId().equals("java")){				// 관리자가 아닐때 정보 수정
				session.setAttribute("membervo", membervo);			// 정보수정시 새롭게 적용
				path="info.member";
			}
			subject(request, membervo);
			System.out.println(membervo+" test vo");
			memberService.update(membervo);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		System.out.println("CheckControlel : "+membervo);
		return new ModelAndView(path,"membervo",membervo);
	}

	/*
	 * 				회원 삭제
	 */
	public ModelAndView delete(HttpServletRequest request, HttpServletResponse response,MemberVO membervo){
		System.out.println("[MemberController] : delete 호출 ");
		ListVO listvo=null;
		try {
			memberService.delete(membervo.getMemberId());
			System.out.println(" nowPage : " +request.getParameter("nowPage"));
			listvo = memberService.list(request.getParameter("nowPage"));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return new ModelAndView("list.member","listvo",listvo);
	}

	/*
	 * 				전체회원보기 (관리자)
	 */
	public ModelAndView list(HttpServletRequest request, HttpServletResponse response){
		System.out.println("[CheckController] : list 호출");
		String nowPage = request.getParameter("nowPage");
		ListVO listvo = null;
		try {
			listvo  = memberService.list(nowPage);
			System.out.println(listvo);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return new ModelAndView("list.admin","listvo",listvo);
	}

	public void subject(HttpServletRequest request,MemberVO membervo){
		String subject[] = request.getParameterValues("sbj");
		membervo.setSubject1(subject[0]);
		membervo.setSubject2(subject[1]);
		membervo.setSubject3(subject[2]);
	}
}



















