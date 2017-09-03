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
					
					<form action="label/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="label_id" id="label_id" value="${pd.label_id}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">标签类型:</td>
								<td><input type="text" name="label_type" id="label_type" value="${pd.label_type}" maxlength="10" placeholder="这里输入标签类型" title="标签类型" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">标签名字:</td>
								<td><input type="text" name="label_name" id="label_name" value="${pd.label_name}" maxlength="100" placeholder="这里输入标签名字" title="标签名字" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">父ID:</td>
								<td><input type="text" name="parent_label_id" id="parent_label_id" value="${pd.parent_label_id}" maxlength="100" placeholder="这里输入父ID" title="父ID" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">使用数量:</td>
								<td><input type="number" name="use_count" id="use_count" value="${pd.use_count}" maxlength="32" placeholder="这里输入使用数量" title="使用数量" style="width:98%;"/></td>
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
			if($("#parent_label_id").val()==""){
				$("#parent_label_id").tips({
					side:3,
		            msg:'请输入父ID',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#parent_label_id").focus();
			return false;
			}
			if($("#use_count").val()==""){
				$("#use_count").tips({
					side:3,
		            msg:'请输入使用数量',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#use_count").focus();
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