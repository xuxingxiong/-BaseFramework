<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<base href="<%=basePath%>">
	<!-- 下拉框 -->
	<link rel="stylesheet" href="static/ace/css/chosen.css" />
	<!-- jsp文件头和头部 -->
	<%@ include file="../../system/index/top.jsp"%>
	<!-- 日期框 -->
	<link rel="stylesheet" href="static/ace/css/datepicker.css" />
	<style type="text/css">
	input[type="text"]:disabled{
		border: 0px;
		background:#ffffff;
	}
	textarea:disabled{
		resize: none;
		border: 0px;
		background:#ffffff;
	}
	</style>
</head>
<body class="no-skin">
<!-- /section:basics/navbar.layout -->
<div class="main-container" id="main-container">
	<!-- /section:basics/sidebar -->
	<div class="main-content">
		<div class="main-content-inner">
			<div class="page-content">
				<div class="row">
					<div class="col-xs-12">
					<div>
   <p style="margin:0pt; orphans:0; text-align:center; widows:0"><span style="font-family:仿宋; font-size:18pt; font-weight:bold">采购</span><span style="font-family:仿宋; font-size:18pt; font-weight:bold">申</span><span style="font-family:仿宋; font-size:18pt; font-weight:bold">请</span><span style="font-family:仿宋; font-size:18pt; font-weight:bold">单</span></p>
   <p style="margin:0pt; orphans:0; text-align:right; widows:0"><span style="font-family:仿宋; font-size:12pt">&nbsp;</span></p>
   <p style="margin:0pt; orphans:0; text-align:right; widows:0"><span style="font-family:仿宋; font-size:12pt">申领</span>
   <span style="font-family:仿宋; font-size:12pt">日期：
   <input type="text" value="${fn:substring(pd.APPLY_DATE,0,4)}" id='year' <c:if test="${msg == 'detail' }">disabled </c:if> style='color: #393939;width:50px;' />年
   <input type="text" value="${fn:substring(pd.APPLY_DATE,5,7)}" id='month' <c:if test="${msg == 'detail' }">disabled </c:if> style='color: #393939;width:30px;' /></span>
   <span style="font-family:仿宋; font-size:12pt"> </span><span style="font-family:仿宋; font-size:12pt">月
   <input type="text" value="${fn:substring(pd.APPLY_DATE,8,10)}" id='day' <c:if test="${msg == 'detail' }">disabled </c:if> style='color: #393939;width:30px;' />日</span></p>
   
	<form action="purchaseorder/${msg }.do" name="Form" id="Form" method="post">
		<input type="hidden" name="ID" id="ID" value="${pd.ID}"/>
		<input type="hidden" name="APPLY_DATE" id="APPLY_DATE" value="${pd.APPLY_DATE}"/>
		<div id="zhongxin" style="padding-top: 13px;">
	   <table style="border-collapse:collapse; margin-left:5.4pt; width:700px">
	    <tbody>
	     <tr style="height:29.25pt">
	      <td rowspan="2" style="border-bottom-color:#393939000; border-bottom-style:solid; border-bottom-width:0.75pt; border-left-color:#393939000; border-left-style:solid; border-left-width:0.75pt; border-right-color:#393939000; border-right-style:solid; border-right-width:0.75pt; border-top-color:#393939000; border-top-style:solid; border-top-width:1.5pt; height:29.25pt; padding-left:5.03pt; padding-right:5.03pt; vertical-align:middle; width:34.45pt; writing-mode:tb-rl">
	      <p style="margin:0pt 5.65pt; orphans:0; text-align:center; widows:0">
	      <span style="font-family:宋体; font-size:12pt; -webkit-transform: rotate(90deg); display: block;">申</span>
	      <span style="font-family:宋体; font-size:12pt; -webkit-transform: rotate(90deg); display: block;">请</span>
	      <span style="font-family:宋体; font-size:12pt; -webkit-transform: rotate(90deg); display: block;">人</span></p>
	      </td>
	      <td style="border-bottom-color:#393939000; border-bottom-style:solid; border-bottom-width:0.75pt; border-left-color:#393939000; border-left-style:solid; border-left-width:0.75pt; border-right-color:#393939000; border-right-style:solid; border-right-width:0.75pt; border-top-color:#393939000; border-top-style:solid; border-top-width:1.5pt; padding-left:5.03pt; padding-right:5.03pt; vertical-align:middle; width:61.15pt"><p style="margin:0pt; orphans:0; text-align:center; widows:0"><span style="font-family:宋体; font-size:12pt">部门</span></p></td>
	      <td colspan="2" style="border-bottom-color:#393939000; border-bottom-style:solid; border-bottom-width:0.75pt; border-left-color:#393939000; border-left-style:solid; border-left-width:0.75pt; border-right-color:#393939000; border-right-style:solid; border-right-width:0.75pt; border-top-color:#393939000; border-top-style:solid; border-top-width:1.5pt; padding-left:5.03pt; padding-right:5.03pt; vertical-align:middle; width:178.1pt"><p style="margin:0pt; orphans:0; text-align:center; widows:0"><span style="font-family:宋体; font-size:12pt">
		  <input type="text" <c:if test="${msg == 'detail' }">disabled </c:if> value="${pd.DEPARTMENT}" name='DEPARTMENT' style='color: #393939;width:100%;' />
		  </span></p></td>
	      <td style="border-bottom-color:#393939000; border-bottom-style:solid; border-bottom-width:0.75pt; border-left-color:#393939000; border-left-style:solid; border-left-width:0.75pt; border-right-color:#393939000; border-right-style:solid; border-right-width:0.75pt; border-top-color:#393939000; border-top-style:solid; border-top-width:1.5pt; padding-left:5.03pt; padding-right:5.03pt; vertical-align:middle; width:61.15pt"><p style="margin:0pt; orphans:0; text-align:center; widows:0"><span style="font-family:宋体; font-size:12pt">姓名</span></p></td>
	      <td style="border-bottom-color:#393939000; border-bottom-style:solid; border-bottom-width:0.75pt; border-left-color:#393939000; border-left-style:solid; border-left-width:0.75pt; border-right-color:#393939000; border-right-style:solid; border-right-width:0.75pt; border-top-color:#393939000; border-top-style:solid; border-top-width:1.5pt; padding-left:5.03pt; padding-right:5.03pt; vertical-align:middle; width:106.15pt"><p style="margin:0pt; orphans:0; widows:0"><span style="color:#a6a6a6; font-family:宋体; font-size:12pt">
		  <input type="text" <c:if test="${msg == 'detail' }">disabled </c:if> value="${pd.EMP_NAME}" name='EMP_NAME' style='color: #393939;width:100%;' />
		  </span></p></td>
	     </tr>
	     <tr style="height:29.25pt">
	      <td style="border-bottom-color:#393939000; border-bottom-style:solid; border-bottom-width:0.75pt; border-left-color:#393939000; border-left-style:solid; border-left-width:0.75pt; border-right-color:#393939000; border-right-style:solid; border-right-width:0.75pt; border-top-color:#393939000; border-top-style:solid; border-top-width:0.75pt; padding-left:5.03pt; padding-right:5.03pt; vertical-align:middle; width:61.15pt"><p style="margin:0pt; orphans:0; text-align:center; widows:0"><span style="font-family:宋体; font-size:12pt">工号</span></p></td>
	      <td colspan="2" style="border-bottom-color:#393939000; border-bottom-style:solid; border-bottom-width:0.75pt; border-left-color:#393939000; border-left-style:solid; border-left-width:0.75pt; border-right-color:#393939000; border-right-style:solid; border-right-width:0.75pt; border-top-color:#393939000; border-top-style:solid; border-top-width:0.75pt; padding-left:5.03pt; padding-right:5.03pt; vertical-align:middle; width:178.1pt"><p style="margin:0pt; orphans:0; text-align:center; widows:0"><span style="color:#a6a6a6; font-family:宋体; font-size:12pt">
	      <input type="text" <c:if test="${msg == 'detail' }">disabled </c:if> value="${pd.EMP_ID}" name='EMP_ID' style='color: #393939;width:100%;' /></span></p></td>
	      <td style="border-bottom-color:#393939000; border-bottom-style:solid; border-bottom-width:0.75pt; border-left-color:#393939000; border-left-style:solid; border-left-width:0.75pt; border-right-color:#393939000; border-right-style:solid; border-right-width:0.75pt; border-top-color:#393939000; border-top-style:solid; border-top-width:0.75pt; padding-left:5.03pt; padding-right:5.03pt; vertical-align:middle; width:61.15pt"><p style="margin:0pt; orphans:0; text-align:center; widows:0"><span style="font-family:宋体; font-size:12pt">职务</span></p></td>
	      <td style="border-bottom-color:#393939000; border-bottom-style:solid; border-bottom-width:0.75pt; border-left-color:#393939000; border-left-style:solid; border-left-width:0.75pt; border-right-color:#393939000; border-right-style:solid; border-right-width:0.75pt; border-top-color:#393939000; border-top-style:solid; border-top-width:0.75pt; padding-left:5.03pt; padding-right:5.03pt; vertical-align:middle; width:106.15pt"><p style="margin:0pt; orphans:0; widows:0"><span style="color:#a6a6a6; font-family:宋体; font-size:12pt">
	      <input type="text" <c:if test="${msg == 'detail' }">disabled </c:if> value="${pd.POST}" name='POST' style='color: #393939;width:100%;' /></span></p></td>
	     </tr>
	     <tr style="height:29.7pt">
	      <td colspan="2" style="border-bottom-color:#393939000; border-bottom-style:solid; border-bottom-width:0.75pt; border-left-color:#393939000; border-left-style:solid; border-left-width:0.75pt; border-right-color:#393939000; border-right-style:solid; border-right-width:0.75pt; border-top-color:#393939000; border-top-style:solid; border-top-width:0.75pt; padding-left:5.03pt; padding-right:5.03pt; vertical-align:middle; width:106.4pt"><p style="margin:0pt; orphans:0; text-align:center; widows:0"><span style="font-family:宋体; font-size:12pt">申</span><span style="font-family:宋体; font-size:12pt">请</span><span style="font-family:宋体; font-size:12pt">物资名称（1）</span></p></td>
	      <td colspan="2" style="border-bottom-color:#393939000; border-bottom-style:solid; border-bottom-width:0.75pt; border-left-color:#393939000; border-left-style:solid; border-left-width:0.75pt; border-right-color:#393939000; border-right-style:solid; border-right-width:0.75pt; border-top-color:#393939000; border-top-style:solid; border-top-width:0.75pt; padding-left:5.03pt; padding-right:5.03pt; vertical-align:middle; width:178.1pt"><p style="margin:0pt; orphans:0; widows:0"><span style="color:#a6a6a6; font-family:宋体; font-size:12pt">
	      <input type="text" <c:if test="${msg == 'detail' }">disabled </c:if> value="${pd.MATE_NAME1}" name='MATE_NAME1' style='color: #393939;width:100%;' /></span></p></td>
	      <td style="border-bottom-color:#393939000; border-bottom-style:solid; border-bottom-width:0.75pt; border-left-color:#393939000; border-left-style:solid; border-left-width:0.75pt; border-right-color:#393939000; border-right-style:solid; border-right-width:0.75pt; border-top-color:#393939000; border-top-style:solid; border-top-width:0.75pt; padding-left:5.03pt; padding-right:5.03pt; vertical-align:middle; width:61.15pt"><p style="margin:0pt; orphans:0; text-align:center; widows:0"><span style="font-family:宋体; font-size:12pt">数量</span></p></td>
	      <td style="border-bottom-color:#393939000; border-bottom-style:solid; border-bottom-width:0.75pt; border-left-color:#393939000; border-left-style:solid; border-left-width:0.75pt; border-right-color:#393939000; border-right-style:solid; border-right-width:0.75pt; border-top-color:#393939000; border-top-style:solid; border-top-width:0.75pt; padding-left:5.03pt; padding-right:5.03pt; vertical-align:middle; width:106.15pt"><p style="margin:0pt; orphans:0; widows:0"><span style="font-family:宋体; font-size:12pt">
	      <input type="text" <c:if test="${msg == 'detail' }">disabled </c:if> value="${pd.MATE_NUM1}" name='MATE_NUM1' style='color: #393939;width:100%;' /></span></p></td>
	     </tr>
	     <tr style="height:29.7pt">
	      <td colspan="2" style="border-bottom-color:#393939000; border-bottom-style:solid; border-bottom-width:0.75pt; border-left-color:#393939000; border-left-style:solid; border-left-width:0.75pt; border-right-color:#393939000; border-right-style:solid; border-right-width:0.75pt; border-top-color:#393939000; border-top-style:solid; border-top-width:0.75pt; padding-left:5.03pt; padding-right:5.03pt; vertical-align:middle; width:106.4pt"><p style="margin:0pt; orphans:0; text-align:center; widows:0"><span style="font-family:宋体; font-size:12pt">申</span><span style="font-family:宋体; font-size:12pt">请</span><span style="font-family:宋体; font-size:12pt">物资名称（2）</span></p></td>
	      <td colspan="2" style="border-bottom-color:#393939000; border-bottom-style:solid; border-bottom-width:0.75pt; border-left-color:#393939000; border-left-style:solid; border-left-width:0.75pt; border-right-color:#393939000; border-right-style:solid; border-right-width:0.75pt; border-top-color:#393939000; border-top-style:solid; border-top-width:0.75pt; padding-left:5.03pt; padding-right:5.03pt; vertical-align:middle; width:178.1pt"><p style="margin:0pt; orphans:0; widows:0"><span style="color:#a6a6a6; font-family:宋体; font-size:12pt">
	      <input type="text" <c:if test="${msg == 'detail' }">disabled </c:if> value="${pd.MATE_NAME2}" name='MATE_NAME2' style='color: #393939;width:100%;' /></span></p></td>
	      <td style="border-bottom-color:#393939000; border-bottom-style:solid; border-bottom-width:0.75pt; border-left-color:#393939000; border-left-style:solid; border-left-width:0.75pt; border-right-color:#393939000; border-right-style:solid; border-right-width:0.75pt; border-top-color:#393939000; border-top-style:solid; border-top-width:0.75pt; padding-left:5.03pt; padding-right:5.03pt; vertical-align:middle; width:61.15pt"><p style="margin:0pt; orphans:0; text-align:center; widows:0"><span style="font-family:宋体; font-size:12pt">数量</span></p></td>
	      <td style="border-bottom-color:#393939000; border-bottom-style:solid; border-bottom-width:0.75pt; border-left-color:#393939000; border-left-style:solid; border-left-width:0.75pt; border-right-color:#393939000; border-right-style:solid; border-right-width:0.75pt; border-top-color:#393939000; border-top-style:solid; border-top-width:0.75pt; padding-left:5.03pt; padding-right:5.03pt; vertical-align:middle; width:106.15pt"><p style="margin:0pt; orphans:0; widows:0"><span style="font-family:宋体; font-size:12pt">
	      <input type="text" <c:if test="${msg == 'detail' }">disabled </c:if> value="${pd.MATE_NUM2}" name='MATE_NUM2' style='color: #393939;width:100%;' /></span></p></td>
	     </tr>
	     <tr style="height:29.7pt">
	      <td colspan="2" style="border-bottom-color:#393939000; border-bottom-style:solid; border-bottom-width:0.75pt; border-left-color:#393939000; border-left-style:solid; border-left-width:0.75pt; border-right-color:#393939000; border-right-style:solid; border-right-width:0.75pt; border-top-color:#393939000; border-top-style:solid; border-top-width:0.75pt; padding-left:5.03pt; padding-right:5.03pt; vertical-align:middle; width:106.4pt"><p style="margin:0pt; orphans:0; text-align:center; widows:0"><span style="font-family:宋体; font-size:12pt">申</span><span style="font-family:宋体; font-size:12pt">请</span><span style="font-family:宋体; font-size:12pt">物资名称（3）</span></p></td>
	      <td colspan="2" style="border-bottom-color:#393939000; border-bottom-style:solid; border-bottom-width:0.75pt; border-left-color:#393939000; border-left-style:solid; border-left-width:0.75pt; border-right-color:#393939000; border-right-style:solid; border-right-width:0.75pt; border-top-color:#393939000; border-top-style:solid; border-top-width:0.75pt; padding-left:5.03pt; padding-right:5.03pt; vertical-align:middle; width:178.1pt"><p style="margin:0pt; orphans:0; widows:0"><span style="color:#a6a6a6; font-family:宋体; font-size:12pt">
	      <input type="text" <c:if test="${msg == 'detail' }">disabled </c:if> value="${pd.MATE_NAME3}" name='MATE_NAME3' style='color: #393939;width:100%;' /></span></p></td>
	      <td style="border-bottom-color:#393939000; border-bottom-style:solid; border-bottom-width:0.75pt; border-left-color:#393939000; border-left-style:solid; border-left-width:0.75pt; border-right-color:#393939000; border-right-style:solid; border-right-width:0.75pt; border-top-color:#393939000; border-top-style:solid; border-top-width:0.75pt; padding-left:5.03pt; padding-right:5.03pt; vertical-align:middle; width:61.15pt"><p style="margin:0pt; orphans:0; text-align:center; widows:0"><span style="font-family:宋体; font-size:12pt">数量</span></p></td>
	      <td style="border-bottom-color:#393939000; border-bottom-style:solid; border-bottom-width:0.75pt; border-left-color:#393939000; border-left-style:solid; border-left-width:0.75pt; border-right-color:#393939000; border-right-style:solid; border-right-width:0.75pt; border-top-color:#393939000; border-top-style:solid; border-top-width:0.75pt; padding-left:5.03pt; padding-right:5.03pt; vertical-align:middle; width:106.15pt"><p style="margin:0pt; orphans:0; widows:0"><span style="font-family:宋体; font-size:12pt">
	      <input type="text" <c:if test="${msg == 'detail' }">disabled </c:if> value="${pd.MATE_NUM3}" name='MATE_NUM3' style='color: #393939;width:100%;' /></span></p></td>
	     </tr>
	     <tr style="height:71.35pt">
	      <td rowspan="4" style="border-bottom-color:#393939000; border-bottom-style:solid; border-bottom-width:1.5pt; border-left-color:#393939000; border-left-style:solid; border-left-width:0.75pt; border-right-color:#393939000; border-right-style:solid; border-right-width:0.75pt; border-top-color:#393939000; border-top-style:solid; border-top-width:0.75pt; padding-left:5.03pt; padding-right:5.03pt; vertical-align:middle; width:34.45pt"><p style="margin:0pt; orphans:0; text-align:center; widows:0"><span style="font-family:宋体; font-size:12pt">请购</span><span style="font-family:宋体; font-size:12pt">部门填写</span></p></td>
	      <td colspan="5" style="border-bottom-color:#393939000; border-bottom-style:solid; border-bottom-width:0.75pt; border-left-color:#393939000; border-left-style:solid; border-left-width:0.75pt; border-right-color:#393939000; border-right-style:solid; border-right-width:0.75pt; border-top-color:#393939000; border-top-style:solid; border-top-width:0.75pt; padding-left:5.03pt; padding-right:5.03pt; vertical-align:top; width:438.95pt"><p style="margin:0pt; orphans:0; text-align:center; widows:0"><span style="color:#808080; font-family:宋体; font-size:12pt">申</span><span style="color:#808080; font-family:宋体; font-size:12pt">请</span><span style="color:#808080; font-family:宋体; font-size:12pt">原因及物资使用说明</span></p>
	      <textarea <c:if test="${msg == 'detail' }">disabled </c:if> rows="2" cols="81"  style='color: #393939;' name='APPLY_REASON'>${pd.DEPARTMENT}</textarea>
	      </td>
	     </tr>
	     <tr style="height:26.65pt">
	      <td style="border-bottom-color:#393939000; border-bottom-style:solid; border-bottom-width:0.75pt; border-left-color:#393939000; border-left-style:solid; border-left-width:0.75pt; border-right-color:#393939000; border-right-style:solid; border-right-width:0.75pt; border-top-color:#393939000; border-top-style:solid; border-top-width:0.75pt; padding-left:5.03pt; padding-right:5.03pt; vertical-align:middle; width:61.15pt"><p style="margin:0pt; orphans:0; text-align:center; widows:0"><span style="font-family:宋体; font-size:12pt">预算金额</span></p></td>
	      <td style="border-bottom-color:#393939000; border-bottom-style:solid; border-bottom-width:0.75pt; border-left-color:#393939000; border-left-style:solid; border-left-width:0.75pt; border-right-color:#393939000; border-right-style:solid; border-right-width:0.75pt; border-top-color:#393939000; border-top-style:solid; border-top-width:0.75pt; padding-left:5.03pt; padding-right:5.03pt; vertical-align:middle; width:127.15pt"><p style="margin:0pt 0pt 0pt 0pt; orphans:0; text-align:right; widows:0"><span style="font-family:宋体; font-size:12pt">
	      	<input type="text" <c:if test="${msg == 'detail' }">disabled </c:if> value="${pd.BUDGET_AMOUNT}" name='BUDGET_AMOUNT' style='color: #393939;width:90%;' />元</span></p></td>
	      <td colspan="2" style="border-bottom-color:#393939000; border-bottom-style:solid; border-bottom-width:0.75pt; border-left-color:#393939000; border-left-style:solid; border-left-width:0.75pt; border-right-color:#393939000; border-right-style:solid; border-right-width:0.75pt; border-top-color:#393939000; border-top-style:solid; border-top-width:0.75pt; padding-left:5.03pt; padding-right:5.03pt; vertical-align:middle; width:112.1pt"><p style="margin:0pt; orphans:0; text-align:center; widows:0"><span style="font-family:宋体; font-size:12pt">期望交付日期</span></p></td>
	      <td style="border-bottom-color:#393939000; border-bottom-style:solid; border-bottom-width:0.75pt; border-left-color:#393939000; border-left-style:solid; border-left-width:0.75pt; border-right-color:#393939000; border-right-style:solid; border-right-width:0.75pt; border-top-color:#393939000; border-top-style:solid; border-top-width:0.75pt; padding-left:5.03pt; padding-right:5.03pt; vertical-align:middle; width:106.15pt"><p style="margin:0pt 0pt 0pt 0pt; orphans:0; widows:0"><span style="font-family:宋体; font-size:12pt">
		  <c:if test="${msg != 'detail' }">
		  <input class="span10 date-picker" name="EXPECT_DELI_DATE" id="EXPECT_DELI_DATE"  value="${pd.EXPECT_DELI_DATE}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:150px;" placeholder="期望交付日期" title="期望交付日期"/>
		  </c:if>
		  <c:if test="${msg == 'detail' }">${pd.EXPECT_DELI_DATE}</c:if>
		  </span></p></td>
	     </tr>
	     <tr style="height:29.15pt">
	      <td style="border-bottom-color:#393939000; border-bottom-style:solid; border-bottom-width:0.75pt; border-left-color:#393939000; border-left-style:solid; border-left-width:0.75pt; border-right-color:#393939000; border-right-style:solid; border-right-width:0.75pt; border-top-color:#393939000; border-top-style:solid; border-top-width:0.75pt; padding-left:5.03pt; padding-right:5.03pt; vertical-align:middle; width:61.15pt"><p style="margin:0pt; orphans:0; text-align:center; widows:0"><span style="font-family:宋体; font-size:12pt">交付地点</span></p></td>
	      <td style="border-bottom-color:#393939000; border-bottom-style:solid; border-bottom-width:0.75pt; border-left-color:#393939000; border-left-style:solid; border-left-width:0.75pt; border-right-color:#393939000; border-right-style:solid; border-right-width:0.75pt; border-top-color:#393939000; border-top-style:solid; border-top-width:0.75pt; padding-left:5.03pt; padding-right:5.03pt; vertical-align:middle; width:127.15pt"><p style="margin:0pt; orphans:0; text-align:center; widows:0"><span style="color:#808080; font-family:宋体; font-size:12pt">
	      <input type="text" <c:if test="${msg == 'detail' }">disabled </c:if> value="${pd.DELI_ADDRESS}" name='DELI_ADDRESS' style='color: #393939;width:100%;' /></span></p></td>
	      <td colspan="2" style="border-bottom-color:#393939000; border-bottom-style:solid; border-bottom-width:0.75pt; border-left-color:#393939000; border-left-style:solid; border-left-width:0.75pt; border-right-color:#393939000; border-right-style:solid; border-right-width:0.75pt; border-top-color:#393939000; border-top-style:solid; border-top-width:0.75pt; padding-left:5.03pt; padding-right:5.03pt; vertical-align:middle; width:112.1pt"><p style="margin:0pt; orphans:0; text-align:center; widows:0"><span style="font-family:宋体; font-size:12pt">签收人及联系方式</span></p></td>
	      <td style="border-bottom-color:#393939000; border-bottom-style:solid; border-bottom-width:0.75pt; border-left-color:#393939000; border-left-style:solid; border-left-width:0.75pt; border-right-color:#393939000; border-right-style:solid; border-right-width:0.75pt; border-top-color:#393939000; border-top-style:solid; border-top-width:0.75pt; padding-left:5.03pt; padding-right:5.03pt; vertical-align:middle; width:106.15pt"><p style="margin:0pt; orphans:0; text-align:center; widows:0"><span style="color:#808080; font-family:宋体; font-size:12pt">
	      <input type="text" <c:if test="${msg == 'detail' }">disabled </c:if> value="${pd.USE_REASON}" name='USE_REASON' style='color: #393939;width:100%;' /></span></p></td>
	     </tr>
	     <tr style="height:47.4pt">
	      <td style="border-bottom-color:#393939000; border-bottom-style:solid; border-bottom-width:1.5pt; border-left-color:#393939000; border-left-style:solid; border-left-width:0.75pt; border-right-color:#393939000; border-right-style:solid; border-right-width:0.75pt; border-top-color:#393939000; border-top-style:solid; border-top-width:0.75pt; padding-left:5.03pt; padding-right:5.03pt; vertical-align:middle; width:61.15pt"><p style="margin:0pt; orphans:0; text-align:center; widows:0"><span style="font-family:宋体; font-size:12pt">申请</span><span style="font-family:宋体; font-size:12pt">部门</span></p><p style="margin:0pt; orphans:0; text-align:center; widows:0"><span style="font-family:宋体; font-size:12pt">经理确认</span></p></td>
	      <td style="border-bottom-color:#393939000; border-bottom-style:solid; border-bottom-width:1.5pt; border-left-color:#393939000; border-left-style:solid; border-left-width:0.75pt; border-right-color:#393939000; border-right-style:solid; border-right-width:0.75pt; border-top-color:#393939000; border-top-style:solid; border-top-width:0.75pt; padding-left:5.03pt; padding-right:5.03pt; vertical-align:middle; width:127.15pt"><p style="margin:0pt; orphans:0; text-align:center; widows:0"><span style="font-family:宋体; font-size:12pt">
	      <input type="text" <c:if test="${msg == 'detail' }">disabled </c:if> value="${pd.MANAGER_CONFIRM}" name='MANAGER_CONFIRM' style='color: #393939;width:100%;' /></span></p></td>
	      <td colspan="2" style="border-bottom-color:#393939000; border-bottom-style:solid; border-bottom-width:1.5pt; border-left-color:#393939000; border-left-style:solid; border-left-width:0.75pt; border-right-color:#393939000; border-right-style:solid; border-right-width:0.75pt; border-top-color:#393939000; border-top-style:solid; border-top-width:0.75pt; padding-left:5.03pt; padding-right:5.03pt; vertical-align:middle; width:112.1pt"><p style="margin:0pt; orphans:0; text-align:center; widows:0"><span style="font-family:宋体; font-size:12pt">申请部门</span></p><p style="margin:0pt; orphans:0; text-align:center; widows:0"><span style="font-family:宋体; font-size:12pt">总经理确认</span></p></td>
	      <td style="border-bottom-color:#393939000; border-bottom-style:solid; border-bottom-width:1.5pt; border-left-color:#393939000; border-left-style:solid; border-left-width:0.75pt; border-right-color:#393939000; border-right-style:solid; border-right-width:0.75pt; border-top-color:#393939000; border-top-style:solid; border-top-width:0.75pt; padding-left:5.03pt; padding-right:5.03pt; vertical-align:middle; width:106.15pt"><p style="margin:0pt; orphans:0; text-align:center; widows:0"><span style="font-family:宋体; font-size:12pt">
	      <input type="text" <c:if test="${msg == 'detail' }">disabled </c:if> value="${pd.GENERAL_MGR_CFM}" name='GENERAL_MGR_CFM' style='color: #393939;width:100%;' /></span></p></td>
	     </tr>
	     <tr style="height:22.95pt">
	      <td rowspan="3" style="border-bottom-color:#393939000; border-bottom-style:solid; border-bottom-width:1.5pt; border-left-color:#393939000; border-left-style:solid; border-left-width:0.75pt; border-right-color:#393939000; border-right-style:solid; border-right-width:0.75pt; border-top-color:#393939000; border-top-style:solid; border-top-width:1.5pt; padding-left:5.03pt; padding-right:5.03pt; vertical-align:middle; width:34.45pt"><p style="margin:0pt; orphans:0; text-align:center; widows:0"><span style="font-family:宋体; font-size:12pt">采购部门填写</span></p></td>
	      <td style="border-bottom-color:#393939000; border-bottom-style:solid; border-bottom-width:0.75pt; border-left-color:#393939000; border-left-style:solid; border-left-width:0.75pt; border-right-color:#393939000; border-right-style:solid; border-right-width:0.75pt; border-top-color:#393939000; border-top-style:solid; border-top-width:1.5pt; padding-left:5.03pt; padding-right:5.03pt; vertical-align:middle; width:61.15pt"><p style="margin:0pt; orphans:0; text-align:justify; widows:0"><span style="font-family:宋体; font-size:12pt">预估金额</span></p></td>
	      <td style="border-bottom-color:#393939000; border-bottom-style:solid; border-bottom-width:0.75pt; border-left-color:#393939000; border-left-style:solid; border-left-width:0.75pt; border-right-color:#393939000; border-right-style:solid; border-right-width:0.75pt; border-top-color:#393939000; border-top-style:solid; border-top-width:1.5pt; padding-left:5.03pt; padding-right:5.03pt; vertical-align:middle; width:127.15pt"><p style="margin:0pt; orphans:0; text-align:right; widows:0"><span style="font-family:宋体; font-size:12pt">
	      <input type="text" <c:if test="${msg == 'detail' }">disabled </c:if> value="${pd.ESTI_AMOUNT}" name='ESTI_AMOUNT' style='color: #393939;width:90%;' />元</span></p></td>
	      <td colspan="2" style="border-bottom-color:#393939000; border-bottom-style:solid; border-bottom-width:0.75pt; border-left-color:#393939000; border-left-style:solid; border-left-width:0.75pt; border-right-color:#393939000; border-right-style:solid; border-right-width:0.75pt; border-top-color:#393939000; border-top-style:solid; border-top-width:0.75pt; padding-left:5.03pt; padding-right:5.03pt; vertical-align:middle; width:112.1pt"><p style="margin:0pt; orphans:0; text-align:center; widows:0"><span style="font-family:宋体; font-size:12pt">预计交付时间</span></p></td>
	      <td style="border-bottom-color:#393939000; border-bottom-style:solid; border-bottom-width:0.75pt; border-left-color:#393939000; border-left-style:solid; border-left-width:0.75pt; border-right-color:#393939000; border-right-style:solid; border-right-width:0.75pt; border-top-color:#393939000; border-top-style:solid; border-top-width:0.75pt; padding-left:5.03pt; padding-right:5.03pt; vertical-align:middle; width:106.15pt"><p style="margin:0pt; orphans:0; widows:0"><span style="font-family:宋体; font-size:12pt">
		  <c:if test="${msg != 'detail' }">
		  <input class="span10 date-picker" name="ESTI_DELI_DATE" id="ESTI_DELI_DATE"  value="${pd.ESTI_DELI_DATE}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:150px;" placeholder="预计交付时间" title="预计交付时间"/>
		  </c:if>
		  <c:if test="${msg == 'detail' }">${pd.ESTI_DELI_DATE}</c:if>
		  </span></p></td>
	     </tr>
	     <tr style="height:72.15pt">
	      <td colspan="5" style="border-bottom-color:#393939000; border-bottom-style:solid; border-bottom-width:0.75pt; border-left-color:#393939000; border-left-style:solid; border-left-width:0.75pt; border-right-color:#393939000; border-right-style:solid; border-right-width:0.75pt; border-top-color:#393939000; border-top-style:solid; border-top-width:0.75pt; padding-left:5.03pt; padding-right:5.03pt; vertical-align:middle; width:438.95pt"><p style="margin:0pt; orphans:0; widows:0">
	      <span style="font-family:宋体; font-size:12pt">
	      <textarea <c:if test="${msg == 'detail' }">disabled </c:if> rows="2" cols="81" style='color: #393939;'  name='PUR_DEPART_OPINION'>${pd.PUR_DEPART_OPINION}</textarea></span></p><p style="margin:0pt; orphans:0; text-align:right; widows:0"><span style="font-family:宋体; font-size:12pt">
	      	经办人：<input type="text" <c:if test="${msg == 'detail' }">disabled </c:if> style='color: #393939;' value="${pd.OPERATOR}" name='OPERATOR' /></span></p></td>
	     </tr>
	     <tr style="height:53.35pt">
	      <td style="border-bottom-color:#393939000; border-bottom-style:solid; border-bottom-width:1.5pt; border-left-color:#393939000; border-left-style:solid; border-left-width:0.75pt; border-right-color:#393939000; border-right-style:solid; border-right-width:0.75pt; border-top-color:#393939000; border-top-style:solid; border-top-width:0.75pt; padding-left:5.03pt; padding-right:5.03pt; vertical-align:middle; width:61.15pt"><p style="margin:0pt; orphans:0; text-align:center; widows:0"><span style="font-family:宋体; font-size:12pt">物料采购部经理意见</span></p></td>
	      <td style="border-bottom-color:#393939000; border-bottom-style:solid; border-bottom-width:1.5pt; border-left-color:#393939000; border-left-style:solid; border-left-width:0.75pt; border-right-color:#393939000; border-right-style:solid; border-right-width:0.75pt; border-top-color:#393939000; border-top-style:solid; border-top-width:0.75pt; padding-left:5.03pt; padding-right:5.03pt; vertical-align:middle; width:127.15pt"><p style="margin:0pt; orphans:0; text-align:center; widows:0"><span style="font-family:宋体; font-size:12pt">
	      <textarea <c:if test="${msg == 'detail' }">disabled </c:if> rows="2" cols="20" style='color: #393939;'  name='MATPUR_MGR_OPINION'>${pd.MATPUR_MGR_OPINION}</textarea></span></p></td>
	      <td colspan="2" style="border-bottom-color:#393939000; border-bottom-style:solid; border-bottom-width:1.5pt; border-left-color:#393939000; border-left-style:solid; border-left-width:0.75pt; border-right-color:#393939000; border-right-style:solid; border-right-width:0.75pt; border-top-color:#393939000; border-top-style:solid; border-top-width:0.75pt; padding-left:5.03pt; padding-right:5.03pt; vertical-align:middle; width:112.1pt"><p style="margin:0pt; orphans:0; text-align:center; widows:0"><span style="font-family:宋体; font-size:12pt">综合管理中心</span></p><p style="margin:0pt; orphans:0; text-align:center; widows:0"><span style="font-family:宋体; font-size:12pt">总经理意见</span></p></td>
	      <td style="border-bottom-color:#393939000; border-bottom-style:solid; border-bottom-width:1.5pt; border-left-color:#393939000; border-left-style:solid; border-left-width:0.75pt; border-right-color:#393939000; border-right-style:solid; border-right-width:0.75pt; border-top-color:#393939000; border-top-style:solid; border-top-width:0.75pt; padding-left:5.03pt; padding-right:5.03pt; vertical-align:middle; width:106.15pt"><p style="margin:0pt; orphans:0; text-align:center; widows:0"><span style="font-family:宋体; font-size:12pt">
	      <textarea <c:if test="${msg == 'detail' }">disabled </c:if> rows="2" cols="20" style='color: #393939;'  name='CEN_GENE_MGR_CFM'>${pd.CEN_GENE_MGR_CFM}</textarea></span></p></td>
	     </tr>
	     <tr style="height:25.85pt">
	      <td colspan="6" style="border-bottom-color:#393939000; border-bottom-style:solid; border-bottom-width:0.75pt; border-left-color:#393939000; border-left-style:solid; border-left-width:0.75pt; border-right-color:#393939000; border-right-style:solid; border-right-width:0.75pt; border-top-color:#393939000; border-top-style:solid; border-top-width:1.5pt; padding-left:5.03pt; padding-right:5.03pt; vertical-align:middle; width:484.2pt"><p style="margin:0pt 5.65pt 0pt 0pt; orphans:0; text-align:center; widows:0"><span style="font-family:宋体; font-size:12pt">验收情况（请购部门填写）</span></p></td>
	     </tr>
	     <tr style="height:105.95pt">
	      <td style="border-bottom-color:#393939000; border-bottom-style:solid; border-bottom-width:1.5pt; border-left-color:#393939000; border-left-style:solid; border-left-width:0.75pt; border-right-color:#393939000; border-right-style:solid; border-right-width:0.75pt; border-top-color:#393939000; border-top-style:solid; border-top-width:0.75pt; padding-left:5.03pt; padding-right:5.03pt; vertical-align:middle; width:34.45pt"><p style="margin:0pt; orphans:0; text-align:center; widows:0"><span style="font-family:宋体; font-size:12pt">按照设备实际情况选择</span></p></td>
	      <td colspan="5" style="border-bottom-color:#393939000; border-bottom-style:solid; border-bottom-width:1.5pt; border-left-color:#393939000; border-left-style:solid; border-left-width:0.75pt; border-right-color:#393939000; border-right-style:solid; border-right-width:0.75pt; border-top-color:#393939000; border-top-style:solid; border-top-width:0.75pt; padding-left:5.03pt; padding-right:5.03pt; vertical-align:top; width:438.95pt"><p style="margin:0pt 5.65pt 0pt 0pt; orphans:0; text-align:justify; widows:0">
	      	<span style="font-family:宋体; font-size:12pt">物资质量是否符合要求？</span>
	      	<span style="padding-left: 188px;font-family:宋体; font-size:12pt">
	      	<input type="radio" <c:if test="${msg == 'detail' }">disabled </c:if> name="IS_MATE_QUALITY" value="1" <c:if test="${pd.IS_MATE_QUALITY == '1' }">checked </c:if> /> 是&nbsp;&nbsp; <input type="radio" <c:if test="${msg == 'detail' }">disabled </c:if> name="IS_MATE_QUALITY" value="2" <c:if test="${pd.IS_MATE_QUALITY == '2' }">checked </c:if>/> 否</span></p><p style="margin:0pt; orphans:0; text-align:justify; widows:0">
	      	<span style="font-family:宋体; font-size:12pt">物资交付日期是否符合要求？</span>
	      	<span style="padding-left: 155px;font-family:宋体; font-size:12pt">
	      	<input type="radio" <c:if test="${msg == 'detail' }">disabled </c:if> name="IS_MATE_DELI_DATE" value="1" <c:if test="${pd.IS_MATE_DELI_DATE == '1' }">checked </c:if>/> 是&nbsp;&nbsp; <input type="radio" <c:if test="${msg == 'detail' }">disabled </c:if> name="IS_MATE_DELI_DATE" value="2" <c:if test="${pd.IS_MATE_DELI_DATE == '2' }">checked </c:if>/> 否</span></p><p style="margin:0pt; orphans:0; text-align:justify; widows:0">
	      	<span style="font-family:宋体; font-size:12pt">验收综合评分：
	      	&nbsp;<input type="radio" <c:if test="${msg == 'detail' }">disabled </c:if> name="ACCEPT_COM_SCORE" <c:if test="${pd.ACCEPT_COM_SCORE == '1' }">checked </c:if> value="1"/> 优&nbsp;
	      	&nbsp;<input type="radio" <c:if test="${msg == 'detail' }">disabled </c:if> name="ACCEPT_COM_SCORE" <c:if test="${pd.ACCEPT_COM_SCORE == '2' }">checked </c:if> value="2"/> 良&nbsp;
	      	&nbsp;<input type="radio" <c:if test="${msg == 'detail' }">disabled </c:if> name="ACCEPT_COM_SCORE" <c:if test="${pd.ACCEPT_COM_SCORE == '3' }">checked </c:if> value="3"/> 中&nbsp;
	      	&nbsp;<input type="radio" <c:if test="${msg == 'detail' }">disabled </c:if> name="ACCEPT_COM_SCORE" <c:if test="${pd.ACCEPT_COM_SCORE == '4' }">checked </c:if> value="4"/> 差&nbsp;
	      	&nbsp;<input type="radio" <c:if test="${msg == 'detail' }">disabled </c:if> name="ACCEPT_COM_SCORE" <c:if test="${pd.ACCEPT_COM_SCORE == '5' }">checked </c:if> value="5"/> 很差&nbsp; </span></p>
	      	<p style="margin:0pt; orphans:0; text-align:justify; widows:0">
	      	<span style="font-family:宋体; font-size:12pt">（选中及以下时请写出原因，以便督促供应商进行改善）&nbsp; </span></p>
	      	<textarea <c:if test="${msg == 'detail' }">disabled </c:if> rows="2" cols="55" style='color: #393939;'  name='CEN_GENE_MGR_CFM'>${pd.CEN_GENE_MGR_CFM}</textarea>
	      	<span style="margin-bottom:10px">
	      	<label>验收人：</label>
	      	<input type="text" <c:if test="${msg == 'detail' }">disabled </c:if> value="${pd.RECEIVER}" name='RECEIVER' style='color: #393939;width: 140px;' />
	      	</span>
	      	</td>
	     </tr>
	     <tr style="height:0pt">
	      <td style="width:45.25pt; border:none"></td>
	      <td style="width:71.95pt; border:none"></td>
	      <td style="width:137.95pt; border:none"></td>
	      <td style="width:50.95pt; border:none"></td>
	      <td style="width:71.95pt; border:none"></td>
	      <td style="width:116.95pt; border:none"></td>
	     </tr>
	    </tbody>
	   </table>
		</div>
		<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
	</form>
    <p style="margin:0pt; orphans:0; widows:0"><span style="font-family:仿宋; font-size:12pt">注：日常耗用品原则上全部入隆昌路物资库</span></p>
	<c:if test="${msg != 'detail' }">
		<div style="magin:20px;text-align: center;">
			<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
			<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
		</div>
	</c:if>
		
  </div>
					</div>
					<!-- /.col -->
				</div>
				<!-- /.row -->
			</div>
			<!-- /.page-content -->
		</div>
	</div>
	<!-- /.main-content -->
</div>
<!-- /.main-container -->


	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script type="text/javascript">
		$(top.hangge());
		//保存
		function save(){
			if($("#EMP_ID").val()==""){
				$("#EMP_ID").tips({
					side:3,
		            msg:'请输入员工编号',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#EMP_ID").focus();
			return false;
			}
			if($("#EMP_NAME").val()==""){
				$("#EMP_NAME").tips({
					side:3,
		            msg:'请输入员工姓名',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#EMP_NAME").focus();
			return false;
			}
			if($("#DEPARTMENT").val()==""){
				$("#DEPARTMENT").tips({
					side:3,
		            msg:'请输入所属部门',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#DEPARTMENT").focus();
			return false;
			}
			if($("#POST").val()==""){
				$("#POST").tips({
					side:3,
		            msg:'请输入职务',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#POST").focus();
			return false;
			}
			if($("#APPLY_REASON").val()==""){
				$("#APPLY_REASON").tips({
					side:3,
		            msg:'请输入申请原因',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#APPLY_REASON").focus();
			return false;
			}
			if($("#USE_REASON").val()==""){
				$("#USE_REASON").tips({
					side:3,
		            msg:'请输入物资使用说明',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#USE_REASON").focus();
			return false;
			}
			if($("#BUDGET_AMOUNT").val()==""){
				$("#BUDGET_AMOUNT").tips({
					side:3,
		            msg:'请输入预算金额',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#BUDGET_AMOUNT").focus();
			return false;
			}
			if($("#EXPECT_DELI_DATE").val()==""){
				$("#EXPECT_DELI_DATE").tips({
					side:3,
		            msg:'请输入期望交付日期',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#EXPECT_DELI_DATE").focus();
			return false;
			}
			if($("#DELI_ADDRESS").val()==""){
				$("#DELI_ADDRESS").tips({
					side:3,
		            msg:'请输入交付地点',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#DELI_ADDRESS").focus();
			return false;
			}
			if($("#MANAGER_CONFIRM").val()==""){
				$("#MANAGER_CONFIRM").tips({
					side:3,
		            msg:'请输入申请部门经理确认',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#MANAGER_CONFIRM").focus();
			return false;
			}
			if($("#GENERAL_MGR_CFM").val()==""){
				$("#GENERAL_MGR_CFM").tips({
					side:3,
		            msg:'请输入申请部门总经理确认',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#GENERAL_MGR_CFM").focus();
			return false;
			}
			if($("#ESTI_AMOUNT").val()==""){
				$("#ESTI_AMOUNT").tips({
					side:3,
		            msg:'请输入预估金额',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ESTI_AMOUNT").focus();
			return false;
			}
			if($("#ESTI_DELI_DATE").val()==""){
				$("#ESTI_DELI_DATE").tips({
					side:3,
		            msg:'请输入预计交付时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ESTI_DELI_DATE").focus();
			return false;
			}
			if($("#PUR_DEPART_OPINION").val()==""){
				$("#PUR_DEPART_OPINION").tips({
					side:3,
		            msg:'请输入采购部门意见',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PUR_DEPART_OPINION").focus();
			return false;
			}
			if($("#OPERATOR").val()==""){
				$("#OPERATOR").tips({
					side:3,
		            msg:'请输入经办人',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#OPERATOR").focus();
			return false;
			}
			if($("#MATPUR_MGR_OPINION").val()==""){
				$("#MATPUR_MGR_OPINION").tips({
					side:3,
		            msg:'请输入物料采购部经理意见',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#MATPUR_MGR_OPINION").focus();
			return false;
			}
			if($("#CEN_GENE_MGR_CFM").val()==""){
				$("#CEN_GENE_MGR_CFM").tips({
					side:3,
		            msg:'请输入综合管理中心总经理意见',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CEN_GENE_MGR_CFM").focus();
			return false;
			}
			if($("#IS_MATE_QUALITY").val()==""){
				$("#IS_MATE_QUALITY").tips({
					side:3,
		            msg:'请输入物资质量是否达标',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#IS_MATE_QUALITY").focus();
			return false;
			}
			if($("#IS_MATE_DELI_DATE").val()==""){
				$("#IS_MATE_DELI_DATE").tips({
					side:3,
		            msg:'请输入物资交付日期是否达标',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#IS_MATE_DELI_DATE").focus();
			return false;
			}
			if($("#ACCEPT_COM_SCORE").val()==""){
				$("#ACCEPT_COM_SCORE").tips({
					side:3,
		            msg:'请输入验收综合评分',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ACCEPT_COM_SCORE").focus();
			return false;
			}
			if($("#SCORE_REASON").val()==""){
				$("#SCORE_REASON").tips({
					side:3,
		            msg:'请输入评分原因',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#SCORE_REASON").focus();
			return false;
			}
			if($("#RECEIVER").val()==""){
				$("#RECEIVER").tips({
					side:3,
		            msg:'请输入验收人',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#RECEIVER").focus();
			return false;
			}
			if($("#CREATE_TIME").val()==""){
				$("#CREATE_TIME").tips({
					side:3,
		            msg:'请输入创建时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CREATE_TIME").focus();
			return false;
			}
			if($("#MODIFY_TIME").val()==""){
				$("#MODIFY_TIME").tips({
					side:3,
		            msg:'请输入修改时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#MODIFY_TIME").focus();
			return false;
			}
			if($("#CREATER").val()==""){
				$("#CREATER").tips({
					side:3,
		            msg:'请输入创建者',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CREATER").focus();
			return false;
			}
			if($("#UPDATER").val()==""){
				$("#UPDATER").tips({
					side:3,
		            msg:'请输入修改者',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#UPDATER").focus();
			return false;
			}
			if($("#year").val()==""){
				$("#year").tips({
					side:3,
		            msg:'请输入年',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#year").focus();
			return false;
			}
			if($("#month").val()==""){
				$("#month").tips({
					side:3,
		            msg:'请输入月',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#month").focus();
			return false;
			}
			if($("#day").val()==""){
				$("#day").tips({
					side:3,
		            msg:'请输入日',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#day").focus();
			return false;
			}
			var APPLY_DATE = $("#year").val()+'-'+$("#month").val()+'-'+$("#day").val();
			if(new Date(Date.parse(APPLY_DATE.replace(/-/g,  "-")))=='Invalid Date'){
				$("#year").tips({
					side:3,
		            msg:'日期格式不对',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#year").focus();
				return false;
			}
			$("#APPLY_DATE").val(APPLY_DATE);
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
		});
		</script>
</body>
</html>