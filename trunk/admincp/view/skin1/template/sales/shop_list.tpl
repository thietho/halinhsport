<div class="section">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content">
    	
        <form action="" method="post" id="frm_shop">
        	<div id="ben-search">
            	
                <label>Tên cửa hàng</label>
                <input type="text" id="shopname" name="shopname" class="text" value="" />
                
                <input type="button" class="button" name="btnSearch" value="Tìm" onclick="searchForm()"/>
                <input type="button" class="button" name="btnSearch" value="Xem tất cả" onclick="window.location = '?route=sales/shop<?php echo $_GET['opendialog']=='true'?'&opendialog=true':''?>'"/>
            </div>
            <!-- end search -->
            
        	<div class="button right">
                <?php if($dialog==true){ ?>
            	
                <?php } ?>
                <?php if($dialog!=true){ ?>
                <?php if($this->user->checkPermission("sales/shop/insert")==true){ ?>
                <input class="button" value="Thêm" type="button" onclick="linkto('<?php echo $insert?>')">
                <?php } ?>
                <?php if($this->user->checkPermission("sales/shop/delete")==true){ ?>
            	<input class="button" type="button" name="delete_all" value="Xóa" onclick="deleteitem()"/>
                <?php } ?>
                <?php } ?>  
            </div>
            <div class="clearer">^&nbsp;</div>
            
            <div id="listshop" class="sitemap treeindex">
                
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
		$.post("?route=sales/shop/delete", 
				$("#frm_shop").serialize(), 
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

$('#frm_shop .text').keyup(function(e) {
    searchForm();
});
$('#frm_shop select').change(function(e) {
    searchForm();
});
function viewAll()
{
	url = "?route=sales/shop/getList";
	if("<?php echo $_GET['opendialog']?>" == "true")
	{
		url += "&opendialog=true";
	}
	$('#listshop').html(loading);
	$('#listshop').load(url);
}

function searchForm()
{
	var url =  "";
	if($("#frm_shop #shopname").val() != "")
		url += "&shopname="+ encodeURI($("#frm_shop #shopname").val());

	if("<?php echo $_GET['opendialog']?>" == "true")
	{
		url += "&opendialog=true";
	}
	$('#listshop').html(loading);
	$('#listshop').load("?route=sales/shop/getList"+url);
}

function moveto(url,eid)
{
	$(eid).html(loading);
	$(eid).load(url);	
}
function selectNhanVien(shopid)
{
	$('body').append('<div id="nhanvienfrom" style="display:none"></div>');
	var eid = "#nhanvienfrom"
	$(eid).attr('title','Thông tin file');
		$(eid).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: 500,
			height: 600,
			modal: true,
			close:function()
				{
					$(eid).remove();
				},
			
		});
	
		
		$(eid).load("?route=sales/shop/getListStaff&dialog=true",function(){
			$(eid).dialog("open");
			$('.nhanvien').click(function(e) {
                //alert($(this).attr('nhanvienid'));
				var nhanvienid = $(this).attr('nhanvienid');
				$.post("?route=sales/shop/saveStaffToShop",
					{
						staffid:nhanvienid,
						shopid:shopid
					},
					function(data){
						window.location.reload();
					});
				$(eid).dialog( "close" );
            });
		});
}
function removeStaff(staffid)
{
	$.get("?route=sales/shop/removeStaff&staffid="+staffid,function(data){
		if(data=='true')
			window.location.reload();
	});
}

</script>