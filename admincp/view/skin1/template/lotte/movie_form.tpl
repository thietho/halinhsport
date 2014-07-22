<div class="section" id="sitemaplist">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content padding1">
    
    	<form  id="frm_movie" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        	
            
        	<div class="button right">
            	<input type="button" value="Lưu" class="button" onClick="save('')"/>
                 <input type="button" value="Bỏ qua" class="button" onclick="linkto('?route=quanlykho/phieuxuat')"/>  
     	        <input type="hidden" name="id" value="<?php echo $item['id']?>">
                
            </div>
            <div class="clearer">^&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
        	<div id="container">
            	<ul>
                    <li class="tabs-selected"><a href="#fragment-movieinfo" ><span>Movie info</span></a></li>
                    <li><a href="#fragment-timeshow"><span>Time Show</span></a></li>
                    <li><a href="#fragment-cenimalocation"><span>Cenima location</span></a></li>
                    <li><a href="#fragment-ticketprice"><span>Ticket price</span></a></li>
                    
                </ul>
                <div id="fragment-movieinfo">
                	<p>
                        <label>Tên film</label><br />
                        <input type="text" id="moviename" name="moviename" value="<?php echo $item['moviename']?>" class="text" size=60/>
                        
                    </p>
                    <p>
                        <label>Icon(262x262)</label>
                        
                        <input type="hidden" id="icone_fileid" name="icone_fileid" value="<?php echo $item['icone']?>"/><br />
                        <img id="icone_preview" src="<?php echo $item['iconethumbnail']?>"/>
                        <input type="button" class="button" value="<?php echo $entry_photo ?>" onclick="browserFile('icone','single')"/>
                        
                        
                    </p>
                    <p>
                        <label>Banner(1045x540)</label>
                        <input type="hidden" id="banner_fileid" name="banner_fileid" value="<?php echo $item['banner']?>"/><br />
                        <img id="banner_preview" src="<?php echo $item['bannerthumbnail']?>"/>
                        <input type="button" class="button" value="<?php echo $entry_photo ?>" onclick="browserFile('banner','single')"/>
                    </p>
                    <p>
                        <label>Image(214x403)</label>
                        <input type="hidden" id="image_fileid" name="image_fileid" value="<?php echo $item['image']?>"/><br />
                        <img id="image_preview" src="<?php echo $item['imagethumbnail']?>"/>
                        <input type="button" class="button" value="<?php echo $entry_photo ?>" onclick="browserFile('image','single')"/>
                    </p>
                    <p>
                    	<label>Movie info</label><br />
                        <input type="button" class="button" value="<?php echo $entry_photo ?>" onclick="browserFile('movieinfo','editor')"/>
                        <input type="button" class="button" value="Chọn video" onclick="browserFile('movieinfo','video')"/>
                    	<textarea class="text" id="movieinfo" name="movieinfo"><?php echo $item['movieinfo']?></textarea>
                    </p>
                    

                </div>
                <div id="fragment-timeshow">
                	<input type="button" class="button" value="<?php echo $entry_photo ?>" onclick="browserFile('timeshow','editor')"/>
                    <input type="button" class="button" value="Chọn video" onclick="browserFile('timeshow','video')"/>
                    <br />
                	<textarea class="text" id="timeshow" name="timeshow"><?php echo $item['timeshow']?></textarea>
                </div>
                <div id="fragment-cenimalocation">
                	<input type="button" class="button" value="<?php echo $entry_photo ?>" onclick="browserFile('cinemalocation','editor')"/>
                    <input type="button" class="button" value="Chọn video" onclick="browserFile('cinemalocation','video')"/>
                    <br />
                	<textarea class="text" id="cinemalocation" name="cinemalocation"><?php echo $item['cinemalocation']?></textarea>
                </div>
                <div id="fragment-ticketprice">
                	<input type="button" class="button" value="<?php echo $entry_photo ?>" onclick="browserFile('ticketprice','editor')"/>
                    <input type="button" class="button" value="Chọn video" onclick="browserFile('ticketprice','video')"/>
                    <br />
                	<textarea class="text" id="ticketprice" name="ticketprice"><?php echo $item['ticketprice']?></textarea>
                </div>
            </div>
            
        </form>
    
    </div>
    
</div>
<script type="text/javascript" charset="utf-8">
function save()
{
	$.blockUI({ message: "<h1><?php echo $announ_infor ?></h1>" }); 
	var oEditor = CKEDITOR.instances['movieinfo'] ;
	var pageValue = oEditor.getData();
	$('textarea#movieinfo').val(pageValue);
	
	var oEditor = CKEDITOR.instances['timeshow'] ;
	var pageValue = oEditor.getData();
	$('textarea#timeshow').val(pageValue);
	
	var oEditor = CKEDITOR.instances['cinemalocation'] ;
	var pageValue = oEditor.getData();
	$('textarea#cinemalocation').val(pageValue);
	
	var oEditor = CKEDITOR.instances['ticketprice'] ;
	var pageValue = oEditor.getData();
	$('textarea#ticketprice').val(pageValue);
	
	$.post("?route=lotte/movie/save",$('#frm_movie').serialize(),
		function(data){
			if(data=="true")
			{
				window.location = "?route=lotte/movie";
				
			}
			else
			{
				$('#error').html(data).show('slow');
				$.unblockUI();
			}
			
		});
}




$(document).ready(function() { 
	setCKEditorType('movieinfo',2);
	setCKEditorType('timeshow',2);
	setCKEditorType('cinemalocation',2);
	setCKEditorType('ticketprice',2);
	$('#container').tabs({ fxSlide: true, fxFade: true, fxSpeed: 'slow' });
	
});
</script>

