<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en" style="position: absolute; width: 2460px;">
<head>
<base href="<%=basePath%>">
<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />
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
						<form action="customer/list.do" method="post" name="Form" id="Form">
						<table style="margin-top:5px;">
							<tr>
								<td>
									<input type="text" name="USER_NAME" id="USER_NAME" placeholder="这里输入用户名称" title="用户名称"/>
								</td>
								<td style="padding-left:2px;">
									<select name="TYPE" id="TYPE" data-placeholder="请选择用户类型"
										style="vertical-align: top; width: 100%; ">
										<option value="">请选择用户类型</option>
										<option value="1">会员</option>
										<option value="2">体验用户</option>
										<option value="4">潜在客户</option>
									</select>
								</td>
								<td>
									<select name="CARD_ID" id="CARD_ID" data-placeholder="卡种" style="vertical-align:top;width:150px;">
									<option value="">请选择卡种</option>
									<c:forEach items="${cardList}" var="card">
										<option id="${card.ID }" value="${card.ID }" >${card.CADR_NAME}</option>
									</c:forEach>
									</select>
								</td>
								<td style="text-align: right;padding-top: 2px;padding-left: 12px;">手机号:</td>
								<td><input type="number" name="MOBILE_PHONE" id="MOBILE_PHONE" maxlength="255" placeholder="这里输入手机号" title="手机号"/></td>
								<c:if test="${QX.cha == 1 }">
								<td style="vertical-align:top;padding-left:2px"><a class="btn btn-light btn-xs" onclick="tosearch();"  title="检索"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
								</c:if>
							</tr>
						</table>
						<!-- 检索  -->
					<div style="overflow: auto; width: 100%;">
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">	
							<thead>
								<tr>
									<th class="center" style="width:35px;">
									<label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label>
									</th>
									<th class="center" style="width:70px;">用户名称</th>
									<th class="center" style="width:70px;">用户类型</th>
									<th class="center" style="width:100px;">店名</th>
									<th class="center" style="width:200px;">微信号</th>
									<th class="center" style="width:100px;">手机号</th>
									<th class="center" style="width:50px;">年龄</th>
									<th class="center" style="width:50px;">性别</th>
									<th class="center" style="width:100px;">生日</th>
									<th class="center" style="width:200px;">联系地址</th>
									<th class="center" style="width:200px;">电子邮件</th>
									<th class="center" style="width:150px;">QQ</th>
									<th class="center" style="width:500px;">肤质情况</th>
									<th class="center" style="width:200px;">头像</th>
									<th class="center" style="width:50px;">护肤<br>频率</th>
									<th class="center" style="width:150px;">卡种</th>
									<th class="center" style="width:150px;">卡号</th>
									<th class="center" style="width:50px;">当前余额</th>
									<th class="center" style="width:50px;">赠送余额</th>
									<th class="center" style="width:20px;">操作</th>
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
											<td>${var.USER_NAME}</td>
											<c:choose>
												<c:when test="${var.TYPE == 1 }">
													<td>会员</td>
												</c:when>
												<c:when test="${var.TYPE == 2 }">
													<td>体验用户</td>
												</c:when>
												<c:when test="${var.TYPE == 4 }">
													<td>潜在客户</td>
												</c:when>
												<c:otherwise>
													<td></td>
												</c:otherwise>
											</c:choose>
											<td class='left'>${var.SHOP_NAME}</td>
											<td>${var.WECHAT_ID}</td>
											<td>${var.MOBILE_PHONE}</td>
											<td>${var.AGE}</td>
											<c:choose>
												<c:when test="${var.SEX == 1 }">
													<td>男</td>
												</c:when>
												<c:when test="${var.SEX == 2 }">
													<td>女</td>
												</c:when>
												<c:otherwise>
													<td></td>
												</c:otherwise>
											</c:choose>
											<td>${var.BIRTHDAY}</td>
											<td class='left'>${var.ADDRESS}</td>
											<td>${var.EMAIL}</td>
											<td>${var.QQ}</td>
											<td class='left'>${var.SKIN_COMENT}</td>
											<td>
												<iframe id="beauty_img_iframe" class="beauty_img_iframe" src="pictures/goRefImageList.do?id=${var.PHOTO}&msg="></iframe>
											</td>
											<td>${var.CARE_RATE}</td>
											<td>${var.CADR_NAME}</td>
											<td>${var.CARD_NO}</td>
											<td>${var.BALANCE}</td>
											<td>${var.SERVICE_BALANCE}</td>
											<td class="center">
												<c:if test="${QX.edit != 1 && QX.del != 1 }">
												<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="无权限"></i></span>
												</c:if>
												<div class="inline pos-rel">
														<button class="btn btn-minier btn-primary dropdown-toggle" data-toggle="dropdown" data-position="auto">
															<i class="ace-icon fa fa-cog icon-only bigger-110"></i>
														</button>
			
														<ul class="dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close">
															<c:if test="${QX.edit == 1 }">
															<li>
																<a style="cursor:pointer;" onclick="edit('${var.ID}');" class="tooltip-success" data-rel="tooltip" title="修改">
																	<span class="green">
																		<i class="ace-icon fa fa-pencil-square-o bigger-120"></i>
																	</span>
																</a>
															</li>
															<li>
																<a style="cursor:pointer;" onclick="goAddCare('${var.ID}');" class="tooltip-success" data-rel="tooltip" title="新增护肤记录">
																	<span class="dark">
																		<i class="ace-icon fa fa-pencil-square-o bigger-120"></i>
																	</span>
																</a>
															</li>
															<li>
																<a style="cursor:pointer;" onclick="goOrder('${var.ID}');" class="tooltip-success" data-rel="tooltip" title="下单">
																	<span class="blue">
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
						
					</div>
						<div class="page-header position-relative">
						<table style="width:100%;">
							<tr>
								<td style="vertical-align:top;">
									<c:if test="${QX.add == 1 }">
									<a class="btn btn-mini btn-success" onclick="add();">新增</a>
									</c:if>
									<c:if test="${QX.del == 1 }">
									<a class="btn btn-mini btn-danger" onclick="makeAll('确定要删除选中的数据吗?');" title="批量删除" ><i class='ace-icon fa fa-trash-o bigger-120'></i></a>
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
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript">
		$(top.hangge());//关闭加载状态
		//检索
		function tosearch(){
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
		
		//新增
		function add(){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增";
			 diag.URL = '<%=basePath%>customer/goAdd.do';
			 diag.Width = 750;
			 diag.Height = 800;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 if('${page.currentPage}' == '0'){
						 top.jzts();
						 setTimeout("self.location=self.location",100);
					 }else{
						 nextPage(${page.currentPage});
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
					var url = "<%=basePath%>customer/delete.do?ID="+Id+"&tm="+new Date().getTime();
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
		
		//修改
		function edit(Id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑";
			 diag.URL = '<%=basePath%>customer/goEdit.do?ID='+Id;
			 diag.Width = 750;
			 diag.Height = 800;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮 
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 nextPage(${page.currentPage});
				}
				diag.close();
			 };
			 diag.show();
		}
				
		//新增护肤记录
		function goAddCare(id){
			top.jzts();
			var diag = new top.Dialog();
			diag.Drag=false;
			diag.Title ="新增护肤记录";
			diag.URL = '<%=basePath%>carehistory/goAddCare.do?CUSTOMER_ID=' + id;
			diag.Width = 800;
			diag.Height = 600;
			diag.Modal = true;				//有无遮罩窗口
			diag. ShowMaxButton = true;		//最大化按钮
			diag.ShowMinButton = true;		//最小化按钮 
			diag.CancelEvent = function(){ 	//关闭事件
				if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 nextPage(${page.currentPage});
				}
				diag.close();
			};
			diag.show();
		}
		
		//下单
		function goOrder(id){
			top.jzts();
			var diag = new top.Dialog();
			diag.Drag=false;
			diag.Title ="添加订单";
			diag.URL = '<%=basePath%>beautyorder/goAdd.do?custId=' + id;
			diag.Width = 800;
			diag.Height = 500;
			diag.Modal = true;				//有无遮罩窗口
			diag. ShowMaxButton = true;		//最大化按钮
			diag.ShowMinButton = true;		//最小化按钮 
			diag.CancelEvent = function(){ 	//关闭事件
				if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 nextPage(${page.currentPage});
				}
				diag.close();
			};
			diag.show();
		}
		
		//批量操作
		function makeAll(msg){
			bootbox.confirm(msg, function(result) {
				if(result) {
					var str = '';
					for(var i=0;i < document.getElementsByName('ids').length;i++){
					  if(document.getElementsByName('ids')[i].checked){
					  	if(str=='') str += document.getElementsByName('ids')[i].value;
					  	else str += ',' + document.getElementsByName('ids')[i].value;
					  }
					}
					if(str==''){
						bootbox.dialog({
							message: "<span class='bigger-110'>您没有选择任何内容!</span>",
							buttons: 			
							{ "button":{ "label":"确定", "className":"btn-sm btn-success"}}
						});
						$("#zcheckbox").tips({
							side:1,
				            msg:'点这里全选',
				            bg:'#AE81FF',
				            time:8
				        });
						return;
					}else{
						if(msg == '确定要删除选中的数据吗?'){
							top.jzts();
							$.ajax({
								type: "POST",
								url: '<%=basePath%>customer/deleteAll.do?tm='+new Date().getTime(),
						    	data: {DATA_IDS:str},
								dataType:'json',
								//beforeSend: validateData,
								cache: false,
								success: function(data){
									if(data.msg == 'fail'){
										alert('系统异常！！！');
									}else{
										 $.each(data.list, function(i, list){
												nextPage(${page.currentPage});
										 });
									}
								}
							});
						}
					}
				}
			});
		};
		
		//导出excel
		function toExcel(){
			window.location.href='<%=basePath%>customer/excel.do';
		}
	</script>


</body>
</html>