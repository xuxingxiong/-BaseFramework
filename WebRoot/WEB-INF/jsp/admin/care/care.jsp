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
						<div class="commitbox_top">
							<br />
							<table>
								<tr height="42px;">
									<td style="padding-left: 16px; text-align: right;">服务名称：</td>
									<td style="padding-bottom: 5px;">
										<input class="nav-search-input" style="width: 210px;" 
												name="PRICE_NAME" id="PRICE_NAME" type="text" value="" placeholder="服务名称"
												title="服务名称" />
									</td>
									<td style="padding-left: 16px; text-align: right;">服务英文名称：</td>
									<td>
										<div class="nav-search">
											<input class="nav-search-input" style="width: 210px;" 
												name="PRICE_NAME_EN" id="PRICE_NAME_EN" type="text" value="" placeholder="服务英文名称"
												title="服务英文名称" />
										</div>
									</td>
								</tr>
								<tr height="42px;">
									<td style="padding-left: 16px; text-align: right;">单价（售价）：</td>
									<td>
										<div class="nav-search">
											<input class="nav-search-input" style="width: 210px;"
												name="PRICE" id="PRICE" type="number" value="" placeholder="商品单价（售价）"
												title="单价（售价）" />
										</div>
									</td>
									<td style="padding-left: 16px; text-align: right;">单价（成本价）：</td>
									<td>
										<div class="nav-search">
											<input class="nav-search-input" style="width: 210px;"
												name="PURCHACE_PRICE" id="PURCHACE_PRICE" type="number" value="" placeholder="商品单价（成本价）"
												title="单价（成本价）" />
										</div>
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
							<div class="hr hr-18 dotted hr-double"></div>
							<div class="row">
								<div class="col-xs-12">
									<form>
										<input type="hidden" name="zindex" id="zindex" value="0">
										<input type="hidden" name="ID" id="ID" value="${pd.ID}">
										<table id="table_report" class="table table-striped table-bordered table-hover">
											<tr>
												<td style="width:20%;text-align: right;padding-top: 13px;">服务名称:</td>
												<td><input type="text" name="NAME" id="NAME" value="${pd.NAME}" maxlength="255" placeholder="这里输入服务名称" title="服务名称" style="width:98%;"/></td>
											</tr>
											<tr>
												<td style="width:75px;text-align: right;padding-top: 13px;">服务英文名称:</td>
												<td><input type="text" name="NAME_EN" id="NAME_EN" value="${pd.NAME_EN}" maxlength="255" placeholder="这里输入服务英文名称" title="服务英文名称" style="width:98%;"/></td>
											</tr>
											<tr>
												<td style="width:75px;text-align: right;padding-top: 13px;">功效:</td>
												<td><textarea name="DETAILS" id="DETAILS" rows="5" cols="30" maxlength="2000" placeholder="这里输入功效" title="功效" style="width:98%;">${pd.DETAILS}</textarea></td>
											</tr>
											<tr>
												<td style="width:75px;text-align: right;padding-top: 13px;">流程:</td>
												<td><textarea name="FLOWS" id="FLOWS" rows="4" cols="30" maxlength="2000" placeholder="这里输入流程" title="流程" style="width:98%;">${pd.FLOWS}</textarea></td>
											</tr>
											<tr>
												<td style="width:75px;text-align: right;padding-top: 13px;">时长:</td>
												<td><input type="number" name="TIMER" id="TIMER" value="${pd.TIMER}" maxlength="32" placeholder="这里输入时长" title="时长" style="width:98%;"/></td>
											</tr>
										</table>

										<table id="table_report"
											class="table table-striped table-bordered table-hover"
											style="margin-top: 5px;">
											<thead>
												<tr>
													<th class="center" style="width: 50px;">序号</th>
													<th class="center">服务名称</th>
													<th class="center">服务英文名称</th>
													<th class="center">单价（售价）</th>
													<th class="center">单价（成本价）</th>
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
														<i class="ace-icon glyphicon glyphicon-plus" id="addCarePrice"></i>新增价格</a> 
													<a class="btn btn-app btn-success btn-xs" onclick="save();">
														<i class="ace-icon fa fa-print bigger-160"></i>保存</a> 
													<a class="btn btn-app btn-danger btn-xs" onclick="top.Dialog.close();">
														<i class="ace-icon fa fa-reply icon-only"></i>取消</a>
												</td>
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
	<script type="text/javascript">
		$(top.hangge());//关闭加载状态
		var basePath = '<%=basePath%>';
		var fieldarray = [];
		var index = 0;
	</script>
	<script src="static/js/myjs/care.js"></script>
</body>
</html>