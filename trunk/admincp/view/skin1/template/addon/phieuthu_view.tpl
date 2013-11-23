<center>
	<h2>Phiếu thu</h2>
	Ngày <?php echo $this->date->getDay($item['ngaylap'])?> tháng <?php echo $this->date->getMonth($item['ngaylap'])?> năm <?php echo $this->date->getYear($item['ngaylap'])?><br />

	<label>Số:</label> <?php echo $item['sophieu']?>

</center>
<table>
	<tr>
    	<td width="50%"><label>Tên khách hàng:</label> <?php echo $item['tenkhachhang']?></td>
        <td><label>Địa chỉ:</label> <?php echo $item['diachi']?></td>
    </tr>
    <tr>
    	<td width="50%"><label>Số điện thoại</label> <?php echo $item['dienthoai']?></td>
        <td><label>Email:</label> <?php echo $item['email']?></td>
    </tr>
    <tr>
    	<td colspan="2"><label>Lý do:</label><?php echo $item['lydo']?></td>
    </tr>
    <tr>
    	<td colspan="2"><label>Số tiền:</label> <?php echo $this->string->numberFormate($item['quidoi'])?> <?php echo $this->document->tiente['VND']?> 
    <i>(Số tiền viết bằng chữ)</i> <?php echo $this->string->doc_so($item['quidoi'])?> <?php echo $this->document->tientechu['VND']?></td>
    </tr>
</table>

<table style="margin:15px 0">
	<tr>
    	<th width="20%">Thủ trưởng đơn vị</th>
        <th width="20%">Kế toán trưởng</th>
        <th width="20%">Người lập phiếu</th>
        <th width="20%">Người nộp</th>
        <th width="20%">Thủ quỷ</th>
    </tr>
    <tr>
    	<td align="center"><i>(Ký, Họ tên, Đóng dấu)</i></td>
        <td align="center"><i>(Ký, Họ tên)</i></td>
        <td align="center"><i>(Ký, Họ tên)</i></td>
        <td align="center"><i>(Ký, Họ tên)</i></td>
        <td align="center"><i>(Ký, Họ tên)</i></td>
    </tr>
</table>
          	
         