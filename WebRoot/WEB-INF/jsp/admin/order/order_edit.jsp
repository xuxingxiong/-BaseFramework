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
					
					<form action="order/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="ID" id="ID" value="${pd.ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">订单编号:</td>
								<td style="text-align: left;padding-top: 13px;">${pd.ID}</td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">微信账号:</td>
								<td style="text-align: left;padding-top: 13px;">${pd.WECHAT_ID}</td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">订单名称:</td>
								<td style="text-align: left;padding-top: 13px;">${pd.NAME}</td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">下单时间:</td>
								<td style="text-align: left;padding-top: 13px;">${pd.TIME}</td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">订单商品:</td>
								<td style="text-align: left;padding-top: 13px;">
								<c:choose>
								<c:when test="${not empty varList}">
									<c:forEach items="${varList}" var="pd" varStatus="vs">
											${pd.GOODS_NAME}/${pd.UNIT}&nbsp;&nbsp;&nbsp;x&nbsp;${pd.GOODS_NUM}&nbsp;&nbsp;${pd.GOODS_PRICE}<br/>
									</c:forEach>
								</c:when>
								</c:choose>
								</td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">订单状态:</td>
								<c:if test="${pd.STATUS == 0 }">
									<td style="text-align: left;padding-top: 13px;">支付成功</td>
								</c:if>
								<c:if test="${pd.STATUS == 1 }">
									<td style="text-align: left;padding-top: 13px;">支付失败</td>
								</c:if>
								<c:if test="${pd.STATUS == 2 }">
									<td style="text-align: left;padding-top: 13px;">尚未支付</td>
								</c:if>
							</tr>
							<!-- <tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">店铺编号:</td>
								<td><input type="text" name="STORE_ID" id="STORE_ID" value="${pd.STORE_ID}" maxlength="32" placeholder="这里输入店铺编号" title="店铺编号" style="width:98%;"/></td>
							</tr> -->
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">店铺名称:</td>
								<td style="text-align: left;padding-top: 13px;">${pd.STORE_NAME}</td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">订单合计:</td>
								<td style="text-align: left;padding-top: 13px;">${pd.COUNT}</td>
							</tr>
							<!-- <tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">创建时间:</td>
								<td><input class="span10 date-picker" name="CREATE_TIME" id="CREATE_TIME" value="${pd.CREATE_TIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="创建时间" title="创建时间" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">修改时间:</td>
								<td><input class="span10 date-picker" name="MODIFY_TIME" id="MODIFY_TIME" value="${pd.MODIFY_TIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="修改时间" title="修改时间" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">创建者:</td>
								<td><input type="text" name="CREATER" id="CREATER" value="${pd.CREATER}" maxlength="24" placeholder="这里输入创建者" title="创建者" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">修改者:</td>
								<td><input type="text" name="UPDATER" id="UPDATER" value="${pd.UPDATER}" maxlength="24" placeholder="这里输入修改者" title="修改者" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="text-align: center;" colspan="10">
									<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
									<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
								</td>
							</tr> -->
						</table>
						</div>
					</form>
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
		
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
		});
		</script>
</body>
</html>