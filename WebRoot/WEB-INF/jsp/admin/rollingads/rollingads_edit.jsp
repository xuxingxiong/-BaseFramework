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
					
					<form action="rollingads/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="ID" id="ROLLINGADS_ID" value="${pd.ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:100px;text-align: right;padding-top: 13px;">滚动广告名称:</td>
								<td><input type="text" name="NAME" id="NAME" value="${pd.NAME}" maxlength="255" placeholder="这里输入滚动广告名称" title="滚动广告名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:100px;text-align: right;padding-top: 13px;">滚动广告说明:</td>
								<td><input type="text" name="DETAILS" id="DETAILS" value="${pd.DETAILS}" maxlength="2000" placeholder="这里输入滚动广告说明" title="滚动广告说明" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:100px;text-align: right;padding-top: 13px;">滚动广告图片:</td>
								<td><img id="imgAD" src="<%=basePath%>uploadFiles/uploadImgs/${pd.PICTURE}" alt="" width="100" 
								style="display: <c:if test="${pd.PICTURE == null }">none</c:if>" /> 
		  							<input type="hidden" name="PICTURE" id="ICON" value="${pd.PICTURE}" /><!-- 图片成功上传后的url -->
		  							<a class="btn btn-mini btn-danger" onclick="chooseImg();">选择图片</a>
	  							</td>
							</tr>
							<tr>
								<td style="width:100px;text-align: right;padding-top: 13px;">显示顺序:</td>
								<td><input type="text" name="DISPLAY_ORDER" id="DISPLAY_ORDER" value="${pd.DISPLAY_ORDER}" maxlength="3" onkeyup= "if(this.value.length==1){this.value = this.value.replace(/[^1-9]/g,'')}else{this.value = this.value.replace(/\D/g,'')}" onafterpaste= "if(this.value.length==1){this.value = this.value.replace(/[^1-9]/g,'0')}else{this.value = this.value.replace(/\D/g,'')}" placeholder="这里输入显示顺序(整数)"  placeholder="这里输入滚动广告显示顺序" title="滚动广告显示顺序" style="width:98%;"/></td>
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
			if($("#NAME").val()==""){
				$("#NAME").tips({
					side:3,
		            msg:'请输入滚动广告名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NAME").focus();
			return false;
			}
			if($("#DETAILS").val()==""){
				$("#DETAILS").tips({
					side:3,
		            msg:'请输入滚动广告说明',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#DETAILS").focus();
			return false;
			}
			if($("#ICON").val()==""){
				$("#ICON").tips({
					side:3,
		            msg:'请选择滚动广告图片',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ICON").focus();
			return false;
			}
			if($("#DISPLAY_ORDER").val()==""){
				$("#DISPLAY_ORDER").tips({
					side:3,
		            msg:'请输入滚动广告显示顺序',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#DISPLAY_ORDER").focus();
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

		// 选择图片
		function chooseImg() {
			top.jzts();
			var diag = new top.Dialog();
			 diag.Drag=false;
			 diag.Title ="选择图片";
			 diag.URL = '<%=basePath%>pictures/listChoose.do?flag='+'rollingads';
			 diag.Width = 800;
			 diag.Height = 600;
			 diag.Modal = false;				//有无遮罩窗口
			 diag.ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
			 };
			 diag.show();
		}
		
		</script>
</body>
</html>