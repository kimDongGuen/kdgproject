package com.kdn.model.biz;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kdn.model.domain.Board;
import com.kdn.model.domain.BoardFile;
import com.kdn.model.domain.PageBean;
import com.kdn.model.domain.UpdateException;
import com.kdn.util.PageUtility;

@Service("boardService")
public class BoardServiceImpl implements BoardService {
	@Autowired
	@Qualifier("boardDao")
	private BoardDao dao;
	@Override
	public void add(Board board, String dir) {
		File[ ] files = null;
		int size = 0;
		try {
			
			int bno = dao.getBoardNo();
			board.setNo(bno);
			dao.add( board);
			
			MultipartFile[] fileup = board.getFileup();
			if(fileup!=null){
				size = fileup.length;
				files = new File[size];     
				ArrayList<BoardFile> fileInfos = new ArrayList<BoardFile>(size);
				String rfilename = null;
				String sfilename = null;
				int index =0;  
				for (MultipartFile file : fileup) {
					rfilename = file.getOriginalFilename();
					sfilename = String.format("%d%s"
											, System.currentTimeMillis()
											, rfilename);
					fileInfos.add(new BoardFile(rfilename, sfilename));
					String fileName = String.format("%s/%s", dir, sfilename);
					files[index] = new File(fileName);
					file.transferTo(files[index++]);
				}
				dao.addFiles( fileInfos, bno);
			}
		} catch (Exception e) {
			e.printStackTrace();
			if(files!=null){  
				//오류가 발생해서 롤백하기 때문에 저장한 파일이 있다면 삭제
				for (File file : files) {
					//해당 파일이 지정한 경로에 존재하면 
					if(file!=null && file.exists()){
						file.delete();   //파일 삭제 
					}
				}
			}
			throw new UpdateException("게시글 작성 중 오류 발생");
		} 
	}
	public void update(Board board) {
		try {
			dao.update(board);
		} catch (Exception e) {
			e.printStackTrace();
			throw new UpdateException("게시글 수정 중 오류 발생");
		} 
	}
	public void remove(int no) {
		try {
			dao.removeFiles(no);
			dao.remove( no);
		} catch (Exception e) {
			e.printStackTrace();
			throw new UpdateException("게시글 삭제 중 오류 발생");
		}
	}
	public Board search(int no) {
		try {
			return dao.search( no);
		} catch (Exception e) {
			e.printStackTrace();
			throw new UpdateException("게시글 검색 중 오류 발생");
		} 
	}
	public List<Board> searchAll(PageBean bean) {
		try {
			int total = dao.getCount(bean);
			PageUtility bar = 
			  new PageUtility(bean.getInterval()
					  		, total
					  		, bean.getPageNo()
					  		, "images/");
			bean.setPagelink(bar.getPageBar());
			return dao.searchAll(bean);
		} catch (Exception e) {
			e.printStackTrace();
			throw new UpdateException("게시글 검색 중 오류 발생");
		} 
	}
}
