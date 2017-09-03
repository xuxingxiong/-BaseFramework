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
					
					<form action="beautycard/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="ID" id="ID" value="${pd.ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:125px;text-align: right;padding-top: 13px;">卡名:</td>
								<td><input type="text" name="CADR_NAME" id="CADR_NAME" value="${pd.CADR_NAME}" maxlength="255" placeholder="这里输入卡名" title="卡名" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:125px;text-align: right;padding-top: 13px;">最低预充值:</td>
								<td><input type="number" name="MIN_CHARGE" id="MIN_CHARGE" value="${pd.MIN_CHARGE}" maxlength="32" placeholder="这里输入最低预充值" title="最低预充值" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:125px;text-align: right;padding-top: 13px;">赠送:</td>
								<td><input type="number" name="SERVICE_CHARGE" id="SERVICE_CHARGE" value="${pd.SERVICE_CHARGE}" maxlength="32" placeholder="这里输入赠送" title="赠送" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:125px;text-align: right;padding-top: 13px;">折扣:</td>
								<td><input type="number" name="DISCUT" id="DISCUT" value="${pd.DISCUT}" maxlength="32" placeholder="这里输入折扣" title="折扣" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:125px;text-align: right;padding-top: 13px;">护理次数	:</td>
								<td><input type="number" name="CARE_TIMES" id="CARE_TIMES" value="${pd.CARE_TIMES}" maxlength="32" placeholder="这里输入护理次数" title="护理次数	" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:125px;text-align: right;padding-top: 13px;">护理周期:</td>
								<td><input type="number" name="CARE_PERIOD" id="CARE_PERIOD" value="${pd.CARE_PERIOD}" maxlength="32" placeholder="这里输入护理周期" title="护理周期" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:125px;text-align: right;padding-top: 13px;">使用限制:</td>
								<td><input type="text" name="USE_LIMIT" id="USE_LIMIT" value="${pd.USE_LIMIT}" maxlength="2000" placeholder="这里输入使用限制" title="使用限制" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:125px;text-align: right;padding-top: 13px;">备注:</td>
								<td><textarea name="USE_COMMENT" id="USE_COMMENT" rows="4" cols="30" maxlength="2000" placeholder="这里输入备注" title="备注" style="width:98%;">${pd.USE_COMMENT}</textarea></td>
							</tr>
							<tr>
								<td style="width:125px;text-align: right;padding-top: 13px;">贩卖开始时间:</td>
								<td><input class="span10 date-picker" name="SALE_STARTTIME" id="SALE_STARTTIME" value="${pd.SALE_STARTTIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="贩卖开始时间" title="贩卖开始时间" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:125px;text-align: right;padding-top: 13px;">贩卖截止时间:</td>
								<td><input class="span10 date-picker" name="SALE_ENDTIME" id="SALE_ENDTIME" value="${pd.SALE_ENDTIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="贩卖截止时间" title="贩卖截止时间" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:125px;text-align: right;padding-top: 13px;">图片:</td>
								<td>
									<iframe class="beauty_img_iframe" src="<%=basePath%>pictures/goRefImageList.do?id=${pd.IMAGE_ID}&msg=save"></iframe>
									<input type="hidden" name="IMAGE_ID" id="IMAGE_ID" value="${pd.IMAGE_ID}"/>
								</td>
							</tr>
							<tr>
								<td style="text-align: center;" colspan="10">
									<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
									<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
								</td>
							</tr>
						</table>
						</div>
						<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
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
		//保存
		function save(){
			if($("#CADR_NAME").val()==""){
				$("#CADR_NAME").tips({
					side:3,
		            msg:'请输入卡名',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CADR_NAME").focus();
			return false;
			}
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