
<div class="section">
    <div class="section-content">
    	
        <form action="" method="post" id="frmphanquyen" name="frmphanquyen">
        
        	<div class="button right">
            	
                
                
                <input type="hidden" name="nhanvienid" value="<?php echo $nhanvien['id']?>">
                <input type="hidden" name="userid" value="<?php echo $nhanvien['username']?>">
            </div>
            <div class="clearer">^&nbsp;</div>
            
            <div>
            	<p>
                	<label>Tên nhân viên</label> <?php echo $nhanvien['hoten']?>
                </p>
                <p>
                	<label>Loại tài khoản</label> <?php echo $this->document->getUserType($this->user->getUserTypeId())?>
                </p>
                <p>
                	<label>Ngày sinh</label> <?php echo $this->date->formatMySQLDate($nhanvien['ngaysinh'])?>
                </p>
                <p>
                	<label>CMND</label> <?php echo $nhanvien['cmnd']?>
                </p>
                <p>
                	<label>Giới tính</label> <?php echo $this->document->gioitinh[$nhanvien['gioitinh']]?>
                </p>
                
                
                <p>
                	<label>Địa chỉ thường trú</label> <?php echo $nhanvien['diachitamtru']?>
                </p>
				
                
            </div>
        	
        
        </form>
        
    </div>
    
</div>