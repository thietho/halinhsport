				<div class="ben-home-news">
                    <div class="bbb"><a href="<?php echo $this->document->createLink($sitemap['sitemapid'])?>"><?php echo $sitemap['sitemapname']?></a></div>
                    <div>
                        
<?php foreach($medias as $key => $media) {?>
	
                        <div class="ben-news-item ben-left">
                        	<table>
                            	<tr>
                                	<td>
                                    	<a href="<?php echo $media['link']?>"><img src="<?php echo $media['imagethumbnail']?>" /></a>
                                        
                                    </td>
                                    <td>
                                    	<p>
                                            <strong><a href="<?php echo $media['link']?>"><?php echo $media['title']?></a></strong><br/>
                                            <?php echo $this->string->getTextLength($media['summary'],0,15)?>...
                                        </p>
                                    	<p class="ben-right"><a class="ben-right do" href="<?php echo $media['link']?>">Chi tiết >></a></p>
                            			<div class="clearer"></div>
                                    </td>
                                </tr>
                            </table>                	
                            
                            
                        </div>
								
<?php } ?>                	
						<div class="clearer">&nbsp;</div>
                    </div>
                </div>
                <div class="clearer">&nbsp;</div>
							