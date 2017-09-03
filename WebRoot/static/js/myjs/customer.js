"use strict";
var locat = (window.location+'').split('/'); 
$(function(){
	if('createCode'== locat[3]){
		locat =  locat[0]+'//'+locat[2];
	}else{
		locat =  locat[0]+'//'+locat[2]+'/'+locat[3];
	};

	//绑定数据到控件
	function bindData(data){
		let customer=data.customer;
		
		$("#USER_NAME").val(customer.USER_NAME);
		$("#TYPE").find("option[value='"+customer.TYPE+"']").attr("selected",true);
		$("#WECHAT_ID").val(customer.WECHAT_ID);
		$("#MOBILE_PHONE").val(customer.MOBILE_PHONE);
		$("#TEL").val(customer.TEL);
		$("#AGE").val(customer.AGE);
		$("#SEX").find("option[value='"+customer.SEX+"']").attr("selected",true);
		$("#BIRTHDAY").val(customer.BIRTHDAY);
		$("#ADDRESS").val(customer.ADDRESS);
		$("#EMAIL").val(customer.EMAIL);
		$("#QQ").val(customer.QQ);
		$("#SKIN_COMENT").val(customer.SKIN_COMENT);
		$("#PHOTO").val(customer.PHOTO);
		$("#beauty_img_iframe").attr("src","pictures/goRefImageList.do?id="+customer.PHOTO+"&msg=save");
		$("#CARE_RATE").val(customer.CARE_RATE);
		
		let customercard=data.customercard;
		for(let i=0;i<customercard.length;i++){
			let field={
				CARD_NO:customercard[i].CARD_NO,
				CARD_ID:customercard[i].CARD_ID,
				CARD_NAME:customercard[i].CARD_NAME,
				CHARGE:customercard[i].CHARGE,
				SERVICE_CHAGE:customercard[i].SERVICE_CHAGE,
				BALANCE:customercard[i].BALANCE,
				SERVICE_BALANCE:customercard[i].SERVICE_BALANCE,
				BUY_TIME:customercard[i].BUY_TIME,
				END_TIME:customercard[i].END_TIME
			};
			arrayField(field);
		}
	}
	
	// 修改时初始数据绑定
	function init(){
		if($("#ID").val()!="" && $("#ID").val()!="add"){
			$('#switchCust').hide();
			$.ajax({
				type: "POST",
				url: basePath + 'customer/editInfo.do',
		    	data: {ID:$("#ID").val()},
				dataType:'json',
				cache: false,
				success: function(data){
					bindData(data);
				}
			});
		}
	}
	
	init();
});

//保存
function save(){
	if($("#USER_NAME").val()==""){
		$("#USER_NAME").tips({
			side:3,
            msg:'用户不能为空',
            bg:'#AE81FF',
            time:2
        });
		$("#USER_NAME").focus();
		return false;
	}
	
	if($("#TYPE").val()==""){
		$("#TYPE").tips({
			side:3,
            msg:'请选择用户类型',
            bg:'#AE81FF',
            time:2
        });
		$("#TYPE").focus();
	return false;
	}
	
	let customerData ={
		USER_NAME: $("#USER_NAME").val(),
		TYPE: $("#TYPE").val(),
		WECHAT_ID: $("#WECHAT_ID").val(),
		MOBILE_PHONE: $("#MOBILE_PHONE").val(),
		TEL: $("#TEL").val(),
		AGE: $("#AGE").val(),
		SEX: $("#SEX").val(),
		BIRTHDAY: $("#BIRTHDAY").val(),
		ADDRESS: $("#ADDRESS").val(),
		EMAIL: $("#EMAIL").val(),
		QQ: $("#QQ").val(),
		SKIN_COMENT: $("#SKIN_COMENT").val(),
		PHOTO: $("#PHOTO").val(),
		CARE_RATE: $("#CARE_RATE").val(),
		fieldarray: fieldarray
	}
	
	let uri='customer/save.do';
	if($("#ID").val()!="" && $("#ID").val()!="add"){
		customerData.ID = $("#ID").val();
		uri='customer/edit.do';
	}

	$.ajax({
		type: "POST",
		url: basePath + uri,
    	data: customerData,
		dataType:'json',
		cache: false,
		success: function(data){
			if(data.msg=='success'){
				$("#zhongxin").hide();
				$("#zhongxin2").show();
				top.Dialog.close();
			}else{
				alert('系统异常！！！');
			}
		},
		error:function(err){
		}
	});
}

//添加客户会员卡
function saveD(){
	var msgIndex = $("#msgIndex").val();
	
	var cardNo = $("#CARD_NO").val();
	var charge = $("#CHARGE").val();
	var serviceChage = $("#SERVICE_CHAGE").val();
	var chargeD = $("#CHARGED").val();
	var serviceChageD = $("#SERVICE_CHAGED").val();
	var balance = $("#BALANCE").val();
	var balanceD = $("#BALANCED").val();
	var serviceBalance = $("#SERVICE_BALANCE").val();
	var serviceBalanceD = $("#SERVICE_BALANCED").val();
	var buyTime = $("#BUY_TIME").val();
	var buyTimeD = $("#BUY_TIMED").val();
	var endTime = $("#END_TIME").val();
	var cardId = $("#CARD_ID").val();
	var cardName = $("#CARD_NAME").val();

	if (balance == balanceD) {
		charge = chargeD;
	}
	if (serviceBalance == serviceBalanceD) {
		serviceChage = serviceChageD;
	}
	
	if(cardNo==""){
		$("#CARD_NO").tips({
			side:3,
            msg:'卡号不能为空',
            bg:'#AE81FF',
            time:2
        });
		$("#CARD_NO").focus();
		return false;
	}
	
	if(endTime==""){
		$("#END_TIME").tips({
			side:3,
            msg:'本卡使用有效期不能为空',
            bg:'#AE81FF',
            time:2
        });
		$("#END_TIME").focus();
		return false;
	}

	charge = '' != charge?charge:0;
	serviceChage = '' != serviceChage?serviceChage:0;
	balance = '' != balance?balance:0;
	serviceBalance = '' != serviceBalance?serviceBalance:0;
	
	let field={
			CARD_NO:cardNo,
			CARD_ID:cardId,
			CARD_NAME:cardName,
			CHARGE:charge,
			SERVICE_CHAGE:serviceChage,
			BALANCE:balance,
			SERVICE_BALANCE:serviceBalance,
			BUY_TIME:buyTime,
			END_TIME:endTime
	};
	
	if(msgIndex == ''){
		arrayField(field);
	}else{
		editArrayField(field,msgIndex);
	}
	$("#dialog-add").css("display","none");
}

function selectType(cardId){
	let selected='';
	let html='<option value="">请选择</option>';
	let selector=document.getElementById('CARD_ID');
	
	$.ajax({
		type: "POST",
		url: basePath + 'beautycard/listAll.do',
		dataType:'json',
		cache: false,
		success: function(data){
			for(let i=0;i<data.length;i++){
				if(cardId && cardId==data[i].CARD_ID){
					selected=' selected="true"';
				}
				html = html + '<option value="'+data[i].CARD_ID+'"'+ selected +'>'+data[i].CARD_NAME+'</option>';
			}
			selector.innerHTML=html;
		}
	});
}

function selectCard(){
	$("#CARD_NAME").val($('#SELECT_CARD_ID option:selected').text());
}

function sumBalance(type){
	var charge = (null == $("#CHARGE").val() || '' == $("#CHARGE").val()) ? 0 : parseInt($("#CHARGE").val());
	var serviceCharge = (null == $("#CHARGE").val() || '' == $("#SERVICE_CHAGE").val()) ? 0 : parseInt($("#SERVICE_CHAGE").val());
	var balance = (null == $("#BALANCED").val() || '' == $("#BALANCED").val()) ? 0 : parseInt($("#BALANCED").val());
	var serviceBalance = (null == $("#SERVICE_BALANCED").val() || '' == $("#SERVICE_BALANCED").val()) ? 0 : parseInt($("#SERVICE_BALANCED").val());
	if (type == '1') {
		$("#BUY_TIME").val(((new Date()).toLocaleDateString()).replace('/','-').replace('/','-'));
		$("#BALANCE").val(balance + charge);
	} else if (type == '0') {
		$("#SERVICE_BALANCE").val(serviceBalance + serviceCharge);
	}
}

//打开编辑属性(新增)
function dialog_open(){
	$("#dialog-add").css("display","block");
	selectType('');
	$("#msgIndex").val('');
	$("#CARD_NO").val('');
	$("#CARD_ID").val('');
	$("#CARD_NAME").val('');
	$("#CHARGE").val('');
	$("#SERVICE_CHAGE").val('');
	$("#CHARGED").val('');
	$("#SERVICE_CHAGED").val('');
	$("#BALANCE").val('');
	$("#SERVICE_BALANCE").val('');
	$("#BUY_TIME").val('');
	$("#END_TIME").val('');
}

//打开编辑属性(修改)
function editField(msgIndex){
	$("#dialog-add").css("display","block");
	$("#CARD_NO").val(fieldarray[msgIndex].CARD_NO);
	selectType(fieldarray[msgIndex].CARD_ID);
	$("#CARD_NAME").val(fieldarray[msgIndex].CARD_NAME);
	$("#CHARGE").val('0');
	$("#SERVICE_CHAGE").val('0');
	$("#CHARGED").val(fieldarray[msgIndex].CHARGE);
	$("#SERVICE_CHAGED").val(fieldarray[msgIndex].SERVICE_CHAGE);
	$("#BALANCE").val(fieldarray[msgIndex].BALANCE);
	$("#BALANCED").val(fieldarray[msgIndex].BALANCE);
	$("#SERVICE_BALANCE").val(fieldarray[msgIndex].SERVICE_BALANCE);
	$("#SERVICE_BALANCED").val(fieldarray[msgIndex].SERVICE_BALANCE);
	$("#BUY_TIME").val(fieldarray[msgIndex].BUY_TIME);
	$("#BUY_TIMED").val(fieldarray[msgIndex].BUY_TIME);
	$("#END_TIME").val(fieldarray[msgIndex].END_TIME);
	$("#msgIndex").val(msgIndex);			//数组ID
}

//关闭编辑属性
function cancel_pl(){
	$("#dialog-add").css("display","none");
}

//追加属性列表
function appendC(field){
	$("#fields").append(
		'<tr>'+
		'<td class="center">'+Number(index+1)+'</td>'+
		'<td class="center">'+field.CARD_NO+'</td>'+
		'<td class="center"><input type="hidden" name="CARD_ID" id="CARD_ID" value="'+field.CARD_ID+'"/>'+field.CARD_NAME+'</td>'+
		'<td class="center">'+field.CHARGE+'</td>'+
		'<td class="center">'+field.SERVICE_CHAGE+'</td>'+
		'<td class="center">'+field.BALANCE+'</td>'+
		'<td class="center">'+field.SERVICE_BALANCE+'</td>'+
		'<td class="center">'+field.BUY_TIME+'</td>'+
		'<td class="center">'+field.END_TIME+'</td>'+
		'<td class="center" style="width:100px;">'+
		'<a class="btn btn-mini btn-info" title="编辑" onclick="editField(\''+index+'\')"><i class="ace-icon fa fa-pencil-square-o bigger-120"></i></a>&nbsp;'+
		'<a class="btn btn-mini btn-danger" title="删除" onclick="removeField(\''+index+'\')"><i class="ace-icon fa fa-trash-o bigger-120"></i></a>'+
		'</td>'+
		'</tr>'
	);
	index++;
	$("#zindex").val(index);
}

//保存属性后往数组添加元素
function arrayField(value){
	fieldarray.push(value);
	appendC(value);
}

//修改属性
function editArrayField(value,msgIndex){
	fieldarray[msgIndex] = value;
	index = 0;
	$("#fields").html('');
	for(var i=0;i<fieldarray.length;i++){
		appendC(fieldarray[i]);
	}
}

//删除数组添加元素并重组列表
function removeField(value){
	index = 0;
	$("#fields").html('');
	fieldarray.splice(value,1);
	for(var i=0;i<fieldarray.length;i++){
		appendC(fieldarray[i]);
	}
}

function cancelQrcode(){
	$("#imgAD").attr("style","display:none");
	$("#ICON").val("");
}

//选择图片
function chooseImg() {
	top.jzts();
	var diag = new top.Dialog();
	 diag.Drag=false;
	 diag.Title ="选择图片";
	 diag.URL = '<%=basePath%>pictures/listChoose.do?flag='+'';
	 diag.Width = 800;
	 diag.Height = 600;
	 diag.Modal = false;			//有无遮罩窗口
	 diag.ShowMaxButton = true;		//最大化按钮
     diag.ShowMinButton = true;		//最小化按钮
	 diag.CancelEvent = function(){ //关闭事件
		diag.close();
	 };
	 diag.show();
}
