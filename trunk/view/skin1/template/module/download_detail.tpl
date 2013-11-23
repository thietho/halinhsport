<div class="bb"><?php echo $this->document->getSiteMap($this->document->sitemapid,$this->member->getSiteId() )?></div>
<div class="ben-post">
	<?php if($post['imagethumbnail'] !=""){ ?>
	<img src='<?php echo $post['imagethumbnail']?>' class='ben-alignleft' />
	<?php }?>
    <h2><?php echo $post['title']?></h2>
    <div class="ben-post-date"><?php echo $post['statusdate']?></div>
    <div class="ben-post-body">
        <p><b><?php echo $post['summary']?></b></p>
    </div>
    <div class="clearer">&nbsp;</div>

    <div class="ben-hline"></div>
    <p>
        <?php echo $post['description']?>
    </p>
    <p>
    	<?php foreach($download as $file){ ?>
        	<div>
            	<img src="<?php echo $file['icon']?>"/> <a href="<?php echo HTTP_SERVER.DIR_FILE.$file['filepath']?>" target="_blank"><?php echo $file['filename']?></a>
            </div>
        <?php } ?>
    </p>
    
    <p class="ben-text-right">
        <b><?php echo $post['source']?></b>
    </p>
</div>