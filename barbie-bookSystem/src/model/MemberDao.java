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
	public void insert(MemberVO membervo) throws SQLException{
		sqlMapClient.insert("member.insertMember",membervo);
	}
	public List list(HashMap  map) throws SQLException{
		return sqlMapClient.queryForList("member.selectMemberList",map);
	}
	public int allContent() throws SQLException{
		return (Integer)sqlMapClient.queryForObject("member.selectNumContent");
	}
}
