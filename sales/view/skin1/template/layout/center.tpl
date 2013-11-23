<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">

<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<meta name="description" content="" />
<meta name="keywords" content="" />
<meta name="author" content="" />
	<link rel="stylesheet" type="text/css" href="<?php echo DIR_CSS?>style.css" media="screen" />
	<link rel='stylesheet' type='text/css' href='<?php echo DIR_CSS?>blockui.css'>
	<link rel='stylesheet' type='text/css' href='<?php echo DIR_CSS?>jquery-ui.css'>
    <link rel='stylesheet' type='text/css' href='<?php echo DIR_CSS?>jquery.tabs.css'>
    
    
   	<script src="<?php echo HTTP_SERVER.DIR_JS?>jquery.js" type="text/javascript"></script>
    <script src="<?php echo HTTP_SERVER.DIR_JS?>jquery-ui.js" type="text/javascript"></script>
    <link rel="stylesheet" href="<?php echo DIR_CSS?>jquery.treeview.css" />
	<script src="<?php echo DIR_JS?>jquery.cookie.js" type="text/javascript"></script>
    <script src="<?php echo DIR_JS?>jquery.treeview.js" type="text/javascript"></script>
    <script src="<?php echo DIR_JS?>jquery.treeview.edit.js" type="text/javascript"></script>
    
   
    <script type='text/javascript' language='javascript' src='<?php echo DIR_JS?>jquery.blockUI.js'></script>
	
	<script type='text/javascript' language='javascript' src='<?php echo DIR_COMPONENT?>ckeditor/ckeditor.js'></script>
    <script src="<?php echo DIR_JS?>common.js" type="text/javascript"></script>
    <script src="<?php echo DIR_JS?>control.js" type="text/javascript"></script>

    <script src="<?php echo DIR_JS?>menu-collapsed.js" type="text/javascript"></script>

	
	<title>HL Solutions Content Management System</title>


</head>
<!--[if lt IE 7]>
	<link rel='stylesheet' type='text/css' href='<?php echo DIR_CSS?>jquery.tabs-ie.css'>
	<link href="<?php echo DIR_VIEW?>css/ie_style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="<?php echo DIR_JS?>js/ie_png.js"></script>
    <script type="text/javascript">
       ie_png.fix('.png, #content .pagenavi, .aside ');
	</script>
<![endif]-->

<script language="javascript">
var loading = '<center><img src="<?php echo DIR_IMAGE?>loading.gif"></center>';
$(document).ready(function(e) {
    $("#main-content").height($('body').height()- $('#header').height())
});
</script>
<body>
<div id="header"><?php echo $header?></div>
<div id="main-content" >
	<?php echo $content?>
</div>


</body>
	<div id="popup" style="display:none">
    	<div id="popup-selete">
        	
            <div id="popup-seletetion">
                
                
            </div>
        </div>
        <div id="popup-content"></div>
        
    </div>
    <div id="ctrnumpad" style="display:none">
    	
    </div>
</html>
