<div class="section">

	<div class="section-title">
    	<?php echo $breadcrumb?>
    </div>
    
    <div class="section-content padding1">
    
    	<form name="frmPost" id="frmPost"  action="" method="post" enctype="multipart/form-data">
    
    	<div class="left">
            
            <h3><?php echo $heading_title?></h3>
        
        </div>
        
    	<div class="right">
        	
        	<input class="button" type="button" value="<?php echo $button_save?>" onclick="save()"/>
            <a class="button" href="<?php echo $DIR_CANCEL.'&page='.$_GET['page']?>"><?php echo $button_cancel?></a>
             
             <input type="hidden" id="mediaid" name="mediaid" value="<?php echo $post['mediaid']?>" />
             <input type="hidden" id="mediatype" name="mediatype" value="<?php echo $post['mediatype']?>" />
             <input type="hidden" id="refersitemap" name="refersitemap" value="<?php echo $post['refersitemap']?>" />
             
        </div>
        <div class="clearer">&nbsp;</div>
        
        
        <div id="container">
        	
            
        	<ul>
                <li class="tabs-selected"><a href="#fragment-content" ><span><?php echo $tab_editcontent?></span></a></li>
                <?php if($hasProperties) {?>
                <li><a href="#fragment-properties"><span><?php echo $lbl_property ?></span></a></li>
                <?php }?>
                <li><a href="#fragment-detail"><span><?php echo $lbl_detail ?></span></a></li>
                <?php if($hasVideo) {?>
                <li><a href="#fragment-video"><span>Video</span></a></li>
                <?php }?>
                <?php if($hasAudio) {?>
                <li><a href="#fragment-audio"><span>Audio</span></a></li>
                <?php }?>
                <?php if($hasSubInfor) {?>
                <li><a href="#fragment-subinfor"><span><?php echo $lbl_infor ?></span></a></li>
                <?php }?>
                <?php if($hasTabImages){ ?>
                <li><a href="#fragment-images"><span><?php echo $lbl_image ?></span></a></li>
                <?php } ?>
                <?php if($hasTabVideos){ ?>
                <li><a href="#fragment-videos"><span>Videos</span></a></li>
                <?php } ?>
                <?php if($hasTabDocuments){ ?>
                <li><a href="#fragment-documents"><span><?php echo $lbl_document ?></span></a></li>
                <?php } ?>
                
                <?php if($hasTabMap) {?>
                <li><a href="#fragment-map"><span><?php echo $tab_map?></span></a></li>
                <?php } ?>
                <?php if($hasTabComment) {?>
                <li><a href="#fragment-comment"><span>Đánh giá</span></a></li>
                <?php } ?>
                 
                
                
            </ul>
           
            
            <div id="fragment-content">
            	
                <div style="<?php echo $displaynews?>">
        			
                    <div class="col2 left">
                    	
                        <?php if($hasTitle) {?>
                        
                       
                        <p>
                            <label><?php echo $entry_title?></label><br>
                            <input class="text" type="text" id="title" name="title" value="<?php echo $post['title']?>" size="60" />
                        </p>
                        
                        <p>
                            <label><?php echo $text_alias?></label><br>
                            <input class="text" type="text" id="alias" name="alias" value="<?php echo $post['alias']?>" size="60" />
                        </p>
<script>
$('#title').change(function(e) {
	
    $.ajax({
			url: "?route=common/api/getAlias&title=" + toBasicText(this.value),
			cache: false,
			success: function(html)
			{
				$("#alias").val(html);
			}
	});
});
</script>
                       <!-- <p>
                            <label><?php echo $text_keyword?></label><br>
                            <textarea class="text" rows="3" cols="70" name="keyword"><?php echo $keyword?></textarea>
                        </p>-->
                        <?php } ?>
                        <?php if($hasCode){?>
                       	<p>
                        	<label>Code</label><br>
                            <input class="text" type="text" id="code" name="code" value="<?php echo $post['code']?>" size="60" />
                        </p>
                        <p>
                        	<label>Qui cách</label><br>
                            <textarea cols="50" rows="4" class="text" id="sizes" name="sizes"><?php echo $post['sizes']?></textarea>
                        </p>
                        <p>
                        	<label>Đơn vị</label><br>
                            <select id="unit" name="unit">
                            	
                                <option value=""></option>
                                <?php foreach($donvitinh as $val){ ?>
                                <option value="<?php echo $val['madonvi']?>"><?php echo $val['tendonvitinh']?></option>
                                <?php } ?>
                                
                            </select>
                            <script language="javascript">
								
								
								$('#unit').change(function(e) {
									$('#giaban').html('');
                                    $.getJSON("?route=quanlykho/donvitinh/getListDonVi&madonvi="+ this.value,function(data){
										for(i in data)
										{
											var str = "";
											str+='<input type="text" id="saleprice-'+data[i].madonvi+'" name="saleprice['+data[i].madonvi+']" class="text number">/'+data[i].tendonvitinh+'<br>'
											$('#giaban').append(str);
											numberReady();
										}
										
										<?php if($post["saleprice"]!=""){ ?>
											
										var saleprice = $.parseJSON('<?php echo $post["saleprice"]?>');
										for(i in saleprice)
										{
											//alert(saleprice[i])
											$('#saleprice-'+i).val(saleprice[i]);
										}
										
										<?php } ?>
										numberReady();
									})
                                });
								$(document).ready(function(e) {
                                	$('#unit').val("<?php echo $post['unit']?>").change();    
                                });
								
								
							</script>
                           
                        </p>
                        <?php } ?>
                    	<?php if($hasPrice) {?>
                        <p>
                        	<label>Giá bán</label>
                            <div id="giaban"></div>
                        </p>
                        
                        <p>
                            <label><?php echo $text_price?></label><br>
                            <input class="text number" type="text" name="price" value="<?php echo $post['price']?>" size="60" />
                        </p>
                        <p>
                            <label>Giá khuyến mãi</label><br>
                            <input class="text number" type="text" name="pricepromotion" value="<?php echo $post['pricepromotion']?>" size="60" />
                        </p>
                        <?php } ?>
                        <p>
                        	<label>Trang thái:</label>
                            
                            <select id="status" name="status">
                            	<option value="active">Hiện</option>
                                <option value="hide">Ẩn</option>
                            </select>
                            <script language="javascript">
								$('#status').val("<?php echo $post['status']?>")
							</script>
                        </p>
                    </div>
                    <?php if($hasFile) {?>
                    <div class="col2 right">
                    	
                    	<p id="pnImage">
                            <label for="image"><?php echo $entry_image?></label><br />
                            <a  class="button" onclick="browserFileImage()"><?php echo $entry_selectphoto?></a><br />
                            <img id="imagepreview" src="<?php echo $imagethumbnail?>" />
                            <input type="hidden" id="imagepath" name="imagepath" value="<?php echo $post['imagepath']?>" />
                            <input type="hidden" id="imageid" name="imageid" value="<?php echo $post['imageid']?>" />
                            <input type="hidden" id="imagethumbnail" name="imagethumbnail" value="<?php echo $post['imagethumbnail']?>" />
                        </p>
                        
                        
                        <div id="errorupload" class="error" style="display:none"></div>
                        
                        <div class="loadingimage" style="display:none"></div>
                       <?php if($hasAttachment){ ?>
                        <p>
                        	<a id="btnAddAttachment" class="button" onclick="browserFileAttachment()"><?php echo $entry_attachment?></a><br />
                        </p>
                        <p id="attachment">
                        </p>
                    	
                        <span id="delfile"></span>
                        <?php } ?>
                    </div>
                    <?php }?>
<script language="javascript">
	
	$(document).ready(function() {
   	// put all your jQuery goodness in here.
	
<?php
		foreach($attachment as $item)
		{
			if(count($item))
			{
?>
			$('#attachment').append(attachment.creatAttachmentRow("<?php echo $item['fileid']?>","<?php echo $item['filename']?>","<?php echo $item['imagethumbnail']?>"));
<?php
			}
		}
?>
 	});
	
</script>
                    <div class="clearer">&nbsp;</div>
                
                </div>
                
                <div>
                    
                    
                    
              		<?php if($hasSummary) {?>
                    <p>
                        <label><?php echo $entry_summary?></label><br>
                        <textarea class="text" rows="3" cols="70" id="summary" name="summary"><?php echo $post['summary']?></textarea>
<script language="javascript">
$(document).ready(function(e) {
    setCKEditorType('summary',2);
});
</script>
                    </p>
                    <?php } ?>
                    <?php if($hasSource) {?>
                    <p>
                        <label><?php echo $entry_source?></label><br>
                        <input class="text" type="text" name="source" value="<?php echo $post['source']?>" size="40" />
                    </p>
                    <?php } ?>
                
                </div>
                
            </div>
            <?php if($hasProperties) {?>
            <div id="fragment-properties">
            	<div>
                	
                	<p>
                    	<label>Nhãn hiệu</label><br />
                        <select name="nhanhieu">
                        	<option value=""></option>
                        	<?php foreach($nhanhieu as $it){ ?>
                        	<option value="<?php echo $it['categoryid']?>" <?php echo in_array($it['categoryid'],$properties)?'selected="selected"':''; ?>><?php echo $this->string->getPrefix("&nbsp;&nbsp;&nbsp;&nbsp;",$it['level']) ?><?php echo $it['categoryname']?></option>                        
                        	<?php } ?>
                        </select>
                    </p>
                    <p>
                    	<label><?php echo $text_status?></label>
                        <?php foreach($statuspro as $it){ ?>
                        <div>
                        	
                        	<?php echo $this->string->getPrefix("&nbsp;&nbsp;&nbsp;&nbsp;",$it['level']) ?>
                            <input type="checkbox"  name="loaisp[<?php echo $it['categoryid']?>]" value="<?php echo $it['categoryid']?>" <?php echo in_array($it['categoryid'],$properties)?'checked="checked"':''; ?> />
                            <?php echo $it['categoryname']?>
                        </div>
                        <?php } ?>
                    </p>
                </div>
            </div>
            <?php } ?>
            <div id="fragment-detail">
            	<a class="button" onclick="browserFileEditor()"><?php echo $entry_photo ?></a>
                <input type="hidden" id="listselectfile" name="listselectfile" />
            	<div>
                	<p>
                        <textarea name="description" id="editor1" cols="80" rows="10"><?php echo $post['description']?></textarea>
                    </p>
                </div>
            </div>
            <?php if($hasVideo) {?>
            <div id="fragment-video">
                    <p id="pnVideo">
                        <label for="file"><?php echo $lbl_file ?></label><br />
                        <a id="btnAddVideo" class="button"><?php echo $entry_file ?></a><br />
                        <span id="filename"><?php echo $post['filepath']?></span>
                        <input type="hidden" id="filepath" name="filepath" value="<?php echo $post['filepath']?>" />
                        <input type="hidden" id="fileid" name="fileid" value="<?php echo $post['fileid']?>" />
                        <div id="sub_errorupload" class="error" style="display:none"></div>
                        
                        
                    </p>
                    
                    
                    <div id="errorupload" class="error" style="display:none"></div>
                    
                    <div class="loadingimage" style="display:none"></div>
            </div>
            <?php } ?>
            
            <?php if($hasAudio) {?>
            <div id="fragment-audio">
                    <p id="pnAudio">
                        <label for="file"><?php echo $lbl_file ?></label><br />
                        <a id="btnAddAudio" class="button"><?php echo $entry_file ?></a><br />
                        <span id="filename"><?php echo $filepath?></span>
                        <input type="hidden" id="filepath1" name="filepath" value="<?php echo $post['filepath']?>" />
                        <input type="hidden" id="fileid1" name="fileid" value="<?php echo $post['fileid']?>" />
                        <div id="sub_errorupload" class="error" style="display:none"></div>
                        
                        
                    </p>
                    
                    
                    <div id="errorupload" class="error" style="display:none"></div>
                    
                    <div class="loadingimage" style="display:none"></div>
            </div>
            <?php } ?>
            
            <?php if($hasSubInfor) {?>
            <div id="fragment-subinfor">
            	<input type="hidden" name="sub_mediaid" id="sub_mediaid" />
            	<div>
                	<p>
                       <?php echo $lbl_title ?><br />
                        <input class="text" type="text" name="sub_title" id="sub_title" value="" size="40" />
                    </p>
                    <p id="sub_pnImage">
                        <label for="image"><?php echo $lbl_image ?></label><br />
                        <a id="btnAddSubImage" class="button"><?php echo $entry_photo ?></a><br />
                        <img id="sub_preview" src="" />
                        <input type="hidden" id="sub_imagepath" name="sub_imagepath" />
                        <input type="hidden" id="sub_imageid" name="sub_imageid"  />
                        <input type="hidden" id="sub_imagethumbnail" name="sub_imagethumbnail" />
                    </p>
                    <p>
                    	<textarea name="sub_description" id="sub_description" cols="80" rows="10"></textarea>
                    </p>
                    <p>
                    	<input type="button" class="button" value="<?php echo $button_save?>" onclick="postSubInfor()"/>
                        <input type="button" class="button" value="<?php echo $button_cancel?>"/>
                    </p>
                </div>
                <div id="subinforlist">
                </div>
<script language="javascript">
function postSubInfor()
{
	var oEditor = CKEDITOR.instances['sub_description'] ;
	var pageValue = oEditor.getData();
	$('textarea#sub_description').val(pageValue);
	$.post("?route=core/postcontent/savepost", 
					{
						mediaid : $("#sub_mediaid").val(), 
						mediaparent : $("#mediaid").val(),
						title : $("#sub_title").val(), 
						mediatype : 'subinfor',
						description : $("#sub_description").val(),
						imageid : $("#sub_imageid").val(),
						imagepath : $("#sub_imagepath").val()
					},
		function(data){
			if(data=="true")
			{
				$("#subinforlist").load("?route=core/postcontent/loadSubInfor&mediaid="+$("#mediaid").val());
				$("#sub_mediaid").val("");
				$("#sub_title").val("");
				$("#sub_summary").val("");
				$("#sub_author").val("");
				$("#sub_imageid").val("");
				$("#sub_imagepath").val("");
				$("#sub_preview").attr("src", "");
				var oEditor = CKEDITOR.instances.sub_description ;
				oEditor.setData("") ;
				$("#subimageerror").hide('slow');
			}
			else
			{
				$("#subimageerror").html(data);
				$("#subimageerror").show('slow');
			}
			
		});
}
function editeSubInfor(mediaid)
{
	
	$.getJSON("?route=core/postcontent/getSubInfor&mediaid="+mediaid, 
			function(data) 
			{
				//alert(data.subimage.imagepreview);
				$("#sub_mediaid").val(data.subinfor.mediaid);
				$("#sub_title").val(data.subinfor.title);
				$("#sub_summary").val(data.subinfor.summary);
				$("#sub_author").val(data.subinfor.author);
				$("#sub_imageid").val(data.subinfor.imageid);
				$("#sub_imagepath").val(data.subinfor.imagepath);
				$("#sub_imagethumbnail").val(data.subinfor.imagepreview);
				$("#sub_preview").attr("src", data.subinfor.imagepreview);
				var oEditor = CKEDITOR.instances.sub_description ;
				oEditor.setData(data.subinfor.description);
				
			});
}

function removeSubInfor(mediaid)
{
	//$.blockUI({ message: "<h1><?php echo $announ_infor ?></h1>" });
	$.ajax({
		url: "?route=core/postcontent/removeSubImage&mediaid="+mediaid, 
		cache: false,
		success: function(html)
		{
			$("#subinforlist").load("?route=core/postcontent/loadSubInfor&mediaid="+$("#mediaid").val());
		}
	});
	
}
</script>
<script language="javascript">
$(document).ready(function() { 
	setCKEditorType('sub_description',2);
	$("#subinforlist").load("?route=core/postcontent/loadSubInfor&mediaid="+$("#mediaid").val());
})
</script>
            </div>
            <?php }?>
            <?php if($hasTabImages){ ?>
            <div id="fragment-images">
            </div>
            <?php } ?>
            <?php if($hasTabVideos){ ?>
            <div id="fragment-videos">
            </div>
            <?php } ?>
            <?php if($hasTabDocuments){ ?>
            <div id="fragment-documents">
            </div>
            <?php } ?>
            
            <?php if($hasTabMap) {?>
            <div id="fragment-map">
                <div>
                	<table>
                    	<thead>
                        	<th width="50%"><?php echo $column_menu?></th>
                            <th width="50%"><?php echo $column_parent?></th>
                        </thead>
                        <tbody>
                        	<?php echo $listReferSiteMap?>
                        </tbody>
                    </table>
                	
                
                </div>
            </div>
            <?php } ?>
            <?php if($hasTabComment) {?>
            <div id="fragment-comment">
            	<div id="listcommet">
                </div>
            </div>
<script language="javascript">
function Comment()
{
	this.loadComment = function(mediaid)
	{
		$('#listcommet').load('?route=core/comment&mediaid='+mediaid+"&popup=true");
	}
}
function callbackLoadCommnet()
{
	objComment.loadComment('<?php echo $post['mediaid']?>');
}
var objComment = new Comment();
$(document).ready(function(e) {
    objComment.loadComment('<?php echo $post['mediaid']?>');
});
</script>
            <?php } ?>
            
        
        </div>
        
        </form>
    
    </div>

</div>

<script src='<?php echo DIR_JS?>ajaxupload.js' type='text/javascript' language='javascript'> </script>


<script type="text/javascript" charset="utf-8">
function save()
{
	$.blockUI({ message: "<h1><?php echo $announ_infor ?></h1>" }); 
	var oEditor = CKEDITOR.instances['editor1'] ;
	var pageValue = oEditor.getData();
	$('textarea#editor1').val(pageValue);
	<?php if($hasSummary) {?>
	var oEditor = CKEDITOR.instances['summary'] ;
	var pageValue = oEditor.getData();
	$('textarea#summary').val(pageValue);
	<?php } ?>
	$.post("?route=core/postcontent/savepost",$('#frmPost').serialize(),
		function(data){
			if(data=="true")
			{
				if("<?php echo $_GET['sitemapid']?>"!= "")
				{
					var sitemapid = $('#refersitemap').val().replace('[',"");
					sitemapid = sitemapid.replace("]","");
					//alert(strurl)
					if(strurl=="")
						window.location = "?route=<?php echo $this->getRoute()?>&sitemapid=<?php echo $_GET['sitemapid']?>&page=<?php echo $_GET['page'] ?>";	
					
						
				}
				else
					window.location = "?route=core/media";	
			}
			else
			{
				$.unblockUI();
			}
			
		});
}



var DIR_UPLOADPHOTO = "<?php echo $DIR_UPLOADPHOTO?>";
var DIR_UPLOADATTACHMENT = "<?php echo $DIR_UPLOADATTACHMENT?>";
$(document).ready(function() { 
	
	setCKEditorType('editor1',2);
	$('#container').tabs({ fxSlide: true, fxFade: true, fxSpeed: 'slow' });
	
});
</script>
<?php if($hasFile) {?>

<?php if($hasSubInfor) {?>
<script src="<?php echo DIR_JS?>uploadsubimage.js" type="text/javascript"></script>
<?php } ?>

<?php }?>
<?php if($hasVideo) {?>
<script src="<?php echo DIR_JS?>uploadvideo.js" type="text/javascript"></script>
<?php }?>
<?php if($hasAudio) {?>
<script src="<?php echo DIR_JS?>uploadaudio.js" type="text/javascript"></script>
<?php }?>
<script language="javascript">


function browserFileImage()
{
    //var re = openDialog("?route=core/file&dialog=true",800,500);
	/*$('#handler').val('image');
	$('#outputtype').val('image');
	showPopup("#popup", 800, 500);
	$("#popup").html("<img src='view/skin1/image/loadingimage.gif' />");
	$("#popup").load("?route=core/file&dialog=true");*/
	
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
                $('#popup-seletetion').append($(this))
            });
			break;
	}
}
function browserFileAttachment()
{

	$("#popup").attr('title','Chọn hình');
		$( "#popup" ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: 800,
			height: 600,
			modal: true,
			buttons: {
				
				
				
				'Xem danh sach':function()
				{
					$( "#popup-selete" ).show('fast',function(){
						$( "#popup-selete" ).position({
							my: "center",
							at: "center",
							of: "#popup"
						});
						$( "#popup-selete" ).draggable();
					});
					$('.closeselect').click(function(e) {
                        $( "#popup-selete" ).hide('fast');
                    });
				},
				'Chọn': function() 
				{
					$('#popup-seletetion .filelist').each(function(index, element) {
                        $.getJSON("?route=core/file/getFile&fileid="+this.id+"&width=50", 
							function(file) 
							{
								
								$('#attachment').append(attachment.creatAttachmentRow(file.file.fileid,file.file.filename,file.file.imagepreview));
								
							});
						
                    });
					$('#popup-seletetion').html("");
					$( this ).dialog( "close" );
				},
			}
		});
	
		
		$("#popup-content").load("?route=core/file&dialog=true&type=multi",function(){
			$("#popup").dialog("open");	
		});
}
function browserFile()
{
    //var re = openDialog("?route=core/file&dialog=true",800,500);
	$('#handler').val('file');
	$('#outputtype').val('file');
	showPopup("#popup", 800, 500);
	$("#popup").html("<img src='view/skin1/image/loadingimage.gif' />");
	$("#popup").load("?route=core/file&dialog=true")
		
}

function browserFileEditor()
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
	
		
		$("#popup-content").load("?route=core/file&dialog=true&type=editor",function(){
			$("#popup").dialog("open");	
		});
}


function Attachment()
{
	this.index = 0;
	this.removeAttachmentRow = function(index)
	{
		$("#delfile").append('<input type="hidden" id="attimageid'+attachment.index+'" name="delfile['+index+']" value="'+$("#attimageid"+index).val()+'" />');
		$("#attrows"+index).html("")
	}
	this.creatAttachmentRow = function(iid,path,thums)
	{
		
		row = '<div id="attrows'+attachment.index+'"><img src="'+thums+'" /><input type="hidden" id="attimageid'+attachment.index+'" name="attimageid['+attachment.index+']" value="'+iid+'" />'+path+' <a id="removerow'+attachment.index+'" onclick="attachment.removeAttachmentRow('+attachment.index+')" class="button" >Remove</a></div>';
		attachment.index++;
		return row;	
	}
	this.creatAttachmentRowView = function(iid,name,path,thums)
	{
		row = '<div id="attrows'+attachment.index+'"><img src="'+thums+'" /><input type="hidden" id="attimageid'+attachment.index+'" name="attimageid['+attachment.index+']" value="'+iid+'" />'+'<a href="'+path+'" target="_blank">'+name+'</a>';
		attachment.index++;
		return row;
	}

}
var attachment = new Attachment();

</script>