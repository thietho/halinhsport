<div class="ben-three-columns">
	<div class="ben-sidebar ben-left">
    	<?php foreach($leftsitebar as $item){ ?>
        <?php echo $item?>
        <?php } ?>
    </div>
    
	<div class="ben-left" id="ben-maincontent">
    	<div class="ben-navigation">
    
            <ul id="ben-main-nav">
                <?php echo $mainmenu?>
            </ul>
    
            <div class="clearer">&nbsp;</div>
    
        </div>
    	<div class="ben-section">
        
        	<div class=" ben-section-title">Homepage</div>
            
            <div class=" ben-section-content">
            
            	<?php echo $bannerhome?>
            	<?php echo $producthome?>
            </div>
            
            
        	
        </div>
    </div>
    
    <div class="ben-sidebar ben-right">
    	<?php foreach($rightsitebar as $item){ ?>
        <?php echo $item?>
        <?php } ?>
    </div>
    
    <div class="clearer">&nbsp;</div>

</div>