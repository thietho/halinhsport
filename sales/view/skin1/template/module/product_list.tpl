			<h2><?php echo $breadcrumb?></h2>
			<div id="productlist">
            	<?php foreach($medias as $key => $media) {?>
            	<div class="pro-item left" mediaid="<?php echo $media['mediaid']?>" style="background:url('<?php echo $media['imagepreview']?>') no-repeat center center;">
                	<table>
                    	<tr>
                        	<td>
                            	<?php echo $media['code']?><br />
                                <?php echo $media['title']?>
                            </td>
                        </tr>
                        
                        
                    </table>
                </div>
                	<?php if(count($media['child'])){ ?>
                    	<?php foreach($media['child'] as $k =>$child){ ?>
                <div class="pro-item left" mediaid="<?php echo $child['mediaid']?>" style="background:url('<?php echo $child['imagepreview']?>') no-repeat center center;">
                	<table>
                    	<tr>
                        	<td>
                            	<?php echo $child['code']?><br />
                                <?php echo $child['title']?>
                            </td>
                        </tr>
                        
                        
                    </table>
                </div>
                		<?php } ?>
                    <?php } ?>
                <?php } ?>
                <div class="clearer">^&nbsp;</div>
            </div>
			
            
            <div class="clearer">&nbsp;</div>
<script language="javascript">
$('.procat').click(function(e) {
    
	pro.loadProduct(pro.url + "&sitemapid="+$(this).attr('ref'));
});
</script>