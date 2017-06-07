package com.kdn.controller;

import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kdn.model.biz.BoardService;
import com.kdn.model.domain.Board;
import com.kdn.model.domain.PageBean;
import com.kdn.util.LoginCheck;

@Controller
public class BoardController {
	
	/**
	 * Error 처리 
	 * @ExceptionHandler  Controller에서 오류가 발생하면 처리하는 기능 
	 */
	@ExceptionHandler
	public ModelAndView handler(Exception e){
		ModelAndView  model = new ModelAndView("index");
		model.addObject("msg", e.getMessage());  //request에 저장
		model.addObject("content", "ErrorHandler.jsp");  //request에 저장
		return model;
	}
	
	@Autowired
	private BoardService  boardService;
	@RequestMapping(value="listBoard.do", method=RequestMethod.GET)
	public String listBoard(PageBean bean, Model model ){
		List<Board> list = boardService.searchAll(bean);
		model.addAttribute("list", list);
		model.addAttribute("content", "board/listBoard.jsp");
		return "index";
	}
	@RequestMapping(value="searchBoard.do", method=RequestMethod.GET)
	public String searchBoard(int no, Model model ){
		model.addAttribute("board", boardService.search(no));
		model.addAttribute("content", "board/searchBoard.jsp");
		return "index";
	}
	@RequestMapping(value="insertBoardForm.do", method=RequestMethod.GET)
	public String insertBoardForm(Model model, HttpSession session){
		if(LoginCheck.check(model, session, "insertBoardForm.do")){
			model.addAttribute("content", "board/insertBoard.jsp");
		}
		return "index";
	}
	@RequestMapping(value="insertBoard.do", method=RequestMethod.POST)
	public String insertBoard(Board board, HttpServletRequest request){
		String dir = request.getRealPath("upload/");
		boardService.add(board, dir);
		return "redirect:listBoard.do";
	}
	
	@RequestMapping(value="filedown.do")
	public void fileDown( HttpServletRequest req, HttpServletResponse res , @RequestParam String rfilename
			, @RequestParam String sfilename ){
		res.reset();
	        int len = 0;
	        byte[] buf = new byte[1024];
	        BufferedOutputStream out = null;
	        FileInputStream fis = null;
	        StringBuffer sb = new StringBuffer();
	        try{
	        	System.out.println("=================================");
	        	System.out.println("realFilename:"+sfilename);
	        	System.out.println("File Name = " +rfilename);
	        	System.out.println("=================================");	        	
	        	
	        	String dir = req.getRealPath("/upload/");
	        	System.out.println("dir :"+dir);
	        	//다운 시켜줄 파일에 대한 경로를 지정한 파일 읽어줄 객체를 생성 
	        	fis = new FileInputStream(dir+"/"+sfilename);
	        	String agent = req.getHeader("User-Agent");
                if(agent !=null&& agent.indexOf("MSIE 5.5") != -1 ) {
                	res.setContentType("doesn/matter");
                	res.setHeader("Content-Disposition", "filename=" + rfilename+ ";");
                } else {
                    res.setContentType("application/octet-stream");
                    res.setHeader("Content-Disposition", "attachment;filename="+rfilename+ ";");
                };
                res.setHeader("Content-Transfer-Encoding", "binary;");
                res.setHeader("Content-Length", "" + fis.available());
                res.setHeader("Pragma", "no-cache;");
                res.setHeader("Expires", "-1;");

                out = new BufferedOutputStream(res.getOutputStream());

                System.out.println("OutputStream 생성");
                //파일의 끝이 아닐때까지 파일 정보를 읽는다. 
                while ((len = fis.read(buf)) > 0) {
                    out.write(buf, 0, len); //읽은 데이타를 출력 
                }
                System.out.println("OutputStream 완료");
                out.flush(); //버퍼에 출력된 데이타를 강제로 출력 
                System.out.println("OutputStream flush()");
	        }
	        catch (Exception e) {
	            e.printStackTrace();
	        }
	        finally {
                if (out != null)try{   out.close();}catch(Exception e){}
                if (fis != null)try{   fis.close();}catch(Exception e){}
	        }
	        
	}
}




