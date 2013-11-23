<center>
    <h2>Phiếu bán hàng</h2>
    Ngày <?php echo $this->date->getDay($item['ngaylap'])?> tháng <?php echo $this->date->getMonth($item['ngaylap'])?> năm <?php echo $this->date->getYear($item['ngaylap'])?><br />
	<label>Số:</label> <?php echo $item['maphieu']?>

</center>
<table>
	<tr>
    	<td width="50%"><label>Người bán:</label> <?php echo $item['nguoithuchien']?></td>
        <td>
        	<label>Khách hàng:</label> <?php echo $item['nguoinhan']?>
        </td>
    </tr>
    
    <tr>
    	<td colspan="2"><label>Ghi chú:</label> <?php echo $item['ghichu']?></td>
    </tr>
</table>

<table class="table-data">
	<thead>
        <tr>
            <th>STT</th>
            <th>Sản phẩm</th>
            <th>Số lượng</th>
            <th>Đơn vị</th>
            <th>Giá nhập</th>
            <th>Thành tiên</th>
        </tr>
    </thead>
    <tbody>
    	
        <?php foreach($data_nhapkho as $key =>$val){ ?>
            
        <tr>
            <td><center><?php echo $key+1?></center></td>
            <td><?php echo $val['title']?></td>
            <td class="number"><?php echo $this->string->numberFormate($val['soluong'])?></td>
            <td><?php echo $this->document->getDonViTinh($val['madonvi'])?></td>
            <td class="number"><?php echo $this->string->numberFormate($val['giatien'])?></td>
            <td class="number"><?php echo $this->string->numberFormate($val['thanhtien'])?></td>
            
        </tr>
        <?php } ?>
        <tr>
            
           
            <td colspan="5" class="number">Tổng tiền</td>
            <td class="number"><?php echo $this->string->numberFormate($item['tongtien'])?></td>
        </tr>
        <tr>
          
            <td colspan="5" class="number">Thanh toán</td>
            <td class="number"><?php echo $this->string->numberFormate($item['thanhtoan'])?></td>
        </tr>
        <?php if($item['congno']){ ?>
        <tr>
            
            <td colspan="5" class="number">Công nợ</td>
            <td class="number"><?php echo $this->string->numberFormate($item['congno'])?></td>
        </tr>
        <?php }?>
    </tbody>
</table>
<table style="margin:15px 0">
	<tr>
    	
        <th width="20%">Người lập phiếu</th>
        <th width="20%">Khách hàng</th>
        <th width="20%">Thủ quỷ</th>
    </tr>
    <tr>
    	
        <td align="center"><i>(Ký, Họ tên)</i></td>
        <td align="center"><i>(Ký, Họ tên)</i></td>
        <td align="center"><i>(Ký, Họ tên)</i></td>
    </tr>
</table>
<div style="height:80px"></div>

         