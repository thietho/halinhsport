
<div class="section">

	<div class="section-title">Bán hàng</div>
    
    <div class="section-content">
    	
        <div id="main-screen" class="left sales-scr">
        	
        </div>
        <div id="orderview" class="left sales-scr" style="width:320px">
        	
            <input type="hidden" id="orderid" name="orderid" />
            <div id="orderdetail">
            </div>
            
            <h3><center>Các đơn hàng chờ thanh toán</center></h3>
            <div id="listorder"></div>
        </div>
        <div class="clearer">^&nbsp;</div>
    </div>
</div>
<script language="javascript">
$(document).ready(function(e) {
    $('#main-screen').load('?route=page/home/main');
	/*pro.loadProduct(pro.url+"&"+strurl);
	$('#keyword').keyup(function(e) {
		pro.searchForm();
	});*/
	//pro.history.push('?route=page/home/main');
	pro.fixSize();
	pro.getListOrder();
	
});
$(window).resize(function(e) {
    pro.fixSize();
	
});
function Product()
{
	//this.history = new Array();
	this.url = "?route=page/home/getList";
	this.loadProduct = function(url)
	{
		//pro.history.push(url);
		$('#showsanpham').html(loading);
		$('#showsanpham').load(url,function()
		{
			$('.pro-item').click(function(e) {
                
				pro.view($(this).attr('mediaid'));
            });
		});
	}
	this.searchForm = function(sitemapid)
	{
		url = this.url+"&sitemapid="+sitemapid;
		if($('#keyword').val()!="")
		{
			url += "&keyword="+encodeURI($('#keyword').val());
		}
		this.loadProduct(url);
	}
	this.fixSize = function()
	{
		//$('#showdanhmuc').height($('body').height() - $('#showdanhmuc').position().top);
		$('#main-screen').height($('body').height() - $('#main-screen').position().top);
		$('#orderview').height($('body').height() - $('#orderview').position().top);
		$('#main-screen').width($('body').width() - $('#orderview').width());
		
	}
	this.view = function(mediaid)
	{
		$("#popup").attr('title','Giá sản phẩm');
		$( "#popup" ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: 800,
			height: 500,
			modal: true,
			buttons: {
				
				
				'Đóng': function() 
				{
					
					$(this).dialog("close");
				},
				
			}
		});
	
		
		$("#popup-content").load("?route=page/home/viewProduct&mediaid="+mediaid,function(){
			$("#popup").dialog("open");
			$('.orderpro').click(function(e) {
                pro.addOrder($('#orderid').val(),$(this).attr('mediaid'),$(this).attr('code'),$(this).attr('title'),$(this).attr('unit'),1,$(this).attr('price'));
            });
		});	
	}
	this.addOrder = function(orderid,mediaid,code,title,unit,quantity,price)
	{
		$.post("?route=page/home/addOrder",
			{
				orderid:orderid,
				mediaid:mediaid,
				code:code,
				title:title,
				unit:unit,
				quantity:quantity,
				price:price
			},
			function(data)
			{
				var obj = $.parseJSON(data);
				pro.loadOrder(obj.orderid);
				
			});	
	}
	this.updateOrderDetail = function(orderid,mediaid,code,title,unit,quantity,price)
	{
		$.post("?route=page/home/updateOrderDetail",
			{
				orderid:orderid,
				mediaid:mediaid,
				code:code,
				title:title,
				unit:unit,
				quantity:quantity,
				price:price
			},
			function(data)
			{
				var obj = $.parseJSON(data);
				pro.loadOrder(obj.orderid);
				
			});	
	}
	this.loadOrder = function(orderid)
	{
		$('#orderid').val(orderid);
		$('#orderdetail').html(loading);
		$('#orderdetail').load("?route=page/home/orderView&orderid="+orderid);
	}
	this.printOrder = function(orderid)
	{
		$("#popup").attr('title','Đơn hàng');
		$( "#popup" ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: 350,
			height: 600,
			modal: true,
			buttons: {
				'In': function() 
				{
					openDialog("?route=page/home/orderView&orderid="+orderid+"&view=print",207,600);
				},
				'Hoàn tất thanh toán':function()
				{
					$.post("?route=page/home/updateOrder",
						{
							orderid:orderid,
							col:'status',
							val:'completed'
						},
						function(data)
						{
							$('#orderid').val('');
							$('#orderdetail').html('');
							pro.getListOrder();	
							$('#popup').dialog("close");
						});
				},
				'Đóng':function()
				{
					$(this).dialog("close");
				}
				
			}
		});
	
		
		$("#popup-content").load("?route=page/home/orderView&orderid="+orderid+"&view=dialog",function(){
			$("#popup").dialog("open");	
			
		});
	}
	this.getListOrder = function()
	{
		$('#listorder').load("?route=page/home/getOrder");
	}
	this.viewIncome = function()
	{
		$("#popup").attr('title','Doanh thu');
		$( "#popup" ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: 800,
			height: 600,
			modal: true,
			buttons: {
				'In': function() 
				{
					openDialog("?route=page/home/income&view=print",800,600);
				},
				'Đóng phiên làm việc':function()
				{
					$.get("?route=page/home/closeSession",
						function(html)
						{
							
							//alert("Đóng phiên làm việc thành công");
							openDialog("?route=page/home/income&sessionid="+ html +"&view=print",800,600);
							window.location = 'logout.php';
						});
				},
				'Đóng':function()
				{
					$(this).dialog("close");
				}
				
			}
		});
	
		
		$("#popup-content").load("?route=page/home/income&view=dialog",function(){
			$("#popup").dialog("open");	
			
		});
	}
}
var pro = new Product();

</script>