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
<!--查看图片插件 -->
<link rel="stylesheet" media="screen" type="text/css" href="plugins/zoomimage/css/zoomimage.css" />
<link rel="stylesheet" media="screen" type="text/css" href="plugins/zoomimage/css/custom.css" />
<script type="text/javascript" src="plugins/zoomimage/js/jquery.js"></script>
<script type="text/javascript" src="plugins/zoomimage/js/eye.js"></script>
<script type="text/javascript" src="plugins/zoomimage/js/utils.js"></script>
<script type="text/javascript" src="plugins/zoomimage/js/zoomimage.js"></script>
<script type="text/javascript" src="plugins/zoomimage/js/layout.js"></script>
<!--查看图片插件 -->
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
						<input type="hidden" name="STORE_ID" id="STORE_ID" value="${STORE_ID}">
						<div class="col-xs-12">
						<!-- 检索  -->
						<form action="goods/list.do" method="post" name="Form" id="Form">
						<table style="margin-top:5px;">
							<tr>
								<td>
									<div class="nav-search">
										<span class="input-icon">
											<input type="text" placeholder="这里输入关键词" class="nav-search-input" id="nav-search-input" autocomplete="off" name="keywords" value="${pd.keywords }" placeholder="这里输入关键词"/>
											<i class="ace-icon fa fa-search nav-search-icon"></i>
										</span>
									</div>
								</td>
								<c:if test="${QX.cha == 1 }">
								<td style="vertical-align:top;padding-left:2px"><a class="btn btn-light btn-xs" onclick="tosearch();"  title="检索"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
								</c:if>
							</tr>
						</table>
						<!-- 检索  -->
						
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">	
							<thead>
								<tr>
									<th class="center" style="width:35px;">
									<label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label>
									</th>
									<th class="center" style="width:50px;">序号</th>
									<th class="center">商品名称</th>
									<th class="center">商品说明</th>
									<th class="center">商品照片</th>
									<th class="center">商品单价</th>
									<th class="center">商品单位</th>
									<th class="center">商品显示顺序</th>
									<th class="center">分类</th>
									<th class="center">分类一</th>
									<th class="center">分类二</th>
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
											<td class='center'>${var.NAME}
												<input type="hidden" id="${var.ID}_NAME" value="${var.NAME}" />
											</td>
											<td class='center'>${var.DETAILS}
												<input type="hidden" id="${var.ID}_DETAILS" value="${var.DETAILS}" />
											</td>
											<td class='center'>
												<a href="<%=basePath%>uploadFiles/uploadImgs/${var.PATH}" title="${var.NAME}" class="bwGal"><img src="<%=basePath%>uploadFiles/uploadImgs/${var.PATH}" alt="${var.NAME}" width="100"></a>
								  				<input type="hidden" id="${var.ID}_PATH" value="<%=basePath%>uploadFiles/uploadImgs/${var.PATH}" />
								  				<input type="hidden" id="${var.ID}_PATH_TEXT" value="${var.PATH}" />
											</td>
											<td class='center'>${var.PRICE}
												<input type="hidden" id="${var.ID}_PRICE" value="${var.PRICE}" />
											</td>
											<td class='center'>${var.UNIT}
												<input type="hidden" id="${var.ID}_UNIT" value="${var.UNIT}" />
											</td>
											<td class='center'>${var.DISPLAY_ORDER}
												<input type="hidden" id="${var.ID}_DISPLAY_ORDER" value="${var.DISPLAY_ORDER}" />
											</td>
											<td class='center'>${var.CATEGORY_NAME}
												<input type="hidden" id="${var.ID}_CATEGORY_ID" value="${var.CATEGORY_ID}" />
												<input type="hidden" id="${var.ID}_CATEGORY_NAME" value="${var.CATEGORY_NAME}" />
											</td>
											<td class='center'>${var.CATEGORY_NAME_1}
												<input type="hidden" id="${var.ID}_CATEGORY_ID_1" value="${var.CATEGORY_ID_1}" />
												<input type="hidden" id="${var.ID}_CATEGORY_NAME_1" value="${var.CATEGORY_NAME_1}" />
											</td>
											<td class='center'>${var.CATEGORY_NAME_2}
												<input type="hidden" id="${var.ID}_CATEGORY_ID_2" value="${var.CATEGORY_ID_2}" />
												<input type="hidden" id="${var.ID}_CATEGORY_NAME_2" value="${var.CATEGORY_NAME_2}" />
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
									<a class="btn btn-mini btn-success" onclick="select();">选择</a>
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

		// 选择商品
		function select(){
			var Id = '';
			var j = 0;
			for(var i=0;i < document.getElementsByName('ids').length;i++)
			{
				  if(document.getElementsByName('ids')[i].checked){
				  	j++;
				  	Id = document.getElementsByName("ids")[i].value;
				  }
			}
			if(Id==''){
				alert("您没有选择任何内容!"); 
				return;
			}else{
				if(j>1){
					alert("请只选择一条!"); 
					return;
				}
				var m = 0;
				while(true){
					if (window.parent.document.getElementById("_DialogDiv_"+m) != null) {
						var n = m + 1;
						while(true){
							if (window.parent.document.getElementById("_DialogDiv_"+n) != null) {
								var parentDocument=window.parent.document.getElementById("_DialogFrame_"+m).contentDocument;
								parentDocument.getElementById("NAME").value=$("#"+Id+"_NAME").val();
								parentDocument.getElementById("DETAILS").value=$("#"+Id+"_DETAILS").val();
								parentDocument.getElementById("imgAD").style="display:inline";
								parentDocument.getElementById("imgAD").src=$("#"+Id+"_PATH").val();
								parentDocument.getElementById("ICON").value=$("#"+Id+"_PATH_TEXT").val();
								parentDocument.getElementById("PRICE").value=$("#"+Id+"_PRICE").val();
								var unit = parentDocument.getElementById("UNIT").options;
								for(i=0; i<unit.length; i++){
									 unit[i].selected = false;
									 if (unit[i].id == $("#"+Id+"_UNIT").val())  // 根据option标签的ID来进行判断  测试的代码这里是两个等号
								      {
										 unit[i].selected = true;
								      }
								}
								parentDocument.getElementById("UNIT_chosen").childNodes[0].childNodes[0].innerHTML = $("#"+Id+"_UNIT").val();
								parentDocument.getElementById("DISPLAY_ORDER").value=$("#"+Id+"_DISPLAY_ORDER").val();
								var categoryId = parentDocument.getElementById("CATEGORY_ID").options;
								for(i=0; i<categoryId.length; i++){
									 categoryId[i].selected = false;
									 if (categoryId[i].id == $("#"+Id+"_CATEGORY_ID").val())  // 根据option标签的ID来进行判断  测试的代码这里是两个等号
								      {
										 categoryId[i].selected = true;
								      }
								}
								parentDocument.getElementById("CATEGORY_ID_1_chosen").childNodes[0].childNodes[0].innerHTML = $("#"+Id+"_CATEGORY_NAME_1").val();
								var categoryId = parentDocument.getElementById("CATEGORY_ID_1").options;
								for(i=0; i<categoryId.length; i++){
									 categoryId[i].selected = false;
									 if (categoryId[i].id == $("#"+Id+"_CATEGORY_ID_1").val())  // 根据option标签的ID来进行判断  测试的代码这里是两个等号
								      {
										 categoryId[i].selected = true;
								      }
								}
								parentDocument.getElementById("CATEGORY_ID_1_chosen").childNodes[0].childNodes[0].innerHTML = $("#"+Id+"_CATEGORY_NAME_1").val();
								var categoryId = parentDocument.getElementById("CATEGORY_ID_2").options;
								for(i=0; i<categoryId.length; i++){
									 categoryId[i].selected = false;
									 if (categoryId[i].id == $("#"+Id+"_CATEGORY_ID_2").val())  // 根据option标签的ID来进行判断  测试的代码这里是两个等号
								      {
										 categoryId[i].selected = true;
								      }
								}
								parentDocument.getElementById("CATEGORY_ID_2_chosen").childNodes[0].childNodes[0].innerHTML = $("#"+Id+"_CATEGORY_NAME_2").val();
								break;
							}
							n++;
						}
						break;
					}
					m++;
				}
				top.Dialog.close();
			}
		}
		
		//导出excel
		function toExcel(){
			window.location.href='<%=basePath%>goods/excel.do';
		}
	</script>
</body>
<style type="text/css">
	li {list-style-type:none;}
</style>
<ul class="navigationTabs">
    <li><a></a></li>
    <li></li>
</ul>
</html>