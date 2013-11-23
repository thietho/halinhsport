<div class="section" id="sitemaplist">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content padding1">
    
    	<form name="frm" id="frm" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	<input type="button" value="Lưu" class="button" onClick="save()"/>
     	        <input type="button" value="Bỏ qua" class="button" onclick="linkto('?route=quanlykho/donvitinh')"/>   
     	        <input type="hidden" name="id" value="<?php echo $item['madonvi']?>"/>
            </div>
            <div class="clearer">^&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
        	<div>
            	<p>
            		<label>Mã đơn vị tính</label><br />
					<input type="text" name="madonvi" value="<?php echo $item['madonvi']?>" class="text" size=60 <?php echo $readonly?>/>
                    
            	</p>
              	
                
                <p>
            		<label>Tên đơn vị tính</label><br />
					<input type="text" name="tendonvitinh" value="<?php echo $item['tendonvitinh']?>" class="text" size=60 />
                    
            	</p>
               
                <p>
            		<label>Quy đổi</label><br />
					<input type="text" name="quidoi" value="<?php echo $item['quidoi']?>" class="text number" size=60 />
                    
            	</p>
                <p>
            		<label>Đơn vị qui đổi</label><br />
                    <select id="madonviquydoi" name="madonviquydoi">
                    	<option value=""></option>
                    	<?php foreach($listdonvitinh as $it){ ?>
                        <option value="<?php echo $it['madonvi']?>"><?php echo $it['tendonvitinh']?></option>
                        <?php } ?>
                    </select>
            	</p>
               
               
            </div>
            
        </form>
    
    </div>
    
</div>
<script language="javascript">
function save()
{
	$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
	$.post("?route=quanlykho/donvitinh/save", $("#frm").serialize(),
		function(data){
			if(data == "true")
			{
				window.location = "?route=quanlykho/donvitinh";
			}
			else
			{
			
				$('#error').html(data).show('slow');
				$.unblockUI();
				
			}
			
		}
	);
}

$("#madonviquydoi").val("<?php echo $item['madonviquydoi']?>");
</script>
