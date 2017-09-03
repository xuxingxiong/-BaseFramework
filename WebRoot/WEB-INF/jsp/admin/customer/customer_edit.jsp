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
					
					<input type="hidden" name="HTYPE" id="HTYPE" value="${pd.TYPE}"/>
					<input type="hidden" name="HSEX" id="HSEX" value="${pd.SEX}"/>
					<form action="customer/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="ID" id="ID" value="${pd.ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:20%;text-align: right;padding-top: 13px;">用户名称:</td>
								<td><input type="text" name="USER_NAME" id="USER_NAME" value="${pd.USER_NAME}" maxlength="255" placeholder="这里输入用户名称" title="用户名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">用户类型:</td>
								<td style="vertical-align:top;padding-left:10px;">
								 	<select class="chosen-select form-control" name="TYPE" id="TYPE" data-placeholder="请选择" style="vertical-align:top;width: 120px;">
									<option value="1" selected>固定客户</option>
									<option value="2">体验用户</option>
									<option value="3">购买化妆品用户</option>
									<option value="4">潜在客户</option>
								  	</select>
								</td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">微信号:</td>
								<td><input type="text" name="WECHAT_ID" id="WECHAT_ID" value="${pd.WECHAT_ID}" maxlength="255" placeholder="这里输入微信号" title="微信号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">手机号:</td>
								<td><input type="text" name="MOBILE_PHONE" id="MOBILE_PHONE" value="${pd.MOBILE_PHONE}" maxlength="12" placeholder="这里输入手机号" title="手机号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">电话座机:</td>
								<td><input type="text" name="TEL" id="TEL" value="${pd.TEL}" maxlength="12" placeholder="这里输入电话座机" title="电话座机" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">年龄:</td>
								<td><input type="number" name="AGE" id="AGE" value="${pd.AGE}" maxlength="32" placeholder="这里输入年龄" title="年龄" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">性别:</td>
								<td style="vertical-align:top;padding-left:10px;">
								 	<select class="chosen-select form-control" name="SEX" id="SEX" data-placeholder="请选择性别" style="vertical-align:top;width: 120px;">
									<option value="">请选择</option>
									<option value="1">男</option>
									<option value="2">女</option>
								  	</select>
								</td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">联系地址:</td>
								<td><input type="text" name="ADDRESS" id="ADDRESS" value="${pd.ADDRESS}" maxlength="128" placeholder="这里输入联系地址" title="联系地址" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">电子邮件:</td>
								<td><input type="email" name="EMAIL" id="EMAIL" value="${pd.EMAIL}" maxlength="64" placeholder="这里输入电子邮件" title="电子邮件" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">QQ:</td>
								<td><input type="text" name="QQ" id="QQ" value="${pd.QQ}" maxlength="12" placeholder="这里输入QQ" title="QQ" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">肤质情况:</td>
								<td><textarea name="SKIN_COMENT" id="SKIN_COMENT" rows="4" cols="30" maxlength="2000" placeholder="这里输入肤质情况" title="肤质情况" style="width:98%;">${pd.SKIN_COMENT}</textarea></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">头像:</td>
								<td><img id="imgAD" src="<%=basePath%>uploadFiles/uploadImgs/${pd.PHOTO}" alt="" width="100" style="display: <c:if test="${pd.PHOTO == null }">none</c:if>" /> 
		  							<input type="hidden" name="PHOTO" id="ICON" value="${pd.PHOTO}" /><!-- 图片成功上传后的url -->
		  							<a class="btn btn-mini btn-danger" id="choosePhoto" onclick="chooseImg();">选择图片</a>
									<a class="btn btn-mini btn-danger" onclick="cancelQrcode();">取消</a>
	  							</td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">护肤频率:</td>
								<td><input type="number" name="CARE_RATE" id="CARE_RATE" value="${pd.CARE_RATE}" maxlength="32" placeholder="这里输入护肤频率" title="护肤频率" style="width:98%;"/></td>
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
		
		$("#TYPE option[value='1']").attr("selected",false);
		$("#TYPE option[value='"+$("#HTYPE").val()+"']").attr("selected",true);

		$("#SEX option[value='1']").attr("selected",false);
		$("#SEX option[value='"+$("#HSEX").val()+"']").attr("selected",true);
		
		function cancelQrcode(){
			$("#imgAD").attr("style","display:none");
			$("#ICON").val("");
		}
		
		//保存
		function save(){
			if($("#USER_NAME").val()==""){
				$("#USER_NAME").tips({
					side:3,
		            msg:'请输入用户名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#USER_NAME").focus();
			return false;
			}
			if($("#TYPE").val()==""){
				$("#TYPE").tips({
					side:3,
		            msg:'请选择用户类型',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#TYPE").focus();
			return false;
			}
			
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}

		// 选择图片
		function chooseImg() {
			top.jzts();
			var diag = new top.Dialog();
			 diag.Drag=false;
			 diag.Title ="选择图片";
			 diag.URL = '<%=basePath%>pictures/listChoose.do?flag='+'';
			 diag.Width = 800;
			 diag.Height = 600;
			 diag.Modal = false;			//有无遮罩窗口
			 diag.ShowMaxButton = true;		//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
			 };
			 diag.show();
		}
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
		});
		</script>
</body>
</html>