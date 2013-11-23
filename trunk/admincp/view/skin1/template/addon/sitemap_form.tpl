<div class="section" id="sitemaplist">

	<div class="section-title"><?php echo $menu_sitemap ?></div>
    
    <div class="section-content padding1">
    	
        <form name="frm" action="" method="post" enctype="multipart/form-data">
        	<div class="button left">
            	<h3><?php echo $title_add_new_sitemap ?></h3>
            </div>
            
            <div class="button right">
            	<input type="submit" value="<?php echo $button_save ?>" class="button" onclick="save()"/>
	            <input type="button" value="<?php echo $button_cancel ?>" class="button" onclick="linkto('?route=addon/sitemap')"/>
            </div>
            <div class="clearer">^&nbsp;</div>
			<p>
            	<label><?php echo $lbl_name ?></label><br />
            	<input type="text" name="sitemapname" id="sitemapname" value="<?php echo $sitemap['sitemapname']?>" class="text" size="80"/>
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
	<script>
		$('#sitemapname').change(function(e) {
		
			$.ajax({
					url: "?route=common/api/getAlias&title=" + toBasicText(this.value),
					cache: false,
					success: function(html)
					{
						$("#sitemapid").val(html);
					}
			});
		});
    </script>
            
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
            
            
        
        </form>
    
    </div>
    
</div>       
<!-- main indent-->
<script src='<?php echo DIR_JS?>ajaxupload.js' type='text/javascript' language='javascript'> </script>
<script language="javascript">
function save()
{
	$.blockUI({ message: "<h1><?php echo $announ_infor ?></h1>" }); 
	$.post("?route=addon/sitemap/save", $("#frmSiteMap").serialize(),
		function(data){
			var arr = data.split("-");
			if(arr[0] == "true")
			{
				window.location = "?route=addon/sitemap";
			}
			else
			{
			
				$('#error').html(data).show('slow');
				$.unblockUI();
				
			}
			
		}
	);
}
function browserFileImage()
{
    //var re = openDialog("?route=core/file",800,500);
	$('#handler').val('image');
	$('#outputtype').val('image');
	showPopup("#popup", 800, 500);
	$("#popup").html("<img src='view/skin1/image/loadingimage.gif' />");
	$("#popup").load("?route=core/file")
		
}
function addImageTo()
{
	var str= trim($("#listselectfile").val(),",");
	var arr = str.split(",");
	
	if(str!="")
	{
		for (i=0;i<arr.length;i++)
		{
			$.getJSON("?route=core/file/getFile&fileid="+arr[i], 
				function(data) 
				{
					switch($('#outputtype').val())
					{
						case 'editor':
							width = "";
							
							var value = "<img src='<?php echo HTTP_IMAGE?>"+data.file.filepath+"'/>";
							
							var oEditor = CKEDITOR.instances[$('#handler').val()] ;
							
							
							// Check the active editing mode.
							if (oEditor.mode == 'wysiwyg' )
							{
								// Insert the desired HTML.
								oEditor.insertHtml( value ) ;
								$("#listselectfile").val('');
								var temp = oEditor.getData()
								oEditor.setData( temp );
							}
							else
								alert( 'You must be on WYSIWYG mode!' ) ;
							break;
						case 'image':
							var handler = $('#handler').val();
							$('#'+handler+'id').val(data.file.fileid)
							$('#'+handler+'path').val(data.file.filepath)
							$.getJSON("?route=core/file/getFile&fileid="+data.file.fileid+"&width=200", 
							function(file) 
							{
								$('#'+handler+'thumbnail').val(file.file.imagepreview)
								$('#'+handler+'preview').attr('src',file.file.imagepreview)
							});
							
							
							break;
						
					}
				});
		}
	}
}
function removeImage()
{
	$('#imagepath').val("");
	$('#imageid').val("");
	$('#imagepreview').attr("src","<?php echo $noimage?>");
	$('#imagethumbnail').val("");
}
</script>
