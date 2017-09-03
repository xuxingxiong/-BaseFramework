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
					
					<input type="hidden" id="HTYPE" value="${pd.TYPE}"/>
					<input type="hidden" id="HUNIT" value="${pd.UNIT}"/>
					<form action="beautygoods/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="ID" id="ID" value="${pd.ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:25%;text-align: right;padding-top: 13px;">商品种类:</td>
								<td style="vertical-align:top;padding-left:10px;">
								 	<select class="chosen-select form-control" name="TYPE" id="TYPE" data-placeholder="这里输入商品种类" style="vertical-align:top;width: 120px;">
									<option value="1">用于销售的商品 </option>
									<option value="2">赠品，小样</option>
								  	</select>
								</td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">商品名称:</td>
								<td><input type="text" name="NAME" id="NAME" value="${pd.NAME}" maxlength="255" placeholder="这里输入商品名称" title="商品名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">商品说明:</td>
								<td><textarea name="DETAILS" id="DETAILS" rows="4" cols="30" maxlength="2000" placeholder="这里输入商品说明" title="商品说明" style="width:98%;">${pd.DETAILS}</textarea></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">商品单价（售价）:</td>
								<td><input type="text" name="PRICE" id="PRICE" value="${pd.PRICE}" maxlength="12" placeholder="这里输入商品单价（售价）" title="商品单价（售价）" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">商品单位:</td>
								<td style="vertical-align:top;padding-left:10px;">
								 	<select class="chosen-select form-control" name="UNIT" id="UNIT" data-placeholder="这里选择商品单位" style="vertical-align:top;width: 120px;">
									<option value="">请选择</option>
									<option value="1">元</option>
									<option value="2">美元</option>
									<option value="3">日元</option>
								  	</select>
								</td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">商品单价（进价）:</td>
								<td><input type="text" name="PURCHACE_PRICE" id="PURCHACE_PRICE" value="${pd.PURCHACE_PRICE}" maxlength="12" placeholder="这里输入商品单价（进价）" title="商品单价（进价）" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">进货渠道:</td>
								<td><input type="text" name="FROM_CHANNEL" id="FROM_CHANNEL" value="${pd.FROM_CHANNEL}" maxlength="64" placeholder="这里输入进货渠道" title="进货渠道" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">规格:</td>
								<td><input type="text" name="SPEC" id="SPEC" value="${pd.SPEC}" maxlength="32" placeholder="这里输入规格" title="规格" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">存货:</td>
								<td><input type="number" name="STOCK" id="STOCK" value="${pd.STOCK}" maxlength="3" onkeyup= "if(this.value.length==1){this.value = this.value.replace(/[^1-9]/g,'')}else{this.value = this.value.replace(/\D/g,'')}" onafterpaste= "if(this.value.length==1){this.value = this.value.replace(/[^1-9]/g,'0')}else{this.value = this.value.replace(/\D/g,'')}" placeholder="这里输入存货" title="存货" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">推广信息:</td>
								<td><input type="text" name="INFO" id="INFO" value="${pd.INFO}" maxlength="256" placeholder="这里输入推广信息" title="推广信息" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">显示顺序:</td>
								<td><input type="number" name="DISPLAY_ORDER" id="DISPLAY_ORDER" value="${pd.DISPLAY_ORDER}" maxlength="3" onkeyup= "if(this.value.length==1){this.value = this.value.replace(/[^1-9]/g,'')}else{this.value = this.value.replace(/\D/g,'')}" onafterpaste= "if(this.value.length==1){this.value = this.value.replace(/[^1-9]/g,'0')}else{this.value = this.value.replace(/\D/g,'')}" placeholder="这里输入显示顺序（整数）" title="显示顺序" style="width:98%;"/></td>
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

		$("#TYPE option[value='1']").attr("selected",false);
		$("#TYPE option[value='"+$("#HTYPE").val()+"']").attr("selected",true);
		
		$("#UNIT option[value='1']").attr("selected",false);
		$("#UNIT option[value='"+$("#HUNIT").val()+"']").attr("selected",true);
		
		//保存
		function save(){
			if($("#TYPE").val()==""){
				$("#TYPE").tips({
					side:3,
		            msg:'请选择商品种类',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#TYPE").focus();
			return false;
			}
			if($("#NAME").val()==""){
				$("#NAME").tips({
					side:3,
		            msg:'请输入商品名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NAME").focus();
			return false;
			}
			if($("#PRICE").val()==""){
				$("#PRICE").tips({
					side:3,
		            msg:'请输入商品单价（售价）',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PRICE").focus();
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