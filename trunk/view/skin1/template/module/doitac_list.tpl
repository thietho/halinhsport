<div class="bb"><?php echo $sitemap['sitemapname'] ?></div>
					<div class="doitac">	
                        <table>
                        	<?php for($i=0 ; $i< count($medias) && count($medias[$i]) > 0 ; ){ ?>
                            <tr>
                            	<?php for($j=0;$j<3 && count($medias[$i]) > 0 ;$j++){?>
                                	<?php $media = $medias[$i];?>
                                <td>
                                	
                                    <a href="<?php echo $media['link']?>"><img src='<?php echo $media['imagethumbnailpng']?>' class="ben-center" /></a>
                                    <p class="ben-text-center"><?php echo $media['title']?></p>
                                </td>
                                	<?php $i++?>
                                <?php } ?>
                            </tr>
                            <?php }?>
                        	
                        </table>
                    </div>