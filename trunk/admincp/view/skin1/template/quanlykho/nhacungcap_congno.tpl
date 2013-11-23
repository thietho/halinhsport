<h3>Thông tin nhà cung cấp</h3>
<p>
	<label>Tên nhà cung cấp:</label> <?php echo $nhacungcap['tennhacungcap']?>
    <label>Số điện thoai:</label> <?php echo $nhacungcap['sodienthoai']?>
</p>
<p>
    <label>Địa chỉ:</label> <?php echo $nhacungcap['diachi']?>
    <label>Email:</label> <?php echo $nhacungcap['email']?>
</p>
<form id="frm_thanhtoancongno">
	<p>
    	<label>Số tiền:</label> <input type="text" class="text number" id="thanhtoan" name="thanhtoan"/>
        <input type="button" class="button" id="btnTraHet" value="Trả hết"/>
        <input type="button" class="button" id="btnThanhToan" value="Thanh toán"/>
        
    </p>
</form>
<h3>Dach sách phiếu nhập kho</h3>
<table>
	<tr>
    	<th width="30%">Số phiếu nhập kho</th>
        <th width="30%">Ngày lập</th>
        <th>Tổng tiền</th>
        <th>Thanh toán</th>
        <th>Công nợ</th>
    </tr>
    <?php foreach($data_phieunhapkho as $item){ ?>
    <tr>
    	<td><a onclick="viewPhieuNhapHang(<?php echo $item['id']?>)"><?php echo $item['maphieu']?></a></td>
        <td><?php echo $this->date->formatMySQLDate($item['ngaylap'])?></td>
        <td class="number"><?php echo $this->string->numberFormate($item['tongtien'])?></td>
        <td class="number"><?php echo $this->string->numberFormate($item['thanhtoan'])?></td>
        <td class="number"><?php echo $this->string->numberFormate($item['congno'])?></td>
    </tr>
    <?php } ?>
    <tr>
    	<td></td>
        <td></td>
        <td></td>
        <td class="text-right">Tổng công nợ:</td>
        <td class="number"><?php echo $this->string->numberFormate($tongno)?></td>
    </tr>
</table>
<h3>Dach sách phiếu bán hàng</h3>
<table>
	<tr>
    	<th width="30%">Số phiếu nhập kho</th>
        <th width="30%">Ngày lập</th>
        <th>Tổng tiền</th>
        <th>Thanh toán</th>
        <th>Công nợ</th>
    </tr>
    <?php foreach($data_phieubanhang as $item){ ?>
    <tr>
    	<td><a onclick="viewPhieuBanHang(<?php echo $item['id']?>)"><?php echo $item['maphieu']?></a></td>
        <td><?php echo $this->date->formatMySQLDate($item['ngaylap'])?></td>
        <td class="number"><?php echo $this->string->numberFormate($item['tongtien'])?></td>
        <td class="number"><?php echo $this->string->numberFormate($item['thanhtoan'])?></td>
        <td class="number"><?php echo $this->string->numberFormate($item['congno'])?></td>
    </tr>
    <?php } ?>
    <tr>
    	<td></td>
        <td></td>
        <td></td>
        <td class="text-right">Tổng công nợ:</td>
        <td class="number"><?php echo $this->string->numberFormate($tongban)?></td>
    </tr>
</table>
<h3>Dach sách phiếu chi thanh toán công nợ</h3>
<table>
	<tr>
    	<th width="30%">Số phiếu</th>
        <th width="30%">Ngày lập</th>
        <th>Số tiền</th>
    </tr>
    <?php foreach($data_phieuchi as $item){ ?>
    <tr>
    	<td><a onclick="viewPhieuThu(<?php echo $item['maphieu']?>)"><?php echo $item['sophieu']?></a></td>
        <td><?php echo $this->date->formatMySQLDate($item['ngaylap'])?></td>
        <td class="number"><?php echo $this->string->numberFormate($item['quidoi'])?></td>
    </tr>
    <?php } ?>
    <tr>
    	<td></td>
        <td class="text-right">Tổng đã trả:</td>
        <td class="number"><?php echo $this->string->numberFormate($tongphieuthu)?></td>
    </tr>
</table>

<h3>Tổng công nợ: <?php echo $this->string->numberFormate($congno)?></h3>
<script language="javascript">
$(document).ready(function(e) {
    numberReady();
});
$('#btnTraHet').click(function(e) {
    $('#thanhtoan').val("<?php echo $this->string->numberFormate($congno)?>");
});
$('#btnThanhToan').click(function(e) {

    $.post("?route=addon/phieuchi/save",
		{
			chungtulienquan:"",
			makhachhang:"NCC-<?php echo $nhacungcap['id']?>",
			tenkhachhang:"<?php echo $nhacungcap['tennhacungcap']?>",
			dienthoai:"<?php echo $nhacungcap['sodienthoai']?>",
			email:"<?php echo $nhacungcap['email']?>",
			diachi:"<?php echo $nhacungcap['diachi']?>",
			sotien:$('#thanhtoan').val(),
			donvi:"VND",
			taikhoanthuchi:"thanhtoanncc",
			hinhthucthanhtoan:"cash",
			nguoithuchienid:"<?php echo $this->user->nhanvien['id']?>",
			nguoithuchien:"<?php echo $this->user->nhanvien['hoten']?>",
			lydo:"Thanh toán công nợ nhà cung cấp"
		},
		function(data)
		{
			var arr = data.split("-");
			if(arr[0] == "true")
			{
				alert("Thanh toán thành công")
				window.location.reload();	
			}
		}
	);
});
function viewPhieuNhapHang(id)
{
	openDialog("?route=quanlykho/phieunhap/view&id="+id+"&opendialog=print",800,500);
}
function viewPhieuBanHang(id)
{
	openDialog("?route=quanlykho/phieuxuat/view&id="+id+"&opendialog=print",800,500);
}
function viewPhieuThu(maphieu)
{
	openDialog("?route=addon/phieuthu/view&maphieu="+maphieu+"&dialog=print",800,500);
}
</script>