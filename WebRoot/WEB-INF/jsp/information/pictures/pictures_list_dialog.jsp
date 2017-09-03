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
<!-- bootstrap & fontawesome -->
<link rel="stylesheet" href="static/ace/css/bootstrap.min.css" />
<link rel="stylesheet" href="static/ace/css/font-awesome.css" />
<!-- page specific plugin styles -->
<!-- text fonts -->
<link rel="stylesheet" href="static/ace/css/ace-fonts.css" />
<!-- ace styles -->
<link rel="stylesheet" href="static/ace/css/ace.css" class="ace-main-stylesheet" id="main-ace-style" />
<!--[if lte IE 9]>
	<link rel="stylesheet" href="static/ace/css/ace-part2.css" class="ace-main-stylesheet" />
<![endif]-->
<!--[if lte IE 9]>
  <link rel="stylesheet" href="static/ace/css/ace-ie.css" />
<![endif]-->
<!-- inline styles related to this page -->
<!-- ace settings handler -->
<script src="static/ace/js/ace-extra.js"></script>
<!-- HTML5shiv and Respond.js for IE8 to support HTML5 elements and media queries -->
<!--[if lte IE 8]>
<script src="static/ace/js/html5shiv.js"></script>
<script src="static/ace/js/respond.js"></script>
<![endif]-->
<!--查看图片插件 -->
<link rel="stylesheet" media="screen" type="text/css" href="plugins/zoomimage/css/zoomimage.css" />
<link rel="stylesheet" media="screen" type="text/css" href="plugins/zoomimage/css/custom.css" />
<script type="text/javascript" src="plugins/zoomimage/js/jquery.js"></script>
<script type="text/javascript" src="plugins/zoomimage/js/eye.js"></script>
<script type="text/javascript" src="plugins/zoomimage/js/utils.js"></script>
<script type="text/javascript" src="plugins/zoomimage/js/zoomimage.js"></script>
<script type="text/javascript" src="plugins/zoomimage/js/layout.js"></script>
<!--查看图片插件 -->
</head>
<body class="no-skin">
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
					<!-- 检索  -->
					<input type="hidden" name="flag" id="flag" value="${flag}" />
					<form action="pictures/listChoose.do?flag=${flag}" method="post" name="Form" id="Form">
					<table style="margin-top:5px;">
						<tr>
							<td>
								<div class="nav-search">
								<span class="input-icon">
									<input autocomplete="off" class="nav-search-input"  id="nav-search-input" type="text" name="keyword"  value="${pd.keyword}" placeholder="这里输入关键词" />
								</span>
								</div>
							</td>
							<c:if test="${QX.cha == 1 }">
							<td style="vertical-align:top;padding-left:2px;">
								<a class="btn btn-light btn-xs" onclick="searchs();"  title="检索"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a>
							</td>
							<td><p style="font-weight:blod;font-size:16px;color:red;">新增图片时，请上传尺寸为${height} * ${width}的图片</p></td>
							</c:if>
						</tr>
					</table>
					<!-- 检索  -->
					<table id="simple-table" class="table table-striped table-bordered table-hover"  style="margin-top:0px;">
						<thead>
							<tr>
								<th class="center" onclick="selectAll()" style="width:35px;">
								<label><input type="checkbox" id="zcheckbox" class="ace" /><span class="lbl"></span></label>
								</th>
								<th class="center" style="width:50px;">序号</th>
								<th class="center" >图片</th>
								<th class="center" >标题</th>
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
										<td class='center' style="width: 30px;">
											<label><input type='checkbox' name='ids' class="ace" value="${var.PATH}" /><span class="lbl"></span></label>
											<input type="hidden" name="PICTURES_ID" id="PICTURES_ID" value="${var.PICTURES_ID}" /><!-- 图片成功上传后的url -->
										</td>
										<td class='center' style="width: 30px;">${vs.index+1}</td>
										<td class="center">
										<a href="<%=basePath%>uploadFiles/uploadImgs/${var.PATH}" title="${var.TITLE}" class="bwGal"><img src="<%=basePath%>uploadFiles/uploadImgs/${var.PATH}" alt="${var.TITLE}" width="100"></a>
										</td>
										<td class="center">${var.TITLE}</td>
										<td class="center" style="width:130px;">
										<c:if test="${QX.edit != 1 && QX.del != 1 }">
										<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="无权限"></i></span>
										</c:if>
											<c:if test="${QX.del == 1 }">
											<a style="cursor:pointer;" class="red" onclick="del('${var.PICTURES_ID}','${var.PATH}');" title="删除">
												<i class="ace-icon fa fa-trash-o bigger-130"></i>
											</a>
											</c:if>
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
				</form>
				<div style="position:fixed; bottom:0;width:100%;height:40px;margin:0px;padding:0px;background-color:white">
						<div class="page-header position-relative">
						<table style="width:100%;">
							<tr>
								<td style="vertical-align:top;">
									<c:if test="${QX.add == 1 }">
									<a class="btn btn-sm btn-success" onclick="add();">新增</a>
									</c:if>
									<a class="btn btn-sm btn-success" onclick="choose();">选择</a>
									<a class="btn btn-sm btn-danger" onclick="cancel();">取消</a>
									<c:if test="${QX.del == 1 }">
									<a title="批量删除" class="btn btn-sm btn-danger" onclick="makeAll('此操作可能会删除其他功能正在使用的图片导致无法显示，您确定要删除选中的数据吗?');" ><i class='ace-icon fa fa-trash-o bigger-120'></i></a>
									</c:if>
								</td>
								<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
							</tr>
						</table>
						</div>
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
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	</body>
	<script type="text/javascript">
		$(top.hangge());
		
		//检索
		function searchs(){
			top.jzts();
			$("#Form").submit();
		}
		
		//新增
		function add(){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=false;
			 diag.Title ="新增";
			 diag.URL = '<%=basePath%>pictures/goAdd.do?flag=' + document.getElementById("flag").value;
			 diag.Width = 800;
			 diag.Height = 600;
			 diag.Modal = false;				//有无遮罩窗口
			 diag.CancelEvent = function(){ //关闭事件
				 if('${page.currentPage}' == '0'){
					 top.jzts();
					 setTimeout("self.location=self.location",100);
				 }else{
					 debugger
					 nextPage(${page.currentPage});
				 }
				diag.close();
			 };
			 diag.show();
		}
		
		//删除
		function del(Id,PATH){
			
			if(confirm("此操作可能会删除其他功能正在使用的图片导致无法显示，确定要删除?")){ 
				top.jzts();
				var url = "<%=basePath%>pictures/delete.do?PICTURES_ID="+Id+"&PATH="+PATH+"&tm="+new Date().getTime();
				$.get(url,function(data){
					nextPage(${page.currentPage});
				});
			}
		}
		
		//修改
		function edit(Id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑";
			 diag.URL = '<%=basePath%>pictures/goEdit.do?PICTURES_ID='+Id+'&flag='+document.getElementById("flag").value;
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
		
		function cancel(){
			top.Dialog.close();
		}
		
		// 选择图片
		function choose(){
			var str = '';
			var j = 0;
			for(var i=0;i < document.getElementsByName('ids').length;i++)
			{
				  if(document.getElementsByName('ids')[i].checked){
				  	j++;
				  	str = document.getElementsByName("ids")[i].value;
				  }
			}
			if(str==''){
				alert("您没有选择任何内容!"); 
				return;
			}else{
				if(j>1){
					alert("请只选择一张图片!"); 
					return;
				}
				var m = 0;
				while(true){
					if (window.parent.document.getElementById("_DialogDiv_"+m) != null) {
						var n = m + 1;
						while(true){
							if (window.parent.document.getElementById("_DialogDiv_"+n) != null) {
								window.parent.document.getElementById("_DialogFrame_"+m).contentDocument.getElementById("ICON").value=str;
								window.parent.document.getElementById("_DialogFrame_"+m).contentDocument.getElementById("imgAD").style="display:inline";
								window.parent.document.getElementById("_DialogFrame_"+m).contentDocument.getElementById("imgAD").src='<%=basePath%>uploadFiles/uploadImgs/'+str;
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
						  	if(str=='') str += document.getElementsByName('PICTURES_ID')[i].value;
						  	else str += ',' + document.getElementsByName('PICTURES_ID')[i].value;
						  }
					}
					if(str==''){
						alert("您没有选择任何内容!"); 
						return;
					}else{
						if(msg == '此操作可能会删除其他功能正在使用的图片导致无法显示，您确定要删除选中的数据吗?'){
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

