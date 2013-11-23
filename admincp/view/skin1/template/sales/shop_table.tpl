				<?php echo $pager?>
                <table class="data-table" cellpadding="0" cellspacing="0">
                <thead>
                    <tr class="tr-head">
                    	<?php if($dialog!=true){ ?>
                        <th width="1%">
                        <input class="inputchk" type="checkbox" onclick="$('input[name*=\'delete\']').attr('checked', this.checked);">
                        </th>
                        <?php } ?>
                        <th>STT</th>
                        <th>Tên cửa hàng</th>
                        <th>Địa chỉ</th>
                        <th>Điện thoại</th>
                        <th>Nhân viên</th>
                        <?php if($dialog==false){ ?>
                        <th>Control</th>            
                        <?php } ?>                      
                    </tr>
                </thead>
                <tbody>
        
        
        <?php
            foreach($datas as $key => $item)
            {
        ?>
                    <tr id="<?php echo $item['id']?>" class="item" manhanvien="<?php echo $item['manhanvien']?>" hoten="<?php echo $item['hoten']?>" email="<?php echo $item['email']?>" sodienthoai="<?php echo $item['sodienthoai']?>" diachithuongtru="<?php echo $item['diachithuongtru']?>" diachitamtru="<?php echo $item['diachitamtru']?>">
                    	<?php if($dialog!=true){ ?>
                        <td class="check-column"><input class="inputchk" type="checkbox" name="delete[<?php echo $item['id']?>]" value="<?php echo $item['id']?>" ></td>
                        <?php } ?>
                        <td><?php echo $key+1 ?></td>
                        <td><?php echo $item['shopname']?></td>
                        <td><?php echo $item['address']?></td>
                        <td><?php echo $item['phone']?></td>
                       	<td>
                        	<?php if(count($item['arr_staffid'])){ ?>
                            <ul>
                        	<?php foreach($item['arr_staffid'] as $staffid){ ?>
                            	<li>
                                	<?php echo $this->document->getNhanVien($staffid)?>
                                    (<?php echo $this->document->getNhanVien($staffid,'username')?>)
                                    <input type="button" class="button" value="Xóa" onclick=" removeStaff(<?php echo $staffid?>)"/>
                                    
                                </li>
                            <?php } ?>
                            </ul>
                            <?php } ?>
                        </td>
                        <?php if($dialog==false){ ?>
                        <td class="link-control">
                            <?php if($this->user->checkPermission("sales/shop/update")==true){ ?>
                            <input type="button" class="button" name="btnEdit" value="<?php echo $item['text_edit']?>" onclick="window.location='<?php echo $item['link_edit']?>'"/>
                            <?php } ?>
                            
                            <input type="button" class="button" name="btnAddStaff" value="Thêm nhân viên vào cửa hàng" onclick="selectNhanVien(<?php echo $item['id']?>)"/>
                            
                        </td>
                        <?php } ?>
                    </tr>
        <?php
            }
        ?>
                        
                                                    
                </tbody>
                </table>
                <?php echo $pager?>

<?php if($dialog){ ?>
<script language="javascript">
	intSelectNhanVien()
</script>
<?php } ?>