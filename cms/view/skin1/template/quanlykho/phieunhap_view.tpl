<center>
    <h2>Phiếu nhập kho</h2>
    Ngày <?php echo $this->date->getDay($item['ngaylap'])?> tháng <?php echo $this->date->getMonth($item['ngaylap'])?> năm <?php echo $this->date->getYear($item['ngaylap'])?><br />
    
        <label>Số:</label> <?php echo $item['maphieu']?>
</center>
<table>
	<tr>
    	<td width="50%"><label>Người nhập:</label> <?php echo $item['nguoithuchien']?></td>
        <td>
        	<?php if($item['tennhacungcap']){?>
            <label>Nhà cung cấp:</label> <?php echo $item['tennhacungcap']?>
            <?php } ?>
            <label>Người giao:</label> <?php echo $item['nguoigiao']?>
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
            <th>Code</th>
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
            <td><?php echo $val['code']?></td>
            <td><?php echo $val['title']?></td>
            <td class="number"><?php echo $this->string->numberFormate($val['soluong'])?></td>
            <td><?php echo $this->document->getDonViTinh($val['madonvi'])?></td>
            <td class="number"><?php echo $this->string->numberFormate($val['giatien'])?></td>
            <td class="number"><?php echo $this->string->numberFormate($val['thanhtien'])?></td>
            
        </tr>
        <?php } ?>
        <tr>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td class="number">Tổng tiền</td>
            <td class="number"><?php echo $this->string->numberFormate($item['tongtien'])?></td>
        </tr>
    </tbody>
</table>
<table style="margin:15px 0">
	<tr>
    	
        <th width="20%">Người lập phiếu</th>
        <th width="20%">Người nhập</th>
        <th width="20%">Thủ kho</th>
    </tr>
    <tr>
    	
        <td align="center"><i>(Ký, Họ tên)</i></td>
        <td align="center"><i>(Ký, Họ tên)</i></td>
        <td align="center"><i>(Ký, Họ tên)</i></td>
    </tr>
</table>
<div style="height:80px"></div>

         