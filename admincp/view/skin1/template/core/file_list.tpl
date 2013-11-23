<script src='<?php echo DIR_JS?>ajaxupload.js' type='text/javascript' language='javascript'> </script>


<form id="ffile" name="ffile" method="post">

<table width="100%" class="data-table">
	<tr>
        <td colspan="3">
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
                <input type="button" class="button" value="Xóa thư mục" onclick="delFolder($('.selectfolder').attr('folderid'))"/>
                <br />
                <div id="errorupload" class="error" style="display:none"></div>
                <input type="button" class="button" id="btnDelFile" value="Xóa file"/>
                <input type="button" class="button" id="btnMoveFile" value="Chuyển thư mục" onclick="showFolderMoveForm()"/>
            </p>
        </td>
    </tr>
    <tr valign="top">
    	<td  width="20%" style="vertical-align:top">
        	<span class="folderitem selectfolder" folderid="0">Root</span>
            <div id="showfolder"></div>   
        </td>
        <td id="result" style="vertical-align:top !important">
        	Loading...
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
	var CLASSES = ($.treeview.classes = {
		open: "open",
		closed: "closed",
		expandable: "expandable",
		expandableHitarea: "expandable-hitarea",
		lastExpandableHitarea: "lastExpandable-hitarea",
		collapsable: "collapsable",
		collapsableHitarea: "collapsable-hitarea",
		lastCollapsableHitarea: "lastCollapsable-hitarea",
		lastCollapsable: "lastCollapsable",
		lastExpandable: "lastExpandable",
		last: "last",
		hitarea: "hitarea"
	});
	loadFolder()
  	showResult("?route=core/file/getList&folderid=0&edit=true");
	
	$(".checkbox").click(function(index){
		//alert($(this).val());
		//alert(this.checked);
		
		temp ="";
		$(".checkbox").each(function(index){
			
			if(this.checked)
			temp += $(this).val()+",";
		})
		$("#sitemap").val(temp);
	});
	
	
});
function intFolder()
{
	$('.folderitem').click(function(e) {
		$('.folderitem').removeClass("selectfolder");
		$(this).addClass("selectfolder");
		showResult("?route=core/file/getList&folderid="+ $(this).attr('folderid') +"&edit=true");
	});
}
var arrfileid = new Array();
$("#btnfilter").click(function(){
	
	url = "?route=core/file/getList&edit=true&keyword="+escape($("#keyword").val())+"&location="+$("#location").val()+"&sitemap="+$("#sitemap").val();
	showResult(url);						   
})
$('#btnDelFile').click(function(e) {
    /*for(i in arrfileid)
	{
		$.get("?route=core/file/delFile&fileid="+arrfileid[i],function(){
			showResult("?route=core/file/getList&edit=true");	
		});
	}*/
	/*$('.chkfile').each(function(index, element) {
        if(this.checked==true)
		{
			$.get("?route=core/file/delFile&fileid="+this.value,function(){
				showResult("?route=core/file/getList&edit=true");
			});
		}
    });*/
	$.post("?route=core/file/delListFile",$('#ffile').serialize(),function(data){
		showResult("?route=core/file/getList&edit=true");
	});
});


function removeFile(fileid)
{
	$("#rowimage"+fileid).html("");	
	//arr.splice(arr.indexOf(fileid),1,arr);
}
var arr = new Array();
function selectFile(fileid)
{
	if(arr.indexOf(fileid)==-1)
	{
		arr.push(fileid);
	
		input = '<input type="hidden" class="rows" id="seletediamge'+fileid+'" name="seletediamge'+fileid+'" value="'+fileid+'" />';
		remove = '<a class="button" onClick="removeFile('+ fileid +')">Remove</a>'
		$("#selected").append("<div id='rowimage"+fileid+"'>"+$("#image"+fileid).html()+input+"</div>"+remove+"<br/>");
	}
}

function saveSelect()
{
	//parent.opener.document.InsertContent.listselectfile.value ="";
	$("#listselectfile").val('');
	$(".rows").each(function(index){
		//parent.opener.document.InsertContent.listselectfile.value+=$(this).val()+",";
		$("#listselectfile").val($("#listselectfile").val()+$(this).val()+",")
	})
	//window.close();
	$.unblockUI();
	addImageTo();
}

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
				var folderid = $('.selectfolder').attr('folderid');
				$.get("?route=core/file/updateFolder&fileid="+fileid+"&folderid="+folderid,
					function(){
						 showResult("?route=core/file/getList&folderid="+folderid+"&edit=true");
					});
				//Cap nhat vo thu muc folder:$('.selectfolder').attr('folderid'),
			}
			$('#errorupload').hide();
			
           
				
            
			
			
				
			
			
			$('#pnImage').show();
			$('.loadingimage').hide();
			
		}
	});	

	
}
function showResult(url)
{
	$("#result").load(url,function(){
		//intSeleteFile("<?php echo $_GET['type']?>");
	});
}
callbackUploadFile();
</script>
