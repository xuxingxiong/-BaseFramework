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
					
					<form action="contacts/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="contacts_id" id="contacts_id" value="${pd.contacts_id}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">学生ID:</td>
								<td><input type="text" name="user_id" id="user_id" value="${pd.user_id}" maxlength="100" placeholder="这里输入学生ID" title="学生ID" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">老师ID:</td>
								<td><input type="text" name="friend_user_id" id="friend_user_id" value="${pd.friend_user_id}" maxlength="100" placeholder="这里输入老师ID" title="老师ID" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">名字备注:</td>
								<td><input type="text" name="name_note" id="name_note" value="${pd.name_note}" maxlength="50" placeholder="这里输入名字备注" title="名字备注" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">分组ID:</td>
								<td><input type="text" name="contacts_group_id" id="contacts_group_id" value="${pd.contacts_group_id}" maxlength="100" placeholder="这里输入分组ID" title="分组ID" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">图片ID:</td>
								<td><input type="text" name="picture_id" id="picture_id" value="${pd.picture_id}" maxlength="100" placeholder="这里输入图片ID" title="图片ID" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">描述:</td>
								<td><input type="text" name="description" id="description" value="${pd.description}" maxlength="100" placeholder="这里输入描述" title="描述" style="width:98%;"/></td>
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
			if($("#user_id").val()==""){
				$("#user_id").tips({
					side:3,
		            msg:'请输入学生ID',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#user_id").focus();
			return false;
			}
			if($("#friend_user_id").val()==""){
				$("#friend_user_id").tips({
					side:3,
		            msg:'请输入老师ID',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#friend_user_id").focus();
			return false;
			}
			if($("#name_note").val()==""){
				$("#name_note").tips({
					side:3,
		            msg:'请输入名字备注',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#name_note").focus();
			return false;
			}
			if($("#contacts_group_id").val()==""){
				$("#contacts_group_id").tips({
					side:3,
		            msg:'请输入分组ID',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#contacts_group_id").focus();
			return false;
			}
			if($("#picture_id").val()==""){
				$("#picture_id").tips({
					side:3,
		            msg:'请输入图片ID',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#picture_id").focus();
			return false;
			}
			if($("#description").val()==""){
				$("#description").tips({
					side:3,
		            msg:'请输入描述',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#description").focus();
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