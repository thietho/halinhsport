
<div class="section" id="sitemaplist">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content padding1">
    
    	<form name="frm" id="frm" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	<input type="button" value="Save" class="button" onClick="save()"/>
     	        <input type="button" value="Cancel" class="button" onclick="linkto('?route=quanlykho/nguyenlieu')"/>   
     	        <input type="hidden" name="id" value="<?php echo $dinhluong['id']?>">
                <input type="hidden" name="manguyenlieu" value="<?php echo $item['id']?>">
            </div>
            <div class="clearer">^&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
        	<div>
            	<p>
            		<label>Mã nguyên vật liệu: <?php echo $item['manguyenlieu']?></label>
            	</p>
              	
                
                <p>
            		<label>Tên nguyên vật liệu: <?php echo $item['tennguyenlieu']?> (<?php echo $item['tendonvitinh']?>)</label>
            	</p>
               	<p>
            		<label>Giá</label><br />
					<input type="text" id="gia" name="gia" value="<?php echo $item['dongia']?>" class="text number" size=60 />
            	</p>
                <p>
                    <label>Ngày</label><br />
<script language="javascript">
 	$(function() {
		$("#ngay").datepicker({
				changeMonth: true,
				changeYear: true,
				dateFormat: 'dd-mm-yy'
				});
		});
 </script>
                	<input type="text" id="ngay" name="ngay" value="<?php echo $this->date->formatMySQLDate($this->date->getToday())?>" class="text" size=60 />
                </p>
               	<p>
                	<label>Nhà cung cấp</label><br>
                    <input type="hidden" id="manhacungung" name="manhacungung" value="">
                    <span id="tennhacungcap"></span>
                    <input type="button" class="button" name="btnChonNhaCungCap" value="Chọn nhà cung cấp" onClick="selcetNhaCungCap()">
                    <input type="button" class="button" name="btnChonNhaCungCap" value="Bỏ chọn" onClick="unSelcetNhaCungCap()">
                </p>
               
            </div>
            
        </form>
    
    </div>
    
</div>
<script language="javascript">
function save()
{
	$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
	$.post("?route=quanlykho/nguyenlieu/savecapnhatgia", $("#frm").serialize(),
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
function getNhaCungCap(col,val,operator)
{
	$.getJSON("?route=quanlykho/nhacungung/getNhaCungUng&col="+col+"&val="+val+"&operator="+operator, 
			function(data) 
			{
				//var str = '<option value=""></option>';
				for( i in data.nhacungungs)
				{
					
					$("#manhacungung").val(data.nhacungungs[i].id);
					$("#tennhacungcap").html(data.nhacungungs[i].tennhacungung);
				}
				
			});
}

function selcetNhaCungCap()
{
	openDialog("?route=quanlykho/nhacungung&opendialog=true",1000,800);
	
	list = trim($("#manhacungung").val(), ',');
	arr = list.split(",");
	manhacungcap = arr[0];
	getNhaCungCap("id",manhacungcap,'');
}

function unSelcetNhaCungCap()
{
	$("#manhacungung").val("");
	$("#tennhacungcap").html("");
}

</script>
