<div class="ben-home-news">
    
    <table class="tabletop">
        <tr>
            <td width="520px">
                <a href="<?php echo $medias[0]['link']?>"><img src="<?php echo $medias[0]['imagethumbnail']?>" /></a>
                <p>
                    <h4><a href="<?php echo $medias[0]['link']?>"><?php echo $medias[0]['title']?></a></h4>
                    <?php echo $medias[0]['summary']?>
                </p>
            </td>
            <td>
            	<table>
                <?php for($i=1;$i<count($medias)&& $i<9;$i++){ ?>
                	<tr>
                    	<td><a href="<?php echo $medias[$i]['link']?>"><img src="<?php echo $medias[$i]['imagethumbnail']?>" width="50px"/></a></td>
                        <td><a href="<?php echo $medias[$i]['link']?>"><?php echo $medias[$i]['title']?></a></td>
                    </tr>
                <?php } ?>
                </table>
            </td>
        </tr>
    </table>
    <table>
    	<tr>
    	<?php for($i=9;$i<count($medias);$i++){ ?>
        	<td style="width:25%">
            	<table>
                	<tr height="150px" valign="middle">
                    	<td align="center"><a href="<?php echo $medias[$i]['link']?>"><img src="<?php echo $medias[$i]['imagethumbnail']?>" width="150px"/></a></td>
                    </tr>
                    <tr>
                    	<td align="center"><a href="<?php echo $medias[$i]['link']?>"><?php echo $medias[$i]['title']?></a></td>
                    </tr>
                </table>
            </td>
        <?php }?>
        </tr>
    </table>
</div>

            