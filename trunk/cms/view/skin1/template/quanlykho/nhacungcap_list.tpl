<div class="section">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content">
    	
        <form action="" method="post" id="frm_nhacungcap">
        	<div id="ben-search">
            	<label>Tên nhà cung cấp</label>
                <input type="text" id="tennhacungcap" name="tennhacungcap" class="text" value="" />
                <label>Số điện thoại</label>
                <input type="text" id="sodienthoai" name="sodienthoai" class="text" value="" />
                <label>Địa chỉ</label>
                <input type="text" id="diachi" name="diachi" class="text" value="" />
                <label>Email</label>
                <input type="text" id="email" name="email" class="text" value="" />
                <br />
                <label>Nguoi liên hệ</label>
                <input type="text" id="nguoilienhe" name="nguoilienhe" class="text" value="" />
                <label>Số điện thoại liên hệ</label>
                <input type="text" id="sodienthoainguoilienhe" name="sodienthoainguoilienhe" class="text" value="" />
                
                <br />
                <input type="button" class="button" name="btnSearch" value="Tìm" onclick="searchForm()"/>
                <input type="button" class="button" name="btnSearch" value="Xem tất cả" onclick="viewAll()"/>
            </div>
        	<div class="button right">
            	<?php if($dialog==true){ ?>
            	
                <?php }else{ ?>
                
               
                <?php if($this->user->checkPermission("quanlykho/nhacungcap/insert")==true){ ?>
                <input class="button" value="Thêm" type="button" onclick="linkto('<?php echo $insert?>')">
                <?php } ?>
                <?php if($this->user->checkPermission("quanlykho/nhacungcap/delete")==true){ ?>
            	<input class="button" type="button" name="delete_all" value="Xóa" onclick="deleteitem()"/>
                <?php } ?>
                <?php } ?>
            </div>
            <div class="clearer">^&nbsp;</div>
            
            <div id="listsanpham" class="sitemap treeindex">
                
            </div>
        	
        
        </form>
        
    </div>
    
</div>
<script language="javascript">

function deleteitem()
{
	var answer = confirm("Bạn có muốn xóa không?")
	if (answer)
	{
		$.post("?route=quanlykho/nhacungcap/delete", 
				$("#frm_nhacungcap").serialize(), 
				function(data)
				{
					if(data!="")
					{
						alert(data)
						window.location.reload();
					}
				}
		);
	}
}
$(document).ready(function(e) {
    viewAll();
});

$('.text').keyup(function(e) {
    searchForm();
});
$('select').change(function(e) {
    searchForm();
});
function viewAll()
{
	url = "?route=quanlykho/nhacungcap/getList";
	if("<?php echo $_GET['opendialog']?>" == "true")
	{
		url += "&opendialog=true";
	}
	$('#listsanpham').html(loading);
	$('#listsanpham').load(url);
}

function searchForm()
{
	var url =  "";
	if($("#frm_nhacungcap #tennhacungcap").val() != "")
		url += "&tennhacungcap=" + encodeURI($("#frm_nhacungcap #tennhacungcap").val());
	
	if($("#frm_nhacungcap #sodienthoai").val() != "")
		url += "&sodienthoai="+ encodeURI($("#frm_nhacungcap #sodienthoai").val());
	
	if($("#frm_nhacungcap #diachi").val() != "")
		url += "&diachi="+ encodeURI($("#frm_nhacungcap #diachi").val());
	if($("#frm_nhacungcap #email").val() != "")
		url += "&email="+ encodeURI($("#frm_nhacungcap #email").val());
	if($("#frm_nhacungcap #nguoilienhe").val() != "")
		url += "&nguoilienhe="+ encodeURI($("#frm_nhacungcap #nguoilienhe").val());
	if($("#frm_nhacungcap #sodienthoainguoilienhe").val() != "")
		url += "&sodienthoainguoilienhe="+ encodeURI($("#frm_nhacungcap #sodienthoainguoilienhe").val());

	
	if("<?php echo $_GET['opendialog']?>" == "true")
	{
		url += "&opendialog=true";
	}
	$('#listsanpham').html(loading);
	$('#listsanpham').load("?route=quanlykho/nhacungcap/getList"+url);
}

function moveto(url,eid)
{
	$(eid).html(loading);
	$(eid).load(url);	
}
</script>