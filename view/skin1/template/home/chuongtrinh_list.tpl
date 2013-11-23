			<div>
        		<div class="bb">Chương trình đào tạo nổi bật</div>
                <?php foreach($medias as $key => $media) {?>
                <?php if($key < 2){ ?>
				<div>
            		<div class="imageBlock ben-left">
                		<img src="<?php echo $media['imagethumbnail']?>">
                    	<a href="<?php echo $media['link']?>" onclick="_gaq.push(['_trackPageview', 'about-2']);" class="moreButton magenta">
                        	<?php echo $media['title']?>
                        </a>
                	<div class="panel"><p><?php echo $this->string->getTextLength($media['summary'],0,40)?>...</p></div>
               	  </div>
           		</div>
                <?php } ?>
            	<?php } ?>
            	<div class="clearer"></div>
            </div>