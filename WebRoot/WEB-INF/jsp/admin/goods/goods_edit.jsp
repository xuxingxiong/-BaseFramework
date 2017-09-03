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
					
					<input type="hidden" name="HUNIT" id="HUNIT" value="${pd.UNIT}"/>
					<form action="goods/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="STORE_ID" id="STORE_ID" value="${pd.STORE_ID}">
						<input type="hidden" name="ID" id="ID" value="${pd.ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:100px;text-align: right;padding-top: 13px;">商品名称:</td>
								<td><input type="text" name="NAME" id="NAME" value="${pd.NAME}" maxlength="255" placeholder="这里输入商品名称" title="商品名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:100px;text-align: right;padding-top: 13px;">商品说明:</td>
								<td><input type="text" name="DETAILS" id="DETAILS" value="${pd.DETAILS}" maxlength="2000" placeholder="这里输入商品说明" title="商品说明" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:100px;text-align: right;padding-top: 13px;">商品照片:</td>
								<td><img id="imgAD" src="<%=basePath%>uploadFiles/uploadImgs/${pd.PATH}" alt="" width="100" style="display: <c:if test="${pd.PATH == null }">none</c:if>" /> 
		  							<input type="hidden" name="PATH" id="ICON" value="${pd.PATH}" /><!-- 图片成功上传后的url -->
		  							<a class="btn btn-mini btn-danger" onclick="chooseImg();">选择图片</a>
	  							</td>
							</tr>
							<tr>
								<td style="width:100px;text-align: right;padding-top: 13px;">商品单价(元):</td>
								<td><input type="number" name="PRICE" id="PRICE" value="${pd.PRICE}" maxlength="32" placeholder="这里输入商品单价" title="商品单价" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:100px;text-align: right;padding-top: 13px;">商品单位:</td>
								<td id="selectUnit">
									<select class="chosen-select form-control" name="UNIT" id="UNIT" data-placeholder="请选择分商品单位" style="vertical-align:top;" style="width:98%;" >
										<option id="千克" value="千克" selected>千克</option>
										<option id="克" value="克">克</option>
										<option id="500克" value="500克">500克</option>
										<option id="箱" value="箱">箱</option>
										<option id="袋" value="袋">袋</option>
										<option id="个" value="个">个</option>
										<option id="两" value="两">两</option>
										<option id="斤" value="斤">斤</option>
										<option id="公斤" value="公斤">公斤</option>
									</select>
								</td>
							</tr>
							<tr>
								<td style="width:100px;text-align: right;padding-top: 13px;">商品显示顺序:</td>
								<td><input type="number" name="DISPLAY_ORDER" id="DISPLAY_ORDER" value="${pd.DISPLAY_ORDER}" maxlength="3" onkeyup= "if(this.value.length==1){this.value = this.value.replace(/[^1-9]/g,'')}else{this.value = this.value.replace(/\D/g,'')}" onafterpaste= "if(this.value.length==1){this.value = this.value.replace(/[^1-9]/g,'0')}else{this.value = this.value.replace(/\D/g,'')}" placeholder="这里输入商品显示顺序（整数）" title="商品显示顺序" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:100px;text-align: right;padding-top: 13px;">分类:</td>
								<td id="SELECT_CATEGORY_ID">
								<select class="chosen-select form-control" name="CATEGORY_ID" id="CATEGORY_ID" data-placeholder="请选择分类" style="vertical-align:top;" style="width:98%;" >
								<c:forEach items="${categoryList}" var="category">
									<option id="${category.CATEGORY_ID }" value="${category.CATEGORY_ID }" <c:if test="${category.CATEGORY_ID == pd.CATEGORY_ID }">selected</c:if>>${category.CATEGORY_NAME}</option>
								</c:forEach>
								</select>
								</td>
							</tr>
							<tr>
								<td style="width:100px;text-align: right;padding-top: 13px;">分类一:</td>
								<td id="SELECT_CATEGORY_ID_1">
								<select class="chosen-select form-control" name="CATEGORY_ID_1" id="CATEGORY_ID_1" data-placeholder="请选择分类" style="vertical-align:top;" style="width:98%;" >
								<option></option>
								<c:forEach items="${categoryList}" var="category">
									<option id="${category.CATEGORY_ID }" value="${category.CATEGORY_ID }" <c:if test="${category.CATEGORY_ID == pd.CATEGORY_ID_1 }">selected</c:if>>${category.CATEGORY_NAME}</option>
								</c:forEach>
								</select>
								</td>
							</tr>
							<tr>
								<td style="width:100px;text-align: right;padding-top: 13px;">分类二:</td>
								<td id="SELECT_CATEGORY_ID_2">
								<select class="chosen-select form-control" name="CATEGORY_ID_2" id="CATEGORY_ID_2" data-placeholder="请选择分类" style="vertical-align:top;" style="width:98%;" >
								<option></option>
								<c:forEach items="${categoryList}" var="category">
									<option id="${category.CATEGORY_ID }" value="${category.CATEGORY_ID }" <c:if test="${category.CATEGORY_ID == pd.CATEGORY_ID_2 }">selected</c:if>>${category.CATEGORY_NAME}</option>
								</c:forEach>
								</select>
								</td>
							</tr>
							<tr>
								<td style="text-align: center;" colspan="10">
									<c:if test="${pd.ID ==null}">
										<a class="btn btn-mini btn-primary" onclick="selectGoods();">选择商品</a>
									</c:if>
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

		$("#UNIT option[value='千克']").attr("selected",false);
		$("#UNIT option[value='"+$("#HUNIT").val()+"']").attr("selected",true);
		
		// 选择商品
		function selectGoods(){
			top.jzts();
			var diag = new top.Dialog();
			diag.Drag=false;
			diag.Title ="选择商品";
			diag.URL = '<%=basePath%>goods/list_dialog.do?STORE_ID='+$("#STORE_ID").val();
			diag.Width = 800;
			diag.Height = 600;
			diag.Modal = false;				//有无遮罩窗口
			diag.ShowMaxButton = false;	//最大化按钮
		   	diag.ShowMinButton = false;		//最小化按钮
			diag.CancelEvent = function(){ //关闭事件
				diag.close();
			};
			diag.show();
		}
		
		//保存
		function save(){
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
			if($("#DETAILS").val()==""){
				$("#DETAILS").tips({
					side:3,
		            msg:'请输入商品说明',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#DETAILS").focus();
			return false;
			}
			if($("#PATH").val()==""){
				$("#PATH").tips({
					side:3,
		            msg:'请选择商品照片',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PATH").focus();
			return false;
			}
			if($("#PRICE").val()==""){
				$("#PRICE").tips({
					side:3,
		            msg:'请输入商品单价',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PRICE").focus();
			return false;
			}
			if($("#UNIT").val()==""){
				$("#selectUnit").tips({
					side:3,
		            msg:'请选择商品单位',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#UNIT").focus();
			return false;
			}
			if($("#DISPLAY_ORDER").val()==""){
				$("#DISPLAY_ORDER").tips({
					side:3,
		            msg:'请输入商品显示顺序',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#DISPLAY_ORDER").focus();
			return false;
			}
			if($("#CATEGORY_ID").val()==""){
				$("#SELECT_CATEGORY_ID").tips({
					side:3,
		            msg:'请选择分类',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CATEGORY_ID").focus();
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
			 diag.URL = '<%=basePath%>pictures/listChoose.do?flag='+'goods';
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
		$(function() {
			//下拉框
			if(!ace.vars['touch']) {
				$('.chosen-select').chosen({allow_single_deselect:true}); 
				$(window)
				.off('resize.chosen')
				.on('resize.chosen', function() {
					$('.chosen-select').each(function() {
						 var $this = $(this);
						 $this.next().css({'width': $this.parent().width()});
					});
				}).trigger('resize.chosen');
				$(document).on('settings.ace.chosen', function(e, event_name, event_val) {
					if(event_name != 'sidebar_collapsed') return;
					$('.chosen-select').each(function() {
						 var $this = $(this);
						 $this.next().css({'width': $this.parent().width()});
					});
				});
				$('#chosen-multiple-style .btn').on('click', function(e){
					var target = $(this).find('input[type=radio]');
					var which = parseInt(target.val());
					if(which == 2) $('#form-field-select-4').addClass('tag-input-style');
					 else $('#form-field-select-4').removeClass('tag-input-style');
				});
			}
		});
		</script>
</body>
</html>