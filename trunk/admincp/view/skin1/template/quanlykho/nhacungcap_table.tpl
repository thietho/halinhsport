				<?php echo $pager?>
                <table class="data-table" cellpadding="0" cellspacing="0">
                <thead>
                    <tr class="tr-head">
                    	<?php if($dialog!=true){ ?>
                        <th width="1%">
                        	
                        	<input id="inputchk" type="checkbox" onclick="$('input[name*=\'delete\']').attr('checked', this.checked);">
                           
                        </th>
                        <?php } ?>
                        <th>STT</th>
                        <th>Tên nhà cung cấp</th>
                        <th>Số điện thoại</th>
                        <th>Địa chỉ</th>
                        <th>Email</th>
                        <th>Người liên hệ</th>
                        <th>Số điện thoại liên hệ</th>
                        <th>Email liên hệ</th>
                        <th>Công nợ</th>
                        <th>Ghi chú</th>
                        <?php if($dialog!=true){ ?>
                        <th>Control</th>     
                        <?php } ?>
                    </tr>
                </thead>
                <tbody>
        
        
        <?php
            foreach($datas as $key => $item)
            {
        ?>
                    <tr class="item" id="<?php echo $item['id']?>" tennhacungcap="<?php echo $item['tennhacungcap']?>" sodienthoai="<?php echo $item['sodienthoai']?>" diachi="<?php echo $item['diachi']?>" email="<?php echo $item['email']?>">
                    	<?php if($dialog!=true){ ?>
                        <td class="check-column"><input class="inputchk" type="checkbox" name="delete[<?php echo $item['id']?>]" value="<?php echo $item['id']?>" ></td>
                        <?php } ?>
                        <td><?php echo $key+1 ?></td>
                        <td><?php echo $item['tennhacungcap']?></td>
                        <td><?php echo $item['sodienthoai']?></td>
        				<td><?php echo $item['diachi']?></td>
                        <td><?php echo $item['email']?></td>
                       	<td><?php echo $item['nguoilienhe']?></td>
                        <td><?php echo $item['sodienthoainguoilienhe']?></td>
                        <td><?php echo $item['emailnguoilienhe']?></td>
                        
                        <td class="number"><a onclick="viewCongNoNCC(<?php echo $item['id']?>)"><?php echo $this->string->numberFormate($item['congno'])?></a></td>
                        <td><?php echo $item['ghichu']?></td>
                        <?php if($dialog!=true){ ?>
                        <td class="link-control">
                            <?php if($this->user->checkPermission("quanlykho/sanpham/update")==true){ ?>
                            <input type="button" class="button" name="btnEdit" value="<?php echo $item['text_edit']?>" onclick="showNhaCungCapForm(<?php echo $item['id']?>,'searchForm()')"/>
                            <?php } ?>
                           
                            
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
	intSelectNhaCungCap()
</script>
<?php } ?>