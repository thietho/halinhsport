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
                        <th>Mã nhân viên</th>
                        <th>Họ tên</th>
                        <th>Email</th>
                        <th>Số điện thoại</th>
                        <?php if($dialog!=true){ ?>
                        <th>Chuyên môn</th>
                        <th>Bằng cấp</th>
                        <th>Lương cơ bản</th>
                        <th>Ngạch</th>
                        <th>Thang</th>
                        <th>Hệ số</th>
                        <th>Ngày vào làm</th>
                        <th>Ngày ký hợp đồng</th>
                        <th>BHXH</th>
                        <th>BHYT</th>
                        <?php } ?>
                        <th>Tên tài khoản</th>
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
                        <td><?php echo $item['manhanvien']?></td>
                        <td><?php echo $item['hoten']?></td>
                        <td><?php echo $item['email']?></td>
                        <td><?php echo $item['sodienthoai']?></td>
                        <?php if($dialog!=true){ ?>
                        <td><?php echo $item['chuyenmon']?></td>
                        <td><?php echo $item['bangcap']?></td>
                        <td><?php echo $this->string->numberFormate($item['luongcoban']) ?></td>
                        <td><?php echo $item['ngach'] ?></td>
                        <td><?php echo $item['thang'] ?></td>
                        <td><?php echo $this->string->numberFormate($item['heso']) ?></td>
                        <td><?php echo $this->date->formatMySQLDate($item['ngayvaolam'])?></td>
                        <td><?php echo $this->date->formatMySQLDate($item['ngaykyhopdong'])?></td>
                        <td><?php echo $item['bhxh'] ?></td>
                        <td><?php echo $item['bhyt'] ?></td>
                        <?php } ?>
                        <td><?php echo $item['username'] ?></td>
                        <?php if($dialog==false){ ?>
                        <td class="link-control">
                            <?php if($this->user->checkPermission("quanlykho/nhanvien/update")==true){ ?>
                            <input type="button" class="button" name="btnEdit" value="<?php echo $item['text_edit']?>" onclick="window.location='<?php echo $item['link_edit']?>'"/>
                            <?php } ?>
                            <?php if($item['text_phanquyen'] != "") { ?>
                            <?php if($this->user->checkPermission("quanlykho/nhanvien/phanquyen")==true){ ?>
                           	<input type="button" class="button" name="btnPhanQuyen" value="<?php echo $item['text_phanquyen']?>" onclick="window.location='<?php echo $item['link_phanquyen']?>'"/>
                            <?php } ?>
                            <?php if($this->user->checkPermission("quanlykho/nhanvien/resetPass")==true){ ?>
                            <input type="button" class="button" name="btnResetPass" value="<?php echo $item['text_resetpass']?>" onclick="resetPass('<?php echo $item['id']?>')"/>
                            <?php } ?>
                            <?php } ?>
                            <?php if($this->user->checkPermission("quanlykho/nhanvien/taotaikhoan")==true){ ?>
                            <input type="button" class="button" name="btnTaiKhoan" value="<?php echo $item['text_taikhoan']?>" onclick="window.location='<?php echo $item['link_taikhoan']?>'"/>
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
	intSelectNhanVien()
</script>
<?php } ?>