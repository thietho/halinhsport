<h3><center>Đơn hàng</center></h3>
<h4>Mã đơn hàng: <?php echo $order['code']?></h4>
<input type="button" class="button" id="btnToPending" value="Chờ tính tiền">
<table>
    <thead>
        <tr>      
        	   
            <th>Sản phẩm</th>
            <th>Số lượng</th>
            <th>ĐVT</th>
            <th>Giá bán</th>
            <th>Thành tiền</th>
        </tr>
    </thead>
    <tbody>
    	<?php $sum = 0;?>
    	<?php foreach($data_ct as $ct){ ?>
        <?php $sum += $ct['subtotal']?>
        <tr class="orderrow" ctid="<?php echo $ct['id']?>">
        	
        	<td>
            	<table style="width:auto">
                	<tr>
                    	<td><input type="checkbox" class="chklist" value="<?php echo $ct['id']?>"/></td>
                        <td><?php echo $ct['title']?></td>
                    </tr>
                </table>
            	
            </td>
            <td class="number">
            	<table style="width:auto">
                	<tr>
                    	<td><?php echo $this->string->numberFormate($ct['quantity'])?></td>
                        <td><input type="button" class="button btnEditQty" value="..." mediaid="<?php echo $ct['mediaid']?>" code="<?php echo $ct['code']?>" title="<?php echo $ct['title']?>" price="<?php echo $ct['price']?>" unit="<?php echo $ct['unit']?>" quantity="<?php echo $ct['quantity']?>"></td>
                        
                    </tr>
                </table>
            	
                
                
            </td>
            <td><?php echo $this->document->getDonViTinh($ct['unit'])?></td>
            <td class="number"><?php echo $this->string->numberFormate($ct['price'])?></td>
            <td class="number"><?php echo $this->string->numberFormate($ct['subtotal'])?></td>
        </tr>
        <?php } ?>
        <tr>
        	<td colspan="4" align="right">Tổng</td>
            <td class="number"><?php echo $this->string->numberFormate($sum)?></td>
        </tr>
        <tr>
        	<td colspan="4" align="right">
            	Giảm giá%
                <input type="hidden" id="discountpercent" value="<?php echo $order['discountpercent']?>">
            </td>
            <td class="number" id="discountpercentshow"><?php echo $this->string->numberFormate($order['discountpercent'])?></td>
        </tr>
        <tr>
        	<td colspan="4" align="right">Số tiền giảm</td>
            <td class="number" id="discount"><?php echo $this->string->numberFormate($order['discount'])?>"></td>
        </tr>
        <tr>
        	<td colspan="4" align="right">Tổng tiền</td>
            <td class="number" id="finaltotal"></td>
        </tr>
        <tr>
        	<td colspan="4" align="right">
            	Khách hàng trả
                <input type="hidden" id="payment" value="<?php echo $order['payment']?>"/>
            </td>
            <td class="number" id="paymentshow"><?php echo $this->string->numberFormate($order['payment'])?></td>
        </tr>
        <tr>
        	<td colspan="4" align="right">
            	Thối lại
                <input type="hidden" id="remain" value="<?php echo $order['remain']?>"/>
            </td>
            <td class="number" id="remainshow"><?php echo $this->string->numberFormate($order['remain'])?></td>
        </tr>
    </tbody>
</table>
<input type="hidden" id="customerid" value="<?php echo $order['customerid']?>">
<input type="hidden" id="customername" value="<?php echo $order['customername']?>">
Khách hàng: <span id="customernametext"><?php echo $order['customername']?></span>
<input type="button" class="button" id="btnSelectCustomer" value="Chọn khách hàng">
<div>
    <input type="button" class="button" id="btnRemove" value="Xóa hàng">
    <input type="button" class="button" id="btnDiscount" value="Giảm giá">
    <input type="button" class="button" id="btnPayment" value="Thanh toán">
    <?php if($order['payment']){ ?>
    <input type="button" class="button" id="btnPrintOrder" value="In hóa đơn">
    <?php } ?>
</div>
<script language="javascript">

numberReady();
$(document).ready(function(e) {
    tinhtong();
	
});
$('#btnPayment').click(function(e) {
	
	function paymentOrder()
	{
		if(Number(np.text) >= Number(stringtoNumber($('#finaltotal').html())))
		{
			$('#payment').val(np.text);
			$('#paymentshow').html(formateNumber(np.text));
			tinhtong();
			
			var sum = Number("<?php echo $sum?>");
			var discountpercent = Number(stringtoNumber($('#discountpercent').val()));
			var finaltotal = (1 - discountpercent/100)*sum;
			var discount = discountpercent/100*sum;
			$.post("?route=page/home/payment",
			{
				
				orderid:$('#orderid').val(),
				total:finaltotal,
				payment:Number($('#payment').val()),
				remain:Number($('#remain').val()),
				discount:discount,
				discountpercent:discountpercent
			},
			function(data){
				pro.loadOrder($('#orderid').val());
			});
		}
		else
		{
			alert("Bạn nhập số tiền thanh toán phải lớn hơn tổng tiền của đơn hàng!");
		}
	}
    np.show("Nhập số tiền khách hàng trả",0,paymentOrder);
});
$('#btnPrintOrder').click(function(e) {
    pro.printOrder($('#orderid').val());
});
$('#btnDiscount').click(function(e) {
    function disCountOrder()
	{
		if(Number(np.text) < 100 )
		{
			$('#discountpercent').val(np.text);
			$('#discountpercentshow').html(formateNumber(np.text));
			tinhtong()
			
			var sum = Number("<?php echo $sum?>");
			var discountpercent = Number(stringtoNumber($('#discountpercent').val()));
			var finaltotal = (1 - discountpercent/100)*sum;
			var discount = discountpercent/100*sum;
			$.post("?route=page/home/payment",
			{
				
				orderid:$('#orderid').val(),
				total:finaltotal,
				payment:Number($('#payment').val()),
				remain:Number($('#remain').val()),
				discount:discount,
				discountpercent:discountpercent
			},
			function(data){
				pro.loadOrder($('#orderid').val());
			});
			
		}
		else
		{
			alert("Bạn nhập phần trăm giảm giá phải < 100");
		}
	}
    np.show("Giảm giá%",$('#discountpercent').val(),disCountOrder);
});
function tinhtong()
{
	var sum = Number("<?php echo $sum?>");
	var discountpercent = Number(stringtoNumber($('#discountpercent').val()));
	var finaltotal = (1 - discountpercent/100)*sum;
	var discount = discountpercent/100*sum;
	
	$('#discount').html(formateNumber(discount));
	$('#finaltotal').html(formateNumber(finaltotal));
	
	if(Number($('#payment').val())!=0 || discountpercent!=0)
	{
		
		$('#remain').val(Number($('#payment').val())-finaltotal);
		$('#remainshow').html(formateNumber($('#remain').val()));
		
		
		
	}
	if(Number($('#payment').val())==0)
	{
		
		$('#remain').val(0);
		$('#remainshow').html(0);	
	}
	
}
$('#discountpercent').keyup(function(e) {
	tinhtong();
	
	
});
/*$('.btnaddOrder').click(function(e) {
     pro.addOrder($('#orderid').val(),$(this).attr('mediaid'),$(this).attr('code'),$(this).attr('title'),$(this).attr('unit'),1,$(this).attr('price'));
});
$('.btnDecOrder').click(function(e) {
    pro.addOrder($('#orderid').val(),$(this).attr('mediaid'),$(this).attr('code'),$(this).attr('title'),$(this).attr('unit'),-1,$(this).attr('price'));
});*/

$('.btnEditQty').click(function(e) {
	var orderid = $('#orderid').val();
	var mediaid = $(this).attr('mediaid');
	var code = $(this).attr('code');
	var title = $(this).attr('title');
	var unit = $(this).attr('unit');
	var price = $(this).attr('price');
	
	
	function updateOrdreDetail()
	{
		//alert(np.text);
		pro.updateOrderDetail(orderid,mediaid,code,title,unit,np.text,price);
	}
    np.show("Nhập số lượng",$(this).attr('quantity'),updateOrdreDetail);
});
/*$('.orderrow').click(function(e) {
	if($(this).hasClass('selectRow'))
	    $(this).removeClass('selectRow');
	else
		$(this).addClass('selectRow');
	
});*/
$('#btnToPending').click(function(e) {
    pro.getListOrder();
	$('#orderdetail').html('');
	$('#orderid').val(0);
});
$('#btnRemove').click(function(e) {
	$('.chklist').each(function(index, element) {
        if(this.checked == true)
		{
			
			$.get("?route=page/home/delOrderDetail&id="+ this.value,
			function()
			{
				$('#orderdetail').load("?route=page/home/orderView&orderid="+$('#orderid').val());	
			});	
		}
    });
});

$('#btnSelectCustomer').click(function(e) {
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
	$('.item').click(function(e) 
	{
		
        $('#customerid').val($(this).attr('id'));
		$('#customername').val($(this).attr('fullname'));
		$('#customernametext').html($(this).attr('fullname'));
		$("#popup").dialog("close");
		$("#popup").dialog("destroy");
		//Cap nhat customerid
		$.post("?route=page/home/updateOrder",
		{
			orderid:$('#orderid').val(),
			col:"customerid",
			val:$('#customerid').val()
		},
		function(data){
		
		});
		//Cap nhat customername
		$.post("?route=page/home/updateOrder",
		{
			orderid:$('#orderid').val(),
			col:"customername",
			val:$('#customername').val()
		},
		function(data){
		
		});
	});
		
}
</script>