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
					
					<form action="question/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="question_id" id="question_id" value="${pd.question_id}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">用户id:</td>
								<td><input type="text" name="user_id" id="user_id" value="${pd.user_id}" maxlength="100" placeholder="这里输入用户id" title="用户id" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">问答标题:</td>
								<td><input type="text" name="question_title" id="question_title" value="${pd.question_title}" maxlength="100" placeholder="这里输入问答标题" title="问答标题" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">行业:</td>
								<td><input type="text" name="hy_label" id="hy_label" value="${pd.hy_label}" maxlength="100" placeholder="这里输入行业" title="行业" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">方向:</td>
								<td><input type="text" name="fx_label" id="fx_label" value="${pd.fx_label}" maxlength="100" placeholder="这里输入方向" title="方向" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">职能:</td>
								<td><input type="text" name="zn_label" id="zn_label" value="${pd.zn_label}" maxlength="100" placeholder="这里输入职能" title="职能" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">技能:</td>
								<td><input type="text" name="jn_label" id="jn_label" value="${pd.jn_label}" maxlength="100" placeholder="这里输入技能" title="技能" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">价格:</td>
								<td><input type="number" name="question_price" id="question_price" value="${pd.question_price}" maxlength="32" placeholder="这里输入价格" title="价格" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">是否传播:</td>
								<td><input type="text" name="spread" id="spread" value="${pd.spread}" maxlength="10" placeholder="这里输入是否传播" title="是否传播" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">问题状态:</td>
								<td><input type="text" name="question_state" id="question_state" value="${pd.question_state}" maxlength="10" placeholder="这里输入问题状态" title="问题状态" style="width:98%;"/></td>
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
		            msg:'请输入用户id',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#user_id").focus();
			return false;
			}
			if($("#question_title").val()==""){
				$("#question_title").tips({
					side:3,
		            msg:'请输入问答标题',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#question_title").focus();
			return false;
			}
			if($("#hy_label").val()==""){
				$("#hy_label").tips({
					side:3,
		            msg:'请输入行业',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#hy_label").focus();
			return false;
			}
			if($("#fx_label").val()==""){
				$("#fx_label").tips({
					side:3,
		            msg:'请输入方向',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#fx_label").focus();
			return false;
			}
			if($("#zn_label").val()==""){
				$("#zn_label").tips({
					side:3,
		            msg:'请输入职能',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#zn_label").focus();
			return false;
			}
			if($("#jn_label").val()==""){
				$("#jn_label").tips({
					side:3,
		            msg:'请输入技能',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#jn_label").focus();
			return false;
			}
			if($("#question_price").val()==""){
				$("#question_price").tips({
					side:3,
		            msg:'请输入价格',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#question_price").focus();
			return false;
			}
			if($("#spread").val()==""){
				$("#spread").tips({
					side:3,
		            msg:'请输入是否传播',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#spread").focus();
			return false;
			}
			if($("#question_state").val()==""){
				$("#question_state").tips({
					side:3,
		            msg:'请输入问题状态',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#question_state").focus();
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