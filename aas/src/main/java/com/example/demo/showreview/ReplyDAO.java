package com.example.demo.showreview;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ReplyDAO {

	public ReplyDAO() {
		System.out.println("-----ReplyDAO 객체 생성");
	}
	
	@Autowired
	private SqlSession sqlSession;
	
	 public void insert(ReplyDTO replyDto) {
	        sqlSession.insert("reply.insert", replyDto);
	    }

	 public List<ReplyDTO> getRepliesByReviewId(int rev_Id) {
	        return sqlSession.selectList("reply.getRepliesByReviewId", rev_Id);
	    }
	
	 public void update (ReplyDTO replyDto) {
		 sqlSession.update("reply.update", replyDto);
	 }
	 
	 public void delete (int replyDto) {
		 sqlSession.delete("reply.delete", replyDto);
	 }
	 
}//class end
