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
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta charset="utf-8" />
<title>${pd.SYSNAME}</title>
<meta name="description" content="" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
	<%@ include file="../../system/index/top.jsp"%>
	<style type="text/css">
	.beauty_img_row a img{
		width:20px;
		height:20px;
		margin-right:5px;
	}
	body{
		height:50px;
		overflow: hidden;
	}
	#simple-table{
		border:none;
	}
	#simple-table td{
		height:40px;
	}
	</style>
</head>
<body class="no-skin">
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
					<!-- 检索  -->
					<form action="pictures/goRefImageList.do" method="post" name="Form" id="Form">
					<table id="simple-table" class="table table-striped"  style="height:40px;margin-top:0px;">
						<tbody>
						<tr><td class="beauty_img_row">
						<c:forEach items="${list}" var="var" varStatus="vs">
						<a IMAGEID="${var.ID}" SUBID="${var.SUB_ID}" href="javascript:void(0);" src="<%=basePath%>uploadFiles/uploadImgs/${var.PATH}" title="${var.DISCRIBE}" data-lightbox="${id}"><img alt="${var.DISCRIBE}" src="<%=basePath%>uploadFiles/uploadImgs/${var.PATH}"></a>
						</c:forEach>
						</td>
						<c:if test="${msg=='save' }">
						<td style="vertical-align:top;">
							<a class="btn btn-sm btn-success" onclick="add();">新增</a>
						</td>
						</c:if>
						</tr>
						</tbody>
					</table>
					
				<div class="page-header position-relative" style="display: none;">
				<table style="width:100%;">
					<tr>
						<td style="vertical-align:top;display: none;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
					</tr>
				</table>
				</div>
				</form>
				<!-- /.page-content -->
			</div>
		</div>
	</div>
	<!-- /.main-container -->
	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	</body>
	<script type="text/javascript">
		$(top.hangge());
		$(function() {
			$('a').click(function(){
				var diag = new top.Dialog();
				 diag.Drag=true;
				 diag.Title ="图片预览";
				 diag.URL = $(this).attr("src");
				 diag.Width = $(this).find("img")[0].naturalWidth;
				 diag.Height = $(this).find("img")[0].naturalHeight;
				 diag.CancelEvent = function(){ //关闭事件
					diag.close();
				 };
				 diag.IMAGEID = $(this).attr("IMAGEID");
				 diag.SUBID = $(this).attr("SUBID");
				 diag.show();
				 diag.addButton("delete","删除",function(){
					 del(diag.IMAGEID,diag.SUBID);
					 diag.close();
					});
				 $(diag.okButton).hide();
				 $(diag.cancelButton).hide();
				 return false;
			});
		});
		//检索
		function searchs(){
			top.jzts();
			$("#Form").submit();
		}
		
		//新增
		function add(){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增";
			 diag.URL = '<%=basePath%>pictures/goRefAdd.do?id=${id}';
			 diag.Width = 800;
			 diag.Height = 490;
			 diag.CancelEvent = function(){ //关闭事件
					 top.jzts();
					 setTimeout("self.location=self.location",100);
				diag.close();
			 };
			 diag.show();
		}
		
		//删除
		function del(Id,SUBID){
			
			if(confirm("确定要删除?")){ 
				top.jzts();
				var url = "<%=basePath%>pictures/refdelete.do?ID="+Id+"&SUB_ID="+SUBID+"&tm="+new Date().getTime();
				$.get(url,function(data){
					top.jzts();
					 setTimeout("self.location=self.location",100);
				});
			}
		}
		
		//修改
		function edit(Id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑";
			 diag.URL = '<%=basePath%>pictures/goEdit.do?PICTURES_ID='+Id;
			 diag.Width = 600;
			 diag.Height = 465;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 nextPage(${page.currentPage});
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//全选 （是/否）
		function selectAll(){
			 var checklist = document.getElementsByName ("ids");
			   if(document.getElementById("zcheckbox").checked){
			   for(var i=0;i<checklist.length;i++){
			      checklist[i].checked = 1;
			   } 
			 }else{
			  for(var j=0;j<checklist.length;j++){
			     checklist[j].checked = 0;
			  }
			 }
		}
		//批量操作
		function makeAll(msg){
			if(confirm(msg)){ 
					var str = '';
					for(var i=0;i < document.getElementsByName('ids').length;i++)
					{
						  if(document.getElementsByName('ids')[i].checked){
						  	if(str=='') str += document.getElementsByName('ids')[i].value;
						  	else str += ',' + document.getElementsByName('ids')[i].value;
						  }
					}
					if(str==''){
						alert("您没有选择任何内容!"); 
						return;
					}else{
						if(msg == '确定要删除选中的数据吗?'){
							top.jzts();
							$.ajax({
								type: "POST",
								url: '<%=basePath%>pictures/deleteAll.do?tm='+new Date().getTime(),
						    	data: {DATA_IDS:str},
								dataType:'json',
								//beforeSend: validateData,
								cache: false,
								success: function(data){
									 $.each(data.list, function(i, list){
											nextPage(${page.currentPage});
									 });
								}
							});
						}
					}
			}
		}
	</script>
	<style type="text/css">
	li {list-style-type:none;}
	</style>
	<ul class="navigationTabs">
           <li><a></a></li>
           <li></li>
       </ul>
</html>

