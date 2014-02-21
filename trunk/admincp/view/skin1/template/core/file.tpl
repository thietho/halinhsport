<script src='<?php echo DIR_JS?>jquery.fileupload.js' type='text/javascript' language='javascript'> </script>


<form id="ffile" name="ffile" method="post">

<table width="100%" class="data-table">
	<tr>
        <td colspan="3">
        	<input type="hidden" id="folderidcur" value="0" />
     		<input type="hidden" name="sitemap" id="sitemap" value="" />
      		<strong>File name</strong> <input type="text" name="keyword" id="keyword" class="text" />&nbsp;&nbsp;
            
            
            			
            
            &nbsp;&nbsp;<input type="button" id="btnfilter" name="btnfilter" value="Filter" class="button"/>
            
            <div class="progress" id="progress'+t+'"><div class="bar" style="width: 0%;"></div></div>
            <table>
                <tbody id="listfile">
                </tbody>
            </table>
        </td>
    </tr>
    <tr>
    	<td colspan="3">
        	<p id="pnImage">
                
                
                <input id="fileupload" class="button" type="file" name="files[]"  multiple value="Chon file" >
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
var cur = "";
var posk =0
$(function () {
    $('#fileupload').fileupload({
        dataType: 'json',
		/*add: function (e, data) {
			//alert(data.files[0].name)
			var t =posk++;
			
			var str = '<tr>';
			str += '<td>'+data.files[0].name+'</td>';
			str += '<td id="btn'+t+'"></td>';
			str += '<td><div class="progress" id="progress'+t+'"><div class="bar" style="width: 0%;"></div></div></td>';
			str += '</tr>'
			$('#listfile').append(str);
            data.context = $('<button class="btnUpload" id="up'+t+'" ref="'+t+'"/>').text('Upload')
                .appendTo($('#btn'+t))
                .click(function () {
					cur = t;
                    data.context = $('<p/>').text('Uploading...').replaceAll($(this));
                    data.submit();
                });
        },*/
        done: function (e, data) {
            /*$.each(data.result.files, function (index, file) {
                $('<p/>').text(file.name).appendTo(document.body);
            });*/
			/*var fileid = response.files[i].imageid;
				var folderid = $('#folderidcur').val();
			$.get("?route=core/file/updateFolder&fileid="+fileid+"&folderid="+folderid,
				function(){
					 showResult("?route=core/file/getList&folderid="+folderid);
				});*/
			showResult("?route=core/file/getList&folderid="+ $('#folderidcur').val());
        },
		progressall: function (e, data) {
			//showProgress(cur,e, data)
			var progress = parseInt(data.loaded / data.total * 100, 10);
			$('.bar').html(progress+"%");
			$('.progress .bar').css(
				'width',
				progress + '%'
			);
		}
    });
});
function showProgress(id,e, data)
{
	var progress = parseInt(data.loaded / data.total * 100, 10);
	$('#progress'+cur+' .bar').css(
				'width',
				progress + '%'
	);
}
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





function showResult(url)
{
	$('#result').html(loading);
	$("#result").load(url,function(){
		if("<?php echo $_GET['dialog']?>" =='true')
			intSeleteFile("<?php echo $_GET['type']?>");
			$('#fileupload').fileupload({
				// Uncomment the following to send cross-domain cookies:
				//xhrFields: {withCredentials: true},
				url: '?route=common/uploadattachment&folderid='+ $('#folderidcur').val()
			});
	});
}
//callbackUploadFile();
</script>
