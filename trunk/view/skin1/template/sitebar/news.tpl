<div class="ben-section-title"><div class="title"><?php echo $sitemap['sitemapname']?></div></div>
<?php if(count($medias)){ ?>
<div class="ben-section">

	
    
    <div class="ben-section-content ben-sitebar-news">
    <table>
    <?php foreach($medias as $media) {?>
    	<tr>
        	<td><img src="<?php echo $media['imagethumbnail']?>" alt="<?php echo $media['title']?>" title="<?php echo $media['title']?>"/></td>
        	<td><a href="<?php echo $media['link']?>" title="<?php echo $media['title']?>"><?php echo $media['title']?></a></td>
        </tr>
    	
    <?php } ?>
    </table>
    
    </div>

</div>
<?php } ?>