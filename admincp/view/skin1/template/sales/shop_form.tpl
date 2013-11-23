<div class="section" id="sitemaplist">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content padding1">
    
    	<form name="frm" id="frm" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	<input type="button" value="Lưu" class="button" onClick="save()"/>
     	        <input type="button" value="Bỏ qua" class="button" onclick="linkto('?route=quanlykho/donvitinh')"/>   
     	        <input type="hidden" name="id" value="<?php echo $item['id']?>"/>
            </div>
            <div class="clearer">^&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
        	<div>
            	<p>
            		<label>Tên cửa hàng</label><br />
					<input type="text" name="shopname" value="<?php echo $item['shopname']?>" class="text" size=60/>
                    
            	</p>
              	
                
                <p>
            		<label>Địa chỉ</label><br />
					<input type="text" name="address" value="<?php echo $item['address']?>" class="text" size=60 />
                    
            	</p>
               
                <p>
            		<label>Số điện thoại</label><br />
					<input type="text" name="phone" value="<?php echo $item['phone']?>" class="text" size=60 />
                    
            	</p>
                
               
               
            </div>
            
        </form>
    
    </div>
    
</div>
<script language="javascript">
function save()
{
	$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
	$.post("?route=sales/shop/save", $("#frm").serialize(),
		function(data){
			if(data == "true")
			{
				window.location = "?route=sales/shop";
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
