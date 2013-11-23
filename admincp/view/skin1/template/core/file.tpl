<script src='<?php echo DIR_JS?>ajaxupload.js' type='text/javascript' language='javascript'> </script>


<form id="ffile" name="ffile" method="post">

<table width="100%" class="data-table">
	<tr>
        <td colspan="3">
        	<input type="hidden" id="folderidcur" value="0" />
     		<input type="hidden" name="sitemap" id="sitemap" value="" />
      		<strong>File name</strong> <input type="text" name="keyword" id="keyword" class="text" />&nbsp;&nbsp;
            
            
            			
            
            &nbsp;&nbsp;<input type="button" id="btnfilter" name="btnfilter" value="Filter" class="button"/>
            
        </td>
    </tr>
    <tr>
    	<td colspan="3">
        	<p id="pnImage">
                <label for="image">Upload file</label><br />
                
                <input type="button" class="button" id="btnAddImagePopup" value="Chọn file" />
                <input type="button" class="button" value="Tạo thư mục" onclick="showFolderForm('',$('#folderidcur').val())"/>
                <input type="button" class="button" value="Sửa tên thư mục" onclick="showFolderForm($('#folderidcur').val(),'')"/>
                <input type="button" class="button" value="Xóa thư mục" onclick="delFolder($('#folderidcur').val())"/>
                <input type="button" class="button" value="Cây thư mục" onclick="$('#folderconten').show()"/>
                <br />
                <div id="errorupload" class="error" style="display:none"></div>
               
                <?php if($_GET['dialog'] == ''){?>
                <input type="button" class="button" id="btnDelFile" value="Xóa file"/>
                <input type="button" class="button" id="btnMoveFile" value="Chuyển thư mục" onclick="showFolderMoveForm()"/>
                <?php } ?>
                
            </p>
        </td>
    </tr>
    <tr valign="top">
    	
        <td style="vertical-align:top !important">
        	
        	<div id="folderconten" style="position:absolute;background:#fff;overflow:auto;display:none;width:300px">
            	<span class="folderitem selectfolder" folderid="0">Root</span>
                <input type="button" class="button right" value="X" onclick="$('#folderconten').hide()"/>
            	<div id="showfolder"></div>
            </div>
        	<div id="result"></div>
        	
        </td>
        
    </tr>
</table>
</form>
<script>
	var imageindex = 0;
	var DIR_UPLOADPHOTO = "<?php echo $DIR_UPLOADPHOTO?>";
	var DIR_UPLOADATTACHMENT = "<?php echo $DIR_UPLOADATTACHMENT?>";
</script>
<script language="javascript">
//alert(parent.opener.document.InsertContent.title.value);
$(document).ready(function() {
	
	loadFolder()
  	showResult("?route=core/file/getList&folderid="+ $('#folderidcur').val());
	
	
	$('#showfolder').css('overflow','auto');
	//'$('#showfolder').css('height',$(window).height() - $('#showfolder').position().top+ 'px');
	
	
});
function loadFolder()
{
	
	$('#showfolder').load("?route=core/file/getFolderTreeView",function(){
		var CLASSES = ($.treeview.classes = {
			animated: "fast",
 			collapsed: false,
			persist: "cookie",
 			cookieId: "rememberme"
		});
		$("#group0").treeview(CLASSES);
		intFolder()
	});
}
function intFolder()
{
	$('.folderitem').click(function(e) {
		$('.folderitem').removeClass("selectfolder");
		$(this).addClass("selectfolder");
		var folderid = $(this).attr('folderid');
		selectFolder(folderid)
	});
}
function selectFolder(folderid)
{
	$('.folderitem').removeClass("selectfolder");
	$('#folderidcur').val(folderid);
	$('#foldername' + folderid).addClass("selectfolder");
	showResult("?route=core/file/getList&folderid="+ folderid);
	
	
	
}
var arrfileid = new Array();
$("#btnfilter").click(function(){
	
	url = "?route=core/file/getList&keyword="+escape($("#keyword").val())+"&location="+$("#location").val()+"&sitemap="+$("#sitemap").val();
	showResult(url);						   
})
$('#btnDelFile').click(function(e) {
    $('.selectfile').each(function(index, element) {
        var fileid = this.id;
		$.get("?route=core/file/delFile&fileid="+fileid,function(data){
			showResult("?route=core/file/getList&folderid="+ $('#folderidcur').val());
		});		
    });
});




function callbackUploadFile()
{
	new AjaxUpload(jQuery('#btnAddImagePopup'), {
		action: DIR_UPLOADATTACHMENT,
		name: 'image2[]',
		
		responseType: 'json',
		onChange: function(file, ext){
		},
		onSubmit: function(file, ext){
			$('.loadingimage').show();
			// Allow only images. You should add security check on the server-side.
			/*if (ext && /^(jpg|png|jpeg|gif)$/i.test(ext)) {                            
				$('#pnImage').hide();
				$('.loadingimage').show();
			} else {
				alert('Your selection is not image');
				return false;
			}        */                    
		},
		onComplete: function(file, response){
			
			for(i in response.files)
			{
				
				var fileid = response.files[i].imageid;
				var folderid = $('#folderidcur').val();
				$.get("?route=core/file/updateFolder&fileid="+fileid+"&folderid="+folderid,
					function(){
						 showResult("?route=core/file/getList&folderid="+folderid);
					});
				//Cap nhat vo thu muc folder:$('#folderidcur').val(),
			}
			$('#errorupload').hide();
			
           
				
            
			
			
				
			
			
			$('#pnImage').show();
			$('.loadingimage').hide();
			
		}
	});	

	
}
function showResult(url)
{
	$('#result').html(loading);
	$("#result").load(url,function(){
		if("<?php echo $_GET['dialog']?>" =='true')
			intSeleteFile("<?php echo $_GET['type']?>");
	});
}
callbackUploadFile();
</script>
