package control;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.MemberService;
import model.vo.ListVO;
import model.vo.MemberVO;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

public class MemberController extends MultiActionController {
	private MemberService memberService;
	
	public MemberController(MemberService memberService){
		System.out.println(" controller 생성자 호출");
		this.memberService = memberService;
	}
	/*
	 *  가입하기 전 가입page 호출
	 */
	public ModelAndView insertView(HttpServletRequest request, HttpServletResponse response){
		return new ModelAndView("insert.member");
	}
	/*
	 * 	가입
	 */
	public ModelAndView insert(HttpServletRequest request, HttpServletResponse response, MemberVO membervo){		
		System.out.println("controller inser t 메서드 호출");
		String sub[] = request.getParameterValues("sub");
		membervo.setSubject1(sub[0]);
		membervo.setSubject2(sub[1]);
		membervo.setSubject3(sub[2]);
		try {
			System.out.println("membervo" + membervo);
			memberService.insert(membervo);
			
			HttpSession session = request.getSession();
			session.setAttribute("membervo", membervo);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return new ModelAndView("info.member");
	}
	/*
	 * 전체회원보기 (관리자)
	 */
	public ModelAndView list(HttpServletRequest request, HttpServletResponse response){
		String strPage = request.getParameter("nowPage");
		int nowPage=0;
		if(strPage == null)
			nowPage=1;
		else
			nowPage = Integer.parseInt(strPage);
		ListVO listvo = null;
		//try {
			//listvo  = memberService.list(nowPage);
			//System.out.println(listvo);
		/*} catch (SQLException e) {
			e.printStackTrace();
		}*/
		return new ModelAndView("list.member","listvo",listvo);
	}
}



















