<div class="bb"><?php echo $this->document->getSiteMap($this->document->sitemapid,$this->member->getSiteId() )?></div>
<div class="ben-post">
	<?php if($post['imagethumbnail'] !=""){ ?>
	<img src='<?php echo $post['imagethumbnail']?>' class='ben-alignleft' />
	<?php }?>
    <h2><?php echo $post['title']?></h2>
    
    <div class="ben-post-date">
    	<?php if($post['eventtime']){ ?>
    	Thời gian: <?php echo $post['eventtime']?>
        ngày <?php echo $this->date->formatMySQLDate($post['eventdate'])?>
        <?php }else{ ?>
        Chưa cập nhật thời gian diển ra sự kiện
        <?php } ?>
    </div>
    
    <div class="ben-post-body">
        <p><b><?php echo $post['summary']?></b></p>
    </div>
    <div class="clearer">&nbsp;</div>

    <div class="ben-hline"></div>
    <div>
        <?php echo $post['description']?>
    </div>
    <p class="ben-text-right">
        <b><?php echo $post['source']?></b>
    </p>
    <div class="ben-hline"></div>
    
    <?php if($othernews) {?>
    <h3>Các tin khác</h3>             
    <div>
        <ul>
            <?php foreach($othernews as $media) {?>
            <li><a href="<?php echo $media['link']?>"><?php echo $media['title']?>&nbsp;<span class="ben-other">(<?php echo $media['statusdate']?>)</span></a></li>
            <?php } ?>    
        </ul>
    </div>
    <?php } ?>
    
    <div class="clearer">&nbsp;</div>
</div>