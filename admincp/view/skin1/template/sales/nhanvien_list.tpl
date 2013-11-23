<table class="data-table" cellpadding="0" cellspacing="0">
	<tr>
    	<th>Họ tên</th>
        <th>Điện thoại</th>
        <th>Tài khoản</th>
    </tr>
    <?php foreach($data_nhanvien as $item){ ?>
    <tr class="item nhanvien" nhanvienid="<?php echo $item['id']?>" hoten="<?php echo $item['hoten']?>" username="<?php echo $item['username']?>">
    	<td><?php echo $item['hoten']?></td>
        <td><?php echo $item['sodienthoai']?></td>
        <td><?php echo $item['username']?></td>
    </tr>
    <?php } ?>
</table>