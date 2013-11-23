<div id="error" class="error" style="display:none"></div>
<form id="frm_import">
	<input type="hidden" name="nguyenlieuid" value="<?php echo $item['id']?>">
	<div>
    	<p>
            <label>Mã nguyên vật liệu:</label>
            <?php echo $item['manguyenlieu']?>
            
        </p>
        <p>
            <label>Tên nguyên vật liệu:</label>
            <?php echo $item['tennguyenlieu']?>(<?php echo $this->document->getDonViTinh($item['madonvi'])?>)
        </p>
        <p>
            <label>Số lượng xuất</label><br />
            <input type="text" id="soluong" name="soluong" class="text number" size=60 />
        </p>
        <p>
            <label>Giá xuất</label><br />
            <input type="text" id="gianhap" name="gianhap" class="text number" size=60 />
        </p>
        <p>
            <label>Thành tiền:</label>
            <span id="thanhtien"></span>
            
        </p>
        <p>
            <label>Ghi chú</label><br />
            <textarea id="ghichu" name="ghichu"></textarea>
        </p>
    </div>
</form>
<script language="javascript">
$(document).ready(function(e) {
    numberReady();
});
$('#soluong').keyup(function(e) {
    var thanhtien = Number(stringtoNumber($('#soluong').val())) * Number(stringtoNumber($('#gianhap').val()));
	$('#thanhtien').html(formateNumber(thanhtien))
});
$('#gianhap').keyup(function(e) {
    var thanhtien = Number(stringtoNumber($('#soluong').val())) * Number(stringtoNumber($('#gianhap').val()));
	$('#thanhtien').html(formateNumber(thanhtien))
});
</script>