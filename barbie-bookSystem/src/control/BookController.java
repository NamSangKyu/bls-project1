package control;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

public class BookController extends MultiActionController{

	public ModelAndView home(HttpServletRequest request, HttpServletResponse response){
		System.out.println("home");
		return new ModelAndView("home","test","홈화면 타일즈 테스트");
	}
	public ModelAndView bookinfo(HttpServletRequest request, HttpServletResponse response){
		System.out.println("bookinfo");
		return new ModelAndView("info.book","test","bookinfo타일즈 테스트");
	}
}
