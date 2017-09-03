"use strict";
$(function(){
	//绑定数据到控件
	function bindData(data){
		let order=data.order;
		if(!order.TO_ID){
			flag=false;
			$("#spanTag").text("非系统客户");
			$("#TO_NAME").show();
			$("#TO_ID_DIV").hide();
			$("#DISCUT").val('10');
			$("#TO_ID option[value='']").attr("selected",true);
		}
		$("#TO_ID").val(order.TO_ID);
		let selector=document.getElementById('PAY_CARD_NO');
		getCardbyCust(order.TO_ID,selector,order.PAY_CARD_NO);
		selectCard(order.PAY_CARD_NO);
		$('#TO_ID').next().children().children('span')[0].innerHTML=order.TO_NAME;
		$("#TO_NAME").val(order.TO_NAME);
		$("#TO_WECHAT").val(order.TO_WECHAT);
		$("#TO_QQ").val(order.TO_QQ);
		$("#TO_ADDRESS").val(order.TO_ADDRESS);
		$("#TO_MOBILE").val(order.TO_MOBILE);
		$("#TAKYUBIN_FEE").val(order.TAKYUBIN_FEE);
		$("#STAFF").val(order.STAFF);
		$("#STATUS").find("option[value='"+order.STATUS+"']").attr("selected",true);
		$("#PAY_TYPE").find("option[value='"+order.PAY_TYPE+"']").attr("selected",true);
		let orderDetails=data.orderDetails;
		for(let i=0;i<orderDetails.length;i++){
			let field={
				TYPE:orderDetails[i].TYPE,
				GOODS_ID:orderDetails[i].GOODS_ID,
				GOODS_NAME:orderDetails[i].GOODS_NAME,
				PURCHACE_PRICE:orderDetails[i].PURCHACE_PRICE,
				PRICE:orderDetails[i].PRICE,
				GOODS_NUM:orderDetails[i].GOODS_NUM,
				IS_DISCUT:orderDetails[i].IS_DISCUT=="1"?true:false,
			};
			arrayField(field);
		}
	}
	
	//判断是否是修改订单
	if($("#ID").val()!="" && $("#ID").val()!="add"){
		$('#switchCust').hide();
		$.ajax({
			type: "POST",
			url: basePath + 'beautyorder/editInfo.do',
	    	data: {ID:$("#ID").val()},
			dataType:'json',
			cache: false,
			success: function(data){
				bindData(data);
			}
		});
	}

	//判断是否是添加订单
	if($("#type").val()!=""){
		let type = $("#type").val();
		let orderDetails = $("#orderDetails").val();
		let orderDtlArr = orderDetails.split(/<<>>/);
		for(let i = 0;i<orderDtlArr.length;i++){
			let orderDtl = orderDtlArr[i];
			let fields = orderDtl.split(',');
			let fieldObj={TYPE:type};
			for(let j = 0;j<fields.length;j++){
				let field = fields[j].split(':');
				switch (field[0]){
					case 'GOODS_ID': fieldObj.GOODS_ID = field[1];break;
					case 'GOODS_NAME': fieldObj.GOODS_NAME = field[1];break;
					case 'PURCHACE_PRICE': fieldObj.PURCHACE_PRICE = field[1];break;
					case 'PRICE': fieldObj.PRICE = field[1];break;
					case 'GOODS_NUM': fieldObj.GOODS_NUM = field[1];break;
					default : break;
				}
			}
			//服务默认打折
			fieldObj.IS_DISCUT = type=='4'?true:false;
			arrayField(fieldObj);
		}
	}
});

var flag = true;

//保存
function save(){
	if($("#TO_ID").val()=="" && flag){
		alert('请选择客户');
		return false;
	}
	if($("#TO_NAME").val()=="" && !flag){
		$("#TO_NAME").tips({
			side:3,
            msg:'客户不能为空',
            bg:'#AE81FF',
            time:2
        });
		$("#TO_NAME").focus();
		return false;
	}
	if($("#PAY_TYPE").val()==""){
		$("#PAY_TYPE").tips({
			side:3,
            msg:'请选择支付种类',
            bg:'#AE81FF',
            time:2
        });
		$("#PAY_TYPE").focus();
		return false;
	}
	if($("#PAY_TYPE").val()=="10" && $("#PAY_CARD_NO").val()==""){
		$("#PAY_CARD_NO").tips({
			side:3,
            msg:'请选择会员卡号',
            bg:'#AE81FF',
            time:2
        });
		$("#PAY_CARD_NO").focus();
		return false;
	}
	if($("#STATUS").val()==""){
		$("#STATUS").tips({
			side:3,
            msg:'请选择订单状态',
            bg:'#AE81FF',
            time:2
        });
		$("#STATUS").focus();
		return false;
	}
	if(!fieldarray.length){
		$("#addGoods").tips({
			side:3,
            msg:'请添加商品',
            bg:'#AE81FF',
            time:2
        });
		$("#addGoods").focus();
		return false;
	}
	
	let orderData ={
		TO_ID: $("#TO_ID").val(),
		TO_NAME: $("#TO_NAME").val(),
		TO_QQ: $("#TO_QQ").val(),
		TO_MOBILE: $("#TO_MOBILE").val(),
		TO_ADDRESS: $("#TO_ADDRESS").val(),
		TO_WECHAT: $("#TO_WECHAT").val(),
		STAFF: $("#STAFF").val(),
		PAY_TYPE: $("#PAY_TYPE").val(),
		PAY_CARD_NO: $("#PAY_CARD_NO").val(),
		TAKYUBIN_FEE: $("#TAKYUBIN_FEE").val(),
		STATUS: $("#STATUS").val(),
		fieldarray: $("#STATUS").val()=="2"?fieldarray:copyArray,
	}
	
	let orderUri='beautyorder/save.do';
	if($("#ID").val()!="" && $("#ID").val()!="add"){
		orderData.ID = $("#ID").val();
		orderUri='beautyorder/edit.do';
	}

	$.ajax({
		type: "POST",
		url: basePath + orderUri,
    	data: orderData,
		dataType:'json',
		cache: false,
		success: function(data){
			if(data.msg=='success'){
				close();
			}else if(data.msg=='fail'){
				alert('系统异常！！！');
			}else{
				alert(data.msg);
			}
		},
		error:function(err){
		}
	});
}

//关闭Dialog
function close(){
	$("#zhongxin").hide();
	$("#zhongxin2").show();
	top.Dialog.close();
}

// 根据销售种类获取uri
function uriByType(type){
	$('#carePrice').hide();
	$('.commitbox_inner').css('height','180px'); 
	$('.commitbox_top').css('height','180px'); 
	switch(type){
		case '1' : uri = '';break;
		case '2' : uri = 'beautygoods';break;
		case '3' : uri = 'beautycard';break;
		case '4' : 
			uri = 'care';
			$('#carePrice').show();
			$('.commitbox_inner').css('height','210px'); 
			$('.commitbox_top').css('height','210px');
			break;
		default :  break;
	}
}

//选择销售种类
function selectType(type,goodsId){
	let selected='';
	let html='<option value="">请选择</option>';
	let selector=document.getElementById('GOODS_ID');
	document.getElementById("discount").checked = type=='4'?true:false;
	uriByType(type);
	$.ajax({
		type: "POST",
		url: basePath + uri + '/listAll.do',
		dataType:'json',
		cache: false,
		success: function(data){
			for(let i=0;i<data.length;i++){
				if(goodsId && goodsId==data[i].GOODS_ID){
					selected=' selected="true"';
					if(type=='4'){
						loadCarePrice(data[i].GOODS_ID);
					}
				}
				html = html + '<option value="'+data[i].GOODS_ID+'"'+ selected +'>'+data[i].GOODS_NAME+'</option>';
				selected='';
			}
			selector.innerHTML=html;
		}
	});
}

//选择商品
function selectGoods(goods){
	carePriceArr = [];
	$("#GOODS_NAME").val(goods.options[goods.options.selectedIndex].text);
	//卡
	if($("#TYPE").val()=='3'){
		$("#PURCHACE_PRICE").val('0');
		$("#PRICE").val('0');
		return;
	}
	$.ajax({
		type: "POST",
		url: basePath + uri +'/byId.do',
    	data: {ID:goods.value},
		dataType:'json',
		cache: false,
		success: function(data){
			//服务
			if($('#TYPE').val()=='4'){
				let selector=document.getElementById('SUB_ID');
				let html='<option value="9999">请选择</option>';
				for(let i=0;i<data.length;i++){
					html = html + '<option value="'+data[i].SUB_ID+'">'+data[i].NAME+'</option>';
					let carePrice = {
							SUB_ID:data[i].SUB_ID,
							NAME:data[i].NAME,
							PURCHACE_PRICE:data[i].PURCHACE_PRICE,
							PRICE:data[i].PRICE,
					};
					carePriceArr.push(carePrice);
				}
				selector.innerHTML=html;
			} else if ($('#TYPE').val()=='2') {
				$("#PURCHACE_PRICE").val(data.PURCHACE_PRICE);
				$("#PRICE").val(data.PRICE);
				$("#GOODS_NUM").attr('placeholder','当前库存为'+data.STOCK);
			} else{
				$("#PURCHACE_PRICE").val(data.PURCHACE_PRICE);
				$("#PRICE").val(data.PRICE);
			}
		}
	});
}

//加载服务价格
function loadCarePrice(id){
//	if($("#orderDetails").val() == '') return;
	$.ajax({
		type: "POST",
		url: basePath +'care/byId.do',
		data: {ID:id},
		dataType:'json',
		cache: false,
		success: function(data){
			let selector=document.getElementById('SUB_ID');
			let html='<option value="9999">请选择</option>';
			for(let i=0;i<data.length;i++){
				html = html + '<option value="'+data[i].SUB_ID+'">'+data[i].NAME+'</option>';
				let carePrice = {
					SUB_ID:data[i].SUB_ID,
					NAME:data[i].NAME,
					PURCHACE_PRICE:data[i].PURCHACE_PRICE,
					PRICE:data[i].PRICE,
				};
				carePriceArr.push(carePrice);
			}
			selector.innerHTML=html;
		}
	});
}

//选择服务价格
function selectCarePrice(id){
	if($("#GOODS_ID").val()=='') {
		alert('请先选择商品');
		return;
	}
	if(!carePriceArr.length) {
		alert('该服务没有价格，请手动填写');
		return;
	}

	if(carePriceArr.length){
		carePriceArr.forEach(item=>{
			if(id==item.SUB_ID){
				$("#PURCHACE_PRICE").val(item.PURCHACE_PRICE);
				$("#PRICE").val(item.PRICE);
			}
		});
	}
}

//选择客户
function selectCustomer(value){
	$.ajax({
		type: "POST",
		url: basePath + 'customer/byId.do',
    	data: {ID:value},
		dataType:'json',
		cache: false,
		success: function(data){
			$("#TO_MOBILE").val(data.MOBILE_PHONE);
			$("#TO_NAME").val(data.USER_NAME);
			$("#TO_WECHAT").val(data.WECHAT_ID);
			$("#TO_QQ").val(data.QQ);
			$("#TO_ADDRESS").val(data.ADDRESS);
			let selector=document.getElementById('PAY_CARD_NO');
			
			if($('#PAY_TYPE').val()=='10'){
				$('#DISCUT').val("10");
				getCardbyCust(value,selector);
			}else{
				discutArr=[];
				$('#DISCUT').val("10");
				selector.innerHTML='<option value="">请选择</option>';
				copyArr(fieldarray);
			}
		}
	});
}

//选择客户类型
function selectCustType() {
	bootbox.confirm("确定要切换吗?这样将清空数据！！！", function(result) {
		if(result) {
			if (flag) {
				$("#spanTag").text("非系统客户");
				$("#TO_NAME").show();
				$("#TO_ID_DIV").hide();
			} else {
				$("#spanTag").text("系统客户");
				$("#TO_ID_DIV").show();
				$("#TO_NAME").hide();
			}
			$("#DISCUT").val('10');
			copyArr(fieldarray);
			$("#TO_ID").val('');
			$('#TO_ID').next().children().children('span')[0].innerHTML='';
			$("#TO_NAME").val('');
			$("#TO_MOBILE").val('');
			$("#TO_WECHAT").val('');
			$("#TO_QQ").val('');
			$("#TO_ADDRESS").val('');
			$("#TO_MOBILE").val('');
			$("#TO_WECHAT").val(''),
			$("#STAFF").val('');
			$("#PAY_TYPE").val('');
			$("#PAY_CARD_NO").val('');
			$("#TAKYUBIN_FEE").val('0');
			$("#STATUS").val('');
			flag = !flag;
			let html='<option value="">请选择</option>';
			let selector=document.getElementById('PAY_CARD_NO');
			selector.innerHTML=html;
		}
	});
}

//选择会员卡
function selectCard(value){
	if(value!=''){
		discutArr.forEach(item=>{
			if(item.cardNo==value && item.discut){
				$('#DISCUT').val(item.discut);
			}
		});
	}
	copyArr(fieldarray);
}

//加载会员卡
function onloadCard(value){
	let selector=document.getElementById('PAY_CARD_NO');
	if(value!='10'){
		discutArr=[];
		$('#DISCUT').val("10");
		selector.innerHTML='<option value="">请选择</option>';
		copyArr(fieldarray);
		return;
	}
	if(value=='10'){
		if(!flag){
			alert('不是系统客户，没有会员卡，不能选择会员卡支付！！！');
			$("#PAY_TYPE").val('');
			return false;
		}
		if($("#TO_ID").val()==""){
			$("#TO_ID").tips({
				side:3,
	            msg:'客户不能为空',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#PAY_TYPE").val('');
			$("#TO_ID").focus();
			return false;
		}

		getCardbyCust($("#TO_ID").val(),selector);
	}
}

//获取客户卡信息
function getCardbyCust(id,selector,payCardNo){
	let html='<option value="">请选择</option>';
	$.ajax({
		type: "POST",
		url: basePath + 'customer/findByCustomer.do',
		data: {ID:id},
		dataType:'json',
		async: false,
		cache: false,
		success: function(data){
			discutArr=[];
			for(let i=0;i<data.length;i++){
				let discut={cardNo:data[i].CARD_NO,discut:data[i].DISCUT};
				discutArr.push(discut);
				if(payCardNo && payCardNo==data[i].CARD_NO){
					html = html + '<option value="'+data[i].CARD_NO+'" selected>'+data[i].CARD_NO+'</option>';
				}else{
					html = html + '<option value="'+data[i].CARD_NO+'">'+data[i].CARD_NO+'</option>';
				}
			}
			selector.innerHTML=html;
			console.log(discutArr);
		},
		error:function(err){
		}
	});
}

//添加商品
function addGoods(){
	var msgIndex = $("#msgIndex").val(); 	 //msgIndex不为空时是修改
	var type = $("#TYPE").val(); 	 		 			//销售种类
	var goodsName = $("#GOODS_NAME").val(); 	 		//商品名称
	var goodsId = $("#GOODS_ID").val(); 	 		 	//商品ID
	var purchacePrice = $("#PURCHACE_PRICE").val(); 	//成本价
	var price = $("#PRICE").val(); 		 				//实际售价
	var goodsNum = $("#GOODS_NUM").val(); 	 			//商品数量

	if(type==""){
		$("#TYPE").tips({
			side:3,
            msg:'请选择销售种类',
            bg:'#AE81FF',
            time:2
        });
		$("#TYPE").focus();
		return false;
	}

	if(goodsId==""){
		$("#GOODS_ID").tips({
			side:3,
            msg:'请选择商品',
            bg:'#AE81FF',
            time:2
        });
		$("#GOODS_ID").focus();
		return false;
	}
	
	if(carePriceArr.length && $("#SUB_ID").val()=='') {
		$("#SUB_ID").tips({
			side:3,
            msg:'请选择服务价格',
            bg:'#AE81FF',
            time:2
        });
		$("#SUB_ID").focus();
		return false;
	}
	
	if(price==""){
		$("#PRICE").tips({
			side:3,
            msg:'请输入实际售价',
            bg:'#AE81FF',
            time:2
        });
		$("#PRICE").focus();
		return false;
	}
	
	if(goodsNum==""){
		$("#GOODS_NUM").tips({
			side:3,
            msg:'请输入商品数量',
            bg:'#AE81FF',
            time:2
        });
		$("#GOODS_NUM").focus();
		return false;
	}
	
	if('' == purchacePrice) purchacePrice = 0;
	
	let field={
			TYPE:type,
			GOODS_ID:goodsId,
			GOODS_NAME:goodsName,
			PURCHACE_PRICE:purchacePrice,
			PRICE:price,
			GOODS_NUM:goodsNum,
			IS_DISCUT:$("#discount").is(':checked'),
	};
	
	msgIndex == ''?arrayField(field):editArrayField(field,msgIndex);
	$("#dialog-add").css("display","none");
}

//打开编辑属性(新增)
function insertField(){
	$("#dialog-add").css("display","block");
	$("#msgIndex").val('');
	$("#TYPE option[value='']").attr("selected",true);
	$("#GOODS_NAME").val('');
	$("#PURCHACE_PRICE").val('');
	$("#PRICE").val('');
	$("#GOODS_NUM").val('');
	document.getElementById("discount").checked = false;
}

//打开编辑属性(修改)
function editField(msgIndex){
	$("#dialog-add").css("display","block");
	selectType(fieldarray[msgIndex].TYPE,fieldarray[msgIndex].GOODS_ID);
	let obj = document.getElementById("TYPE");
    for(let i=0,length=obj.length;i<length;i++){
        obj[i].selected = obj[i].value==fieldarray[msgIndex].TYPE?true:false;
    }
	$("#GOODS_NAME").val(fieldarray[msgIndex].GOODS_NAME);
	$("#PURCHACE_PRICE").val(fieldarray[msgIndex].PURCHACE_PRICE);
	$("#PRICE").val(fieldarray[msgIndex].PRICE);
	$("#GOODS_NUM").val(fieldarray[msgIndex].GOODS_NUM);
	document.getElementById("discount").checked = fieldarray[msgIndex].IS_DISCUT;
	$("#msgIndex").val(msgIndex);			//数组ID
}

//关闭编辑属性
function cancel_pl(){
	$("#dialog-add").css("display","none");
}

//追加属性列表
function appendC(field){
	let typeName='';
	switch(field.TYPE){
		case '1' : typeName='护肤记录';break;
		case '2' : typeName='产品';break;
		case '3' : typeName='卡';break;
		case '4' : typeName='服务';break;
		default :  break;
	}

	$("#fields").append(
		'<tr>'+
		'<td class="center">'+Number(index+1)+'</td>'+
		'<td class="center">'+typeName+'</td>'+
		'<td class="center">'+field.GOODS_NAME+'</td>'+
		(showPurchacePrice?'<td class="center">'+field.PURCHACE_PRICE+'</td>':'')+
		'<td class="center">'+field.PRICE+'</td>'+
		'<td class="center">'+field.GOODS_NUM+'</td>'+
		'<td class="center">'+
		'<input type="checkbox" class="ace" id="hasDiscunt'+index+'" onchange="hasDiscunt(\''+index+'\')"'+(field.IS_DISCUT?' checked':'')+'><span class="lbl"></span>'+
		'</td>'+
		'<td class="center" style="width:100px;">'+
		'<a class="btn btn-mini btn-info" title="编辑" onclick="editField(\''+index+'\')"><i class="ace-icon fa fa-pencil-square-o bigger-120"></i></a>&nbsp;'+
		'<a class="btn btn-mini btn-danger" title="删除" onclick="removeField(\''+index+'\')"><i class="ace-icon fa fa-trash-o bigger-120"></i></a>'+
		'</td>'+
		'</tr>'
	);
	index++;
	$("#zindex").val(index);
}

//是否打折
function hasDiscunt(index){
	let goods = fieldarray[index];
	goods.IS_DISCUT = $("#hasDiscunt"+index).is(':checked');
	editArrayField(goods,index);
}

//保存属性后往数组添加元素
function arrayField(value){
	if(fieldarray.isRepeatField(value)){
		alert("该商品已添加，请确认！！");
		return;
	}
	fieldarray.push(value);
	copyArr(fieldarray);
}

//修改属性
function editArrayField(value,msgIndex){
	if(fieldarray.isRepeatField(value,msgIndex)){
		alert("该商品已添加，请确认！！");
		return;
	}
	fieldarray[msgIndex] = value;
	copyArr(fieldarray);
}

//删除数组添加元素并重组列表
function removeField(value){
	fieldarray.splice(value,1);
	copyArr(fieldarray);
}

//数组拷贝及打折处理
function copyArr(fieldarray){
	copyArray = [];
	
	let payType = $("#PAY_TYPE").val();
	index = 0;
	$("#fields").html('');
	fieldarray.forEach(item=>{
		let temp = deepCopy(item);
		if(payType == 10 && temp.TYPE == '2'){
			temp.PRICE = temp.PRICE - 5;
		}
		if(temp.IS_DISCUT){
			temp.PRICE=temp.PRICE * $("#DISCUT").val() / 10;
		}
		copyArray.push(temp);
		appendC(temp);
	});
}

//对象深复制
function deepCopy(obj) {
	let res = {};
	for (var key in obj) {
		res[key] = obj[key];
	}
	return res;
}

//判断数组里的商品是否重复
Array.prototype.isRepeatField = function(obj,msgIndex){
	let state= false;
	this.forEach((item,index,arr)=>{
		if(item.TYPE == obj.TYPE && item.GOODS_ID == obj.GOODS_ID){
			if(typeof msgIndex =='undefined'){
				state= true;
				return;
			}
			if(msgIndex != index){
				state= true;
				return;
			}
		}
	});
	return state;
}
