<div class="section" id="sitemaplist">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content padding1">
    
    	<form name="frm" id="frm" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	<input type="button" value="Lưu" class="button" onClick="save()"/>
     	        <input type="button" value="Bỏ qua" class="button" onclick="linkto('?route=quanlykho/nguyenlieu')"/>   
     	        <input type="hidden" name="id" value="<?php echo $item['id']?>">
                <input type="hidden" id="handler" />
             	<input type="hidden" id="outputtype" />
            </div>
            <div class="clearer">^&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
        	<div>
            	<p>
            		<label>Mã nguyên vật liệu</label><br />
					<input type="text" id="manguyenlieu" name="manguyenlieu" value="<?php echo $item['manguyenlieu']?>" class="text" size=60 <?php echo $readonly?>/>
                    
            	</p>
              	
                
                <p>
            		<label>Tên nguyên vật liệu</label><br />
					<input type="text" id="tennguyenlieu" name="tennguyenlieu" value="<?php echo $item['tennguyenlieu']?>" class="text" size=60 />
                    
            	</p>
              
                <p>
            		<label>Loại</label><br />
					<select id="loai" name="loai">                   		
                        <?php foreach($loainguyenlieu as $val){ ?>
                        <option value="<?php echo $val['categoryid']?>"><?php echo $this->string->getPrefix("&nbsp;&nbsp;&nbsp;",$val['level']-1)?><?php echo $val['categoryname']?></option>
                        <?php } ?>
                    </select>
            	</p>
                <p>
            		<label>Tồn tối thiểu</label><br />
					<input type="text" id="tontoithieu" name="tontoithieu" value="<?php echo $item['tontoithieu']?>" class="text number" size=60 />
            	</p>
                <!--<p>
            		<label>Tồn tối đa</label><br />
					<input type="text" id="tontoida" name="tontoida" value="<?php echo $item['tontoida']?>" class="text number" size=60 />
            	</p>
                <p>
            		<label>Số lượng 1 lần đăt hàng</label><br />
					<input type="text" id="soluongmoilandathang" name="soluongmoilandathang" value="<?php echo $item['soluongmoilandathang']?>" class="text number" size=60 />
            	</p>-->
                <p>
            		<label>Đơn vị tính</label><br />
					<select id="madonvi" name="madonvi">
                    	<option value=""></option>
                    	<?php foreach($donvitinh as $val){ ?>
                        <option value="<?php echo $val['madonvi']?>"><?php echo $val['tendonvitinh']?></option>
                        <?php } ?>
                    </select>
            	</p>
                
                <!--<p>
            		<label>Mục đích sử dụng</label><br />
					<textarea id="mucdichsudung" name="mucdichsudung"><?php echo $item['mucdichsudung']?></textarea>
            	</p>-->
                <p>
            		<label>Ghi chú</label><br />
					<textarea id="ghichu" name="ghichu"><?php echo $item['ghichu']?></textarea>
            	</p>
               
               	<p id="pnImage">
                    <label for="image">Hình</label><br />
                    <a class="button" onclick="browserFileImage()">Chọn hình</a><br />
                    
                    <img id="preview" src="<?php echo $item['imagethumbnail']?>" />
                    <input type="hidden" id="imagepath" name="imagepath" value="<?php echo $item['imagepath']?>" />
                    <input type="hidden" id="imageid" name="imageid" value="<?php echo $item['imageid']?>" />
                    <input type="hidden" id="imagethumbnail" name="imagethumbnail" value="<?php echo $item['imagethumbnail']?>" />
                </p>
                
                
                <div id="errorupload" class="error" style="display:none"></div>
                
                <div class="loadingimage" style="display:none"></div>
               
            </div>
            
        </form>
    
    </div>
    
</div>
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
	
		
		$("#popup-content").load("?route=core/file&dialog=true",function(){
			$("#popup").dialog("open");	
		});
}
function intSeleteFile()
{
	$('.filelist').click(function(e) {
        $('#preview').attr('src',$(this).attr('imagethumbnail'));
		$('#imageid').val(this.id);
		$('#imagepath').val($(this).attr('filepath'));
		$('#imagethumbnail').val($(this).attr('imagethumbnail'));
		$("#popup").dialog( "close" );
    });
}

function save()
{
	$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
	$.post("?route=quanlykho/nguyenlieu/save", $("#frm").serialize(),
		function(data){
			if(data == "true")
			{
				window.location = "?route=quanlykho/nguyenlieu";
			}
			else
			{
			
				$('#error').html(data).show('slow');
				$.unblockUI();
				
			}
			
		}
	);
}

$("#manhom").val("<?php echo $item['manhom']?>");
$("#loai").val("<?php echo $item['loai']?>");

$("#madonvi").val("<?php echo $item['madonvi']?>");

var DIR_UPLOADPHOTO = "<?php echo $DIR_UPLOADPHOTO?>";
</script>

