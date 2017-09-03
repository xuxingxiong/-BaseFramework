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
										<input type="hidden" id="flag" value="${pd.flag}">

										<table id="table_report"
											class="table table-striped table-bordered table-hover"
											style="margin-top: 5px;">
											<thead>
												<tr>
													<th class="center" style="width: 20%;">服务名称</th>
													<th class="center" style="width: 25%;">服务英文名称</th>
													<th class="center">服务价格选择</th>
													<th class="center" style="width: 15%;">单价（售价）</th>
													<c:if test="${pd.flag != 1 }">
														<th class="center" style="width: 15%;">单价（成本价）</th>
													</c:if>
												</tr>
											</thead>
											<tbody id="fields">
												<c:forEach items="${pdList}" var="var" varStatus="vs">
													<tr id='choosePrice'>
														<td class='center' id='NAME${var.i}'>${var.NAME}</td>
														<td class='center'>${var.NAME_EN}
															<input type='hidden' id='ID${var.i}' value="${var.ID}"/>
															<input type='hidden' id='inPURCHACE_PRICE${var.i}'/></td>
														<td class='center'>
															<select id="SUB_ID${var.i}" data-placeholder="请选择" style="vertical-align: top; width: 150px; "
																onchange="selectPrice(this.value,'${var.ID}','${var.i}')">
																<option value="">请选择</option>
																<c:forEach items="${var.careprice}" var="price" varStatus="vs">
																	<option value="${price.SUB_ID}">${price.NAME}</option>
																</c:forEach>
															</select>
														</td>
														<td class='center' id='PRICE${var.i}'></td>
														<c:if test="${pd.flag != 1 }">
															<td class='center' id='PURCHACE_PRICE${var.i}'></td>
														</c:if>
													</tr>
												</c:forEach>
											</tbody>
										</table>
										<input type='hidden' id='count' value="${count}"/>

										<table id="table_report"
											class="table table-striped table-bordered table-hover">
											<tr>
												<td style="text-align: center;" colspan="100">
													<a class="btn btn-success btn-xs" id='goOrder' onclick="goOrder(this);">下单</a> 
													<a class="btn btn-danger btn-xs" id='close' onclick="top.Dialog.close();">取消</a>
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
		//选择服务价格
		function selectPrice(val,id,i){
			if(val=='') return false;
			$.ajax({
				type: "POST",
				url: basePath + 'careprice/findById.do',
		    	data: {ID:id,SUB_ID:val},
				dataType:'json',
				cache: false,
				success: function(data){
					if(data){
						$('#PRICE'+i).text(data.PRICE);
						$('#PURCHACE_PRICE'+i).text(data.PURCHACE_PRICE);
						$('#inPURCHACE_PRICE'+i).val(data.PURCHACE_PRICE);
					}
				},
				error:function(err){
				}
			});
		}

		var pushToArray = function (){
			let careArray = '4,,';
			$('#flag').val() == '1'? careArray += '1,,' : careArray += '0,,';
			 
			for(let i=0;i<parseInt($('#count').val());i++){
				if($('#SUB_ID'+i).val()==''){
					$('#SUB_ID'+i).tips({
						side:1,
			            msg:'请选择价格',
			            bg:'#AE81FF',
			            time:8
			        });
					return false;
				} 
				careArray = careArray + 'GOODS_ID:'+$('#ID'+i).val()
					+',GOODS_NAME:'+$('#NAME'+i).text().trim()
					+',PRICE:'+$('#PRICE'+i).text().trim()
					+',PURCHACE_PRICE:'+$('#inPURCHACE_PRICE'+i).val()
					+',GOODS_NUM:1'
					+'<<>>';
			}
			return careArray.substring(0, careArray.length-4);
		}
		
		//去下单
		function goOrder(self){
			let data = pushToArray();
			if(!data) return data;
			console.log(data);
			if(self.style.opacity=='0.3') return false;
			self.style.opacity="0.3";
			$('#close').text("关闭");
			
			top.jzts();
			var diag = new top.Dialog();
			diag.Drag=false;
			diag.Title ="添加订单";
			diag.URL = basePath + 'beautyorder/goAdd.do?DATA=' + data;
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
				top.Dialog.close();
			};
			diag.show();
		}
	</script>
</body>
</html>