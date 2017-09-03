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
					<div class="col-xs-12">
					
					<form action="wxnewsmsg/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="WEIXINNEWSMSG_ID" id="WEIXINNEWSMSG_ID" value="${pd.WEIXINNEWSMSG_ID}"/>
						<input type="hidden" name="MSGTYPE" id="MSGTYPE" value="news" />
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:85px;text-align: right;padding-top: 13px;">关键字:</td>
								<td><input type="text" name="INPUTCODE" id="INPUTCODE" value="${pd.INPUTCODE}" maxlength="20" placeholder="这里输入关键字" title="关键字" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:85px;text-align: right;padding-top: 13px;">标题:</td>
								<td><input type="text" name="TITLE" id="TITLE" value="${pd.TITLE}" maxlength="255" placeholder="这里输入标题" title="标题" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:85px;text-align: right;padding-top: 13px;">作者:</td>
								<td><input type="text" name="AUTHOR" id="AUTHOR" value="${pd.AUTHOR}" maxlength="255" placeholder="这里输入作者" title="作者" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:85px;text-align: right;padding-top: 13px;">简介:</td>
								<td><input type="text" name="BRIEF" id="BRIEF" value="${pd.BRIEF}" maxlength="255" placeholder="这里输入简介" title="简介" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:85px;text-align: right;padding-top: 13px;">正文:</td>
								<td>
								<div id="DESCRIPTION_editor" style="width:98%;height:300px;"></div>
								
								<textarea class="hidden" name="DESCRIPTION" id="DESCRIPTION" maxlength="715827882" placeholder="这里输入正文" title="正文" style="width:98%;">${pd.DESCRIPTION}</textarea></td>
							</tr>
							<tr>
								<td style="width:85px;text-align: right;padding-top: 13px;">图片路径:</td>
								<td><input type="text" name="PICPATH" id="PICPATH" value="${pd.PICPATH}" maxlength="255" placeholder="这里输入图片路径" title="图片路径" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">顺序:</td>
								<td><input type="number" max="9" min="0" name="ORDERNUM" id="ORDERNUM" value="${pd.ORDERNUM}" maxlength="1" placeholder="这里输入顺序" title="顺序" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:85px;text-align: right;padding-top: 13px;">是否显示图片:</td>
								<td>
								<select name="SHOWPIC" id="SHOWPIC">
								<option value="1" <c:if test="${var.SHOWPIC=='1'}">selected="selected"</c:if>>显示</option>
								<option value="0" <c:if test="${var.SHOWPIC!='1'}">selected="selected"</c:if>>不显示</option>
								</select>
								</td>
							</tr>
							<tr>
								<td style="width:85px;text-align: right;padding-top: 13px;">原文地址:</td>
								<td><input type="text" name="FROMURL" id="FROMURL" value="${pd.FROMURL}" maxlength="255" placeholder="这里输入原文地址" title="原文地址" style="width:98%;"/></td>
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
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	
<script type="text/javascript" charset="utf-8">window.UEDITOR_HOME_URL = "<%=path%>/plugins/ueditor/";</script>
<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.all.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script type="text/javascript">
		$(top.hangge());
		//保存
		function save(){
			$("#DESCRIPTION").val(getContent("DESCRIPTION_editor"));
			if($("#INPUTCODE").val()==""){
				$("#INPUTCODE").tips({
					side:3,
		            msg:'请输入关键字',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#INPUTCODE").focus();
			return false;
			}
			if($("#TITLE").val()==""){
				$("#TITLE").tips({
					side:3,
		            msg:'请输入标题',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#TITLE").focus();
			return false;
			}
			if($("#AUTHOR").val()==""){
				$("#AUTHOR").tips({
					side:3,
		            msg:'请输入作者',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#AUTHOR").focus();
			return false;
			}
			if($("#DESCRIPTION").val()==""){
				$("#DESCRIPTION").tips({
					side:3,
		            msg:'请输入正文',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#DESCRIPTION").focus();
			return false;
			}
			if($("#SHOWPIC").val()=="1" && $("#PICPATH").val()==""){
				$("#PICPATH").tips({
					side:3,
		            msg:'请输入图片路径',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PICPATH").focus();
			return false;
			}
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
		function ueditor(){
			UE.getEditor('DESCRIPTION_editor').ready( function( editor ) {
				$(this.container).css("width","");
				this.setContent($("#DESCRIPTION").text());
				this.options.weixinBaseUrl="<%=basePath%>";
				this.options.uploadType="weixin";
			});
			
		}
		//ueditor纯文本
		function getContentTxt(id) {
		    var arr = [];
		    arr.push(UE.getEditor(id).getContentTxt());
		    return arr.join("");
		}
		//ueditor有标签文本
		function getContent(id) {
		    var arr = [];
		    arr.push(UE.getEditor(id).getContent());
		    return arr.join("");
		}
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
			setTimeout("ueditor()",500);
		});
		</script>
</body>
</html>