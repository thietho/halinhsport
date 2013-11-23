<div class="bb"><?php echo $sitemap['sitemapname'] ?></div>
					<div class="doitac">	
                        <table>
                        	<?php for($i=0 ; $i< count($medias) && count($medias[$i]) > 0 ; ){ ?>
                            <tr>
                            	<?php for($j=0;$j<3;$j++){?>
                                	<?php $media = $medias[$i];?>
                                <td>
                                	
                                    <a id="<?php echo $media['mediaid']?>" class="videolist"><img src='<?php echo $media['imagethumbnail']?>' class="ben-center" /></a>
                                    <p class="ben-text-center" id="title<?php echo $media['mediaid']?>"><?php echo $media['title']?></p>
                                </td>
                                	<?php $i++?>
                                <?php } ?>
                            </tr>
                            <?php }?>
                        	
                        </table>
                    </div>
<script language="javascript">
$('.videolist').click(function(e) {
	
    $("#ben-popup").attr('title', $("#title"+this.id).html());
		$( "#ben-popup" ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: 575,
			height: 500,
			modal: true,
			close: function(event, ui) {
					$.unblockUI();
				},
			buttons: {
				
				
				'Đóng': function() {
					$( this ).dialog( "close" );
					
				}
				
			}
		});
	
		
		$("#ben-popup-content").load(HTTP_SERVER+"?route=common/video&mediaid="+this.id,function(){
			$("#ben-popup").dialog("open");	
			
		});
});
</script>