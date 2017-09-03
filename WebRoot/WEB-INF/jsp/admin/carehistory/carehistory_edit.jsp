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
	<link rel="stylesheet" href="static/ace/css/bootstrap-timepicker.css" />
	<link rel="stylesheet" href="static/ace/css/datepicker.css" />
	<style type="text/css">
	#table_report .btn{
		margin-right: 10px;
	}
	</style>
</head>
<body class="no-skin">
<!-- /section:basics/navbar.layout -->
<c:if test="${msg=='save' }">
	<div class="main-container " id="main-container">
</c:if>
<c:if test="${msg!='save' }">
	<div class="main-container disable" id="main-container">
</c:if>
	<!-- /section:basics/sidebar -->
	<div class="main-content">
		<div class="main-content-inner">
			<div class="page-content">
				<div class="row">
					<div class="col-xs-12">
					
					<form action="carehistory/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="ID" id="ID" value="${pd.ID}"/>
						<input type="hidden" name="SHOP_ID" id="SHOP_ID" value="001"/>
						<input type="hidden" name="CATE_ITEM_NAME" id="CATE_ITEM_NAME" />
						<input type="hidden" name="IMAGE_ID" id="IMAGE_ID" value="${pd.IMAGE_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:200px;text-align: right;padding-top: 13px;">客户名称:</td>
								<td id="SELECT_CUSTOMER_ID">
								<c:if test="${msg!='save' }">
									<input type="text" name="CUSTOMER_NAME" id="CUSTOMER_NAME" value="${pd.CUSTOMER_NAME}" maxlength="128" style="width:98%;"/>
								</c:if>
							<c:if test="${msg=='save' }">
								<input type="hidden" name="CUSTOMER_NAME" id="CUSTOMER_NAME" value="${pd.CUSTOMER_NAME}" maxlength="128" style="width:98%;"/>
								<select class="inputcombo form-control" name="CUSTOMER_ID" id="CUSTOMER_ID" data-placeholder="请选择客户" style="vertical-align:top;width:98%;" >
								<option value="" selected>请选择</option>
								<c:forEach items="${customerList}" var="customer">
									<c:if test="${customer.CUSTOMER_ID==pd.CUSTOMER_ID}">
									<option  value="${customer.CUSTOMER_ID }" selected="selected">${customer.CUSTOMER_NAME}</option>
									</c:if>
									<c:if test="${customer.CUSTOMER_ID!=pd.CUSTOMER_ID}">
									<option  value="${customer.CUSTOMER_ID }">${customer.CUSTOMER_NAME}</option>
									</c:if>
									
								</c:forEach>
								</select>
								</c:if>
								</td>
							</tr>
							<tr>
								<td style="width:200px;text-align: right;padding-top: 13px;">护理时间开始:</td>
								<td><input class="span10 date-picker" name="lastStart" id="lastStart"  value="${pd.lastStart}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:48.5%;display:inline-block;" placeholder="开始日期" title="开始日期"/>
								<input class="span10 datetimepicker" name="CARE_DATE_START" id="CARE_DATE_START" value="${pd.CARE_DATE_START}" type="text" readonly="readonly" placeholder="护理时间开始" title="护理时间开始" style="width:49%;display:inline-block;"/></td>
							</tr>
							<tr>
								<td style="width:200px;text-align: right;padding-top: 13px;">护理时间结束:</td>
								<td><input class="span10 date-picker" name="lastEnd" id="lastEnd"  value="${pd.lastEnd}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:48.5%;display:none;" placeholder="结束日期" title="结束日期"/>
								<input class="span10 datetimepicker" name="CATE_DATE_END" id="CATE_DATE_END" value="${pd.CATE_DATE_END}" type="text" readonly="readonly" placeholder="护理时间结束" title="护理时间结束" style="width:49%;display:inline-block;"/></td>
							</tr>
							<tr>
								<td style="width:200px;text-align: right;padding-top: 13px;">技师名称:</td>
								<td><input type="text" name="STAFF_NAME" id="STAFF_NAME" value="${pd.STAFF_NAME}" maxlength="255" placeholder="这里输入技师名称" title="技师名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:200px;text-align: right;padding-top: 13px;">护理项目名称:</td>
								<td id="SELECT_CARE_ITEM_ID">
								<select class="chosen-select form-control" name="CARE_ITEM_ID" id="CARE_ITEM_ID" data-placeholder="请选择护理项目" style="vertical-align:top;width:98%;" onchange = "setCareItemName()" >
								<option value="" selected>请选择</option>
								<c:forEach items="${careItemList}" var="careItem">
										<c:if test="${careItem.CARE_ITEM_ID==pd.CARE_ITEM_ID}">
											<option id="${careItem.CARE_ITEM_ID }" value="${careItem.CARE_ITEM_ID }" selected="selected">${careItem.CARE_ITEM_NAME}</option>
										</c:if>
										<c:if test="${careItem.CARE_ITEM_ID!=pd.CARE_ITEM_ID}">
											<option id="${careItem.CARE_ITEM_ID }" value="${careItem.CARE_ITEM_ID }">${careItem.CARE_ITEM_NAME}</option>
										</c:if>
								</c:forEach>
								</select>
								</td>
							</tr>
							<tr>
								<td style="width:200px;text-align: right;padding-top: 13px;">护理店店名:</td>
								<td><input type="text" name="SHOP_NAME" id="SHOP_NAME" value="苏宁慧谷店" maxlength="128" readonly="readonly" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:200px;text-align: right;padding-top: 13px;">单次护理费用(原价):</td>
								<td><input type="text" name="PRICE_ORI" id="PRICE_ORI" value="${pd.PRICE_ORI}" maxlength="128" placeholder="这里输入单次护理费用(原价)" title="单次护理费用(原价)" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:200px;text-align: right;padding-top: 13px;">单次护理费用(折后价):</td>
								<td><input type="text" name="PRICE_DISCUT" id="PRICE_DISCUT" value="${pd.PRICE_DISCUT}" maxlength="4" placeholder="这里输入单次护理费用(折后价)" title="单次护理费用(折后价)" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:200px;text-align: right;padding-top: 13px;">结算类型:</td>
								<td id="SELECT_SETTLE_TYPE">
									<select class="chosen-select form-control" name="SETTLE_TYPE" id="SETTLE_TYPE" data-placeholder="请选择结算类型" style="vertical-align:top;width:98%;" >
										<option value="" selected>请选择</option>
										<option value="1" <c:if test="${pd.SETTLE_TYPE=='1'}">selected="selected"</c:if>>非会员卡</option>
										<option value="2" <c:if test="${pd.SETTLE_TYPE=='2'}">selected="selected"</c:if>>会员卡</option>
									</select>
								</td>
							</tr>
							<tr>
								<td style="width:200px;text-align: right;padding-top: 13px;">本次赠送产品1:</td>
								<td id="SELECT_PRESENT1">
								<select class="chosen-select form-control" name="PRESENT1" id="PRESENT1" data-placeholder="请选择本次赠送产品1" style="vertical-align:top;width:98%;" >
								<option value="" selected>请选择</option>
								<c:forEach items="${presentList1}" var="present1">
									<option id="${present1.PRESENT_NAME }" value="${present1.PRESENT_NAME }" >${present1.PRESENT_NAME}</option>
								</c:forEach>
								</select>
								</td>
							</tr>
							<tr>
								<td style="width:200px;text-align: right;padding-top: 13px;">本次赠送产品2:</td>
								<td id="SELECT_PRESENT2">
								<select class="chosen-select form-control" name="PRESENT2" id="PRESENT2" data-placeholder="请选择本次赠送产品2" style="vertical-align:top;width:98%;" >
								<option value="" selected>请选择</option>
								<c:forEach items="${presentList2}" var="present2">
									<option id="${present2.PRESENT_NAME }" value="${present2.PRESENT_NAME }" >${present2.PRESENT_NAME}</option>
								</c:forEach>
								</select>
								</td>
							</tr>
							<tr>
								<td style="width:200px;text-align: right;padding-top: 13px;">本次赠送产品（自由填写）:</td>
								<td><input type="text" name="PRESENTFREE" id="PRESENTFREE" value="${pd.PRESENTFREE}" maxlength="255" placeholder="这里输入本次赠送产品（自由填写）" title="本次赠送产品（自由填写）" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:200px;text-align: right;padding-top: 13px;">护理图片:</td>
								<td><iframe class="beauty_img_iframe" src="<%=basePath%>pictures/goRefImageList.do?id=${pd.IMAGE_ID}&msg=${msg}"></iframe>
								</td>
							</tr>
							<c:if test="${msg=='save' }">
							<tr>
								<td style="text-align: center;" colspan="10">
									<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
									<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
								</td>
							</tr>
							</c:if>
							<c:if test="${msg!='save' }">
							<tr>
								<td style="text-align: center;" colspan="10">
									<c:if test="${QX.del == 1 }">
									<a class="btn btn-mini btn-danger" onclick="del('${pd.ID}');">删除</a>
									</c:if>
									<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">关闭</a>
								</td>
							</tr>
							</c:if>
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
	<!-- 删除时确认窗口 -->
	<script src="static/ace/js/bootbox.js"></script>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<script src="static/ace/js/date-time/bootstrap-timepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script type="text/javascript">
		$(top.hangge());
		// 选择图片
		function chooseImg() {
			top.jzts();
			var diag = new top.Dialog();
			 diag.Drag=false;
			 diag.Title ="选择图片";
			 diag.URL = '<%=basePath%>pictures/goRefAdd.do';
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
		
		//保存
		function save(){
			if($("#CUSTOMER_NAME").val()==""){
				$("#SELECT_CUSTOMER_ID").tips({
					side:3,
		            msg:'请选择客户',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CUSTOMER_ID").focus();
			return false;
			}
			if($("#lastStart").val()==""){
				$("#lastStart").tips({
					side:3,
		            msg:'请输入护理日期开始',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#lastStart").focus();
			return false;
			}
			$("#lastEnd").val($("#lastStart").val());
			if($("#CARE_DATE_START").val()==""){
				$("#CARE_DATE_START").tips({
					side:3,
		            msg:'请输入护理时间开始',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CARE_DATE_START").focus();
			return false;
			}
			if($("#CATE_DATE_END").val()==""){
				$("#CATE_DATE_END").tips({
					side:3,
		            msg:'请输入护理时间结束',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CATE_DATE_END").focus();
			return false;
			}
			var lastStart = $("#lastStart").val();
			var lastEnd = $("#lastEnd").val();
			if(lastStart>lastEnd){
				$("#lastStart").tips({
					side:3,
		            msg:'护理日期开始不得大于护理日期结束',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#lastStart").focus();
				return false;
			}
			if(lastStart=lastEnd){
				var CARE_DATE_START = $("#CARE_DATE_START").val();
				var CATE_DATE_END = $("#CATE_DATE_END").val();
				if(CARE_DATE_START.length!=5){
					CARE_DATE_START = '0'+CARE_DATE_START;
				}
				if(CATE_DATE_END.length!=5){
					CATE_DATE_END = '0'+CATE_DATE_END;
				}
				if(CARE_DATE_START>CATE_DATE_END){
					$("#CARE_DATE_START").tips({
						side:3,
			            msg:'护理时间开始不得大于护理时间结束',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#CARE_DATE_START").focus();
					return false;
				}
			}
			if($("#STAFF_NAME").val()==""){
				$("#STAFF_NAME").tips({
					side:3,
		            msg:'请输入技师名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#STAFF_NAME").focus();
			return false;
			}
			if($("#CATE_ITEM_ID").val()==""){
				$("#SELECT_CARE_ITEM_ID").tips({
					side:3,
		            msg:'请选择护理项目',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CATE_ITEM_ID").focus();
			return false;
			}
			if($("#SHOP_NAME").val()==""){
				$("#SHOP_NAME").tips({
					side:3,
		            msg:'请输入护理店店名',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#SHOP_NAME").focus();
			return false;
			}
			if($("#PRICE_ORI").val()==""){
				$("#PRICE_ORI").tips({
					side:3,
		            msg:'请输入单次护理费用(原价)',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PRICE_ORI").focus();
			return false;
			}
			if($("#PRICE_DISCUT").val()==""){
				$("#PRICE_DISCUT").tips({
					side:3,
		            msg:'请输入单次护理费用(折后价)',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PRICE_DISCUT").focus();
			return false;
			}
			if($("#SETTLE_TYPE").val()==""){
				$("#SELECT_SETTLE_TYPE").tips({
					side:3,
		            msg:'请选择结算类型',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#SETTLE_TYPE").focus();
			return false;
			}
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
		// 设置项目名称
		function setCareItemName(){
			$('#CATE_ITEM_NAME').val($('#SELECT_CARE_ITEM_ID option:selected').text());
		}
		//删除
		function del(Id){
			bootbox.confirm("确定要删除吗?", function(result) {
				if(result) {
					top.jzts();
					var url = "<%=basePath%>carehistory/delete.do?ID="+Id+"&tm="+new Date().getTime();
					$("#Form").attr("action",url);

					$("#Form").submit();
					$("#zhongxin").hide();
					$("#zhongxin2").show();
				}
			});
		}
		$(function() {
			$('.disable *').prop("disabled",true);
			//时间框
			$('.datetimepicker').timepicker({showMeridian:false});
			$('.date-picker').datepicker({
				autoclose: true,
				todayHighlight: true,
				todayBtn: true
			});
			$("#CUSTOMER_ID").change(function(){
				$("#CUSTOMER_NAME").val($("#CUSTOMER_ID").parent().find('.combo-input.text-input').val());
			});
			$("#CUSTOMER_ID").parent().find('.combo-input.text-input').change(function(){
				$("#CUSTOMER_NAME").val($("#CUSTOMER_ID").parent().find('.combo-input.text-input').val());
			});
		});
		</script>
</body>
</html>