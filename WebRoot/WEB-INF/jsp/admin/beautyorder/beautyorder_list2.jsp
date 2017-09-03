<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
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
table th{
    white-space: nowrap;
}
</style>
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
						<input type="hidden" id="msgId" value='${msg}' />
						
						<!-- 检索  -->
						<form action="beautyorder/listTwo.do" method="post" name="Form" id="Form">
						<table style="margin-top:5px;">
							<tr>
								<td style="width:10%">
									<div class="nav-search">
									<span class="input-icon">
										<input type="text" placeholder="这里输入关键词" class="nav-search-input" id="nav-search-input" name="keywords" value="${pd.keywords}" autocomplete="off" />
										<i class="ace-icon fa fa-search nav-search-icon"></i>
									</span>
									</div>
								</td>
								<td style="padding-left:2px;width:10%;"><input class="span10 date-picker" name="lastStart" id="lastStart"  value="" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="开始日期" title="开始日期"/></td>
								<td style="padding-left:2px;width:10%;"><input class="span10 date-picker" name="lastEnd" id="lastEnd"  value="" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="结束日期" title="结束日期"/></td>
								<td style="padding-left:2px;width:15%;">
									<select name="STATUS" id="STATUS" data-placeholder="请选择支付状态"
										style="vertical-align: top; width: 100%; ">
										<option value="">请选择支付状态</option>
										<option value="0">成功</option>
										<option value="1">失败</option>
										<option value="2">未支付</option>
									</select>
								</td>
								<td style="padding-left:2px;width:15%;">
									<select name="PAY_TYPE" id="PAY_TYPE"
										data-placeholder="请选择支付方式"
										style="vertical-align: top; width: 100%; ">
										<option value="">请选择支付方式</option>
										<option value="10">会员卡</option>
										<option value="1">非会员卡</option>
									</select>
								</td>
								<td style="padding-left:2px;width:150px;">
									<label style="float:left;padding-left: 5px;">
						                <input name="checkbox1" type="checkbox" class="ace" id="checkbox1"><span class="lbl">产品</span>
						            </label>
						            <label style="float:left;padding-left: 2px;">
						                <input name="checkbox2" type="checkbox" class="ace" id="checkbox2"><span class="lbl">卡</span>
						            </label>
						            <label style="float:left;padding-left: 2px;">
						                <input name="checkbox3" type="checkbox" class="ace" id="checkbox3"><span class="lbl">服务</span>
						            </label>
								</td>
								<td style="vertical-align:top;padding-left:2px;"><a class="btn btn-light btn-xs" onclick="searchs();"  title="检索"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
							</tr>
						</table>
						<label class="col-sm-3 control-label no-padding-right" for="form-field-1" style="width: 100%;text-align:left;font-weight:bolder">总销售额：${countPd.SALE_COUNT!=undefined ? countPd.SALE_COUNT : 0}元</label>
						<!-- 检索  -->
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">	
							<thead>
								<tr>
									<th class="center" style="width:35px;">
									<label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label>
									</th>
									<th class="center" style="width:50px;">序号</th>
									<th class="center">客户名字</th>
									<th class="center">电话号码</th>
									<th class="center">微信</th>
									<th class="center">QQ</th>
									<th class="center">客户地址</th>
									<th class="center">快递费用</th>
									<th class="center">销售人</th>
									<th class="center">订单时间</th>
									<th class="center">订单状态</th>
									<th class="center">支付种类</th>
									<th class="center">会员卡号</th>
									<th class="center">操作</th>
								</tr>
							</thead>
													
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty varList}">
									<c:if test="${QX.cha == 1 }">
									<c:forEach items="${varList}" var="var" varStatus="vs">
										<tr>
											<td class='center'>
												<label class="pos-rel"><input type='checkbox' name='ids' value="${var.ID}" class="ace" /><span class="lbl"></span></label>
											</td>
											<td class='center' style="width: 30px;">${vs.index+1}</td>
											<td class="left">${var.TO_NAME}</td>
											<td class="left">${var.TO_MOBILE}</td>
											<td class="left">${var.TO_WECHAT}</td>
											<td class="left">${var.TO_QQ}</td>
											<td class="left">${var.TO_ADDRESS}</td>
											<td class="left">${var.TAKYUBIN_FEE}</td>
											<td class="left">${var.STAFF}</td>
											<td class="left">${var.SALE_TIME}</td>
											<td class="left">
												${var.STATUS == 0?"成功":""}
												${var.STATUS == 1?"失败":""}
												${var.STATUS == 2?"未支付":""}
											</td>
											<td class="left">
												${var.PAY_TYPE == 10?"会员卡":""}
												${var.PAY_TYPE == 1?"非会员卡":""}
											</td>
											<td class="left">${var.PAY_CARD_NO}</td>
											<td class="left">
												<c:if test="${QX.edit != 1 && QX.del != 1 }">
												<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="无权限"></i></span>
												</c:if>
												<div class="inline pos-rel">
														<button class="btn btn-minier btn-primary dropdown-toggle" data-toggle="dropdown" data-position="auto">
															<i class="ace-icon fa fa-cog icon-only bigger-110"></i>
														</button>
			
														<c:if test="${var.STATUS != 2}">
															<ul class="dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close">
																<c:if test="${QX.edit == 1 }">
																<li>
																	<a style="cursor:pointer;" onclick="info('${var.ID}');" class="tooltip-success" data-rel="tooltip" title="详情">
																		<span class="green">
																			<i class="ace-icon fa fa-pencil-square-o bigger-120"></i>
																		</span>
																	</a>
																</li>
																</c:if>
															</ul>
														</c:if>
														<c:if test="${var.STATUS == 2}">
															<ul class="dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close">
																<c:if test="${QX.edit == 1 }">
																<li>
																	<a style="cursor:pointer;" onclick="edit('${var.ID}');" class="tooltip-success" data-rel="tooltip" title="修改">
																		<span class="green">
																			<i class="ace-icon fa fa-pencil-square-o bigger-120"></i>
																		</span>
																	</a>
																</li>
																</c:if>
																<c:if test="${QX.del == 1 }">
																<li>
																	<a style="cursor:pointer;" onclick="del('${var.ID}');" class="tooltip-error" data-rel="tooltip" title="删除">
																		<span class="red">
																			<i class="ace-icon fa fa-trash-o bigger-120"></i>
																		</span>
																	</a>
																</li>
																</c:if>
															</ul>
														</c:if>
													</div>
											</td>
										</tr>
									
									</c:forEach>
									</c:if>
									<c:if test="${QX.cha == 0 }">
										<tr>
											<td colspan="100" class="center">您无权查看</td>
										</tr>
									</c:if>
								</c:when>
								<c:otherwise>
									<tr class="main_info">
										<td colspan="100" class="center" >没有相关数据</td>
									</tr>
								</c:otherwise>
							</c:choose>
							</tbody>
						</table>
						<div class="page-header position-relative">
						<table style="width:100%;">
							<tr>
								<td style="vertical-align:top;">
									<c:if test="${QX.add == 1 }">
									<a class="btn btn-mini btn-success" onclick="addOrder('add');">添加订单</a>
									</c:if>
								</td>
								<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
							</tr>
						</table>
						</div>
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

		<!-- 返回顶部 -->
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
			<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
		</a>

	</div>
	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- 删除时确认窗口 -->
	<script src="static/ace/js/bootbox.js"></script>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript">
		$(top.hangge());//关闭加载状态
		//检索
		function searchs(){
			top.jzts();
			$("#Form").submit();
		}
		$(function() {			
			if($('#msgId').val()=='fail'){
				alert('系统异常！！！');
			}
			//日期框
			$('.date-picker').datepicker({
				autoclose: true,
				todayHighlight: true
			});
			
			//复选框全选控制
			var active_class = 'active';
			$('#simple-table > thead > tr > th input[type=checkbox]').eq(0).on('click', function(){
				var th_checked = this.checked;//checkbox inside "TH" table header
				$(this).closest('table').find('tbody > tr').each(function(){
					var row = this;
					if(th_checked) $(row).addClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', true);
					else $(row).removeClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', false);
				});
			});
		});
		
		//启动代码生成器
		function addOrder(ID){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="添加订单";
			 diag.URL = '<%=basePath%>beautyorder/goAdd.do?ID='+ID+'&flag=1';
			 diag.Width = 800;
			 diag.Height = 500;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮
			 diag.CancelEvent = function(){ //关闭事件
				if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					if('${page.currentPage}' == '0'){
						 top.jzts();
						 setTimeout("self.location=self.location",100);
					 }else{
						 nextPage("${page.currentPage}");
					 }
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//删除
		function del(Id){
			bootbox.confirm("确定要删除吗?", function(result) {
				if(result) {
					top.jzts();
					var url = "<%=basePath%>beautyorder/delete.do?ID="+Id+"&tm="+new Date().getTime();
					$.get(url,function(data){
						if(data == 'success'){
							nextPage(${page.currentPage});
						}else{
							alert('系统异常！！！');
						}
					});
				}
			});
		}

		//订单信息
		function info(id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="修改订单";
			 diag.URL = '<%=basePath%>beautyorder/goInfo.do?ID='+id+'&flag=1';
			 diag.Width = 800;
			 diag.Height = 500;
			 diag.CancelEvent = function(){ //关闭事件
				if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					top.hangge();
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//启动服务修改
		function edit(id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="修改订单";
			 diag.URL = '<%=basePath%>beautyorder/goEdit.do?ID='+id+'&flag=1';
			 diag.Width = 800;
			 diag.Height = 500;
			 diag.CancelEvent = function(){ //关闭事件
				if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					top.hangge();
				}
				diag.close();
			 };
			 diag.show();
		}
	</script>
</body>
</html>