<div class="section" id="sitemaplist">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content padding1">
    
    	<form name="frm" id="frm" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	<input type="button" value="Lưu" class="button" onClick="save('')"/>
                <input type="button" value="Lưu & In" class="button" onClick="save('print')"/>
     	        <input type="button" value="Bỏ qua" class="button" onclick="linkto('?route=quanlykho/phieunhap')"/>   
     	        <input type="hidden" name="id" value="<?php echo $item['id']?>">
                <input type="hidden" name="ngaylap" value="<?php echo $item['ngaylap']?>">
                
            </div>
            <div class="clearer">^&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
            <div id="container">
                <ul class="tabs-nav">
                    <li class="tabs-selected"><a href="#fragment-thongtin"><span>Thông tin phiếu nhập</span></a></li>
                    <li class="tabs"><a href="#fragment-nguyenlieu"><span>Sản phẩm</span></a></li>
                </ul>
                <div id="fragment-thongtin">
                    <p>
                    	<label>Loại phiếu</label><br />
                        <select id="loaiphieu" name="loaiphieu">
                        <?php foreach($loaiphieu as $key =>  $val){ ?>
                        	<option value="<?php echo $key?>"><?php echo $val?></option>
                        <?php } ?>
                        </select>
                        
                    </p>
                    <p id="f-NK-KHTL" class="nhapxuat">
                        <label>Khách hàng</label><br />
                        <input type="hidden" id="khachhangid" name="khachhangid" value="<?php echo $item['khachhangid']?>" >
                        <input type="text" id="tenkhachhang" name="tenkhachhang" value="<?php echo $item['tenkhachhang']?>" class="text" size=60 />
                        <input type="button" class="button" id="btnSelectKhachHang" value="Chọn khách hàng" />
                    </p>
                    <p id="f-NK" class="nhapxuat">
                        <label>Nhà cung cấp</label><br />
                        <span id="nhacungcapview"><?php echo $item['tennhacungcap']?></span>
                        <input type="hidden" id="nhacungcapid" name="nhacungcapid" value="<?php echo $item['nhacungcapid']?>">
                        <input type="hidden" id="tennhacungcap" name="tennhacungcap" value="<?php echo $item['tennhacungcap']?>">
                        <input type="button" class="button" id="btnSeleteNhaCungCap" value="Chọn nhà cung cấp">
                        
                    </p>
                    <p>
                        <label>Người giao</label><br />
                        <input type="text" id="nguoigiao" name="nguoigiao" value="<?php echo $item['nguoigiao']?>" class="text" size=60 />
                        
                    </p>
                    <p>
                        <label>Người nhận</label><br />
                        <input type="hidden" id="nguoinhanid" name="nguoinhanid" value="<?php echo $item['nguoinhanid']?>" value="<?php echo $item['nguoinhanid']?>">
                        <input type="text" id="nguoinhan" name="nguoinhan" value="<?php echo $item['nguoinhan']?>" class="text" size=60 />
                        <input type="button" class="button" id="btnSelectNhanVienNhan" value="Chọn nhân viên nhận"/>
                    </p>
                    <p>
                        <label>Ghi chú</label><br />
                        <textarea id="ghichu" name="ghichu"><?php echo $item['ghichu']?></textarea>
                        
                    </p>
                   
                </div>
                <div id="fragment-nguyenlieu">
                	
                	<table>
                    	<thead>
                            <tr>
                                <th>Code</th>
                                <th>Sản phẩm</th>
                                <th>Số lượng</th>
                                <th>Đơn vị tính</th>
                                <th>Đơn giá</th>
                                <th>Giảm giá%</th>
                                <th>Giảm giá</th>
                                
                                <th>Thành tiền</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody id="nhapkhonguyenlieu">
                        </tbody>
                        <tfoot>
                        	<tr>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td>
                                	
                                    <input type="text" id="lydothu" name="lydothu" class="text" value="<?php echo $item['lydothu']?>"/>
                                </td>
                                <td class="number"><input type="text" class="text number"  id="thuphi" name="thuphi" value="<?php echo $this->string->numberFormate($item['thuphi'])?>"/></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td></td>
                                <td class="number">Tổng số lượng</td>
                                <td id="sumsoluong" class="number"></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td class="number">
                                	Tổng cộng
                                    <input type="hidden" id="tongtien" name="tongtien" value="<?php echo $item['tongtien']?>"/>
                                </td>
                                <td class="number" id="tongcong"><?php echo $this->string->numberFormate($item['tongtien'])?></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td class="number">Thanh toán</td>
                                <td class="number"><input type="text" class="text number"  id="thanhtoan" name="thanhtoan" value="<?php echo $this->string->numberFormate($item['thanhtoan'])?>"/></td>
                                <td><input type="button" class="button" id="btnTrahet" value="Trả hết"/></td>
                            </tr>
                            <tr>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td class="number">
                                	Công nợ
                                	<input type="hidden" id="congno" name="congno" value="<?php echo $item['congno']?>"/>
                                </td>
                                <td class="number" id="lbl-congno"><?php echo $this->string->numberFormate($item['congno'])?></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td class="number">Số ngày công nợ</td>
                                <td class="number"><input type="text" class="text number"  id="songaycongno" name="songaycongno" value="<?php echo $this->string->numberFormate($item['songaycongno'])?>"/></td>
                                <td>Ngày</td>
                            </tr>
                        </tfoot>
                    </table>
                    <input type="hidden" id="delnhapkho" name="delnhapkho" />
                    <input type="button" class="button" id="btnAddRow" value="Thêm dòng"/>
                    <input type="button" class="button" id="btnImport" value="Lấy dữ liệu từ file excel"/>
                    <input type="button" class="button" id="btnGetFomat" value="Lấy file excel mẫu"/>
                </div>
           </div>
            
        </form>
    
    </div>
    
</div>
<?php if(count($data_nhapkho)){ ?>
	<?php foreach($data_nhapkho as $dl){ ?>
<script language="javascript">
$(document).ready(function(e) {
	objdl.addRow("<?php echo $dl['id']?>","<?php echo $dl['mediaid']?>","<?php echo $dl['code']?>","<?php echo $dl['title']?>","<?php echo $dl['soluong']?>","<?php echo $dl['madonvi']?>","<?php echo $dl['giatien']?>","<?php echo $dl['giamgia']?>","<?php echo $dl['phantramgiamgia']?>");
});
</script>
	<?php } ?>
<?php } ?>

<script language="javascript">

$('#btnSelectKhachHang').click(function(e) {
    $("#popup").attr('title','Chọn khách hàng');
		$( "#popup" ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: 900,
			height: 600,
			modal: true,
		});
	
		
		$("#popup-content").load("?route=core/member&opendialog=true",function(){
			$("#popup").dialog("open");
		});
});
$('#btnSelectNhanVienNhan').click(function(e) {
	handle = "nguoinhan";
    $("#popup").attr('title','Chọn nhân viên');
		$( "#popup" ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: 800,
			height: 600,
			modal: true,
			
		});
	
		
		$("#popup-content").load("?route=quanlykho/nhanvien&opendialog=true",function(){
			$("#popup").dialog("open");	
		});
});
function intSelectMember()
{
	$('.item').click(function(e) {
		
        $('#khachhangid').val($(this).attr('id'));
		$('#tenkhachhang').val($(this).attr('fullname'));
		
		$("#popup").dialog( "close" );
    });
}
function intSelectNhanVien()
{
	switch(handle)
	{
		case "nguoithuchien":
			$('.item').click(function(e) {
				$("#nguoithuchienid").val($(this).attr('id'));
				$("#nguoithuchien").val($(this).attr('hoten'));
				$("#popup").dialog( "close" );
			});
			break;
		case "nguoinhan":
			$('.item').click(function(e) {
				$("#nguoinhanid").val($(this).attr('id'));
				$("#nguoinhan").val($(this).attr('hoten'));
				
				$("#popup").dialog( "close" );
			});
			break;	
	}
			
}

$('#btnTrahet').click(function(e) {
    $('#thanhtoan').val($('#tongcong').html());
	$('#thanhtoan').keyup();
});
$('#thuphi').keyup(function(e) {
    objdl.tinhtong(0);
});
$('#thanhtoan').keyup(function(e) {
    var tongcong = Number(stringtoNumber($('#tongcong').html()));
	var thanhtoan = Number(stringtoNumber($('#thanhtoan').val()));
	var congno = tongcong - thanhtoan;
	$('#congno').val(congno);
	$('#lbl-congno').html(formateNumber(congno));
});


$('#btnSeleteNhaCungCap').click(function(e) {
    $("#popup").attr('title','Chọn nhà cung cấp');
		$( "#popup" ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: 900,
			height: 600,
			modal: true,
		});
	
		
		$("#popup-content").load("?route=quanlykho/nhacungcap&opendialog=true",function(){
			$("#popup").dialog("open");
		});
});
function intSelectNhaCungCap()
{
	$('.item').click(function(e) {
        $('#nhacungcapid').val($(this).attr('id'));
		$('#tennhacungcap').val($(this).attr('tennhacungcap'));
		$('#nhacungcapview').html($(this).attr('tennhacungcap'));
		$("#popup").dialog( "close" );
    });
}
$('#btnAddRow').click(function(e) {
	browseProduct();
});
$('#btnImport').click(function(e) {
    objdl.importDetail();
});
$('#btnGetFomat').click(function(e) {
    $.get("?route=quanlykho/phieunhap/getFileFormate",function(data){
		window.location = "download.php?url="+ encodeURI(data);
	});	
});

function save(type)
{
	$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
	$.post("?route=quanlykho/phieunhap/save", $("#frm").serialize(),
		function(data){
			var arr = data.split("-");
			if(arr[0] == "true")
			{
				switch(type)
				{
					case "":
						window.location = "?route=quanlykho/phieunhap";
						break;
					case "print":
						$.unblockUI();
						var id = arr[1];
						$("#popup").attr('title','Phiếu nhập kho');
						$( "#popup" ).dialog({
							autoOpen: false,
							show: "blind",
							hide: "explode",
							width: 900,
							height: 600,
							modal: true,
							close: function(ev, ui){
									window.location = "?route=quanlykho/phieunhap";
								},
							buttons: {
								
								'In':function()
								{
									openDialog("?route=quanlykho/phieunhap/view&id="+id+"&opendialog=print",800,500)
									window.location = "?route=quanlykho/phieunhap";
								},
								'Đóng': function() 
								{
									
									$( this ).dialog( "close" );
									window.location = "?route=quanlykho/phieunhap";
								},
							}
						});
					
						
						$("#popup-content").load("?route=quanlykho/phieunhap/view&id="+id+"&opendialog=true",function(){
							$("#popup").dialog("open");
						});
				}
			}
			else
			{
			
				$('#error').html(data).show('slow');
				$.unblockUI();
				
			}
			
		}
	);
}
$('#loaiphieu').val("<?php echo $item['loaiphieu']?>")
$('#loaiphieu').change(function(e) {
	$('.nhapxuat').hide();
    $('#f-'+$('#loaiphieu').val()).show();
	switch(this.value)
	{
		case "NK":
			$('#khachhangid').val('');
			$('#tenkhachhang').val('');
			break;
		case "NK-KHTL":
			$('#nhacungcapid').val('');
			$('#tennhacungcap').val('');
			$('#nhacungcapview').html('');
	}
});


var DIR_UPLOADPHOTO = "<?php echo $DIR_UPLOADPHOTO?>";
$(document).ready(function(e) {
    $('#container').tabs({ fxSlide: true, fxFade: true, fxSpeed: 'slow' });
	$('#loaiphieu').change();
});
</script>

