package model;

import java.io.File;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import model.vo.ListVO;
import model.vo.MemberVO;
import model.vo.PagingBean;

import org.springframework.web.multipart.MultipartFile;

import config.CommonConstants;

public class MemberService {
	private MemberDao memberDao;
	public MemberService(MemberDao memberDao){
		this.memberDao = memberDao;
	}

	// 	로그인 전 체크
	public boolean checkLogin(MemberVO membervo) throws SQLException{
		String id = memberDao.selectIdForCheck(membervo);
		boolean flag = false;
		if(id !=null)
			flag=true;
		System.out.println("cheking " +flag);
		return flag;
	}

	//		로그인
	public MemberVO login(MemberVO membervo) throws SQLException{
		System.out.println(membervo);
		MemberVO mvo =  memberDao.selectMemberForLogin(membervo);
		return mvo;
	}
	//로그인 사용자에 따른 채추천 메소드
	public HashMap recommand(MemberVO memberVO) throws SQLException{
	String subject1=memberVO.getSubject1();
	String subject2=memberVO.getSubject2();
	String subject3=memberVO.getSubject3();
	System.out.println(subject1+" "+subject2+" "+subject3);
	HashMap map=new HashMap();
	ArrayList list=new ArrayList();

	list=memberDao.recommand(subject1);
	map.put("subject1", list);
	System.out.println("list="+list);
	list=memberDao.recommand(subject2);
	map.put("subject2", list);
	System.out.println("list="+list);
	list=memberDao.recommand(subject3);
	map.put("subject3",list);
	System.out.println("list="+list);
	return map;
		
	}

	// 	회원가입
	public void insert(MemberVO membervo) throws SQLException{
		memberDao.insert(membervo);
	}

	//		list
	public ListVO list(String strNowPage) throws SQLException{
		int nowPage=1;
		if(strNowPage != null)
			nowPage = Integer.parseInt(strNowPage);
		int content = memberDao.allContent();
		HashMap map = new HashMap();
		map.put("nowPage", nowPage);
		map.put("numOfContent", CommonConstants.MEMBER_CONTENT_NUMBER_PER_PAGE);
		ArrayList contents =(ArrayList) memberDao.list(map);
		PagingBean pb = new PagingBean(nowPage, content,CommonConstants.MEMBER_CONTENT_NUMBER_PER_PAGE,CommonConstants.MEMBER_PAGEGROUP_NUMBER_PER_PAGE);
		return new ListVO(contents,pb);
	}

	//			회원정보-request
	public MemberVO info(String memberId) throws SQLException{
		return memberDao.info(memberId);
	}

	//			관심사항 리스트
	public List getBookSbjList() throws SQLException{
		return memberDao.getBookSbjList();
	}

	//			수정
	public void update(MemberVO membervo) throws SQLException{
		memberDao.updateMemberById(membervo);
	}

	//			삭제
	public void delete(String memberId) throws SQLException{
		memberDao.deleteMemberById(memberId);
	}
}
















