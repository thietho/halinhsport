<div class="ben-section">

	
    
    <div class="ben-section-content">
    	
        	
        <?php foreach($medias as $media) {?>
        <a href="<?php echo $media['weblink']?>"><img src="<?php echo HTTP_IMAGE.$media['imagepath']?>" title="<?php echo $media['title']?>" alt="<?php echo $media['title']?>" width="188px"/></a>
        
        <?php } ?>
        
    	
    	
    </div>

</div>