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

									<form name="Form" id="Form"
										method="post" class="form-horizontal" role="form">
										<input type="hidden" name="zindex" id="zindex" value="0">
										<input type="hidden" name="ID" id="ID" value="${pd.ID}" placeholder="订单ID">
										<input type="hidden" name="flag" id="flag" value="${pd.flag}" placeholder="flag">
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
													<input type="text" name="TO_QQ" id="TO_QQ"  readonly="readonly"
														class="col-xs-12 col-sm-12" value="${custData.QQ}">
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-4 control-label no-padding-right"
													for="TO_MOBILE">电话号码：</label>
												<div class="col-sm-8">
													<input type="text" name="TO_MOBILE" id="TO_MOBILE" readonly="readonly"
														 class="col-xs-12 col-sm-12" value="${custData.MOBILE_PHONE}">
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-4 control-label no-padding-right"
													for="TO_ADDRESS">客户地址：</label>
												<div class="col-sm-8">
													<input type="text" name="TO_ADDRESS" id="TO_ADDRESS" readonly="readonly"
														class="col-xs-12 col-sm-12" value="${custData.ADDRESS}">
												</div>
											</div>
										</div>
										<div class="col-sm-4">
											<div class="form-group">
												<label class="col-sm-4 control-label no-padding-right"
													for="TO_NAME">客户名字：</label>
												<div class="col-sm-8">
													<input type="text" name="TO_NAME" id="TO_NAME"
														 readonly="readonly"
														class="col-xs-12 col-sm-12" value="${custData.USER_NAME}"> 
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-4 control-label no-padding-right"
													for="TO_WECHAT">微信：</label>
												<div class="col-sm-8">
													<input type="text" name="TO_WECHAT" id="TO_WECHAT" readonly="readonly"
														 class="col-xs-12 col-sm-12" value="${custData.WECHAT_ID}">
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-4 control-label no-padding-right"
													for="STAFF">销售人：</label>
												<div class="col-sm-8">
													<input type="text" name="STAFF" id="STAFF" readonly="readonly"
														 class="col-xs-12 col-sm-12">
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-4 control-label no-padding-right"
													for="STATUS">订单状态：</label>
												<div class="col-sm-8">
													<input type="text" name="STATUS" id="STATUS" readonly="readonly"
														 class="col-xs-12 col-sm-12">
												</div>
											</div>
										</div>
										<div class="col-sm-4">
											<div class="form-group">
												<label class="col-sm-4 control-label no-padding-right"
													for="PAY_TYPE">支付种类：</label>
												<div class="col-sm-8">
													<input type="text" name="PAY_TYPE" id="PAY_TYPE" readonly="readonly"
														 class="col-xs-12 col-sm-12">
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-4 control-label no-padding-right"
													for="PAY_CARD_NO">会员卡号：</label>
												<div class="col-sm-8">
													<input type="text" name="PAY_CARD_NO" id="PAY_CARD_NO" readonly="readonly"
														class="col-xs-12 col-sm-12">
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-4 control-label no-padding-right"
													for="TAKYUBIN_FEE">快递费用：</label>
												<div class="col-sm-8">
													<input type="number" name="TAKYUBIN_FEE" id="TAKYUBIN_FEE" value="0" readonly="readonly"
														class="col-xs-12 col-sm-12">
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
													<c:if test="${pd.flag == 0}"><th class="center">成本价</th></c:if>
													<th class="center">实际售价</th>
													<th class="center">商品数量</th>
												</tr>
											</thead>
											<tbody id="fields"></tbody>
										</table>

										<table id="table_report"
											class="table table-striped table-bordered table-hover">
											<tr>
												<td style="text-align: center;" colspan="100"><a
													class="btn btn-app btn-danger btn-xs"
													onclick="top.Dialog.close();"><i
														class="ace-icon fa fa-reply icon-only"></i>返回</a></td>
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
		var showPurchacePrice = true;
		debugger
		if($("#flag").val()==1){
			showPurchacePrice = false;
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
	<script src="static/ace/js/bootbox.js"></script>
	<script src="static/js/myjs/orderinfo.js"></script>
</body>
</html>