<div class="section" id="sitemaplist">

	<div class="section-title"><?php echo $dash_header ?></div>
    
    <div class="section-content padding1">
    
    	<form name="frm" id="frm" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	<input type="button" value="<?php echo $button_save ?>" class="button" onClick="save()"/>   
     	        <input type="hidden" name="mediaid" value="<?php echo $item['mediaid']?>">
                
            </div>
            <div class="clearer">^&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
        	<div>
            	<h3><?php echo $dash_infor_header ?></h3><br />
            	<p>
            		<label><?php echo $dash_title ?></label><br />
					<input type="text" name="Title" value="<?php echo $item['Title']?>" class="text" size=60 />
            	</p>
                <p>
            		<label><?php echo $dash_slogan ?></label><br />
					<input type="text" name="Slogan" value="<?php echo $item['Slogan']?>" class="text" size=60 />
            	</p>
                  
                <p>
            		<label><?php echo $dash_currency ?></label><br />
					<input type="text" name="Currency" value="<?php echo $item['Currency']?>" class="text" size=60 />
            	</p>
                
                <p>
            		<label><?php echo $dash_email ?></label><br />
					<input type="text" name="EmailContact" value="<?php echo $item['EmailContact']?>" class="text" size=60 />
            	</p>
                <p>
                    <label>Keyword</label><br />
                    <textarea name="Keyword"><?php echo $item['Keyword']?></textarea>
                        
                </p>
				<p>
                    <label>Mô tả</label><br />
                    <textarea name="Description"><?php echo $item['Description']?></textarea>
                        
                </p>
            </div>
            <div>
            	<!--<h3>Trang chủ</h3>-->
                 <input type="hidden" id="listselectfile" name="listselectfile" />
                 <input type="hidden" id="handler" />
                 <input type="hidden" id="outputtype" />
                
                
                 <p>
                    <label><?php echo $lbl_image ?></label><br />
                    <div id="brochure">
                        <?php echo $item['brochure']?>
                    </div>
                    <input type="hidden" id="brochure_filepath" name="brochure" value="<?php echo $item['brochure']?>"/>
                    <input type="button" class="button" value="<?php echo $entry_photo ?>" onclick="browserFile('brochure','any')"/>
                    <input type="button" class="button" value="Remove" onclick="$('#brochure_filepath').val('');$('#brochure').html('')"/>
                </p>
                <p>
                    <label>Background</label><br />
                    <div id="background">
                        <?php echo $item['background']?>
                    </div>
                    <input type="hidden" id="background_filepath" name="background" value="<?php echo $item['background']?>"/>
                    <input type="button" class="button" value="<?php echo $entry_photo ?>" onclick="browserFile('background','any')"/>
                    <input type="button" class="button" value="Remove" onclick="$('#background_filepath').val('');$('#background').html('')"/>
                </p>
            </div>
        </form>
    
    </div>
    
</div>

<script language="javascript">
function browserFile(eid,type)
{
    $('#handler').val(eid);
	$('#outputtype').val(type);
	$("#popup").attr('title','Chọn hình');
		$( "#popup" ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: $(document).width()-100,
			height: 600,
			modal: true,
			
		});
	
		
		$("#popup-content").load("?route=core/file&dialog=true&type=single",function(){
			$("#popup").dialog("open");	
		});
		
}
function intSeleteFile(type)
{
	
	switch(type)
	{
		case "single":
			$('.filelist').click(function(e) {
				$('#'+ $('#handler').val()).html($(this).attr('filepath'))
				$('#'+ $('#handler').val()+'_filepath').val($(this).attr('filepath'));
				
				/*$('#imagepreview').attr('src',$(this).attr('imagethumbnail'));
				$('#imageid').val(this.id);
				$('#imagepath').val($(this).attr('filepath'));
				$('#imagethumbnail').val($(this).attr('imagethumbnail'));*/
				$("#popup").dialog( "close" );
				
				
			});			
			break;
			
		case "editor":
			$('.filelist').click(function(e) {

				
				width = "";
							
				var value = "<img src='<?php echo HTTP_IMAGE?>"+$(this).attr('filepath')+"'/>";
				
				var oEditor = CKEDITOR.instances['editor1'] ;
				
				
				// Check the active editing mode.
				if (oEditor.mode == 'wysiwyg' )
				{
					// Insert the desired HTML.
					oEditor.insertHtml( value ) ;
					
					var temp = oEditor.getData()
					oEditor.setData( temp );
				}
				else
					alert( 'You must be on WYSIWYG mode!' ) ;
				$("#popup").dialog( "close" );
			});			
			break;
		case "multi":
			$('.filelist').click(function(e) {
                //$('#popup-seletetion').append($(this))
            });
			break;
	}
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
						case 'image':
							if(isImage(data.file.extension))
							{
								width = "";
								
								width = 'width="200px"'
								var value = "<img src='<?php echo HTTP_IMAGE?>"+data.file.filepath+"' " + width +"/>";
								
								$('#'+ $('#handler').val()).html(value)
								$('#'+ $('#handler').val()+'_filepath').val(data.file.filepath);
							}
							else
							{
								alert('Bạn phải chọn file hình');	
							}						
							break;
						default:
							var value = data.file.filepath;
								
							$('#'+ $('#handler').val()).html(value)
							$('#'+ $('#handler').val()+'_filepath').val(data.file.filepath);
					}
					
				});
		}
	}
}
function save()
{
	$.blockUI({ message: "<h1><?php echo $announ_infor ?></h1>" }); 
	/*var oEditor = CKEDITOR.instances['editor1'] ;
	var pageValue = oEditor.getData();
	$('textarea#editor1').val(pageValue);*/
	$.post("?route=common/dashboard/save", $("#frm").serialize(),
		function(data){
			if(data == "true")
			{
				window.location.reload();
			}
			$.unblockUI();
		}
	);
}

</script>
