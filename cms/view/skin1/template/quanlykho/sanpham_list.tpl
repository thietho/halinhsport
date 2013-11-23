<div class="section">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content">
    	
        <form action="" method="post" id="frm_sanpham">
        	<div id="ben-search">
            	<label>Mã số</label>
                <input type="text" id="masanpham" name="masanpham" class="text" value="" />
                <label>Tên</label>
                <input type="text" id="tensanpham" name="tensanpham" class="text" value="" />
                
                <label>Loại</label>
                <select id="loai" name="loai">
                    <option value=""></option>
                    <?php foreach($loainguyenlieu as $val){ ?>
                    <option value="<?php echo $val['categoryid']?>"><?php echo $this->string->getPrefix("&nbsp;&nbsp;&nbsp;",$val['level']-1)?><?php echo $val['categoryname']?></option>
                    <?php } ?>
                </select>
                
                <br />
                <input type="button" class="button" name="btnSearch" value="Tìm" onclick="searchForm()"/>
                <input type="button" class="button" name="btnSearch" value="Xem tất cả" onclick="viewAll()"/>
            </div>
        	<div class="button right">
            	<?php if($dialog==true){ ?>
            	
                <?php }else{ ?>
                
                <?php if($this->user->checkPermission("quanlykho/sanpham/insertlist")==true){ ?>
                <input class="button" value="Thêm nhiều sản phẩm" type="button" onclick="linkto('<?php echo $insertlist?>')">
                <?php } ?>
                <?php if($this->user->checkPermission("quanlykho/sanpham/insert")==true){ ?>
                <input class="button" value="Thêm" type="button" onclick="linkto('<?php echo $insert?>')">
                <?php } ?>
                <?php if($this->user->checkPermission("quanlykho/sanpham/delete")==true){ ?>
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
		$.post("?route=quanlykho/sanpham/delete", 
				$("#frm_sanpham").serialize(), 
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
	url = "?route=quanlykho/sanpham/getList";
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
	if($("#frm_sanpham #masanpham").val() != "")
		url += "&masanpham=" + $("#frm_sanpham #masanpham").val();
	
	if($("#frm_sanpham #tensanpham").val() != "")
		url += "&tensanpham="+ encodeURI($("#frm_sanpham #tensanpham").val());
	
	if($("#frm_sanpham #loai").val() != "")
		url += "&loai="+ encodeURI($("#frm_sanpham #loai").val());

	
	if("<?php echo $_GET['opendialog']?>" == "true")
	{
		url += "&opendialog=true";
	}
	$('#listsanpham').html(loading);
	$('#listsanpham').load("?route=quanlykho/sanpham/getList"+url);
}

function moveto(url,eid)
{
	$(eid).html(loading);
	$(eid).load(url);	
}
</script>