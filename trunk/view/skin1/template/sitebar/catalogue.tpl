<script type='text/javascript' language='javascript' src='<?php echo HTTP_SERVER.DIR_VIEW?>js/menu-collapsed.js'></script>
                    <div class="ben-section">
                    	<div class="ben-section-title"><div class="title">Sản phẩm</div></div>
                        <div>
                        	
                        	<ul id="menu">
                                <?php echo $menu?>
                            </ul>
                        </div>
                    </div>
<script language="javascript">

$(document).ready(function(){
	<?php foreach($path as $item){ ?>
	
	$("#<?php echo $item['sitemapid']?>").show('slow',function(){
		
		if($(this).parent().children('div').children('span').hasClass('down'))
		{
			$(this).parent().children('div').children('span').removeClass('down');
			$(this).parent().children('div').children('span').addClass('up');
		}
		else
		{
			$(this).parent().children('div').children('span').removeClass('up');
			$(this).parent().children('div').children('span').addClass('down');
		}
	});
	<?php } ?>
});
</script>