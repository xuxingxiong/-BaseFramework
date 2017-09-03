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
					
					<form action="contactsmessage/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="contacts_message_id" id="contacts_message_id" value="${pd.contacts_message_id}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">发起人:</td>
								<td><input type="text" name="launch_user_id" id="launch_user_id" value="${pd.launch_user_id}" maxlength="100" placeholder="这里输入发起人" title="发起人" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">接收人:</td>
								<td><input type="text" name="receive_user_id" id="receive_user_id" value="${pd.receive_user_id}" maxlength="100" placeholder="这里输入接收人" title="接收人" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">消息类型:</td>
								<td><input type="text" name="message_type" id="message_type" value="${pd.message_type}" maxlength="5" placeholder="这里输入消息类型" title="消息类型" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">消息文字:</td>
								<td><input type="text" name="message_note" id="message_note" value="${pd.message_note}" maxlength="100" placeholder="这里输入消息文字" title="消息文字" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">消息状态:</td>
								<td><input type="text" name="message_state" id="message_state" value="${pd.message_state}" maxlength="2" placeholder="这里输入消息状态" title="消息状态" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">修改时间:</td>
								<td><input class="span10 date-picker" name="update_time" id="update_time" value="${pd.update_time}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="修改时间" title="修改时间" style="width:98%;"/></td>
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
			if($("#launch_user_id").val()==""){
				$("#launch_user_id").tips({
					side:3,
		            msg:'请输入发起人',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#launch_user_id").focus();
			return false;
			}
			if($("#receive_user_id").val()==""){
				$("#receive_user_id").tips({
					side:3,
		            msg:'请输入接收人',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#receive_user_id").focus();
			return false;
			}
			if($("#message_type").val()==""){
				$("#message_type").tips({
					side:3,
		            msg:'请输入消息类型',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#message_type").focus();
			return false;
			}
			if($("#message_note").val()==""){
				$("#message_note").tips({
					side:3,
		            msg:'请输入消息文字',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#message_note").focus();
			return false;
			}
			if($("#message_state").val()==""){
				$("#message_state").tips({
					side:3,
		            msg:'请输入消息状态',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#message_state").focus();
			return false;
			}
			if($("#update_time").val()==""){
				$("#update_time").tips({
					side:3,
		            msg:'请输入修改时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#update_time").focus();
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