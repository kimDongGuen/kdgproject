package com.kdn.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.kdn.model.biz.MemberService;
import com.kdn.model.domain.Member;

@Controller
public class MemberController {
	@Autowired
	private MemberService  memberService;
	@ExceptionHandler
	public ModelAndView handler(Exception e){
		ModelAndView model = new ModelAndView("index");
		model.addObject("msg", e.getMessage());
		model.addObject("content", "ErrorHandler.jsp");
		return model;
	}
	@RequestMapping(value="insertMemberForm.do", method=RequestMethod.GET)
	public String insertMemberForm(Model  model){
		model.addAttribute("content", "member/insertMember.jsp");
		return "index";
	}
	@RequestMapping(value="insertMember.do", method=RequestMethod.POST)
	public String insertMember(Member member, Model  model){
		memberService.add(member);
		model.addAttribute("content", "member/login.jsp");
		return "index";
	}
	@RequestMapping(value="login.do", method=RequestMethod.POST)
	public String login(Model  model, HttpSession session
						, String id, String pw){
		memberService.login(id, pw);
		session.setAttribute("id", id);
		String referer = (String)session.getAttribute("referer");
		if(referer!=null){
			session.removeAttribute("referer");
			return  "redirect:"+referer;
		}else{
			return "index";
		}
	}
	@RequestMapping(value="loginform.do", method=RequestMethod.GET)
	public String login(Model  model){
		model.addAttribute("content", "member/login.jsp");
		return "index";
	}
	@RequestMapping(value="logout.do", method=RequestMethod.GET)
	public String logout(HttpSession session){
		session.removeAttribute("id");
		return "index";
	}
}



