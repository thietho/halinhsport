<div class="section">

	<div class="section-title">
    	<?php echo $breadcrumb?>
    </div>
    <div id="error" class="error" style="display:none"></div>
    <div class="section-content padding1">
    
    	<form name="frmPost" id="frmPost"  action="" method="post" enctype="multipart/form-data">
    
    	<div class="left">
            
            <h3><?php echo $heading_title?></h3>
        
        </div>
        
    	<div class="right">
        	<?php if($_GET['dialog']==""){ ?>
        	<input class="button" type="button" value="<?php echo $button_save?>" onclick="save()"/>
            <a class="button" href="<?php echo $DIR_CANCEL.'&page='.$_GET['page']?>"><?php echo $button_cancel?></a>
             <?php } ?>
             <input type="hidden" id="id" name="id" value="<?php echo $post['id']?>" />
             <input type="hidden" id="mediaparent" name="mediaparent" value="<?php echo $post['mediaparent']?>" />
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
                    	<?php if($hasId) {?>
                        
                       
                        <p>
                            <label>ID</label><br>
                            <?php if($post['id'] == ""){ ?>
                            <input class="text" type="text" id="mediaid" name="mediaid" value="<?php echo $post['mediaid']?>" size="60" />
                            <?php }else{ ?>
                            <?php echo $post['mediaid']?>
                            <input type="hidden" id="mediaid" name="mediaid" value="<?php echo $post['mediaid']?>" />
                            <?php } ?>
                        </p>
                        <?php }else{ ?>
                    	<input type="hidden" id="mediaid" name="mediaid" value="<?php echo $post['mediaid']?>" />
                        <?php } ?>
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
                        	<label>Model</label><br>
                            <input class="text" type="text" id="code" name="code" value="<?php echo $post['code']?>" size="60" />
                        </p>
                        <p>
                        	<label>Qui cách</label><br>
                            <input class="text" type="text" id="sizes" name="sizes" value="<?php echo $post['sizes']?>" size="60" />
                         	
                        </p>
                        <p>
                        	<label>Màu sắc</label><br>
                            <input class="text" type="text" id="color" name="color" value="<?php echo $post['color']?>" size="60" />
                         	
                        </p>
                        <p>
                        	<label>Chất liệu</label><br>
                            <input class="text" type="text" id="material" name="material" value="<?php echo $post['material']?>" size="60" />
                         	
                        </p>
                        <p>
                            <label>Nhãn hiệu</label><br />
                            <select id="brand" name="brand">
                                <option value=""></option>
                                <?php foreach($nhanhieu as $it){ ?>
                                <option value="<?php echo $it['categoryid']?>"><?php echo $this->string->getPrefix("&nbsp;&nbsp;&nbsp;&nbsp;",$it['level']) ?><?php echo $it['categoryname']?></option>                        
                                <?php } ?>
                            </select>
                        </p>
                        <p>
                        	<label>Chú thích</label><br>
                            <input class="text" type="text" id="noted" name="noted" value="<?php echo $post['noted']?>" size="60" />
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
									if(this.value !="")
									{
										
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
											$('#frmgiaban').show();
											numberReady();
										})										
									}
									else
									{
										$('#frmgiaban').hide();
									}
                                });
								
								$(document).ready(function(e) {
									
                                	$('#unit').val("<?php echo $post['unit']?>").change();
									$('#brand').val("<?php echo $post['brand']?>")
                                });
								
								
							</script>
                           
                        </p>
                        <?php } ?>
                    	<?php if($hasPrice) {?>
                        <p id="frmgiaban">
                        	<label>Giá bán</label>
                            <div id="giaban"></div>
                        </p>
                        
                        <p>
                            <label><?php echo $text_price?></label><br>
                            <input class="text number" type="text" id="price" name="price" value="<?php echo $post['price']?>"/>
                            <input class="text short" type="text" id="noteprice" name="noteprice" value="<?php echo $post['noteprice']?>" />
                        </p>
                        <p>
                            <label>Phần trăm giảm giá</label><br>
                            <input class="text number" type="text" id="discountpercent" name="discountpercent" value="<?php echo $post['discountpercent']?>" />%
                        </p>
                        <p>
                            <label>Giá khuyến mãi</label><br>
                            <input class="text number" type="text" id="pricepromotion" name="pricepromotion" value="<?php echo $post['pricepromotion']?>" />
                        </p>
                        <script language="javascript">
						$('#discountpercent').keyup(function(e) {
                            var price = Number(stringtoNumber($('#price').val()));
							var discountpercent = Number(stringtoNumber($('#discountpercent').val()));
							var pricepromotion = price*( 1- discountpercent/100);
							$('#pricepromotion').val(formateNumber(pricepromotion));
                        });
						
						$('#pricepromotion').keyup(function(e) {
                            var price = Number(stringtoNumber($('#price').val()));
							var pricepromotion = Number(stringtoNumber($('#pricepromotion').val()));
							var discountpercent = (1- pricepromotion/price)*100;
							$('#discountpercent').val(formateNumber(discountpercent));
                        });
						</script>
                        <?php } ?>
                        <p>
                        	<label>Trang thái:</label>
                            
                            <select id="status" name="status">
                            	<?php foreach($this->document->status_media as $key =>$val){ ?>
                                <option value="<?php echo $key?>"><?php echo $val?></option>
                                <?php } ?>
                                
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
                            
                            <input type="button" class="button" value="<?php echo $entry_photo ?>" onclick="browserFile('imageid','single')"/><br />
                            <img id="imageid_preview" src="<?php echo $imagethumbnail?>" onclick="showFile($('#imageid_fileid').val())"/>
                            <input type="hidden" id="imageid_filepath" name="imagepath" value="<?php echo $post['imagepath']?>" />
                            <input type="hidden" id="imageid_fileid" name="imageid" value="<?php echo $post['imageid']?>" />
                            
                        </p>
                        
                        
                        <div id="errorupload" class="error" style="display:none"></div>
                        
                        <div class="loadingimage" style="display:none"></div>
                       <?php if($hasAttachment){ ?>
                        <p>
                        	<input type="button" class="button" value="<?php echo $entry_photo ?>" onclick="browserFile('attachment','multi')"/>
                        	
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
				$.getJSON("?route=core/file/getFile&fileid=<?php echo $item['fileid']?>&width=50", 
				function(file) 
				{
					
					$('#attachment').append(attachment.creatAttachmentRow(file.file.fileid,file.file.filename,file.file.imagepreview));
					
				});
			
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
                    	<label>Màu sắc</label>
                        <?php foreach($color as $it){ ?>
                        <div>
                        	
                        	<?php echo $this->string->getPrefix("&nbsp;&nbsp;&nbsp;&nbsp;",$it['level']) ?>
                            <input type="checkbox"  name="loaisp[<?php echo $it['categoryid']?>]" value="<?php echo $it['categoryid']?>" <?php echo in_array($it['categoryid'],$properties)?'checked="checked"':''; ?> />
                            <?php echo $it['categoryname']?>
                        </div>
                        <?php } ?>
                    </p>
                    <p>
                    	<label>Size</label>
                        <?php foreach($size as $it){ ?>
                        <div>
                        	
                        	<?php echo $this->string->getPrefix("&nbsp;&nbsp;&nbsp;&nbsp;",$it['level']) ?>
                            <input type="checkbox"  name="loaisp[<?php echo $it['categoryid']?>]" value="<?php echo $it['categoryid']?>" <?php echo in_array($it['categoryid'],$properties)?'checked="checked"':''; ?> />
                            <?php echo $it['categoryname']?>
                        </div>
                        <?php } ?>
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
            	
                <input type="button" class="button" value="<?php echo $entry_photo ?>" onclick="browserFile('editor1','editor')"/>
                <input type="button" class="button" value="Chọn video" onclick="browserFile('editor1','video')"/>
                
            	<div>
                	<p>
                        <textarea name="description" id="editor1" ><?php echo $post['description']?></textarea>
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
                	<ul>
                        <?php echo $listReferSiteMap?>
                    </ul>
                   
                        
                	
                
                </div>
            </div>
            <?php if(count($arrrefersitemap)){?>
            	<?php foreach($arrrefersitemap as $sitemapid){?>
                	<?php if($sitemapid){ ?>
                    <script language="javascript">
						$('#refersitemap-<?php echo $sitemapid?>').attr('checked','checked');
                    </script>
                    <?php } ?>
                <?php }?>
            <?php } ?>
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
	objComment.loadComment("<?php echo $post['mediaid']?>");
}
var objComment = new Comment();
$(document).ready(function(e) {
    objComment.loadComment("<?php echo $post['mediaid']?>");
});
</script>
            <?php } ?>
            
        
        </div>
        
        </form>
    
    </div>

</div>

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
				window.location = "<?php echo $DIR_CANCEL.'&page='.$_GET['page']?>";
				
			}
			else
			{
				$('#error').html(data).show('slow');
				$.unblockUI();
			}
			
		});
}




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












</script>