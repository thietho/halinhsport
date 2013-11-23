				<?php echo $pager?>
                <table class="data-table" cellpadding="0" cellspacing="0">
                <thead>
                    <tr class="tr-head">
                    	<?php if($dialog!=true){ ?>
                        <th width="1%">
                        	
                        	<input id="inputchk" type="checkbox" onclick="$('input[name*=\'delete\']').attr('checked', this.checked);">
                           
                        </th>
                        <?php } ?>
                        <th width="50px">STT</th>
                        <th>Mã nguyên vật liệu</th>
                        <th>
                        	Tên nguyên vật liệu
                        </th>
                        <?php if($dialog!=true){ ?>
                        <th>Loại</th>
                        
                        
                        <th>Số lượng tồn</th>
                        <th>Tồn tối thiểu</th>
                        
                        
                        <?php } ?>
                        <th>Đơn vị tính</th>
                        
                        
                        <th>Ghi chú</th>
                        <th>Hình</th>
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
                    <tr class="item<?php echo ($item['soluongton'] <= $item['tontoithieu'])?' needimport':'' ?>" id="<?php echo $item['id']?>" manguyenlieu="<?php echo $item['manguyenlieu']?>" tennguyenlieu="<?php echo $item['tennguyenlieu']?>" madonvi="<?php echo $item['madonvi']?>">
                    	<?php if($dialog!=true){ ?>
                        <td class="check-column"><input class="inputchk" type="checkbox" name="delete[<?php echo $item['id']?>]" value="<?php echo $item['id']?>" ></td>
                        <?php } ?>
                        <td><?php echo $key+1 ?></td>
                        <td><?php echo $item['manguyenlieu']?></td>
                        <td><?php echo $item['tennguyenlieu']?></td>
                        <?php if($dialog!=true){ ?>
                        <td><?php echo $item['loai']?></td>
                        
                        
                		<td class="number">
                        	
                            <a onclick="viewTonKho(<?php echo $item['id']?>)"><?php echo $this->string->numberFormate($item['soluongton'],2)?></a>
                            
                            
                            
                        </td>
                        <td class="number"><?php echo $this->string->numberFormate($item['tontoithieu'],0)?></td>
                       
                        
                        <?php } ?>
                        <td><?php echo $this->document->getDonViTinh($item['madonvi'])?></td>
                        
                        
                        <td><?php echo $item['ghichu']?></td>
                        <td><img src="<?php echo $item['imagethumbnail']?>" /></td>
                        <?php if($dialog!=true){ ?>
                        <td class="link-control">
                            <?php if($this->user->checkPermission("quanlykho/nguyenlieu/update")==true){ ?>
                            <input type="button" class="button" name="btnEdit" value="<?php echo $item['text_edit']?>" onclick="window.location='<?php echo $item['link_edit']?>'"/>
                            <?php } ?>
                           	<!--<input type="button" class="button" value="Nhập kho" onclick="importNguyenLieu(<?php echo $item['id']?>)"/>
                            <input type="button" class="button" value="Xuất kho" onclick="exportNguyenLieu(<?php echo $item['id']?>)"/>-->
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
	intSelectNguyenLieu()
</script>
<?php } ?>