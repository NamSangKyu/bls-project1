package model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import model.vo.MemberVO;

import com.ibatis.sqlmap.client.SqlMapClient;

public class MemberDao {
	private SqlMapClient sqlMapClient;
	public MemberDao(SqlMapClient sqlMapClient){
		this.sqlMapClient = sqlMapClient;
	}

	// 	회원가입
	public void insert(MemberVO membervo) throws SQLException{
		sqlMapClient.insert("member.insertMember",membervo);
	}

	//		회원자수
	public List list(HashMap  map) throws SQLException{
		return sqlMapClient.queryForList("member.selectMemberList",map);
	}

	//		allContent   페이징 처리를 위해
	public int allContent() throws SQLException{
		return (Integer)sqlMapClient.queryForObject("member.selectNumContent");
	}

	//		정보
	public MemberVO info(String memberId) throws SQLException{
		return  (MemberVO)sqlMapClient.queryForObject("member.selectMemberByMemberId",memberId);
	}

	// 	전체 관심 리스트
	public List getBookSbjList() throws SQLException{
		return sqlMapClient.queryForList("member.getBookSbjList");
	}

	//		수정
	public void updateMemberById(MemberVO membervo) throws SQLException{
		sqlMapClient.update("member.updateMemberById",membervo);
	}

	// 	 삭제
	public void deleteMemberById(String memberId) throws SQLException{
		sqlMapClient.delete("member.deleteMemberById",memberId);
	}
}














