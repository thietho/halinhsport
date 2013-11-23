<div class="section">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content">
    	
        <form action="" method="post" id="frm_nguyenlieu">
        	<div id="ben-search">
            	<label>Mã số</label>
                <input type="text" id="manguyenlieu" name="manguyenlieu" class="text" value="" />
                <label>Tên</label>
                <input type="text" id="tennguyenlieu" name="tennguyenlieu" class="text" value="" />
                
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
                
                
                <?php if($this->user->checkPermission("quanlykho/nguyenlieu/insertlist")==true){ ?>
                <input class="button" value="Thêm nhiều nguyên liệu" type="button" onclick="linkto('<?php echo $insertlist?>')">
                <?php } ?>
                <?php if($this->user->checkPermission("quanlykho/nguyenlieu/insert")==true){ ?>
                <input class="button" value="Thêm" type="button" onclick="linkto('<?php echo $insert?>')">
                <?php } ?>
                <?php if($this->user->checkPermission("quanlykho/nguyenlieu/delete")==true){ ?>
            	<input class="button" type="button" name="delete_all" value="Xóa" onclick="deleteitem()"/>
                <?php } ?>
                <?php } ?>
            </div>
            <div class="clearer">^&nbsp;</div>
            
            <div id="listnguyenlieu" class="sitemap treeindex">
                
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
		$.post("?route=quanlykho/nguyenlieu/delete", 
				$("#frm_nguyenlieu").serialize(), 
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

function loadData(url)
{
	$('#listnguyenlieu').html(loading);
	$('#listnguyenlieu').load(url);
}
function viewAll()
{
	url = "?route=quanlykho/nguyenlieu/getList";
	if("<?php echo $_GET['opendialog']?>" == "true")
	{
		url += "&opendialog=true";
	}
	loadData(url);
}

function searchForm()
{
	var url =  "";
	if($("#frm_nguyenlieu #manguyenlieu").val() != "")
		url += "&manguyenlieu=" + $("#frm_nguyenlieu #manguyenlieu").val();
	
	if($("#frm_nguyenlieu #tennguyenlieu").val() != "")
		url += "&tennguyenlieu="+ encodeURI($("#frm_nguyenlieu #tennguyenlieu").val());
	
	if($("#frm_nguyenlieu #loai").val() != "")
		url += "&loai="+ encodeURI($("#frm_nguyenlieu #loai").val());

	
	if("<?php echo $_GET['opendialog']?>" == "true")
	{
		url += "&opendialog=true";
	}
	loadData("?route=quanlykho/nguyenlieu/getList"+url);
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

function viewTonKho(id)
{
	$("#popup").attr('title','Tồn kho');
				$( "#popup" ).dialog({
					autoOpen: false,
					show: "blind",
					hide: "explode",
					width: 800,
					height: 500,
					modal: true,
					buttons: {
						
						
						'Đóng': function() {
							$( this ).dialog( "close" );
						},
						
						
					}
				});
			
				
	$("#popup-content").load("?route=quanlykho/nguyenlieu/viewTonKho&id="+id,function(){
		$("#popup").dialog("open");	
	});
	//openDialog("?route=quanlykho/nguyenlieu/viewTonKho&id="+id,1000,800);
}
function importNguyenLieu(id)
{
	$("#popup").attr('title','Nhập kho');
				$( "#popup" ).dialog({
					autoOpen: false,
					show: "blind",
					hide: "explode",
					width: 800,
					height: 500,
					modal: true,
					buttons: {
						
						'Nhập kho': function(){
							$.post("?route=quanlykho/nguyenlieu/saveImport", $("#frm_import").serialize(),
								function(data){
									if(data == "true")
									{
										alert("Nhâp kho thành công")
										$("#popup").dialog( "close" );
										searchForm()
									}
									else
									{
									
										$('#error').html(data).show('slow');
										
										
									}
									
								}
							);
						},
						'Đóng': function() {
							$( this ).dialog( "close" );
						},
						
						
					}
				});
			
				
	$("#popup-content").load("?route=quanlykho/nguyenlieu/importNguyenLieu&id="+id,function(){
		$("#popup").dialog("open");	
	});
}
function exportNguyenLieu(id)
{
	$("#popup").attr('title','Xuất kho');
				$( "#popup" ).dialog({
					autoOpen: false,
					show: "blind",
					hide: "explode",
					width: 800,
					height: 500,
					modal: true,
					buttons: {
						
						'Xuất kho': function(){
							$.post("?route=quanlykho/nguyenlieu/saveExport", $("#frm_import").serialize(),
								function(data){
									if(data == "true")
									{
										alert("Xuất kho thành công")
										$("#popup").dialog( "close" );
										searchForm()
									}
									else
									{
									
										$('#error').html(data).show('slow');
										
										
									}
									
								}
							);
						},
						'Đóng': function() {
							$( this ).dialog( "close" );
						},
						
						
					}
				});
			
				
	$("#popup-content").load("?route=quanlykho/nguyenlieu/exportNguyenLieu&id="+id,function(){
		$("#popup").dialog("open");	
	});
}
function moveto(url,eid)
{
	$(eid).html(loading);
	$(eid).load(url);	
}
</script>