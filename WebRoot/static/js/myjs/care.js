"use strict";
$(function(){
	//绑定数据到控件
	function bindData(data){
		let care=data.care;
		
		$("#NAME").val(care.NAME);
		$("#NAME_EN").val(care.NAME_EN);
		$("#DETAILS").val(care.DETAILS);
		$("#FLOWS").val(care.FLOWS);
		$("#TIMER").val(care.TIMER);
		
		let careprice=data.careprice;
		for(let i=0;i<careprice.length;i++){
			let field={
				NAME:careprice[i].NAME,
				NAME_EN:careprice[i].NAME_EN,
				PRICE:careprice[i].PRICE,
				PURCHACE_PRICE:careprice[i].PURCHACE_PRICE,
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
				url: basePath + 'care/editInfo.do',
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
	if($("#NAME").val()==""){
		$("#NAME").tips({
			side:3,
            msg:'服务不能为空',
            bg:'#AE81FF',
            time:2
        });
		$("#NAME").focus();
		return false;
	}
	
	if(!fieldarray.length){
		$("#addCarePrice").tips({
			side:3,
            msg:'请添加服务价格',
            bg:'#AE81FF',
            time:2
        });
		$("#addCarePrice").focus();
		return false;
	}
	
	let careData ={
		NAME: $("#NAME").val(),
		NAME_EN: $("#NAME_EN").val(),
		DETAILS: $("#DETAILS").val(),
		FLOWS: $("#FLOWS").val(),
		TIMER: $("#TIMER").val(),
		fieldarray: fieldarray
	}
	
	let uri='care/save.do';
	if($("#ID").val()!="" && $("#ID").val()!="add"){
		careData.ID = $("#ID").val();
		uri='care/edit.do';
	}

	$.ajax({
		type: "POST",
		url: basePath + uri,
    	data: careData,
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

//添加服务价格
function saveD(){
	var msgIndex = $("#msgIndex").val();
	
	var priceName = $("#PRICE_NAME").val();
	var priceNameEn = $("#PRICE_NAME_EN").val();
	var price = $("#PRICE").val();
	var purchacePrice = $("#PURCHACE_PRICE").val();

	if(priceName==""){
		$("#PRICE_NAME").tips({
			side:3,
            msg:'服务名不能为空',
            bg:'#AE81FF',
            time:2
        });
		$("#PRICE_NAME").focus();
		return false;
	}

	purchacePrice = '' != purchacePrice?purchacePrice:0;
	price = '' != price?price:0;
	
	let field={
			NAME:priceName,
			NAME_EN:priceNameEn,
			PURCHACE_PRICE:purchacePrice,
			PRICE:price
	};
	
	if(msgIndex == ''){
		arrayField(field);
	}else{
		editArrayField(field,msgIndex);
	}
	$("#dialog-add").css("display","none");
}

//打开编辑属性(新增)
function dialog_open(){
	$("#dialog-add").css("display","block");
	$("#msgIndex").val('');
	$("#PRICE_NAME").val('');
	$("#PRICE_NAME_EN").val('');
	$("#PRICE").val('');
	$("#PURCHACE_PRICE").val('');
}

//打开编辑属性(修改)
function editField(msgIndex){
	$("#dialog-add").css("display","block");
	$("#PRICE_NAME").val(fieldarray[msgIndex].NAME);
	$("#PRICE_NAME_EN").val(fieldarray[msgIndex].NAME_EN);
	$("#PRICE").val(fieldarray[msgIndex].PRICE);
	$("#PURCHACE_PRICE").val(fieldarray[msgIndex].PURCHACE_PRICE);
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
		'<td class="center">'+field.NAME+'</td>'+
		'<td class="center">'+field.NAME_EN+'</td>'+
		'<td class="center">'+field.PRICE+'</td>'+
		'<td class="center">'+field.PURCHACE_PRICE+'</td>'+
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
