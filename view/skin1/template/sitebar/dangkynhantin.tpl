<div class="ben-section">

	<div class="ben-section-title"><div class="title">Đăng ký nhận tin</div></div>
    
    <div class="ben-section-content ben-sitebar-regis">
    	<p>Đăng ký để nhận những thông tin khuyến mãi sớm nhất!</p>
        <table>
        	<tr>
            	<td>Tên</td>
                <td><input type="text" id="hoten" name="hoten" class="ben-textbox" ></td>
            </tr>
            <tr>
            	<td>Email</td>
                <td><input type="text" id="email" name="email" class="ben-textbox" ></td>
            </tr>
        </table>
        <p><input type="button" class="ben-button ben-center" value="Đăng ký" onclick="dangkynhantin()"></p>
    </div>
</div>
<script language="javascript">
function dangkynhantin()
{
	$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
	$.post("<?php echo HTTP_SERVER?>?route=addon/register/savenhantin", 
		{
			hoten:$('#hoten').val(),
			email:$('#email').val()
		},
		function(data){
			if(data == "true")
			{
				alert('Đăng ký nhận tin thành công');
			}
			else
			{
				
				alert(data);
				
				
			}
			$.unblockUI();
		}
	);					   
}
</script>