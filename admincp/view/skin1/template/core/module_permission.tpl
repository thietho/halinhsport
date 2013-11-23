<div class="section" id="sitemaplist">

	
    
    <div class="section-content padding1">
    
    	<form name="frmmodule" id="frmmodule" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	
     	        
     	        <input type="hidden" id="id" name="id" value="<?php echo $item['id']?>">
                
                
            </div>
            <div class="clearer">^&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
        	<div>   
            	
                
                
                <p>
                    <label>Tên module:</label><br />
                    <?php echo $item['modulename']?>
                </p>               
                
                <p>
                    <label>Loại user:</label><br />
                    <?php foreach($usertypes as $usertype){ ?>
                    <input type="checkbox" name="usertypeid[<?php echo $usertype['usertypeid']?>]" value="<?php echo $usertype['usertypeid']?>" <?php echo in_array($usertype['usertypeid'],$permission)?"checked":"" ?>> <?php echo $usertype['usertypename']?>
                    <?php } ?>
                </p>
            </div>
            
        </form>
    
    </div>
    
</div>
