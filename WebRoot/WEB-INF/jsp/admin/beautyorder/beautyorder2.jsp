<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />
<!-- jsp文件头和头部 -->
<%@ include file="../../system/index/top.jsp"%>

<style type="text/css">
#dialog-add, #dialog-message, #dialog-comment {
	width: 100%;
	height: 100%;
	position: fixed;
	top: 0px;
	z-index: 10000;
	display: none;
}

.commitopacity {
	position: absolute;
	width: 100%;
	height: 500px;
	background: #7f7f7f;
	filter: alpha(opacity = 50);
	-moz-opacity: 0.5;
	-khtml-opacity: 0.5;
	opacity: 0.5;
	top: 0px;
	z-index: 99999;
}

.commitbox {
	width: 95%;
	padding-left: 42px;
	padding-top: 69px;
	position: absolute;
	top: 0px;
	z-index: 99999;
}

.commitbox_inner {
	width: 96%;
	height: 180px;
	margin: 6px auto;
	background: #efefef;
	border-radius: 5px;
}

.commitbox_top {
	width: 100%;
	height: 180px;
	margin-bottom: 10px;
	padding-top: 10px;
	background: #FFF;
	border-radius: 5px;
	box-shadow: 1px 1px 3px #e8e8e8;
}

.commitbox_top textarea {
	width: 95%;
	height: 165px;
	display: block;
	margin: 0px auto;
	border: 0px;
}

.commitbox_cen {
	width: 95%;
	height: 40px;
	padding-top: 10px;
}

.commitbox_cen div.left {
	float: left;
	background-size: 15px;
	background-position: 0px 3px;
	padding-left: 18px;
	color: #f77500;
	font-size: 16px;
	line-height: 27px;
}

.commitbox_cen div.left img {
	width: 30px;
}

.commitbox_cen div.right {
	float: right;
	margin-top: 7px;
}

.commitbox_cen div.right span {
	cursor: pointer;
}

.commitbox_cen div.right span.save {
	border: solid 1px #c7c7c7;
	background: #6FB3E0;
	border-radius: 3px;
	color: #FFF;
	padding: 5px 10px;
}

.commitbox_cen div.right span.quxiao {
	border: solid 1px #f77400;
	background: #f77400;
	border-radius: 3px;
	color: #FFF;
	padding: 4px 9px;
}

#labelTag {
	padding-top: 0px;
}

#spanTag {
	height: 30px;
	line-height: 25px;
}

</style>
</head>
<body class="no-skin">
	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<!-- 添加属性  -->
			<input type="hidden" name="msgIndex" id="msgIndex" value="" /> 
			<div id="dialog-add">
				<div class="commitopacity"></div>
				<div class="commitbox">
					<div class="commitbox_inner">
						<div class="commitbox_top">
							<br />
							<table>
								<tr height="42px;">
									<td style="padding-left: 16px; text-align: right;">销售种类：</td>
									<td style="padding-bottom: 5px;">
									<select name="TYPE" id="TYPE" data-placeholder="请选择" style="vertical-align: top; width: 210px; "
										onchange="selectType(this.value)">
										<option value="">请选择</option>
										<option value="2">产品</option>
										<option value="3">卡</option>
										<option value="4">服务</option>
									</select></td>
									<td style="padding-left: 16px; text-align: right;">商品名称：</td>
									<td style="padding-bottom: 5px;">
									<input type="hidden" name="GOODS_NAME"id="GOODS_NAME">
									<select name="GOODS_ID"id="GOODS_ID" data-placeholder="请选择"
										style="vertical-align: top; width: 210px; "
										onchange="selectGoods(this)">
										<option value="">请选择</option>
									</select></td>
								</tr>
								<tr height="42px;" id="carePrice" style="display: none">
									<td style="padding-left: 16px; text-align: right;">商品价格：</td>
									<td style="padding-bottom: 5px;">
									<select name="SUB_ID"id="SUB_ID" data-placeholder="请选择"
										style="vertical-align: top; width: 210px; "
										onchange="selectCarePrice(this.value)">
										<option value="">请选择</option>
									</select></td>
								</tr>
								<tr height="42px;">
									<td style="padding-left: 16px; text-align: right;">实际售价：</td>
									<td>
										<div class="nav-search">
											<input class="nav-search-input" style="width: 210px;"
												name="PRICE" id="PRICE" type="number" value="" placeholder="实际售价"
												title="实际售价" />
											<input class="nav-search-input" style="width: 210px;" 
												name="PURCHACE_PRICE" id="PURCHACE_PRICE" type="hidden" value="" placeholder="成本价"
												title="成本价" />
										</div>
									</td>
									<td style="padding-left: 16px; text-align: right;">商品数量：</td>
									<td>
										<div class="nav-search">
											<input class="nav-search-input" style="width: 210px;"
												name="GOODS_NUM" id="GOODS_NUM" type="number" value="" placeholder="商品数量"
												title="商品数量" />
										</div>
									</td>
								</tr>
								<tr height="42px;">
									<td colspan="2">
										<div class="nav-search">
											<label style="float:right;padding-left: 5px;margin-bottom: 0px;">
												<input type="checkbox" class="ace" id="discount"><span class="lbl">打折</span>
											</label>
										</div>
									</td>
									<td colspan="2">
										<div class="commitbox_cen">
											<div class="left" id="cityname"></div>
											<div class="right" style="padding-right: 28px;">
												<span class="save" onClick="addGoods()">保存</span>&nbsp;&nbsp;<span
													class="quxiao" onClick="cancel_pl()">取消</span>
											</div>
										</div>
									</td>
								</tr>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div id="zhongxin">
			<!-- /section:basics/navbar.layout -->
			<div class="main-container" id="main-container">
				<!-- /section:basics/sidebar -->
				<div class="main-content">
					<div class="main-content-inner">
						<div class="page-content">
							<div class="hr hr-18 dotted hr-double"></div>
							<div class="row">
								<div class="col-xs-12">

									<input type="hidden" id="DISCUT" value="10">
									<form name="Form" id="Form"
										method="post" class="form-horizontal" role="form">
										<input type="hidden" name="zindex" id="zindex" value="0">
										<input type="hidden" id="count" value="${count}" placeholder="销售总数">
										<input type="hidden" id="type" value="${type}" placeholder="销售种类">
										<input type="hidden" id="orderDetails" value="${orderDetails}" placeholder="销售产品">
										<input type="hidden" name="ID" id="ID" value="${pd.ID}" placeholder="订单ID">
										<div class="col-sm-4">
											<div class="form-group">
												<div class="col-sm-4">
													<a class="btn btn-success btn-sm" id="switchCust" onclick="selectCustType();">切换客户</a>
												</div>
												<label class="col-sm-8 control-label no-padding-right"
													for="form-field-1" id="labelTag" style="text-align: left;"> 
													<span id="spanTag">系统客户</span>
												</label>
											</div>
											<div class="form-group">
												<label class="col-sm-4 control-label no-padding-right"
													for="TO_QQ">QQ：</label>
												<div class="col-sm-8">
													<input type="text" name="TO_QQ" id="TO_QQ" placeholder="QQ"
														class="col-xs-12 col-sm-12" value="${custData.QQ}">
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-4 control-label no-padding-right"
													for="TO_MOBILE">电话号码：</label>
												<div class="col-sm-8">
													<input type="text" name="TO_MOBILE" id="TO_MOBILE"
														placeholder="电话号码" class="col-xs-12 col-sm-12" value="${custData.MOBILE_PHONE}">
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-4 control-label no-padding-right"
													for="TO_ADDRESS">客户地址：</label>
												<div class="col-sm-8">
													<input type="text" name="TO_ADDRESS" id="TO_ADDRESS"
														placeholder="客户地址" class="col-xs-12 col-sm-12" value="${custData.ADDRESS}">
												</div>
											</div>
										</div>
										<div class="col-sm-4">
											<div class="form-group">
												<label class="col-sm-4 control-label no-padding-right"
													for="TO_NAME">客户名字：</label>
												<div class="col-sm-8">
													<input type="text" name="TO_NAME" id="TO_NAME"
														placeholder="客户名字" style="display: none;"
														class="col-xs-12 col-sm-12" value="${custData.USER_NAME}"> 
													<div id="TO_ID_DIV">
														<select class='chosen-select form-control' name="TO_ID" id="TO_ID" data-placeholder="客户名字" style="vertical-align:top;width:200px;" 
															onchange="selectCustomer(this.value)">
															<option value=""></option>
															<c:forEach items="${custList}" var="var">
																<option value="${var.ID}" <c:if test="${custData.ID == var.ID}">selected</c:if> >${var.USER_NAME}</option>
															</c:forEach>
														</select>
													</div>
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-4 control-label no-padding-right"
													for="TO_WECHAT">微信：</label>
												<div class="col-sm-8">
													<input type="text" name="TO_WECHAT" id="TO_WECHAT"
														placeholder="微信" class="col-xs-12 col-sm-12" value="${custData.WECHAT_ID}">
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-4 control-label no-padding-right"
													for="STAFF">销售人：</label>
												<div class="col-sm-8">
													<input type="text" name="STAFF" id="STAFF"
														placeholder="销售人" class="col-xs-12 col-sm-12">
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-4 control-label no-padding-right"
													for="STATUS">订单状态：</label>
												<div class="col-sm-8">
													<select name="STATUS" id="STATUS" data-placeholder="请选择"
														style="vertical-align: top; width: 150px; ">
														<option value="">请选择</option>
														<option value="0">成功</option>
														<option value="1">失败</option>
														<option value="2">未支付</option>
													</select>
												</div>
											</div>
										</div>
										<div class="col-sm-4">
											<div class="form-group">
												<label class="col-sm-4 control-label no-padding-right"
													for="PAY_TYPE">支付种类：</label>
												<div class="col-sm-8">
													<select name="PAY_TYPE" id="PAY_TYPE"
														data-placeholder="请选择"
														style="vertical-align: top; width: 150px; "
														onChange="onloadCard(this.value)">
														<option value="">请选择</option>
														<option value="10">会员卡</option>
														<option value="1">非会员卡</option>
													</select>
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-4 control-label no-padding-right"
													for="PAY_CARD_NO">会员卡号：</label>
												<div class="col-sm-8">
													<select name="PAY_CARD_NO" id="PAY_CARD_NO"
														data-placeholder="请选择" style="vertical-align: top; width: 150px; "
														onChange="selectCard(this.value)">
														<option value="">请选择</option>
													</select>
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-4 control-label no-padding-right"
													for="TAKYUBIN_FEE">快递费用：</label>
												<div class="col-sm-8">
													<input type="number" name="TAKYUBIN_FEE" id="TAKYUBIN_FEE" value="0"
														placeholder="快递费用" class="col-xs-12 col-sm-12">
												</div>
											</div>
										</div>

										<table id="table_report"
											class="table table-striped table-bordered table-hover"
											style="margin-top: 5px;">
											<thead>
												<tr>
													<th class="center" style="width: 50px;">序号</th>
													<th class="center">销售种类</th>
													<th class="center">商品名称</th>
													<th class="center">实际售价</th>
													<th class="center">商品数量</th>
													<th class="center">是否打折</th>
													<th class="center">操作</th>
												</tr>
											</thead>
											<tbody id="fields"></tbody>
										</table>

										<table id="table_report"
											class="table table-striped table-bordered table-hover">
											<tr>
												<td style="text-align: center;" colspan="100"><a
													class="btn btn-app btn-success btn-xs"
													onclick="insertField();"><i
														class="ace-icon glyphicon glyphicon-plus" id="addGoods"></i>新增商品</a> <a
													class="btn btn-app btn-success btn-xs" onclick="save();"
													id="productc"><i
														class="ace-icon fa fa-print bigger-160"></i>保存</a> <a
													class="btn btn-app btn-danger btn-xs"
													onclick="top.Dialog.close();"><i
														class="ace-icon fa fa-reply icon-only"></i>取消</a></td>
											</tr>
										</table>
										
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
		</div>
		<!-- /.main-content -->
	</div>
	<!-- /.main-container -->

	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<script type="text/javascript">
		$(top.hangge());//关闭加载状态
		var basePath = '<%=basePath%>';
		var uri = '';	
		var fieldarray = [];
		var index = 0;
		var carePriceArr = [];
		var discutArr=[];
		var copyArray=[];
		var showPurchacePrice=false;

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
	<script src="static/ace/js/bootbox.js"></script>
	<script src="static/js/myjs/beautyorder.js"></script>
</body>
</html>