<div id="item-sales" class="pro-item left">
	<table>
    	<tr>
        	<td>
            	Bán hàng
            </td>
        </tr>
    </table>
</div>
<?php if($this->user->getUserTypeId() == 'admin'){?>
<div id="item-admincp" class="pro-item left">
	<table>
    	<tr>
        	<td>
            	Quản trị hệ thống
            </td>
        </tr>
    </table>
</div>
<?php } ?>
<div id="item-income" class="pro-item left">
	<table>
    	<tr>
        	<td>
            	Tổng kế doanh thu
            </td>
        </tr>
    </table>
</div>
<div id="item-changepass" class="pro-item left">
	<table>
    	<tr>
        	<td>
            	Thay đổi mật khẩu
            </td>
        </tr>
    </table>
	
</div>
<div id="item-profile" class="pro-item left">
	<table>
    	<tr>
        	<td>
            	Thông tin cá nhân
            </td>
        </tr>
    </table>
	
</div>
<div id="item-logout" class="pro-item left">
	<table>
    	<tr>
        	<td>
            	Đăng xuất
            </td>
        </tr>
    </table>
</div>
<script language="javascript">
$("#item-sales").click(function(e) {
    $('#main-screen').load('?route=page/home/productCat');
});
$('#item-admincp').click(function(e) {
    window.location ="<?php echo ADIMCP?>";
});
$('#item-income').click(function(e) {
    pro.viewIncome();
});
$('#item-changepass').click(function(e) {
    $("#popup").attr('title','Thay đổi mật khẩu');
		$( "#popup" ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: 800,
			height: 500,
			modal: true,
			buttons: {
				
				'Thay đổi mật khẩu': function()
				{
					changePass();
				},
				'Đóng': function() 
				{
					
					$("#popup").dialog("close");
				},
				
			}
		});
	
		
		$("#popup-content").load("?route=common/changepassword",function(){
			$("#popup").dialog("open");
			
		});
});
$('#item-profile').click(function(e) {
     $("#popup").attr('title','Thay đổi mật khẩu');
		$( "#popup" ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: 800,
			height: 500,
			modal: true,
			
		});
	
		
		$("#popup-content").load("?route=addon/nhanvien/profile",function(){
			$("#popup").dialog("open");
			
		});
});
$('#item-logout').click(function(e) {
    window.location = "logout.php";
});
</script>