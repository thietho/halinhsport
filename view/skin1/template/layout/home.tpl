<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="<?php echo $direction; ?>" lang="<?php echo $language; ?>" xml:lang="<?php echo $language; ?>">
<head>
<link type="image/x-icon" href="<?php echo HTTP_SERVER.DIR_IMAGE?>logo-small.png" rel="icon">
<link type="image/x-icon" href="<?php echo HTTP_SERVER.DIR_IMAGE?>logo-small.png" rel="shortcut icon">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="robots" content="INDEX,FOLLOW" />
<meta http-equiv="REFRESH" content="5400" />
<meta name="description" content="<?php echo $meta_description?>" />
<meta name="keywords" content="<?php echo $meta_keyword?>" />		
<title><?php echo $title?></title>
<meta property="og:title" content="<?php echo $title?>">
<meta property="og:type" content="Website">
<meta property="og:url" content="<?php echo $url?>">
<meta property="og:description" content="<?php echo $meta_description?>">
<?php echo $meta_image?>

</head>

<!--[if lt IE 7]>
	<link href="<?php echo DIR_VIEW?>css/ie_style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="<?php echo DIR_VIEW?>js/ie_png.js"></script>
    <script type="text/javascript">
       ie_png.fix('.png');
	</script>
<![endif]-->
<link rel='stylesheet' type='text/css' href='<?php echo HTTP_SERVER.DIR_VIEW?>css/style.css'>
<link rel='stylesheet' type='text/css' href='<?php echo HTTP_SERVER.DIR_CSS?>blockui.css'>
<link rel='stylesheet' type='text/css' href='<?php echo HTTP_SERVER.DIR_VIEW?>css/jquery-ui.css'>
<link rel='stylesheet' type='text/css' href='<?php echo HTTP_SERVER.DIR_CSS?>jquery.tabs.css'>

<link rel='stylesheet' type='text/css' href='<?php echo HTTP_SERVER.DIR_VIEW?>css/niceform.css'>
<link rel='stylesheet' type='text/css' href='<?php echo HTTP_SERVER.DIR_CSS?>product.css'>

<script type='text/javascript' language='javascript' src='<?php echo HTTP_SERVER.DIR_VIEW?>js/jquery.js'></script>
<script type='text/javascript' language='javascript' src='<?php echo HTTP_SERVER.DIR_JS?>jquery.blockUI.js'></script>

<script src="<?php echo HTTP_SERVER.DIR_JS?>jquery.bgiframe-2.1.2.js"></script>
<script src="<?php echo HTTP_SERVER.DIR_JS?>jquery.ui.core.js"></script>
<script src="<?php echo HTTP_SERVER.DIR_JS?>jquery.ui.widget.js"></script>
<script src="<?php echo HTTP_SERVER.DIR_JS?>jquery.ui.mouse.js"></script>
<script src="<?php echo HTTP_SERVER.DIR_JS?>jquery.ui.button.js"></script>
<script src="<?php echo HTTP_SERVER.DIR_JS?>jquery.ui.draggable.js"></script>
<script src="<?php echo HTTP_SERVER.DIR_JS?>jquery.ui.position.js"></script>
<script src="<?php echo HTTP_SERVER.DIR_JS?>jquery.ui.resizable.js"></script>
<script src="<?php echo HTTP_SERVER.DIR_JS?>jquery.ui.dialog.js"></script>
<script src="<?php echo HTTP_SERVER.DIR_JS?>jquery.effects.core.js"></script>

<script type='text/javascript' language='javascript' src='<?php echo HTTP_SERVER.DIR_VIEW?>js/maxheight.js'></script>
<script type='text/javascript' language='javascript' src='<?php echo HTTP_SERVER.DIR_VIEW?>js/jquery.tabs.pack.js'></script>
<script type='text/javascript' language='javascript' src='<?php echo HTTP_SERVER.DIR_VIEW?>js/ui.datepicker.js'></script>

<script type='text/javascript' language='javascript' src='<?php echo HTTP_SERVER.DIR_COMPONENT?>ckeditor/ckeditor.js'></script>
<script language="javascript">
var HTTP_SERVER = '<?php echo HTTP_SERVER?>';
</script>
<script type='text/javascript' language='javascript' src='<?php echo HTTP_SERVER.DIR_VIEW?>js/common.js'></script>
<script type='text/javascript' language='javascript' src='<?php echo HTTP_SERVER.DIR_VIEW?>js/cart.js'></script>

<script type="text/javascript" src="<?php echo HTTP_SERVER.DIR_JS?>jquery.mousewheel-3.0.4.pack.js"></script>
<script type="text/javascript" src="<?php echo HTTP_SERVER.DIR_JS?>jquery.fancybox-1.3.4.js"></script>
<link rel="stylesheet" type="text/css" href="<?php echo HTTP_SERVER.DIR_CSS?>jquery.fancybox-1.3.4.css" media="screen" />
<script type='text/javascript' language='javascript' src='<?php echo HTTP_SERVER.DIR_VIEW?>js/product.js'></script>
<script type='text/javascript' language='javascript' src='<?php echo HTTP_SERVER.DIR_JS?>jquery-tooltip.js'></script>


<script type="text/javascript" language="javascript" src="<?php echo HTTP_SERVER.DIR_JS?>jquery.carouFredSel-6.2.1.js"></script>

<script type="text/javascript" language="javascript" src="<?php echo HTTP_SERVER.DIR_JS?>snowstorm.js"></script>
<link rel='stylesheet' type='text/css' href='<?php echo HTTP_SERVER.DIR_VIEW?>css/stickytooltip.css'>

<script type="text/javascript">
$(document).ready(function() {
		/*
		*   Examples - images
		*/

		

		$(".zoom").fancybox({
			'overlayShow'	: true,
			'transitionIn'	: 'elastic',
			'transitionOut'	: 'elastic'
		});

		
	});
</script>
<script language="javascript">
$(function() {
	$(".ben-datepicker").datepicker({
			changeMonth: true,
			changeYear: true,
			dateFormat: 'dd-mm-yy',
			
			});
	});
</script>


<body>

<div style="display:none"><?php echo $meta_keyword?></div>
<div id="ben-body">
    <div id="ben-main">
        
        <?php echo $header?>
        
        <div id="ben-content">
            <?php echo $content?>
            
        </div>
        
        
    
    </div>
</div>
    <div id="ben-bottom">
        <?php echo $footer?> 
    </div>
    <div id="ben-popup" style="display:none">
        <div id="ben-popup-content"></div>
        
    </div>
</body>

</html>
<div id="mystickytooltip" class="stickytooltip">
	<div style="padding:5px">
        <div id="sticky1">
        	
        </div>
    </div>
</div>
<script language="javascript">

$(document).ready(function(){
	$(".link_hover").hover(function(){
		var img = '<img src="'+$(this).attr('ref')+'">';
		var text = '<h5>'+$(this).attr('title')+'</h5>';
		$('#sticky1').html(img+text);
		
	});

});
	

</script>