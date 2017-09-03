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
					
					<form action="userlabel/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="user_label_id" id="user_label_id" value="${pd.user_label_id}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">标签类型:</td>
								<td><input type="text" name="label_type" id="label_type" value="${pd.label_type}" maxlength="10" placeholder="这里输入标签类型" title="标签类型" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">分数:</td>
								<td><input type="number" name="score" id="score" value="${pd.score}" maxlength="32" placeholder="这里输入分数" title="分数" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">数据类型:</td>
								<td><input type="number" name="data_type" id="data_type" value="${pd.data_type}" maxlength="32" placeholder="这里输入数据类型" title="数据类型" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">标签ID:</td>
								<td><input type="text" name="label_id" id="label_id" value="${pd.label_id}" maxlength="100" placeholder="这里输入标签ID" title="标签ID" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">标签名字:</td>
								<td><input type="text" name="label_name" id="label_name" value="${pd.label_name}" maxlength="100" placeholder="这里输入标签名字" title="标签名字" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">创建时间:</td>
								<td><input class="span10 date-picker" name="create_time" id="create_time" value="${pd.create_time}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="创建时间" title="创建时间" style="width:98%;"/></td>
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
			if($("#label_type").val()==""){
				$("#label_type").tips({
					side:3,
		            msg:'请输入标签类型',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#label_type").focus();
			return false;
			}
			if($("#score").val()==""){
				$("#score").tips({
					side:3,
		            msg:'请输入分数',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#score").focus();
			return false;
			}
			if($("#data_type").val()==""){
				$("#data_type").tips({
					side:3,
		            msg:'请输入数据类型',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#data_type").focus();
			return false;
			}
			if($("#label_id").val()==""){
				$("#label_id").tips({
					side:3,
		            msg:'请输入标签ID',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#label_id").focus();
			return false;
			}
			if($("#label_name").val()==""){
				$("#label_name").tips({
					side:3,
		            msg:'请输入标签名字',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#label_name").focus();
			return false;
			}
			if($("#create_time").val()==""){
				$("#create_time").tips({
					side:3,
		            msg:'请输入创建时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#create_time").focus();
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