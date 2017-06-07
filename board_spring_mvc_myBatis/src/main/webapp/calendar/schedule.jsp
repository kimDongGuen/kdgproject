<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script type="text/javascript">
var screenW, screenH;
	screenW = window.screen.width;
	screenH = window.screen.height;
function calender(param,array){
	 var windowX, windowY;
	 windowX = Math.ceil( (screenW - 240) / 2 );
	 windowY = Math.ceil( (screenH - 250) / 2 );
	 var NewWin = window.open('Calender.jsp?fieldName='+param+'&array='+array,'popCal','status=no,scrollbars=no,width=240,height=250,left='+windowX+',top='+windowY);
	 NewWin.focus();
}	
//-->
</script>
</head>
<body>
<form name="frm" method="post">
<table>
<tr><td>선택</td><td>일정이름</td><td>일정시작</td><td>일정마침</td></tr>
<%for(int i=0; i<20; i++){ %>
<tr>
<td><input type="checkbox" name="choice" value=""></td>
<td><input type="text" name="name"></td>
<td><input type="text" name="start">
<a href="javascript:calender('start',<%=i%>)"><img src="images/btn_year.gif" border="0"></a>
</td>
<td><input type="text" name="end">
<a href="javascript:calender('end',<%=i%>)"><img src="images/btn_year.gif" border="0"></a>
</td>
</tr>
<%}%>
</table>
</form>
</body>
</html>