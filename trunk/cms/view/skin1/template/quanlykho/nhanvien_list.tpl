<div class="section">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content">
    	
        <form action="" method="post" id="frm_nhanvien">
        	<div id="ben-search">
            	<label>Mã số</label>
                <input type="text" id="manhanvien" name="manhanvien" class="text" value="" />
                <label>Tên</label>
                <input type="text" id="hoten" name="hoten" class="text" value="" />
                <label>Loại</label>
                <select id="loai" name="loai">
                    <option value=""></option>
                    <?php foreach($loainhanvien as $val){ ?>
                    <option value="<?php echo $val['categoryid']?>"><?php echo $val['categoryname']?></option>
                    <?php } ?>
                </select>
                
               
                <br />
                <input type="button" class="button" name="btnSearch" value="Tìm" onclick="searchForm()"/>
                <input type="button" class="button" name="btnSearch" value="Xem tất cả" onclick="window.location = '?route=quanlykho/nhanvien<?php echo $_GET['opendialog']=='true'?'&opendialog=true':''?>'"/>
            </div>
            <!-- end search -->
            
        	<div class="button right">
                <?php if($dialog==true){ ?>
            	
                <?php } ?>
                <?php if($dialog!=true){ ?>
                <?php if($this->user->checkPermission("quanlykho/nhanvien/insert")==true){ ?>
                <input class="button" value="Thêm" type="button" onclick="linkto('<?php echo $insert?>')">
                <?php } ?>
                <?php if($this->user->checkPermission("quanlykho/nhanvien/delete")==true){ ?>
            	<input class="button" type="button" name="delete_all" value="Xóa" onclick="deleteitem()"/>
                <?php } ?>
                <?php } ?>  
            </div>
            <div class="clearer">^&nbsp;</div>
            
            <div id="listnhanvien" class="sitemap treeindex">
                
            </div>
        	
        
        </form>
        
    </div>
    
</div>
<script language="javascript">
function resetPass(id)
{
	showPopup("#popup", 500, 300, true )
	$("#popup-content").load("?route=quanlykho/nhanvien/resetPass&id="+id);
}

function deleteitem()
{
	var answer = confirm("Bạn có muốn xóa không?")
	if (answer)
	{
		$.post("?route=quanlykho/nhanvien/delete", 
				$("#frm_nhanvien").serialize(), 
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

$('#frm_nhanvien .text').keyup(function(e) {
    searchForm();
});
$('#frm_nhanvien select').change(function(e) {
    searchForm();
});
function viewAll()
{
	url = "?route=quanlykho/nhanvien/getList";
	if("<?php echo $_GET['opendialog']?>" == "true")
	{
		url += "&opendialog=true";
	}
	$('#listnhanvien').html(loading);
	$('#listnhanvien').load(url);
}

function searchForm()
{
	var url =  "";
	if($("#frm_nhanvien #manhanvien").val() != "")
		url += "&manhanvien=" + $("#frm_nhanvien #manhanvien").val();
	
	if($("#frm_nhanvien #hoten").val() != "")
		url += "&hoten="+ encodeURI($("#frm_nhanvien #hoten").val());
	
	if($("#frm_nhanvien #loai").val() != "")
		url += "&loai="+ encodeURI($("#frm_nhanvien #loai").val());

	
	if("<?php echo $_GET['opendialog']?>" == "true")
	{
		url += "&opendialog=true";
	}
	$('#listnhanvien').html(loading);
	$('#listnhanvien').load("?route=quanlykho/nhanvien/getList"+url);
}

function moveto(url,eid)
{
	$(eid).html(loading);
	$(eid).load(url);	
}
</script>