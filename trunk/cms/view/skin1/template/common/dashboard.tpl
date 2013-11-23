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
            		<label>Description</label><br />
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
                    <!--<div id="logowebsite">
                        <?php echo $item['logowebsite']?>
                    </div>
                    <input type="hidden" id="logowebsite_filepath" name="logowebsite" value="<?php echo $item['logowebsite']?>"/>
                    <input type="button" class="button" value="<?php echo $entry_photo ?>" onclick="browserFile('logowebsite','any')"/>-->
                    <div id="logowebsite">
                        <?php echo $item['logowebsite']?>
                    </div>
                    <a  class="button" onclick="browserFileImage()">Chọn hình</a><br />
                    <img id="imagepreview" src="<?php echo $imagethumbnail?>" />
                    <input type="hidden" id="imagepath" name="imagepath" value="<?php echo $imagepath?>" />
                    <input type="hidden" id="imageid" name="logowebsite" value="<?php echo $imageid?>" />
                    <input type="hidden" id="imagethumbnail" name="imagethumbnail" value="<?php echo $imagethumbnail?>" />
                </p>
            </div>
        </form>
    
    </div>
    
</div>

<script language="javascript">
function browserFileImage()
{
	
	$("#popup").attr('title','Chọn hình');
		$( "#popup" ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: 800,
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
				$('#imagepreview').attr('src',$(this).attr('imagethumbnail'));
				$('#imageid').val(this.id);
				$('#imagepath').val($(this).attr('filepath'));
				$('#imagethumbnail').val($(this).attr('imagethumbnail'));
				$("#popup").dialog( "close" );
			});			
			break;
			
		
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