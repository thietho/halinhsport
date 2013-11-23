<div class="section" id="sitemaplist">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content padding1">
    
    	<form name="frm" id="frm" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	<input type="button" value="Save" class="button" onClick="save()"/>
     	        <input type="button" value="Cancel" class="button" onclick="linkto('?route=quanlykho/nguyenlieu')"/>   
     	        <input type="hidden" name="id" value="<?php echo $item['id']?>">
                
            </div>
            <div class="clearer">^&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
        	<div>
            	<p>
            		<label>Mã nguyên vật liệu: <?php echo $item['manguyenlieu']?></label>
            	</p>
              	
                
                <p>
            		<label>Tên nguyên vật liệu: <?php echo $item['tennguyenlieu']?></label>
            	</p>
               	<p>
                	<label>CÁC NGUYÊN LIỆU BAO GỒM</label>
                    <p>
                    	<table style="width:auto">
                        	<tr>
                            	<td>Nhóm</td>
                                <td>
                                	
                                    <select id="loai" name="loai" onChange="getNguyenLieu('loai',this.value,'')">
                                        <option value=""></option>
                                        <?php foreach($loainguyenlieu as $val){ ?>
                                        <option value="<?php echo $val['manhom']?>"><?php echo $this->string->getPrefix("&nbsp;&nbsp;&nbsp;",$val['level']-1)?><?php echo $val['tennhom']?></option>
                                        <?php } ?>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                            	<td>Nguyen liệu dùng để sản xuất</td>
                                <td>
                                	<select id="nguyenlieugoc" name="nguyenlieugoc">
                                    </select>
                                </td>
                            </tr>
                            <!--<tr>
                            	<td>Số lượng</td>
                                <td>
                                	<input type="text" id="soluong" name="soluong" value="<?php echo $dinhluong['soluong']?>" class="text number" size=10 />
                                    <select id="madonvi" name="madonvi">
                                        <option value=""></option>
                                        <?php foreach($donvitinh as $val){ ?>
                                        <option value="<?php echo $val['madonvi']?>"><?php echo $val['tendonvitinh']?></option>
                                        <?php } ?>
                                    </select>
                                </td>
                            </tr>-->
                        </table>
                    </p>
                </p>
                
               
               
               
            </div>
            
        </form>
    
    </div>
    
</div>
<script language="javascript">
function save()
{
	$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
	$.post("?route=quanlykho/nguyenlieu/savedinhluong", $("#frm").serialize(),
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
function getNguyenLieu(col,val,operator)
{
	$.getJSON("?route=quanlykho/nguyenlieu/getNguyenLieu&col="+col+"&val="+val+"&operator="+operator, 
			function(data) 
			{
				var str = '<option value=""></option>';
				for( i in data.nguyenlieus)
				{
					str+= '<option value="'+data.nguyenlieus[i].id+'">'+data.nguyenlieus[i].tennguyenlieu+'</option>';
				}
				$("#nguyenlieugoc").html(str);
				
				$("#nguyenlieugoc").val("<?php echo $item['nguyenlieugoc']?>");
			});
}
$("#manhom").val("<?php echo $dinhluong['manhom']?>");
$("#madonvi").val("<?php echo $dinhluong['madonvi']?>");
getNguyenLieu('manhom',"<?php echo $dinhluong['manhom']?>",'');

</script>
