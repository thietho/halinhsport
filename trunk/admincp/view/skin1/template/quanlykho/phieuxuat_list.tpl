<div class="section">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content">
    	
        <form action="" method="post" id="frm_phieunhap">
        	<div id="ben-search">
            	<label>Mã phiếu</label>
                <input type="text" id="maphieu" name="maphieu" class="text" value="" />
                <!--<label>Người bán</label>
                <input type="text" id="nguoithuchien" name="nguoithuchien" class="text" value="" />-->
                <label>Khách hàng</label>
                <input type="text" id="tenkhachhang" name="tenkhachhang" class="text" value="" />
                <label>Từ ngày</label>
                <input type="text" class="text date" id="tungay" />
                <script language="javascript">
					$(function() {
						$("#tungay").datepicker({
								changeMonth: true,
								changeYear: true,
								dateFormat: 'dd-mm-yy'
								});
						});
				 </script>
                <label>Đến ngày</label>
                <input type="text" class="text date" id="denngay" />
                <script language="javascript">
					$(function() {
						$("#denngay").datepicker({
								changeMonth: true,
								changeYear: true,
								dateFormat: 'dd-mm-yy'
								});
						});
				 </script>
                <br />
                <input type="button" class="button" name="btnSearch" value="Tìm" onclick="searchForm()"/>
                <input type="button" class="button" name="btnSearch" value="Xem tất cả" onclick="viewAll()"/>
            </div>
        	<div class="button right">
            	<?php if($dialog==true){ ?>
            	
                <?php }else{ ?>
                
                <?php if($this->user->checkPermission("quanlykho/phieuxuat/insert")==true){ ?>
                <input class="button" value="Thêm" type="button" onclick="linkto('<?php echo $insert?>')">
                <?php } ?>
                <?php if($this->user->checkPermission("quanlykho/phieuxuat/delete")==true){ ?>
            	<input class="button" type="button" name="delete_all" value="Xóa" onclick="deleteitem()"/>
                <?php } ?>
                <?php } ?>
            </div>
            <div class="clearer">^&nbsp;</div>
            
            <div id="listphieunhap" class="sitemap treeindex">
                
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
		$.post("?route=quanlykho/phieuxuat/delete", 
				$("#frm_phieunhap").serialize(), 
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
$('.date').change(function(e) {
    searchForm();
});
function loadData(url)
{
	$('#listphieunhap').html(loading);
	$('#listphieunhap').load(url);
}
function viewAll()
{
	url = "?route=quanlykho/phieuxuat/getList";
	if("<?php echo $_GET['opendialog']?>" == "true")
	{
		url += "&opendialog=true";
	}
	loadData(url);
}

function searchForm()
{
	var url =  "";
	if($("#frm_phieunhap #maphieu").val() != "")
		url += "&maphieu=" + $("#frm_phieunhap #maphieu").val();
	
	if($("#frm_phieunhap #tenkhachhang").val() != "")
		url += "&tenkhachhang="+ encodeURI($("#frm_phieunhap #tenkhachhang").val());
	
	if($("#frm_phieunhap #tungay").val() != "")
		url += "&tungay="+ encodeURI($("#frm_phieunhap #tungay").val());
	if($("#frm_phieunhap #denngay").val() != "")
		url += "&denngay="+ encodeURI($("#frm_phieunhap #denngay").val());
	
	if("<?php echo $_GET['opendialog']?>" == "true")
	{
		url += "&opendialog=true";
	}
	loadData("?route=quanlykho/phieuxuat/getList"+url);
}

<?php if($dialog==true){ ?>
	$(".inputchk").click(function()
	{
		$("#selectnguyenlieu").val('');
		$(".inputchk").each(function(){
			if(this.checked == true)
			{
				$("#selectnguyenlieu").val($("#selectnguyenlieu").val()+","+$(this).val());
			}
		})
		
	});
<?php } ?>


function moveto(url,eid)
{
	$(eid).html(loading);
	$(eid).load(url);	
}
</script>