		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
		<meta charset="utf-8" />
		<title>${pd.SYSNAME}</title>
		<meta name="description" content="" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
		<!-- bootstrap & fontawesome -->
		<link rel="stylesheet" href="static/ace/css/bootstrap.css" />
		<link rel="stylesheet" href="static/ace/css/font-awesome.css" />
		<link rel="stylesheet" href="static/css/common.css" />
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
		<link rel="stylesheet" href="plugins/lightbox2/css/lightbox.min.css" />
		<link rel="stylesheet" href="plugins/lightbox2/jquery.lightbox-0.5.css" />
		<link rel="stylesheet" href="plugins/inputcombo/combo.select.css" />
		<style>
		.beauty_img_iframe{
			width:100%;
			border:none;
			height:50px;
		}
		</style>
		<script src="static/ace/js/ace-extra.js"></script>
		<script src="static/js/jquery-3.1.1.js"></script>
		<script src="plugins/inputcombo/jquery.combo.select.js"></script>
		<script type="text/javascript">
		$(function() {
		    $('.inputcombo').comboSelect();
		    $('.inputcombo ').parent().find('.combo-input.text-input').change(function(){
    			$(this).parent().find('.inputcombo option').removeAttr("selected");
		    	$.each($(this).parent().find('.inputcombo option'),function(index,val){
		    		if($(val).text() == $(this).val()){
		    			$(val).attr('selected','selected');
		    		}
		    	});
		    });
		});
		</script>
		<!-- HTML5shiv and Respond.js for IE8 to support HTML5 elements and media queries -->
		<!--[if lte IE 8]>
		<script src="static/ace/js/html5shiv.js"></script>
		<script src="static/ace/js/respond.js"></script>
		<![endif]-->
