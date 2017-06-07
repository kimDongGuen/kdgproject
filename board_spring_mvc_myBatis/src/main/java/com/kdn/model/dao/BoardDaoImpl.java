package com.kdn.model.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kdn.model.biz.BoardDao;
import com.kdn.model.domain.Board;
import com.kdn.model.domain.BoardFile;
import com.kdn.model.domain.PageBean;

@Repository("boardDao")
public class BoardDaoImpl implements BoardDao {
	
	@Autowired
	private SqlSessionTemplate  session; 
	public void add(Board board) {
		session.insert("board.insert", board);
	}
	public void update(Board board) {
		session.update("board.update", board);
	}
	public void remove(int no) {
		session.delete("board.delete", no);
	}
	public Board search(int no) {
		return session.selectOne("board.search", no);
	}
	public List<Board> searchAll(PageBean bean) {
		/*
		 * RowBounds(offset, limit) 
		 * offset 추출할 row의 시작 위치 (0부터 시작)
		 * limit  추출할 개수 
		 */
		RowBounds  rows = new RowBounds(bean.getStart()-1, bean.getInterval());
		return session.selectList("board.searchAll", bean, rows);
	}
	public int getCount(PageBean bean) {
		return session.selectOne("board.getCount", bean);
	}
	public int getBoardNo() {
		return session.selectOne("board.getBoardNo");
	}
	public void addFiles(List<BoardFile> files, int bno) {
		for (BoardFile fileBean : files) {
			fileBean.setBno(bno);
			session.insert("board.insertFile", fileBean);
		}
	}
	public void removeFiles(int bno) {
		session.delete("board.delete", bno);
	}
}





