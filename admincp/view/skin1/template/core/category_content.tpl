<div class="section">

	<div class="section-title">
    	<?php echo $breadcrumb?>
    </div>
    
    <div class="section-content padding1">
    
    	<form name="InsertContent"  action="" method="post" enctype="multipart/form-data">
    
    	<div class="left">
            
            <h3><?php echo $heading_title?></h3>
        
        </div>
        
    	<div class="right">
        	<input class="button" type="submit" value="<?php echo $button_save ?>" />
            <a class="button" href="<?php echo $DIR_CANCEL?>"><?php echo $button_cancel?></a>
             <input type="hidden" id="status" name="status" value="<?php echo $post['status']?>" />
             <input type="hidden" id="mediaid" name="mediaid" value="<?php echo $post['mediaid']?>" />
             <input type="hidden" id="mediatype" name="mediatype" value="<?php echo $post['mediatype']?>" />
             <input type="hidden" id="refersitemap" name="refersitemap" value="<?php echo $post['refersitemap']?>" />
        </div>
        <div class="clearer">&nbsp;</div>
        
        
        <div id="container">
        	
            
        	<ul>
                <li><a href="#fragment-content"><span>Information</span></a></li>
               
                <li><a href="#fragment-detail"><span>Detail</span></a></li>
               
                
            </ul>
           
            
            <div id="fragment-content">
            	
                <div style="<?php echo $displaynews?>">
        			
                    <div class="col2 left">
                    	
                       
                        <p>
                            <label>Title</label><br>
                            <input class="text" type="text" name="title" value="<?php echo $post['title']?>" size="60" />
                        </p>
                        
                        
                        
                        <p>
                            <label>Summary</label><br>
                            <textarea class="text" rows="3" cols="70" name="summary"><?php echo $post['summary']?></textarea>
                        </p>
                        
                    	
                    </div>
                    
                    <div class="col2 right">
                    	
                    	<p id="pnImage">
                            <label for="image"><?php echo $entry_image?></label><br />
                            <a  class="button" onclick="browserFileImage()">Chọn hình</a><br />
                            <img id="imagepreview" src="<?php echo $imagethumbnail?>" onclick="showFile($('#imageid').val())"/>
                            <input type="hidden" id="imagepath" name="imagepath" value="<?php echo $post['imagepath']?>" />
                            <input type="hidden" id="imageid" name="imageid" value="<?php echo $post['imageid']?>" />
                            <input type="hidden" id="imagethumbnail" name="imagethumbnail" value="<?php echo $post['imagethumbnail']?>" />
                        </p>
                        
                        
                        <div id="errorupload" class="error" style="display:none"></div>
                        
                        <div class="loadingimage" style="display:none"></div>
                       	
                        <p>
                        	<a id="btnAddAttachment" class="button" onclick="browserFileAttachment()">Chọn hình phụ</a><br />
                        </p>
                        <p id="attachment">
                        </p>
                    	
                        <span id="delfile"></span>
                        
                    </div>
                   
<script language="javascript">
	$(document).ready(function() {
   	// put all your jQuery goodness in here.
<?php
	if(count($attachment))
		foreach($attachment as $item)
		{
			if(count($item))
			{
?>
			$('#attachment').append(creatAttachmentRow("<?php echo $item['fileid']?>","<?php echo $item['filename']?>","<?php echo $item['imagethumbnail']?>"));
<?php
			}
		}
?>
 	});

</script>
                    <div class="clearer">&nbsp;</div>
                
                </div>
                
               
                
            </div>
            
            <div id="fragment-detail">
            	<a class="button" onclick="browserFileEditor()">Select image</a>
                <input type="hidden" id="listselectfile" name="listselectfile" />
            	<div>
                	<p>
                        <textarea name="description" id="editor1" cols="80" rows="10"><?php echo $description?></textarea>
                    </p>
                </div>
            </div>
            
            
            
            
            
            
        
        </div>
        
        </form>
    
    </div>

</div>
<div id="popup" class="hidden"></div>


<script type="text/javascript" charset="utf-8">

$(document).ready(function() { 
	setCKEditorType('editor1',0);
	
	$('#container').tabs({ fxSlide: true, fxFade: true, fxSpeed: 'slow' });
	
});
</script>



