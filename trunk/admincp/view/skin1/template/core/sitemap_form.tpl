<div class="section" id="sitemaplist">

	<div class="section-title"><?php echo $menu_sitemap ?></div>
    
    <div class="section-content padding1">
    	
        <form id="frmSiteMap" name="frm" action="" method="post" enctype="multipart/form-data">
        	<div class="button left">
            	<h3><?php echo $title_add_new_sitemap ?></h3>
            </div>
            
            <div class="button right">
            	<input type="button" value="<?php echo $button_save ?>" class="button" onclick="save()"/>
	            <input type="button" value="<?php echo $button_cancel ?>" class="button" onclick="linkto('?route=core/sitemap')"/>
                <input type="hidden" name="id" value="<?php echo $sitemap['id']?>" />
                
                <input type="hidden" id="listselectfile" name="listselectfile" />
                <input type="hidden" id="handler" />
             	<input type="hidden" id="outputtype" />
            </div>
            <div class="clearer">^&nbsp;</div>
            <div id="error" class="error" style="display:none"></div>
            <p>
            	<label><?php echo $lbl_name ?></label><br />
            	<input type="text" id="sitemapname" name="sitemapname" value="<?php echo $sitemap['sitemapname']?>" class="text" size="80"/>
                <?php echo $errors['sitemapname']?>
            </p>

        	<p>
            	<label><?php echo $text_category_parent ?></label><br />
            	<select name="sitemapparent">
                    <option value="">Root</option>
<?php
foreach($sitemapparent as $result)
{
    
?>
                    <option value="<?php echo $result['sitemapid']?>" <?php if($sitemap['sitemapparent']==$result['sitemapid']) echo "selected" ?> ><?php echo $result['sitemapname']?></option>
<?php
    
}
?>    
                </select>
                <?php echo $errors['sitemapparent']?>
            </p>
        
            <p>
            	<label><?php echo $text_sitemapid ?></label><br />
            	<input type="text" id="sitemapid" name="sitemapid" value="<?php echo $sitemap['sitemapid']?>" class="text" size="80"/>
                <?php echo $errors['sitemapid']?>
            </p>
<?php if($sitemap[id]==""){ ?>
	<script>
		$('#sitemapname').change(function(e) {
		
			$.ajax({
					url: "?route=common/api/getAliasSiteMap&title=" + toBasicText(this.value),
					cache: false,
					success: function(html)
					{
						$("#sitemapid").val(html);
					}
			});
		});
    </script>
<?php } ?>
            <p>
                <label>Module</label>
            	<select name="moduleid">
<?php
	foreach($modules as $key => $item)
    {
?>
                    <option value="<?php echo $key?>" <?php if($key==$sitemap['moduleid']) echo "selected" ?>><?php echo $item?></option>
<?php
}
?>
                </select>
                 &nbsp;&nbsp;&nbsp;&nbsp;
                <label><?php echo $text_status?></label>
                <select name="status">
<?php
foreach($status as $key=>$val)
{
?>
                    <option value="<?php echo $key?>" <?php if($sitemap['status']==$key) echo "selected"?> >-- <?php echo $val?> --</option>
<?php
}
?>
                        
                                                       
                    </select>
            </p>
            <p>
            	<label>Link</label>
        		<input type="text" id="forward" name="forward" value="<?php echo $sitemap['forward']?>" class="text" size="80"/>
            </p>
            <p>
            	<label><?php echo $lbl_image?></label><br />
            	<input type="button" value="<?php echo $entry_photo ?>" class="button" onclick="browserFileImage()"/>
                <input type="button" value="<?php echo $entry_del_photo ?>" class="button" onclick="removeImage()"/>
                <br />
                
                <input type="hidden" id="imageid" name="imageid" value="<?php echo $sitemap['imageid']?>" /> 
                <input type="hidden" id="imagepath" name="imagepath" value="<?php echo $sitemap['imagepath']?>" />
                <input type="hidden" id="imagethumbnail" name="imagethumbnail" value="<?php echo $sitemap['thumbnail']?>" />
                <img id="imagepreview" src="<?php echo $sitemap['thumbnail']?>" />
                <input type="hidden" name="position" value="<?php echo $sitemap['position']?>">
            </p>
        
        </form>
    
    </div>
    
</div>       
<!-- main indent-->
<script src='<?php echo DIR_JS?>ajaxupload.js' type='text/javascript' language='javascript'> </script>
<script language="javascript">
function save()
{
	$.blockUI({ message: "<h1><?php echo $announ_infor ?></h1>" }); 
	$.post("?route=core/sitemap/save", $("#frmSiteMap").serialize(),
		function(data){
			var arr = data.split("-");
			if(arr[0] == "true")
			{
				window.location = "?route=core/sitemap";
			}
			else
			{
			
				$('#error').html(data).show('slow');
				$.unblockUI();
				
			}
			
		}
	);
}


function removeImage()
{
	$('#imagepath').val("");
	$('#imageid').val("");
	$('#imagepreview').attr("src","<?php echo $noimage?>");
	$('#imagethumbnail').val("");
}
</script>
