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
<!-- jsp文件头和头部 -->
<%@ include file="../../system/index/top.jsp"%>
<!-- 日期框 -->
<link rel="stylesheet" href="static/ace/css/datepicker.css" />

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

#spanTag::before {
	height: 30px;
}

#spanTag::after {
	height: 30px;
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
						<div class="commitbox_top" style="width: 100%;height: 260px;">
							<br />
							<table>
								<tr height="42px;">
									<td style="text-align: right;">卡号：</td>
									<td style="padding-bottom: 5px;">
										<input class="nav-search-input" style="width: 210px;" 
												name="CARD_NO" id="CARD_NO" type="text" value="" placeholder="卡号"
												title="卡号" />
									</td>
									<td style="text-align: right;">卡名：</td>
									<td id="SELECT_CARD_ID">
										<input type="hidden" name="CARD_NAME"id="CARD_NAME">
										<select name="CARD_ID"id="CARD_ID" data-placeholder="请选择"
											style="vertical-align: top; width: 210px; "
											onchange="selectCard(this.value)">
											<option value="">请选择</option>
										</select>
									</td>
								</tr>
								<tr height="42px;">
									<td style="text-align: right;">实际充值：</td>
									<td>
										<div class="nav-search">
											<input type="hidden" name="CHARGED" id="CHARGED" value=""/>
											<input maxlength="32" style="width: 210px;" 
												name="CHARGE" id="CHARGE" type="number" value="" placeholder="实际充值"
												title="实际充值" onchange="sumBalance('1')" />
										</div>
									</td>
									<td style="text-align: right;">实际赠送：</td>
									<td>
										<div class="nav-search">
											<input type="hidden" name="SERVICE_CHAGED" id="SERVICE_CHAGED" value=""/>
											<input maxlength="32" style="width: 210px;"
												name="SERVICE_CHAGE" id="SERVICE_CHAGE" type="number" value="" placeholder="实际赠送"
												title="实际赠送" onchange="sumBalance('0')" />
										</div>
									</td>
								</tr>
								<tr height="42px;">
									<td style="text-align: right;">上次充值时间：</td>
									<td>
										<input type="hidden" name="BUY_TIMED" id="BUY_TIMED" value=""/>
										<input class="nav-search-input" style="width: 210px;"
											name="BUY_TIME" id="BUY_TIME" type="text" readonly value="" placeholder="上次充值时间"
											title="上次充值时间" />
									</td>
									<td style="text-align: right;">本卡使用有效期：</td>
									<td>
										<input class="span10 date-picker" name="END_TIME" id="END_TIME" value="" 
											type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="本卡使用有效期" title="本卡使用有效期" 
											style="width: 210px;"/>
									</td>
								</tr>
								<tr height="42px;">
									<td style="text-align: right;">当前余额：</td>
									<td>
									<input type="hidden" name="BALANCED" id="BALANCED" value=""/>
									<input maxlength="32" style="width: 210px;"
											name="BALANCE" id="BALANCE" type="number" readonly value="" placeholder="当前余额"
											title="当前余额" />
									</td>
									<td style="text-align: right;">赠送余额：</td>
									<td>
									<input type="hidden" name="SERVICE_BALANCED" id="SERVICE_BALANCED" value=""/>
									<input maxlength="32" style="width: 210px;"
											name="SERVICE_BALANCE" id="SERVICE_BALANCE" type="number" readonly value="" placeholder="赠送余额"
											title="赠送余额" />
									</td>
								</tr>
								<tr height="42px;">
									<td colspan="4">
										<div class="commitbox_cen">
											<div class="right" style="padding-right: 220px;">
												<span class="save" onClick="saveD()">保存</span>&nbsp;&nbsp;<span
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
							<div class="row">
								<div class="col-xs-12">
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
												<option value="1" selected>会员</option>
												<option value="2">体验用户</option>
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
											<td style="width:75px;text-align: right;padding-top: 13px;">生日：</td>
											<td>
												<input class="span10 date-picker" name="BIRTHDAY" id="BIRTHDAY" value="" 
													type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="生日" title="生日" 
													style="width: 98%;"/>
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
											<td>
												<iframe id="beauty_img_iframe" class="beauty_img_iframe" src="pictures/goRefImageList.do?id=${pd.PHOTO}&msg=save"></iframe>
												<input type="hidden" name="PHOTO" id="PHOTO" value="${pd.PHOTO}"/>
				  							</td>
										</tr>
										<tr>
											<td style="width:75px;text-align: right;padding-top: 13px;">护肤频率:</td>
											<td><input type="number" name="CARE_RATE" id="CARE_RATE" value="${pd.CARE_RATE}" maxlength="32" placeholder="这里输入护肤频率" title="护肤频率" style="width:98%;"/></td>
										</tr>
									</table>
									<table id="table_report"
											class="table table-striped table-bordered table-hover"
											style="margin-top: 5px;">
											<thead>
												<tr>
													<th class="center" style="width: 50px;">序号</th>
													<th class="center">卡号</th>
													<th class="center">卡名</th>
													<th class="center">实际充值</th>
													<th class="center">实际赠送</th>
													<th class="center">当前余额</th>
													<th class="center">赠送余额</th>
													<th class="center">上次充值时间</th>
													<th class="center">本卡使用有效期</th>
													<th class="center">操作</th>
												</tr>
											</thead>
											<tbody id="fields"></tbody>
										</table>

										<table id="table_report"
											class="table table-striped table-bordered table-hover">
											<tr>
												<td style="text-align: center;" colspan="100">
													<a class="btn btn-app btn-success btn-xs" onclick="dialog_open();">
														<i class="ace-icon glyphicon glyphicon-plus" id="addCustomerCard"></i>新增卡</a> 
													<a class="btn btn-app btn-success btn-xs" onclick="save();">
														<i class="ace-icon fa fa-print bigger-160"></i>保存</a> 
													<a class="btn btn-app btn-danger btn-xs" onclick="top.Dialog.close();">
														<i class="ace-icon fa fa-reply icon-only"></i>取消</a>
												</td>
											</tr>
										</table>
									</div>
									<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
								</form>
								<form id="reloadForm" action=""></form>
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

			</div>
		</div>
		<!-- /.main-content -->
	</div>
	<!-- /.main-container -->

	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<script type="text/javascript">
		$(top.hangge());//关闭加载状态
		var basePath = '<%=basePath%>';
		var fieldarray = [];
		var index = 0;
		
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
		});
	</script>
	<script src="static/js/myjs/customer.js"></script>
</body>
</html>