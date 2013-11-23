<div class="section" id="sitemaplist">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content padding1">
    
    	<form name="frm" id="frm" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        <input type="hidden" name="maphieu" value="<?php echo $item['maphieu']?>">
        <input type="hidden" name="sophieu" value="<?php echo $item['sophieu']?>">
        <input type="hidden" name="ngaylap" value="<?php echo $item['ngaylap']?>">	
            <div class="button right">
                <a class="button save" onclick="save('')">Lưu</a>
                <a class="button save" onclick="save('print')">Lưu & In</a>
                <a class="button cancel" href="?route=addon/phieuthu">Bỏ qua</a>    
        	</div>
            <div class="clearer">&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
        	<div>   
            	<input type="button" class="button" id="btnSelectNhanVien" value="Chọn nhân viên"/>
                <input type="button" class="button" id="btnSelectKhachHang" value="Chọn khách hàng"/>
                <div class="clearer">&nbsp;</div>
                <p class="left">
                    <label>Người nộp tiền</label><br />
                    <input type="hidden" id="makhachhang" name="makhachhang" value="<?php echo $item['makhachhang']?>">
                    <input type="text" id="tenkhachhang" name="tenkhachhang" value="<?php echo $item['tenkhachhang']?>" class="text" size=60 />
                </p>
                
                <p class="left">
                    <label>Số điện thoại</label><br />
                    <input type="text" id="dienthoai" name="dienthoai" value="<?php echo $item['dienthoai']?>" class="text" size=60 />
                </p>
                <p class="left">
                    <label>Email</label><br />
                    <input type="text" id="email" name="email" value="<?php echo $item['email']?>" class="text" size=60 />
                </p>
                
                <p class="left">
                    <label>Địa chỉ</label><br />
                    <input type="text" id="diachi" name="diachi" value="<?php echo $item['diachi']?>" class="text" size=60 />
                </p>
                <div class="clearer">&nbsp;</div>
                <p>
                	<label>Số chứng từ:</label><br />
                    <input type="text" name="chungtulienquan" value="<?php echo $item['chungtulienquan']?>" class="text" size=60/>
                </p>
                
                <p>
                    <label>Số tiền</label><br />
                    <input type="text" name="sotien" value="<?php echo $item['sotien']?>" class="text number"/>
                    <input type="hidden" id="donvi" name="donvi" value="VND" />
                    
                </p>
                <p>
                	<label>Tài khoản thu</label><br>
                    <select id="taikhoanthuchi" name="taikhoanthuchi">
                    	<?php foreach($tkthu as $val){?>
                        <option value="<?php echo $val['categoryid']?>"><?php echo $val['categoryname']?></option>
                        <?php } ?>
                    </select>
                </p>
                <p>
                	<label>Hình thức thanh toán</label><br />
                    <select id="hinhthucthanhtoan" name="hinhthucthanhtoan">
                    <?php foreach($this->document->paymenttype as $key => $val){ ?>
                    <option value="<?php echo $key?>"><?php echo $val?></option>
                    <?php } ?>
                    </select>
                </p>
                <p>
                    <label>Người thu</label><br />
                    <input type="hidden" id="nguoithuchienid" name="nguoithuchienid" value="<?php echo $item['nguoithuchienid']?>"/>
                    <input type="text" id="nguoithuchien" name="nguoithuchien" value="<?php echo $item['nguoithuchien']?>" class="text" size=60 />
                    <input type="button" class="button" id="btnSelectNguoiChi" value="Chọn người thu"/>
                </p>
                <p>
                    <label>Lý do</label><br />
                    <textarea name="lydo" class="ghichu"><?php echo $item['lydo']?></textarea>
                </p>
                <div class="clearer">&nbsp;</div>
            </div>
            
        </form>
    
    </div>
    
</div>

<script language="javascript">
$('#taikhoanthuchi').val("<?php echo $item['taikhoanthuchi']?>");
$('#hinhthucthanhtoan').val("<?php echo $item['hinhthucthanhtoan']?>");
var handle = "";
$('#btnSelectKhachHang').click(function(e) {
	handle = "khachhang";
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
function intSelectMember()
{
	switch(handle)
	{
		case "khachhang":
			$('.item').click(function(e) {
				$("#makhachhang").val("KH-"+$(this).attr('id'));
				$("#tenkhachhang").val($(this).attr('fullname'));
				$("#dienthoai").val($(this).attr('phone'));
				$("#email").val($(this).attr('email'));
				$("#diachi").val($(this).attr('address'));
				
				$("#popup").dialog( "close" );
			});
			break;
	}
			
}
$('#btnSelectNhanVien').click(function(e) {
	handle = "khachhang";
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
$('#btnSelectNguoiChi').click(function(e) {
	handle = "nguoithuchien";
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
function intSelectNhanVien()
{
	switch(handle)
	{
		case "khachhang":
			$('.item').click(function(e) {
				$("#makhachhang").val("NV-"+$(this).attr('manhanvien'));
				$("#tenkhachhang").val($(this).attr('hoten'));
				$("#dienthoai").val($(this).attr('sodienthoai'));
				$("#email").val($(this).attr('email'));
				$("#diachi").val($(this).attr('diachitamtru'));
				$("#popup").dialog( "close" );
			});
			break;
		case "nguoithuchien":
			$('.item').click(function(e) {
				$("#nguoithuchienid").val($(this).attr('id'));
				$("#nguoithuchien").val($(this).attr('hoten'));
				
				$("#popup").dialog( "close" );
			});
			break;	
	}
			
}
function save(action)
{
	$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
	$.post("?route=addon/phieuthu/save", $("#frm").serialize(),
		function(data){
			var arr = data.split("-");
			if(arr[0] == "true")
			{
				if(action == 'print')
				{
					view(arr[1])
					$.unblockUI();
				}
				else
				{
					window.location = "?route=addon/phieuthu";
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
function view(maphieu)
{
	$("#popup").attr('title','Chọn khách hàng');
				$( "#popup" ).dialog({
					autoOpen: false,
					show: "blind",
					hide: "explode",
					width: 800,
					height: 500,
					modal: true,
					close: function(event, ui) {
						window.location = "?route=addon/phieuthu";
					},
					buttons: {
						'Đóng': function() {
							$( this ).dialog( "close" );
							window.location = "?route=addon/phieuthu";
						},
						'In': function(){
							openDialog("?route=addon/phieuthu/view&maphieu="+maphieu+"&dialog=print",800,500)
							window.location = "?route=addon/phieuthu";
						},
					}
				});
			
				
	$("#popup-content").load("?route=addon/phieuthu/view&maphieu="+maphieu+"&dialog=true",function(){
		$("#popup").dialog("open");	
	});
}
</script>
