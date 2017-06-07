<!-- default page directive -->
<%@page session="true" contentType="text/html; charset=KSC5601" %>

<!-- import section -->

<!-- error page section -->

<!-- login check section -->
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>::::: Calender :::::</title>
<style>

a:link, a:active, a:visited {
font-size: 9pt;
color: 666666;
text-decoration:none;
font-family : 돋움;
}
a:hover {
font-size: 9pt;
color: 666666;
text-decoration: none;
font-family : 돋움;
}
td {
    text-align: center;
    font-family: "굴림"; 
    font-size: 9pt; 
    color: #666666; 
    line-height: 16px
}
.day {  color: B00101}
.week {  color: ff3333}
</style>
<script language="javascript" src="/js/datepicker.js"></script>
<SCRIPT LANGUAGE="JavaScript">

var dDate = new Date();
var dCurMonth = dDate.getMonth();
var dCurDayOfMonth = dDate.getDate();
var dCurYear = dDate.getFullYear();
var objPrevElement = new Object();

function fToggleColor(myElement) {
var toggleColor = "#B00101";

if (myElement.id == "calDateText") {

if (myElement.color.toUpperCase() == toggleColor) {
myElement.color = "";
} else {
myElement.color = toggleColor;
  }
} else if (myElement.id == "calCell") {

for (var i in myElement.children) {
if (myElement.children[i].id == "calDateText") {

if (myElement.children[i].color.toUpperCase() == toggleColor) {
myElement.children[i].color = "";
} else {
myElement.children[i].color = toggleColor;
            }
         }
    }
   }
}


function fSetSelectedDay(myElement){
if (myElement.id == "calCell") {
if (!isNaN(parseInt(myElement.children["calDateText"].innerText))) {
myElement.bgColor = "#c0c0c0";
objPrevElement.bgColor = "#FFFFFF";
document.all.calSelectedDate.value = parseInt(myElement.children["calDateText"].innerText);
objPrevElement = myElement;
if (document.all.calSelectedDate.value < 10) document.all.calSelectedDate.value = "0"+document.all.calSelectedDate.value;
// alert("cal value = " +document.frmCalendarSample.tbSelYear.value+"-"+document.frmCalendarSample.tbSelMonth.value+"-"+document.all.calSelectedDate.value);
//var finalDate = document.frmCalendarSample.tbSelYear.value+"-"+document.frmCalendarSample.tbSelMonth.value+"-"+document.all.calSelectedDate.value;
//var finalDay = document.all.calSelectedDate.value;
var finalDate = thisday.innerText.substring(0,4)+thisday.innerText.substring(6,8)+document.all.calSelectedDate.value;
var finalDay = document.all.calSelectedDate.value;

// eval("opener.document."+this.fieldName.value+".value="+finalValue);
// eval("opener.document.form1.start.value="+finalValue);
// window.opener.document.form1.start.value=finalDate;
// alert("opener = " + self.opener.document);
// eval("self.opener.document."+ this.fieldName.value + ".value='"+finalValue+"'; window.close();");
// eval("self.opener.document.<%= request.getParameter("fieldName") %>.value='"+finalDate+"'; window.close();");
<%
String param = request.getParameter("fieldName2");
if(request.getParameter("fieldName2")!= null) {
%>
self.opener.document.form1.<%= param %>.value=finalDate;
<%}%>
window.opener.document.all.<%= request.getParameter("fieldName") %>[<%= request.getParameter("array")%>].value=finalDate;
window.close();
//eval("self.opener.document.<%= request.getParameter("fieldName") %>.value='"+finalDate+"'; window.close();");
// self.opener.document.form1.start.value = finalDate; window.close();
// onClick=\"self.opener.document." + this.gReturnItem + ".value='" + 
//					this.format_data(vDay) + 
//					"';window.close();\">" + 
//				this.format_day(vDay) + 
      }
   }
}
function fGetDaysInMonth(iMonth, iYear) {
var dPrevDate = new Date(iYear, iMonth, 0);
return dPrevDate.getDate();
}
function fBuildCal(iYear, iMonth, iDayStyle) {
var aMonth = new Array();
aMonth[0] = new Array(7);
aMonth[1] = new Array(7);
aMonth[2] = new Array(7);
aMonth[3] = new Array(7);
aMonth[4] = new Array(7);
aMonth[5] = new Array(7);
aMonth[6] = new Array(7);
var dCalDate = new Date(iYear, iMonth-1, 1);
var iDayOfFirst = dCalDate.getDay();
var iDaysInMonth = fGetDaysInMonth(iMonth, iYear);
var iVarDate = 1;
var i, d, w;
if (iDayStyle == 1) {
aMonth[0][0] = "Sun";
aMonth[0][1] = "Mon";
aMonth[0][2] = "Tue";
aMonth[0][3] = "Wed";
aMonth[0][4] = "Thu";
aMonth[0][5] = "Fri";
aMonth[0][6] = "Sat";
} else if (iDayStyle == 2) {
aMonth[0][0] = "Sunday";
aMonth[0][1] = "Monday";
aMonth[0][2] = "Tuesday";
aMonth[0][3] = "Wednesday";
aMonth[0][4] = "Thursday";
aMonth[0][5] = "Friday";
aMonth[0][6] = "Saturday";
} else if (iDayStyle == 3) {
aMonth[0][0] = "일";
aMonth[0][1] = "월";
aMonth[0][2] = "화";
aMonth[0][3] = "수";
aMonth[0][4] = "목";
aMonth[0][5] = "금";
aMonth[0][6] = "토";
} else {
aMonth[0][0] = "Su";
aMonth[0][1] = "Mo";
aMonth[0][2] = "Tu";
aMonth[0][3] = "We";
aMonth[0][4] = "Th";
aMonth[0][5] = "Fr";
aMonth[0][6] = "Sa";
}
for (d = iDayOfFirst; d < 7; d++) {
aMonth[1][d] = iVarDate;
iVarDate++;
}
for (w = 2; w < 7; w++) {
for (d = 0; d < 7; d++) {
if (iVarDate <= iDaysInMonth) {
aMonth[w][d] = iVarDate;
iVarDate++;
      }
   }
}
return aMonth;
}
function fDrawCal(iYear, iMonth, iCellWidth, iCellHeight, sDateTextSize, sDateTextWeight, iDayStyle) {
var myMonth;
myMonth = fBuildCal(iYear, iMonth, iDayStyle);
document.write("<table width='217' border='0' bgcolor='#6692C6' cellpadding='0' cellspacing='0'>");
document.write("<tr>");
document.write("<td height='1' colspan='15'></td>");
document.write("</tr>");
//요일 시작
document.write("<tr>");
document.write("<td width='2'></td>");
document.write("<td width='30' height='26' bgcolor='DDECFD' class='week'>" + myMonth[0][0] + "</td>");
document.write("<td width='1'></td>");
document.write("<td width='30' height='26' bgcolor='DDECFD'>" + myMonth[0][1] + "</td>");
document.write("<td width='1'></td>");
document.write("<td width='30' height='26' bgcolor='DDECFD'>" + myMonth[0][2] + "</td>");
document.write("<td width='1'></td>");
document.write("<td width='30' height='26' bgcolor='DDECFD'>" + myMonth[0][3] + "</td>");
document.write("<td width='1'></td>");
document.write("<td width='30' height='26' bgcolor='DDECFD'>" + myMonth[0][4] + "</td>");
document.write("<td width='1'></td>");
document.write("<td width='30' height='26' bgcolor='DDECFD'>" + myMonth[0][5] + "</td>");
document.write("<td width='1'></td>");
document.write("<td width='30' height='26' bgcolor='DDECFD'><font color='#0033cc'>" + myMonth[0][6] + "</font></td>");
document.write("<td width='1'></td>");
document.write("</tr>");
//요일 끝
document.write("<tr>");
document.write("<td height='1' colspan='15'></td>");
document.write("</tr>");

for (w = 1; w < 7; w++) {
document.write("<tr>");
document.write("<td></td>")
for (d = 0; d < 7; d++) {
document.write("<td align='left' valign='top' width='" + iCellWidth + "' height='" + iCellHeight + "' id=calCell style='CURSOR:Hand' bgcolor='#FFFFFF' onMouseOver='fToggleColor(this)' onMouseOut='fToggleColor(this)' onclick=fSetSelectedDay(this)>");
if (!isNaN(myMonth[w][d])) {
document.write("<font id=calDateText onMouseOver='fToggleColor(this)' style='CURSOR:Hand;FONT-FAMILY:Arial;FONT-SIZE:" + sDateTextSize + ";FONT-COLOR:#B00101;FONT-WEIGHT:" + sDateTextWeight + "' onMouseOut='fToggleColor(this)' onclick=fSetSelectedDay(this)>" + myMonth[w][d] + "</font>");
} else {
document.write("<font id=calDateText onMouseOver='fToggleColor(this)' style='CURSOR:Hand;FONT-FAMILY:Arial;FONT-SIZE:" + sDateTextSize + ";FONT-COLOR:#B00101;FONT-WEIGHT:" + sDateTextWeight + "' onMouseOut='fToggleColor(this)' onclick=fSetSelectedDay(this)> </font>");
}
document.write("</td>")
document.write("<td></td>");
}
document.write("</tr>");
document.write("<tr>");
document.write("<td height='1' colspan='15'></td>");
document.write("</tr>");
}
document.write("</table>")
}
function fUpdateCal(iYear, iMonth) {
myMonth = fBuildCal(iYear, iMonth);
objPrevElement.bgColor = "";
document.all.calSelectedDate.value = "";
for (w = 1; w < 7; w++) {
for (d = 0; d < 7; d++) {
if (!isNaN(myMonth[w][d])) {
calDateText[((7*w)+d)-7].innerText = myMonth[w][d];
} else {
calDateText[((7*w)+d)-7].innerText = " ";
         }
      }
   }
}

function beforeYear(){
var dispYear = eval(thisday.innerText.substring(0,4))-1;
var dispMonth = eval(thisday.innerText.substring(6,8));
if (dispMonth < 10) dispMonth = "0"+dispMonth;

thisday.innerText = dispYear+"년 "+dispMonth+"월";    
fUpdateCal(dispYear, dispMonth);
}

function beforeMonth(){
var dispYear = eval(thisday.innerText.substring(0,4));
var dispMonth = eval(thisday.innerText.substring(6,8))-1;

if (dispMonth < 10) {
	dispMonth = "0"+dispMonth;
} 
if (dispMonth.toString() == "00") {
	dispYear = eval(thisday.innerText.substring(0,4))-1;
	dispMonth = "12";
}
thisday.innerText = dispYear+"년 "+dispMonth+"월";    
fUpdateCal(dispYear, dispMonth);
}

function nextMonth(){
var dispYear = eval(thisday.innerText.substring(0,4));
var dispMonth = eval(thisday.innerText.substring(6,8))+1;

if (dispMonth < 10) {
	dispMonth = "0"+dispMonth;
}
if (dispMonth.toString() == "13") {
	dispYear = eval(thisday.innerText.substring(0,4))+1;
	dispMonth = "01";
}
thisday.innerText = dispYear+"년 "+dispMonth+"월";    
fUpdateCal(dispYear, dispMonth);
}
function nextYear(){
var dispYear = eval(thisday.innerText.substring(0,4))+1;
var dispMonth = eval(thisday.innerText.substring(6,8));
if (dispMonth < 10) dispMonth = "0"+dispMonth;

thisday.innerText = dispYear+"년 "+dispMonth+"월";    
fUpdateCal(dispYear, dispMonth);
}
</script>
</head>
</HEAD>

<!-- STEP TWO: Copy this code into the BODY of your HTML document  -->

<body bgcolor="#FFFFFF" text="#000000" topmargin=0 leftmargin=0 marginwidth=0 marginheight=0>
<form name="frmCalendarSample" method="post" action="">
<input type="hidden" name="calSelectedDate" value="">
<table width="240" border="0">
<tr> 
<td bgcolor="7DA7D9" height="30">
<table width="230" border="0" height="30" cellpadding="0" cellspacing="0">
  <tr>
    <td width="35"><a href="javascript:beforeYear()"><img src="images/back3-1.gif" width="27" height="14" border="0"></a></td>
    <td width="30"><a href="javascript:beforeMonth()"><img src="images/back3.gif" width="27" height="14" border="0"></td>
    <td width="100"><b><font id="thisday" color="#FFFFFF"></font></b></td>
    <td width="30"><a href="javascript:nextMonth()"><img src="images/next3.gif" width="27" height="14" border="0"></a></td>
    <td width="35"><a href="javascript:nextYear()"><img src="images/next3-1.gif" width="27" height="14" border="0"></td>
  </tr>
</table>
</td>
</tr>
  <tr>
    <td height="10"></td>
  </tr>
<tr>
<td>

<script language="JavaScript">
var dCurDate = new Date();
fDrawCal(dCurDate.getFullYear(), dCurDate.getMonth()+1, 26, 26, "12px", "bold", 3);
</script>

</td>
</tr>
</table>
</form>

<script language="JavaScript" for=window event=onload>
<!-- Begin
var dCurDate = new Date();
var dMonth = dCurDate.getMonth()+1;
if(dMonth <10)
dMonth = "0" + dMonth;
 thisday.innerText = dCurDate.getFullYear()+"년 "+dMonth+"월";    
//  End -->
</script>
</html>

