<div class="section" id="sitemaplist">

	<div class="section-title"><?php echo $header_category ?></div>
    
    <div class="section-content padding1">
    
    	<form name="frm" id="frm" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	<input type="button" value="<?php echo $button_save ?>" class="button" onClick="save()"/>
     	        <input type="button" value="<?php echo $button_cancel ?>" class="button" onclick="linkto('?route=core/category')"/>   
     	        <input type="hidden" name="id" value="<?php echo $item['id']?>">
            </div>
            <div class="clearer">^&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
        	<div>   
            	<p>
                    <label><?php echo $text_categoryID ?></label><br />
                    <input type="text" name="categoryid" value="<?php echo $item['categoryid']?>" class="text" size=60 <?php if($item['categoryid']!="") echo 'readonly="readonly"'?>/>
                </p>     
                <p>
                    <label><?php echo $text_categroyname ?></label><br />
                    <input type="text" name="categoryname" value="<?php echo $item['categoryname']?>" class="text" size=60 />
                </p>
                <p>
                    <label><?php echo $text_category_parent?></label><br />
                    <select id="parent" name="parent">
                        <?php foreach($datas as $it){ ?>
                        <option value="<?php echo $it['categoryid']?>"><?php echo $this->string->getPrefix("&nbsp;&nbsp;&nbsp;&nbsp;",$it['level']) ?><?php echo $it['categoryname']?></option>
                        <?php } ?>
                    </select>
                </p>
                
            </div>
            
        </form>
    
    </div>
    
</div>
<?php
	$parent =$item['parent'];
	if($_GET['parent'] !="")
    	$parent = $_GET['parent'];
    
?>
<script language="javascript">
function save()
{
	$.blockUI({ message: "<h1><?php echo $announ_infor ?></h1>" }); 
	
	$.post("?route=core/category/save", $("#frm").serialize(),
		function(data){
			if(data == "true")
			{
				window.location = "?route=core/category";
			}
			else
			{
			
				$('#error').html(data).show('slow');
				$.unblockUI();
				
			}
			
		}
	);
}
$(document).ready(function() {
	
	$("#parent").val("<?php echo $parent?>");
	
	
});

</script>
