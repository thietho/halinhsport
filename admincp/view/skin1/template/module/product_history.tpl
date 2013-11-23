<h3>Tên sản phẩm: <?php echo $media['title']?></h3>
<h3>Mã sản phẩm: <?php echo $media['code']?></h3>

<table class="data-table">
	<thead>
        <tr>
        	<th colspan="5">Nhập kho</th>
            <th colspan="5">Xuất kho</th>
        </tr>
        <tr>
        	<th>Mã phiếu</th>
            <th>Nhà cung cấp</th>
        	<th>Số lượng</th>
            <th>Đơn vị</th>
            <th>Giá</th>
            <th>Mã phiếu</th>
            <th>Khách hàng</th>
            <th>Số lượng</th>
            <th>Đơn vị</th>
            <th>Giá</th>
        </tr>
    </thead>
    <?php if(count($nhapxuat)){ ?>
    <tbody>
    	<?php foreach($nhapxuat as $date => $item){?>
        <tr>
        	<td colspan="8"><strong><?php echo $this->date->formatMySQLDate($date)?></strong></td>
        </tr>
    		<?php $max = max(count($item['nhapkho']),count($item['xuatkho']))?>
        	<?php for($i=0;$i < $max;$i++){ ?>
        <tr class="item">
        	<td><?php echo $item['nhapkho'][$i]['maphieu']?></td>
            <td><?php echo $item['nhapkho'][$i]['tennhacungcap']?></td>
            <td><?php echo $item['nhapkho'][$i]['soluong']?></td>
            <td><?php echo $item['nhapkho'][$i]['madonvi']?></td>
            <td class="number"><?php echo $this->string->numberFormate($item['nhapkho'][$i]['giatien'])?></td>
            <td><?php echo $item['xuatkho'][$i]['maphieu']?></td>
            <td><?php echo $item['xuatkho'][$i]['tenkhachhang']?></td>
            <td><?php echo $item['xuatkho'][$i]['soluong']?></td>
            <td><?php echo $item['xuatkho'][$i]['madonvi']?></td>
            <td class="number"><?php echo $this->string->numberFormate($item['xuatkho'][$i]['giatien'])?></td>
        </tr>
            <?php } ?>
        <?php } ?>
    </tbody>
    <?php } ?>
</table>