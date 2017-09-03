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
<html lang="en">
<head>
<base href="<%=basePath%>">
<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />
<!-- jsp文件头和头部 -->
<%@ include file="../../system/index/top.jsp"%>
<!-- 日期框 -->
<link rel="stylesheet" href="static/ace/css/datepicker.css" />
<link rel='stylesheet' href='static/fullcalendar/lib/cupertino/jquery-ui.min.css' />
<link href='static/fullcalendar/fullcalendar.min.css' rel='stylesheet' />
<link href='static/fullcalendar/fullcalendar.print.min.css' rel='stylesheet' media='print' />
<style type="text/css">
#calendar{
width:95%;
margin: 0 auto;
margin-top:10px;
}
.fc-day{
	cursor: pointer;
}
</style>
<script src='static/fullcalendar/lib/moment.min.js'></script>
<script src='static/fullcalendar/fullcalendar.min.js'></script>
<script src='static/fullcalendar/locale/zh-cn.js'></script>
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
						
				<form action="carehistory/list.do" method="post" name="Form" id="Form">
						<input type="hidden" name="ID" id="ID" value="${ID}"/>
					
					<div class="page-header position-relative">
						<table style="width:100%;">
							<tr>
								<td style="vertical-align:top;">
									<c:if test="${QX.add == 1 }">
									<a class="btn btn-mini btn-success" onclick="add(1);">新增记录</a>
									<a class="btn btn-mini btn-success" onclick="add(2);">预约</a>
									</c:if>
								</td>
								<td style="vertical-align:top;display:none;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
								</tr>
						</table>
						</div>
						<div id='calendar'></div>
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
		function add(type){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 if(type==2){
			 diag.Title ="预约";
			 diag.URL = '<%=basePath%>carehistory/goAdd_order.do';
			 }
			 else{
				 diag.Title ="新增记录";
				 diag.URL = '<%=basePath%>carehistory/goAdd.do';
			 }
			 diag.Width = 800;
			 diag.Height = 600;
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
					var url = "<%=basePath%>carehistory/delete.do?ID="+Id+"&tm="+new Date().getTime();
					$.get(url,function(data){
						nextPage(${page.currentPage});
					});
				}
			});
		}
		
		//修改
		function edit(type,Id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 if(type==2){
				 diag.Title ="详细信息_预约";
				 diag.URL = '<%=basePath%>carehistory/goEdit_order.do?ID='+Id;
				 }
				 else{
					 diag.Title ="详细信息_记录";
					 diag.URL = '<%=basePath%>carehistory/goEdit.do?ID='+Id;
				 }
			
			 diag.Width = 800;
			 diag.Height = 600;
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
								url: '<%=basePath%>carehistory/deleteAll.do?tm='+new Date().getTime(),
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
			window.location.href='<%=basePath%>carehistory/excel.do';
		}
		$(document).ready(function() {
			
			$('#calendar').fullCalendar({
				theme: true,
				height:780,
				header: {
					left: 'prevYear,prev,next,nextYear,|,|,today',
					center: 'title',
					right: 'month,agendaWeek,agendaDay,listDay'
				},
				 eventClick: function(calEvent, jsEvent, view) {
					 if(calEvent.TYPE=="1")
						 {
					 		edit(1,calEvent.ID);
						 }
					 else if(calEvent.TYPE=="2")
					 {
						 edit(2,calEvent.ID);
					 }
				    },
				dayClick: function(date, jsEvent, view) {
					$(".fc-day-top[data-date='"+$(this).attr("data-date")+"'] .fc-day-number").click();
			    },

			   /* viewRender:function( view, element ){
			    	CalendarReload(view);
			    },*/
			    events: {
			        url: '<%=basePath%>carehistory/timelist.do'
			    },
				defaultDate: new Date(),
				locale: 'zh-cn',
				buttonIcons: false, // show the prev/next text
				navLinks: true, // can click day/week names to navigate views
				//editable: true,
				eventLimit: true, // allow "more" link when too many events
				loading: function(bool) {
					$('#loading').toggle(bool);
				}
			});
			//CalendarReload($('#calendar').fullCalendar('getView' ));
		});
		/*function CalendarReload(view){
			$('#calendar').fullCalendar({
			   
			});
		}*/
	</script>


</body>
</html>