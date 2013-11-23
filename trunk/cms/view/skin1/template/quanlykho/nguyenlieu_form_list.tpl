<div class="section" id="sitemaplist">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content padding1">
    
    	
        
        	<div class="button right">
            	<input type="button" value="Lưu" class="button" onClick="save(0)"/>
     	        <input type="button" value="Bỏ qua" class="button" onclick="linkto('?route=quanlykho/nguyenlieu')"/>   
     	        
            </div>
            <div class="clearer">^&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
        	<div>
            	<table>
                	<thead>
                        <tr>
                            <th>Mã nguyên liệu</th>
                            <th>Tên nguyên liệu</th>
                            <th>Loại</th>
                            
                            <th>Đơn vị</th>
                            <th>Tồn tối thiểu</th>
                            <!--<th>Tồn tối đa</th>
                            <th>Mục đích sử dụng</th>-->
                            <th>Ghi chú</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<?php for($i=0;$i<25;$i++){ ?>
                        <form id="frm<?php echo $i?>" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
                    	<tr>
                        	<td><input type="text" class="text" name="manguyenlieu"></td>
                            <td><input type="text" class="text" name="tennguyenlieu"></td>
                            <td>
                            	<select name="loai">
                                                 		
                                    <?php foreach($loainguyenlieu as $val){ ?>
                                    <option value="<?php echo $val['categoryid']?>"><?php echo $this->string->getPrefix("&nbsp;&nbsp;&nbsp;",$val['level']-1)?><?php echo $val['categoryname']?></option>
                                    <?php } ?>
                                </select>
                                
                    		</td>
                           
                            <td>
                            	<select name="madonvi">
                                    <option value=""></option>
                                    <?php foreach($donvitinh as $val){ ?>
                                    <option value="<?php echo $val['madonvi']?>"><?php echo $val['tendonvitinh']?></option>
                                    <?php } ?>
                                </select>
                            </td>
                            <td><input type="text" class="text number" name="tontoithieu" size="5"></td>
                            <!--<td><input type="text" class="text number" name="tontoida" size="5"></td>
                            <td><input type="text" class="text" name="mucdichsudung"></td>-->
                            <td><input type="text" class="text" name="ghichu"></td>
                        </tr>
                        </form>
                        <?php } ?>
                    </tbody>
                </table>
               
            </div>
            
        
    
    </div>
    
</div>
<script language="javascript">
function save(i)
{
	$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
	$.post("?route=quanlykho/nguyenlieu/save", $("#frm"+i).serialize(),
		function(data){
			if(data == "true")
			{
				//window.location = "?route=quanlykho/nguyenlieu";
				save(i+1);
			}
			else
			{
			
				window.location = "?route=quanlykho/nguyenlieu";
				
			}
			
		}
	);
}



var DIR_UPLOADPHOTO = "<?php echo $DIR_UPLOADPHOTO?>";
</script>

