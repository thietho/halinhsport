<div class="section" id="sitemaplist">

	<div class="section-title"><?php echo $heading_title?></div>
    
    <div class="section-content padding1">
    
    	<form id="frmOrder" name="frmOrder" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	<input class="button" type="button" value="<?php echo $button_save?>" onclick="save()"/>
     	        <a class="button" href="index.php?route=addon/order/view&orderid=<?php echo $order['orderid']?>"><?php echo $button_cancel?></a>
                
            </div>
            <div class="clearer">^&nbsp;</div>
        	<div id="container">
                <ul class="tabs-nav">
                    <li class="tabs-selected"><a href="#fragment-thongtin"><span>Thông tin phiếu nhập</span></a></li>
                    <li class="tabs"><a href="#fragment-sanpham"><span>Sản phẩm</span></a></li>
                </ul>
                <div id="fragment-thongtin">
               		<div class="left" style="width:50%;">
                        <h3>Thông tin khách hàng</h3>
                        <?php if($order['orderid']){ ?>
                        <p>
                            <label>Order id</label><br />
                            <?php echo $order['orderid']?>
                            
                        </p>
                        <?php } ?>
                        <input type="hidden" id="orderid" name="orderid" value="<?php echo $order['orderid']?>"/>
                        <p>
                            <label><?php echo $entry_customername?></label><br />
                            <input type="text" class="text" id="customername" name="customername" value="<?php echo $order['customername']?>" size="40">
                            <input type="hidden" id="userid" name="userid" value="<?php echo $order['userid']?>"/>
                            <input type="button" class="button" id="btnSelectKhachHang" value="Chọn khách hàng"/>
                        </p>
                        <p>
                            <label><?php echo $entry_email?></label><br />
                            <input type="text" class="text" id="email" name="email" value="<?php echo $order['email']?>" size="40">
                            
                        </p><p>
                            <label><?php echo $entry_address?></label><br />
                            <input type="text" class="text" id="address" name="address" value="<?php echo $order['address']?>" size="40">
                        </p>
                        <p>
                            <label><?php echo $entry_phone?></label><br />
                            <input type="text" class="text" id="phone" name="phone" value="<?php echo $order['phone']?>" size="40">
                        </p>
                        <?php if($order['orderid']){ ?>
                        <p>
                            <label><?php echo $entry_orderdate?></label><br />
                            <?php echo $this->date->formatMySQLDate($order['orderdate'])?>
                        </p>
                        <?php } ?>
                    </div>

                
                    <div class="left" style="width:50%;">
                        <h3>Thông tin giao hàng</h3>
                        <p>
                            <label>Người nhận hàng</label><br />
                            <input type="text" class="text" id="receiver" name="receiver" value="<?php echo $order['receiver']?>" size="40">
                            <input type="button" class="button" id="btnKhachHangNhan" value="Khách hàng nhận hàng" />
                        </p>
                        <p>
                            <label>Số điện thoại</label><br />
                            <input type="text" class="text" id="receiverphone" name="receiverphone" value="<?php echo $order['receiverphone']?>" size="40">
                        </p>
                        <p>
                            <label>Địa chỉ nhận</label><br />
                            <input type="text" class="text" id="shipperat" name="shipperat" value="<?php echo $order['shipperat']?>" size="40">
                        </p>
                        <p>
                            <label>Phương thức thanh toán</label><br />
                            <select id="paymenttype" name="paymenttype">
                                <?php foreach($this->document->paymenttype as $key => $val){ ?>
                                <option value="<?php echo $key?>"><?php echo $val?></option>
                                <?php } ?>
                            </select>
                        </p>
                        <p>
                            <label>Người giao hàng</label><br />
                            <input type="text" class="text" id="shippername" name="shippername" value="<?php echo $order['shippername']?>" size="40">
                            <input type="hidden" id="shipper" name="shipper" value="<?php echo $order['shipper']?>">
                            <input type="button" class="button" id="btnSelectNhanVien" value="Chọn nhân viên"/>
                        </p>
                        <p>
                            <label>Ngày giao</label><br />
                            <input type="text" class="text" id="shippdate" name="shippdate" value="<?php echo $this->date->formatMySQLDate($order['shippdate'])?>" size="40">
                            <script language="javascript">
                                $(function() {
                                    $("#shippdate").datepicker({
                                            changeMonth: true,
                                            changeYear: true,
                                            dateFormat: 'dd-mm-yy'
                                            });
                                    });
                             </script>
                            
                        </p>
                        <p>
                            <label>Ghi nhớ</label><br />
                            <textarea id="notes" name="notes"><?php echo $order['notes']?></textarea>
                        </p>
                        <!--
                        <p>
                            <label><?php echo $entry_status?></label><br />
                            <select id="status<?php echo $order['orderid']?>" onchange="order.updateStatus('<?php echo $order['orderid']?>',this.value)">
                                <?php foreach($this->document->status as $key => $val) { ?>
                                <option value="<?php echo $key?>" <?php echo ($order['status'] == $key)?'selected="selected"':''?>><?php echo $val?></option>
                                <?php } ?>
                            </select>
                        </p>
                        <p>
                            <label><?php echo $entry_message?></label><br />
                            <?php echo $order['comment']?>
                        </p>-->
                    </div>
            	</div>
                <div class="clearer">^&nbsp;</div>
                <div id="fragment-sanpham">
                    <input type="button" class="button" value="Chọn sản phẩm" onClick="order.browseProduct()">
                    <input type="hidden" id="delid" name="delid">
                    <table>
                        <thead>
                            <tr>
                                <th><?php echo $column_productname?></th>
                                <th><?php echo $column_productimage?></th>
                                <th><?php echo $column_productqty?></th>
                                <th>Đơn vị</th>
                                <th>Giá</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody id="listproduct">
                       
                        </tbody>
                        
                    </table>
                </div>

            </div>
            
        </form>
    
    </div>
    
</div>

<script language="javascript">
$(document).ready(function(e) {
	$('#container').tabs({ fxSlide: true, fxFade: true, fxSpeed: 'slow' });
    <?php foreach($detail as $item){?>
	var row = order.addRow("<?php echo $item['id']?>","<?php echo $item['mediaid']?>","<?php echo $item['title']?>","<?php echo $item['imagepreview']?>","<?php echo $item['quantity']?>","<?php echo $item['quantity']?>","<?php echo $item['price']?>");
	
	<?php } ?>
	numberReady();
	$('#paymenttype').val("<?php echo $order['paymenttype']?>");
});
$('#btnKhachHangNhan').click(function(e) {
    $('#receiver').val($('#customername').val());
	$('#receiverphone').val($('#phone').val());
	$('#shipperat').val($('#address').val());
	
});
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
				$("#userid").val($(this).attr('id'));
				$("#customername").val($(this).attr('fullname'));
				$("#phone").val($(this).attr('phone'));
				$("#email").val($(this).attr('email'));
				$("#address").val($(this).attr('address'));
				
				$("#popup").dialog( "close" );
			});
			break;
	}
			
}
$('#btnSelectNhanVien').click(function(e) {
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
	
	$('.item').click(function(e) {
		$("#shipper").val("NV-"+$(this).attr('id'));
		$("#shippername").val($(this).attr('hoten'));
		
		$("#popup").dialog( "close" );
	});
	
	
			
}
function save()
{
	$.blockUI({ message: "<h1><?php echo $announ_infor ?></h1>" }); 
	
	$.post("?route=addon/order/save", $("#frmOrder").serialize(),
		function(data){
			var arr = data.split('-');
			if(arr[0] == "true")
			{
				window.location = "?route=addon/order/view&orderid="+arr[1];
			}
			else
			{
			
				$('#error').html(data).show('slow');
				$.unblockUI();
				
			}
			
		}
	);
}
</script>