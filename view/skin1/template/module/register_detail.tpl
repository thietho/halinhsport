<div class="bb"><?php echo $media['title']?></div>
<div class="ben-post">

    <div class="ben-editor">
        <p>
            <?php echo $media['description']?>
        </p>
    </div>
	
    <div class="clearer">&nbsp;</div>
</div>


<div class="clearer">&nbsp;</div>
<div class="ben-post">
    <h3>Đăng ký</h3>
    <div class="ben-error ben-hidden"></div>
    <form method="post" action="" id="contractForm" name="contractForm">
    <div>
        <input type="hidden" name="mediaid" value="<?php echo $media['mediaid']?>" />
        <p>
            <label for="input-1">Họ và tên</label><span class="ben-batbuot">*</span><br/>
            <input type="text" name="hoten" id="hoten" class="ben-textbox" size="60" onkeypress='GetKey(event)'/>
        </p>
        
        <p>
            <label for="input-1">Ngày sinh</label><span class="ben-batbuot">*</span><br/>
            <input type="text" name="ngaysinh" id="ngaysinh" class="ben-textbox ben-datepicker"  onkeypress='GetKey(event)'/>
        </p>
        
        <p>
            <label for="input-1">Địa chỉ liên hệ</label><span class="ben-batbuot">*</span><br/>
            <input type="text" name="diachi" id="diachi" class="ben-textbox" size="60" onkeypress='GetKey(event)'/>
        </p>
        
        <p>
            <label for="input-1">Tên công ty</label><br/>
            <input type="text" name="tencongty" id="tencongty" class="ben-textbox" size="60" onkeypress='GetKey(event)'/>
        </p>
    	
        <p>
            <label for="input-1">Email</label><span class="ben-batbuot">*</span><br/>
            <input type="text" name="email" id="email" class="ben-textbox" size="60" onkeypress='GetKey(event)'/>
        </p>
        
        <p>
            <label for="input-1">Di động</label><span class="ben-batbuot">*</span><br/>
            <input type="text" name="didong" id="didong" class="ben-textbox" size="60" onkeypress='GetKey(event)'/>
        </p>
        
        <p>
            <label for="input-1">Khóa học</label><br/>
            <select id="khoahoc" name="khoahoc">
            	<?php foreach($data_sitemap as $sitemap){ ?>
                <option value="<?php echo $sitemap['sitemapid']?>"><?php echo $sitemap['sitemapname']?></option>
                <?php } ?>
            </select>
        </p>
    
        <p>
            <label for="input-3">Ghi chú thêm</label><br/>
            <textarea name="ghichu" id="ghichu" rows="10" cols="90"></textarea>
        </p>
        <p>
            <input type="button" class="ben-button" value="Đăng ký" onclick="sendMessage()"/>
            <input type="reset" class="ben-button" value="Làm lại" />
        </p>
    </div>			
    </form>
</div>
<script language="javascript">
function GetKey(evt)
{
	if(navigator.appName=="Netscape"){theKey=evt.which}
	if(navigator.appName.indexOf("Microsoft")!=-1)
	{
		theKey=window.event.keyCode
	}
	window.status=theKey;
	if(theKey==13)
	{
		sendMessage()
	}
}
function sendMessage()
{
	$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	$.post(HTTP_SERVER+"?route=module/contact/registerEvent", 
			$("#contractForm").serialize(), 
			function(data)
			{
				if(data!="true")
				{
					$('.ben-error').html(data)
					$('.ben-error').fadeIn("slow")
					//linkto("?<?php echo $refres?>")
				}
				else
				{
					alert("Thông tin của bạn đã gửi đến chúng tôi")
					window.location.reload();
				}
				$.unblockUI();
			}
	);
}
</script>