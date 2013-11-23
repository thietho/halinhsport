<div class="section" id="sitemaplist">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content padding1">
    
    	<form name="frm" id="frm" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	<input type="button" value="Lưu" class="button" onClick="save()"/>
     	        <input type="button" value="Bỏ qua" class="button" onclick="linkto('?route=quanlykho/nhacungcap')"/>   
     	        <input type="hidden" name="id" value="<?php echo $item['id']?>">
                
            </div>
            <div class="clearer">^&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
        	<div>
            	<p>
            		<label>Tên nhà cung cấp</label><br />
					<input type="text" id="tennhacungcap" name="tennhacungcap" value="<?php echo $item['tennhacungcap']?>" class="text" size=60/>
                    
            	</p>
                <p>
            		<label>Số điện thoại</label><br />
					<input type="text" id="sodienthoai" name="sodienthoai" value="<?php echo $item['sodienthoai']?>" class="text" size=60 />
                    
            	</p>
                <p>
            		<label>Địa chỉ</label><br />
					<input type="text" id="diachi" name="diachi" value="<?php echo $item['diachi']?>" class="text" size=60 />
                    
            	</p>
                <p>
            		<label>Email</label><br />
					<input type="text" id="email" name="email" value="<?php echo $item['email']?>" class="text" size=60 />
                    
            	</p>
                <p>
            		<label>Người liên hệ</label><br />
					<input type="text" id="nguoilienhe" name="nguoilienhe" value="<?php echo $item['nguoilienhe']?>" class="text" size=60 />
                    
            	</p>
                <p>
            		<label>Số điện thoại liên hệ</label><br />
					<input type="text" id="sodienthoainguoilienhe" name="sodienthoainguoilienhe" value="<?php echo $item['sodienthoainguoilienhe']?>" class="text" size=60 />
                    
            	</p>
                <p>
            		<label>Email liên hệ</label><br />
					<input type="text" id="emailnguoilienhe" name="emailnguoilienhe" value="<?php echo $item['emailnguoilienhe']?>" class="text" size=60 />
                    
            	</p>
                <p>
            		<label>Ghi chú</label><br />
					<textarea id="ghichu" name="ghichu"><?php echo $item['ghichu']?></textarea>
            	</p>
            </div>
            
        </form>
    
    </div>
    
</div>
<script language="javascript">

function save()
{
	$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
	$.post("?route=quanlykho/nhacungcap/save", $("#frm").serialize(),
		function(data){
			if(data == "true")
			{
				window.location = "?route=quanlykho/nhacungcap";
			}
			else
			{
			
				$('#error').html(data).show('slow');
				$.unblockUI();
				
			}
			
		}
	);
}

</script>

