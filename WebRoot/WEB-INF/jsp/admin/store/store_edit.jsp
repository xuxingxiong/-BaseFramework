<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
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
	<link rel="stylesheet" href="static/ace/css/bootstrap-timepicker.css" />
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
					
					<form action="store/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="ID" id="ID" value="${pd.ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:25%;text-align: right;padding-top: 13px;">店铺名称:</td>
								<td><input type="text" name="NAME" id="NAME" value="${pd.NAME}" maxlength="255" placeholder="这里输入店铺名称" title="店铺名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:25%;text-align: right;padding-top: 13px;">积分:</td>
								<td><input type="number" name="INTEGRAL" id="INTEGRAL" value="${pd.INTEGRAL}" maxlength="11" placeholder="这里输入积分" title="积分" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:25%;text-align: right;padding-top: 13px;">店铺显示顺序:</td>
								<td><input type="number" name="DISPLAY_ORDER" id="DISPLAY_ORDER" value="${pd.DISPLAY_ORDER}" maxlength="4" onkeyup= "if(this.value.length==1){this.value = this.value.replace(/[^1-9]/g,'')}else{this.value = this.value.replace(/\D/g,'')}" onafterpaste= "if(this.value.length==1){this.value = this.value.replace(/[^1-9]/g,'0')}else{this.value = this.value.replace(/\D/g,'')}" placeholder="这里输入店铺显示顺序（整数）" title="店铺显示顺序" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:25%;text-align: right;padding-top: 13px;">店铺照片:</td>
								<td><img id="imgAD" src="<%=basePath%>uploadFiles/uploadImgs/${pd.PATH}" alt="" width="100" 
								style="display: <c:if test="${pd.PATH == null }">none</c:if>" /> 
		  							<input type="hidden" name="PATH" id="ICON" value="${pd.PATH}" /><!-- 图片成功上传后的url -->
		  							<a class="btn btn-mini btn-danger" onclick="chooseImg();">选择图片</a>
	  							</td>
							</tr>
							<tr>
								<td style="width:25%;text-align: right;padding-top: 13px;">店铺简介:</td>
								<td><input type="text" name="NOTICE" id="NOTICE" value="${pd.NOTICE}" maxlength="2000" placeholder="这里输入店铺简介" title="店铺简介" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:25%;text-align: right;padding-top: 13px;">店铺地址:</td>
								<td><input type="text" name="ADDRESS" id="ADDRESS" value="${pd.ADDRESS}" maxlength="2000" placeholder="这里输入店铺地址" title="店铺地址" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:25%;text-align: right;padding-top: 13px;">微信号:</td>
								<td><input type="text" name="WECHAT_ID" id="WECHAT_ID" value="${pd.WECHAT_ID}" maxlength="2000" placeholder="这里输入微信号" title="微信号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:25%;text-align: right;padding-top: 13px;">店铺营业时间起:</td>
								<td><input class="span10 datetimepicker" name="BUSSTIME_FROM" id="BUSSTIME_FROM" value="${pd.BUSSTIME_FROM}" type="text" readonly="readonly" placeholder="店铺营业时间起" title="店铺营业时间起" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:25%;text-align: right;padding-top: 13px;">店铺营业时间止:</td>
								<td><input class="span10 datetimepicker" name="BUSSTIME_TO" id="BUSSTIME_TO" value="${pd.BUSSTIME_TO}" type="text" readonly="readonly" placeholder="店铺营业时间止" title="店铺营业时间止" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:25%;text-align: right;padding-top: 13px;">店铺联络方式:</td>
								<td><input type="text" name="PHONE" id="PHONE" value="${pd.PHONE}" maxlength="13" placeholder="这里输入店铺联络方式" title="店铺联络方式" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:25%;text-align: right;padding-top: 13px;">微信二维码:</td>
								<td><img id="wechatQrcodeShow" src="<%=basePath%>uploadFiles/uploadImgs/${pd.WECHAT_QRCODE}" alt="" width="100" 
									style="display: <c:if test="${pd.WECHAT_QRCODE == null || pd.WECHAT_QRCODE == '' }">none</c:if>" />
									<a class="btn btn-mini btn-danger" id="wechatQrcodeA" style="display: <c:if test="${pd.WECHAT_QRCODE == null || pd.WECHAT_QRCODE == '' }">none</c:if>" onclick="cancelQrcode('#wechatQrcode');">取消</a>
		  							<input type="file" name="wechatQrcode" id="wechatQrcode" accept=".gif,.jpg,.jpeg,.png" style="display: <c:if test="${pd.WECHAT_QRCODE != null && pd.WECHAT_QRCODE != '' }">none</c:if>" onchange="fileUpload('#wechatQrcode');" />
		  							<input type="hidden" name="WECHAT_QRCODE" id="wechatQrcodeText" value="${pd.WECHAT_QRCODE}" /><!-- 图片成功上传后的url -->
	  							</td>
							</tr>
							<tr>
								<td style="width:25%;text-align: right;padding-top: 13px;">支付宝二维码:</td>
								<td><img id="alipayQrcodeShow" src="<%=basePath%>uploadFiles/uploadImgs/${pd.ALIPAY_QRCODE}" alt="" width="100" 
									style="display: <c:if test="${pd.ALIPAY_QRCODE == null || pd.ALIPAY_QRCODE == '' }">none</c:if>" /> 
									<a class="btn btn-mini btn-danger" id="alipayQrcodeA" style="display: <c:if test="${pd.ALIPAY_QRCODE == null || pd.ALIPAY_QRCODE == '' }">none</c:if>" onclick="cancelQrcode('#alipayQrcode');">取消</a>
									<input type="file" name="alipayQrcode" id="alipayQrcode" style="display: <c:if test="${pd.ALIPAY_QRCODE != null && pd.ALIPAY_QRCODE != '' }">none</c:if>" accept=".gif,.jpg,.jpeg,.png" onchange="fileUpload('#alipayQrcode');" />
		  							<input type="hidden" name="ALIPAY_QRCODE" id="alipayQrcodeText" value="${pd.ALIPAY_QRCODE}" /><!-- 图片成功上传后的url -->
	  							</td>
							</tr>
							<tr>
								<td style="width:25%;text-align: right;padding-top: 13px;">店主人名字:</td>
								<td><input type="text" name="OWNER" id="OWNER" value="${pd.OWNER}" maxlength="24" placeholder="这里输入店主人名字" title="店主人名字" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="text-align: center;" colspan="10">
									<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
									<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
								</td>
							</tr>
						</table>
						</div>
						<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
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
<!-- /.main-container -->


	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-timepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script type="text/javascript">
		$(top.hangge());
		//保存
		function save(){
			if($("#NAME").val()==""){
				$("#NAME").tips({
					side:3,
		            msg:'请输入店铺名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NAME").focus();
			return false;
			}
			if($("#INTEGRAL").val()==""){
				$("#INTEGRAL").tips({
					side:3,
		            msg:'请输入积分',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#INTEGRAL").focus();
			return false;
			}
			if($("#DISPLAY_ORDER").val()==""){
				$("#DISPLAY_ORDER").tips({
					side:3,
		            msg:'请输入店铺显示顺序',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#DISPLAY_ORDER").focus();
			return false;
			}
			if($("#PATH").val()==""){
				$("#PATH").tips({
					side:3,
		            msg:'请选择店铺照片',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PATH").focus();
			return false;
			}
			if($("#NOTICE").val()==""){
				$("#NOTICE").tips({
					side:3,
		            msg:'请输入店铺简介',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NOTICE").focus();
			return false;
			}
			if($("#ADDRESS").val()==""){
				$("#ADDRESS").tips({
					side:3,
		            msg:'请输入店铺地址',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ADDRESS").focus();
			return false;
			}
			if($("#BUSSTIME_FROM").val()==""){
				$("#BUSSTIME_FROM").tips({
					side:3,
		            msg:'请输入店铺营业时间起',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#BUSSTIME_FROM").focus();
			return false;
			}
			if($("#BUSSTIME_TO").val()==""){
				$("#BUSSTIME_TO").tips({
					side:3,
		            msg:'请输入店铺营业时间止',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#BUSSTIME_TO").focus();
			return false;
			}
			if($("#PHONE").val()==""){
				$("#PHONE").tips({
					side:3,
		            msg:'请输入店铺联络方式',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PHONE").focus();
			return false;
			}
			if($("#OWNER").val()==""){
				$("#OWNER").tips({
					side:3,
		            msg:'请输入店主人名字',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#OWNER").focus();
			return false;
			}
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}

		var imgTypes=['gif','png','jpg','jpeg'];
		
		$(function() {
			//时间框
			$('.datetimepicker').timepicker({showMeridian:false});
			
		});
		
		String.prototype.endWith=function(endStr){
			var d=this.length-endStr.length;
			return (d>=0&&this.lastIndexOf(endStr)==d)
		}
		
		// 二维码上传
		function fileUpload(fileId) {
			var isImg=false;
			var fileName=$(fileId).val();
			$.each(imgTypes, function(index, value, array) {
				if(fileName.endWith(value)){
					isImg=true;
				}
			});
			
			if(!isImg){
				alert("请选择图片二维码，格式为：gif,png,jpg,jpeg");
				return;
			}
			
			var formData = new FormData();
			formData.append('file', $(fileId)[0].files[0]);
			
			$.ajax({
				type : "POST",
			    cache: false,
				url : "<%=basePath%>pictures/save.do",
                contentType: false,
                processData: false,
			    data: formData,
			}).done(function(res) {
				if(res.result=="ok"){
					$(fileId+"A").attr("style","display:inline");
					$(fileId+"Show").attr("style","display:inline");
					$(fileId+"Show").attr("src", "<%=basePath%>uploadFiles/uploadImgs/"+res.PATH);
					$(fileId+"Text").val(res.PATH);
					$(fileId).attr("style","display:none");
				}else{
					alert("二维码上传失败");
				}
			}).fail(function(res) {
				console.log(res);
			});
		}
		
		// 取消二维码
		function cancelQrcode(id){
			$(id).attr("style","display:inline");
			$(id+"A").attr("style","display:none");
			$(id+"Show").attr("style","display:none");
			$(id+"Text").val("");
		}
		
		// 选择图片
		function chooseImg() {
			top.jzts();
			var diag = new top.Dialog();
			diag.Drag=false;
			diag.Title ="选择图片";
			diag.URL = '<%=basePath%>pictures/listChoose.do?flag='+'store';
			diag.Width = 800;
			diag.Height = 600;
			diag.Modal = false;				//有无遮罩窗口
			diag.ShowMaxButton = true;	//最大化按钮
			diag.ShowMinButton = true;		//最小化按钮
			diag.CancelEvent = function(){ //关闭事件
				diag.close();
			};
			diag.show();
		}
		</script>
</body>
</html>