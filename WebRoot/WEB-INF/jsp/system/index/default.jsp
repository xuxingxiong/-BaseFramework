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

<!-- jsp文件头和头部 -->
<%@ include file="../index/top.jsp"%>
<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />
<!-- 日期框 -->
<link rel="stylesheet" href="static/ace/css/datepicker.css" />
<!-- 百度echarts -->
<script src="plugins/echarts/echarts.min.js"></script>
</head>
<body class="no-skin">

	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="hr hr-18 dotted hr-double"></div>
					<div class="row">
						<div class="col-xs-12">

							<div class="alert alert-block alert-success">
								<button type="button" class="close" data-dismiss="alert">
									<i class="ace-icon fa fa-times"></i>
								</button>
								<i class="ace-icon fa fa-check green"></i>
								欢迎登录 BeautySaloon管理平台
							</div>
							
							<form action="login_default.do" method="post" name="Form" id="Form">
							<div id="main" style="width: 90%;margin: 0 auto;">
							<div style="width: 100px;margin: 0 auto;">提醒</div>
							<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">
							<thead>
							<tr><th class="center" style="width:100px;">类型</th><th class="center" style="width:120px;">手机号</th><th  class="left">信息</th>
									<th class="center" style="width:100px;">操作</th></tr>
							</thead>
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty pd.reminds}">
								<c:forEach items="${pd.reminds}" var="var" varStatus="vs">
								<tr>
											<td class='center'>
												${var.TITLE}
											</td>
											<td class='center'>
												${var.PHONE}
											</td>
											<td class='center'>${var.MESSAGE}</td>
											<td class='center'><a class="btn btn-xs btn-danger" onclick="del('${var.REMIND_TYPE}','${var.ID}');">
														<i class="ace-icon fa fa-trash-o bigger-120" title="不再提醒"></i>
													</a></td>
											</tr>
								</c:forEach>
								</c:when>
								</c:choose>
							</table>
							<div class="page-header position-relative">
						<table style="width:100%;">
							<tr>
								<td style="vertical-align:top;display: none;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
							</tr>
						</table>
						</div>
							</div>
							
						</form>
							<script type="text/javascript">
						        // 基于准备好的dom，初始化echarts实例
						        //var myChart = echarts.init(document.getElementById('main'));
						
						        // 指定图表的配置项和数据
								/*var option = {
						            title: {
						                text: 'FH Admin用户统计'
						            },
						            tooltip: {},
						            xAxis: {
						                data: ["系统用户","系统会员"]
						            },
						            yAxis: {},
						            series: [
						               {
						                name: '',
						                type: 'bar',
						                data: [${pd.userCount},${pd.appUserCount}],
						                itemStyle: {
						                    normal: {
						                        color: function(params) {
						                            // build a color map as your need.
						                            var colorList = ['#6FB3E0','#87B87F'];
						                            return colorList[params.dataIndex];
						                        }
						                    }
						                }
						               }
						            ]
						        };	        */

						        // 使用刚指定的配置项和数据显示图表。
						        //myChart.setOption(option);
						    </script>
							
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
	<%@ include file="../index/foot.jsp"%>
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
	//删除
	function del(type,id){
		bootbox.confirm("确定不再提醒吗?", function(result) {
			if(result) {
				top.jzts();
				var url = "<%=basePath%>/removeRemind.do?REMIND_TYPE="+type+"&USERID="+ id +"&tm="+new Date().getTime();
				$.get(url,function(data){
					setTimeout("self.location=self.location",100);
				});
			}
		});
	}
	</script>
<script type="text/javascript" src="static/ace/js/jquery.js"></script>
</body>
</html>