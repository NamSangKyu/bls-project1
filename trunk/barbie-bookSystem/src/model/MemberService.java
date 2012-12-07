package model;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import config.CommonConstants;

import model.vo.ListVO;
import model.vo.MemberVO;
import model.vo.PagingBean;

public class MemberService {
	private MemberDao memberDao;
	public MemberService(MemberDao memberDao){
		this.memberDao = memberDao;
	}
	public void insert(MemberVO membervo) throws SQLException{
		memberDao.insert(membervo);
	}
	/*public ListVO list(int nowPage) throws SQLException{
		int content = memberDao.allContent();
		HashMap map = new HashMap();
		map.put("nowPage", nowPage);
		map.put("numOfContent", CommonConstants.CONTENT_NUMBER_PER_PAGE);
		ArrayList contents =(ArrayList) memberDao.list(map);
		PagingBean pb = new PagingBean(nowPage, content);

		return new ListVO(pb,contents);
	}*/
}
