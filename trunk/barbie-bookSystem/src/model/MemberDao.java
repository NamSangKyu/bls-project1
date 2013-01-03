package model;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import model.vo.MemberVO;

import com.ibatis.sqlmap.client.SqlMapClient;

public class MemberDao {
	private SqlMapClient sqlMapClient;
	public MemberDao(SqlMapClient sqlMapClient){
		this.sqlMapClient = sqlMapClient;
	}

	// 	로그인 전 체크
	public String selectIdForCheck(MemberVO membervo) throws SQLException{
		return (String)sqlMapClient.queryForObject("member.selectIdForCheck",membervo);
	}

	//	탈퇴 전 아이디와 비밀번호 검사
	public Object selectMemberForDrop(HashMap map) throws SQLException {
		return sqlMapClient.queryForObject("member.selectMemberForDrop",map);
	}

	//		가입 전 아이디체크
	public Object selectMemberForInsert(String memberId) throws SQLException{
		return sqlMapClient.queryForObject("member.selectMemberForInsert",memberId);
	}

	// 	로그인
	public MemberVO selectMemberForLogin(MemberVO membervo) throws SQLException{
		return (MemberVO)sqlMapClient.queryForObject("member.selectMemberForLogin",membervo);
	}

	// 	회원가입
	public void insert(MemberVO membervo) throws SQLException{
		System.out.println("mem:" + membervo);
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

	//			추천
	public ArrayList<HashMap> recommand(String subject) throws SQLException {
		return (ArrayList<HashMap>) sqlMapClient.queryForList("book.recommandBookBySubject", subject);
	}

	//			탈퇴 전 예약 테이블 데이터 존제 여부
	public Object selectReserveByMemberId(String memberId) throws SQLException {
		return sqlMapClient.queryForObject("member.selectReserveByMemberId",memberId);
	}

	//			탈퇴 전 대여 테이블 데이터 존재 여부
	public Object selectRentalByMemberId(String memberId) throws SQLException{
		return sqlMapClient.queryForObject("member.selectRentalByMemberId",memberId);
	}
}














