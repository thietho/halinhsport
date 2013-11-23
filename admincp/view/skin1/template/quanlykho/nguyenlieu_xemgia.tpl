
<div class="section" id="sitemaplist">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content padding1">
    
    	<form name="frm" id="frm" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	
     	        <input type="button" value="Trở về" class="button" onclick="linkto('?route=quanlykho/nguyenlieu')"/>   
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
            		<label>Tên nguyên vật liệu: <?php echo $item['tennguyenlieu']?> (<?php echo $this->document->getDonViTinh($item['madonvi'])?>)</label>
            	</p>
               	<p>
            		<label>Giá cung cấp</label>
                    <table>
                    	<thead>
                        	<th>STT</th>
                            <th>Ngày</th>
                            <th>Nhà cung ứng</th>
                            <th>Giá</th>
                        </thead>
                        <tbody>
                            <?php foreach($chitiet as $key => $item){ ?>
                            <tr>
                                <td align="center"><?php echo $key+1?></td>
                                <td><?php echo $this->date->formatMySQLDate($item['ngay'])?></td>
                                <td><?php echo $this->document->getNhaCungUng($item['manhacungung'])?></td>
                                <td align="right"><?php echo $this->string->numberFormate($item['gia'],0)?></td>
                            </tr>
                            <?php } ?>	
                        </tbody>

                    </table>
					
            	</p>
                
               	<p>
                	
                </p>
               
            </div>
            
        </form>
    
    </div>
    
</div>
