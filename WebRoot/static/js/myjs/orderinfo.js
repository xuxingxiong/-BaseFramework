"use strict";
$(function(){
	//绑定数据到控件
	function bindData(data){
		let order=data.order;
		if(!order.TO_ID){
			$("#spanTag").text("非系统客户");
		}
		$("#TO_NAME").val(order.TO_NAME);
		$("#TO_WECHAT").val(order.TO_WECHAT);
		$("#TO_QQ").val(order.TO_QQ);
		$("#TO_ADDRESS").val(order.TO_ADDRESS);
		$("#TO_MOBILE").val(order.TO_MOBILE);
		$("#TAKYUBIN_FEE").val(order.TAKYUBIN_FEE);
		$("#STAFF").val(order.STAFF);
		$("#PAY_CARD_NO").val(order.PAY_CARD_NO);
		$("#STATUS").val(selectStatus(order.STATUS));
		$("#PAY_TYPE").val(selectCard(order.PAY_TYPE+''));
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

});

function selectStatus(type){
	switch(type){
		case '0' : return '成功';
		case '1' : return '失败';
		case '2' : return '未支付';
		default :  return;
	}
}

function selectCard(type){
	switch(type){
		case '10' : return '会员卡';
		case '1' : return '非会员卡';
		default :  return;
	}

}

//保存属性后往数组添加元素
function arrayField(value){
	fieldarray.push(value);
	appendC(value);
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
		(showPurchacePrice?('<td class="center">'+field.PURCHACE_PRICE+'</td>'):'')+
		'<td class="center">'+field.PRICE+'</td>'+
		'<td class="center">'+field.GOODS_NUM+'</td>'+
		'</tr>'
	);
	index++;
	$("#zindex").val(index);
}

