<div class="section" id="sitemaplist">

	
    
    <div class="section-content padding1">
    
    	<form name="frmmodule" id="frmmodule" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	
     	        
                <input type="hidden" id="id" name="id" value="<?php echo $item['id']?>">
                <input type="hidden" id="moduleparent" name="moduleparent" value="<?php echo $item['moduleparent']?>">
            </div>
            <div class="clearer">^&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
        	<div>   
            	
                
                <p>
                    <label>Module cha:</label><br />
                    <?php echo $this->document->getModule($item['moduleparent'])?>
                </p>
                <p>
                    <label>Module id:</label><br />
                    <input type="text" id="moduleid" name="moduleid" value="<?php echo $item['moduleid']?>" class="text" size=60 />
                </p>
                <p>
                    <label>Tên module:</label><br />
                    <input type="text" id="modulename" name="modulename" value="<?php echo $item['modulename']?>" class="text" size=60 />
                </p>               
                
            </div>
            
        </form>
    
    </div>
    
</div>
