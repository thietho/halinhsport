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
                    <label>Module cha:</label><br />
                    <select id="moduleparent" name="moduleparent">
                        <option value="">Khu vực gốc</option>
                        <?php foreach($modules as $module){ ?>
                        <option value="<?php echo $module['id']?>"><?php echo $this->string->getPrefix("&nbsp; &nbsp; &nbsp; &nbsp;",$module['level']);?><?php echo $module['modulename']?></option>
                      <?php }?>
                    </select>
                </p>
            </div>
            
        </form>
    
    </div>
    
</div>
<script language="javascript">
$('#moduleparent').val("<?php echo $item['moduleparent']?>");
</script>