<div class="bb"><?php echo $sitemap['sitemapname'] ?></div>
<div class="ben-post">
	<?php if($post['imagethumbnail'] !=""){ ?>
	<img src='<?php echo $post['imagethumbnail']?>' class='ben-alignleft' />
	<?php }?>
    <h2><?php echo $post['title']?></h2>
    
    <div>
        <?php echo $post['description']?>
    </div>
    
    
    <div class="clearer">&nbsp;</div>
</div>