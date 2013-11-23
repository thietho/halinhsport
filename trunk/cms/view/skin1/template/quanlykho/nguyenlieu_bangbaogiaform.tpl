
<div class="section" id="sitemaplist">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content padding1">
    
    	<form name="frm" id="frm" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	<input type="button" value="Lưu" class="button" onClick="save()"/>
     	        <input type="button" value="Trở về" class="button" onclick="linkto('?route=quanlykho/nguyenlieu/bangbaogia')"/>   
     	        <input type="hidden" name="id" value="<?php echo $item['id']?>">
            </div>
            <div class="clearer">^&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
        	<div>
            	<p>
            		<label>Ngày</label><br />
                    <script language="javascript">
						$(function() {
							$("#ngay").datepicker({
									changeMonth: true,
									changeYear: true,
									dateFormat: 'dd-mm-yy'
									});
							});
					 </script>
					<input type="text" id="ngay" name="ngay" value="<?php echo $this->date->formatMySQLDate($item['ngay'])?>" class="text" size=60 <?php echo $readonly?>/>
                    
            	</p>
              	
                
                <p>
                	<label>Nhà cung cấp</label><br>
                    <input type="hidden" id="manhacungung" name="manhacungung" value="<?php echo $item['manhacungung']?>">
                    <span id="tennhacungcap"><?php echo $this->document->getNhaCungUng($item['manhacungung'])?></span>
                    <input type="button" class="button" name="btnChonNhaCungCap" value="Chọn nhà cung cấp" onClick="selcetNhaCungCap()">
                    <input type="button" class="button" name="btnChonNhaCungCap" value="Bỏ chọn" onClick="unSelcetNhaCungCap()">
                </p>
               
                <p>
                    <label>Chi tiết phiếu nhập nguyên vật liệu</label>
                    <p>
                        <input type="hidden" id="manguyenlieu" name="manguyenlieu">
                        <table style="width:auto">
                            <thead>
                                <tr>
                                    <th>Mã nguyên vật liệu</th>
                                    <th>Tên nguyên vật liệu</th>
                                    
                                    
                                    <th>Đơn giá</th>
                                    
                                    
                                    
                                    <th>&nbsp;</th>
                                </tr>
                            </thead>
                            <tbody id="chitiet">
                                
                            </tbody>
                        </table>
                        <input type="hidden" id="delchitiet" name="delchitiet" />
                        <input class="button" type="button" name="btnAddrow" value="Thêm dòng" onClick="selectNguyenLieu()">
                    </p>
                </p>
               
               
               
            </div>
            
        </form>
    
    </div>
    
</div>
<script language="javascript">
function save()
{
	$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
	$.post("?route=quanlykho/nguyenlieu/savebangbaogia", $("#frm").serialize(),
		function(data){
			if(data == "true")
			{
				window.location = "?route=quanlykho/nguyenlieu/bangbaogia";
			}
			else
			{
			
				$('#error').html(data).show('slow');
				$.unblockUI();
				
			}
			
		}
	);
}





function selcetNhaCungCap()
{
	/*openDialog("?route=quanlykho/nhacungung&opendialog=true",1000,800);
	
	list = trim($("#manhacungung").val(), ',');
	arr = list.split(",");
	manhacungcap = arr[0];
	getNhaCungCap("id",manhacungcap,'');*/
	$("#popup").attr('title','Chọn nhà cung cấp');
		$( "#popup" ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: 800,
			height: 600,
			modal: true,
			
		});
	
		
		$("#popup-content").load("?route=quanlykho/nhacungung&opendialog=true",function(){
			$("#popup").dialog("open");	
		});
}
function intSelectNhaCungCap()
{
	$('.item').click(function(e) {
        $("#manhacungung").val($(this).attr('id'));
		$("#tennhacungcap").html($(this).attr('tennhacungung'));
		$("#popup").dialog( "close" );
    });
}
function unSelcetNhaCungCap()
{
	$("#manhacungung").val("");
	$("#tennhacungcap").html("");
}

//bat dau javascript cho chi tiet

<?php 
	$index = 0;
	
	if(count($chitiet))
	{
		foreach($chitiet as $val)
		{ 
	?>
			createRow(	"<?php echo $val['id']?>",
						"<?php echo $val['manguyenlieu']?>",
						
						
						"<?php echo $val['gia']?>"
						
					);
	<?php
			$index += 1;
		} 
	}
?>

function selectNguyenLieu()
{

	$("#popup").attr('title','Chọn nguyên liệu');
		$( "#popup" ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: 900,
			height: 600,
			modal: true,
			buttons: {
				
				
				
				'Xem danh sach':function()
				{
					$( "#popup-selete" ).show('fast',function(){
						$( "#popup-selete" ).position({
							my: "center",
							at: "center",
							of: "#popup"
						});
						$( "#popup-selete" ).draggable();
					});
					$('.closeselect').click(function(e) {
                        $( "#popup-selete" ).hide('fast');
                    });
				},
				'Chọn': function() 
				{
					$('.selectitem').each(function(index, element) {
						var nguyenlieuid = this.id;
						createRow(0,nguyenlieuid, 0, 0, "", 0);
						
                    });
					$('#popup-seletetion').html("");
					$( this ).dialog( "close" );
				},
			}
		});
	
		
		$("#popup-content").load("?route=quanlykho/nguyenlieu&opendialog=true",function(){
			$("#popup").dialog("open");
		});
	
}

function intSelectNguyenLieu()
{
	$('.item').click(function(e) {
	
		if($('#popup-seletetion #'+this.id).html() == undefined)
		{
			var html = "<div><div class='selectitem left' id='"+ this.id +"'>"+$(this).attr('manguyenlieu')+":"+ $(this).attr('tennguyenlieu') +"   </div><a class='removeitem button right'>X</a><div class='clearer'>^&nbsp;</div></div>";
			$('#popup-seletetion').append(html);
			
			$('.removeitem').click(function(e) {
				$(this).parent().remove();
			});
		}
		
	});	
}

var index = 0;
function createRow(id, nguyenlieuid, dongia)
{
	$.getJSON("?route=quanlykho/nguyenlieu/getNguyenLieu&col=id&val="+nguyenlieuid, 
	function(data) 
	{
		var row = "";
		for( i in data.nguyenlieus)
		{
			var cellid = '<input type="hidden" name="chitiet['+index+']" value="' +id+ '">';
			var cellitemid = '<input type="hidden" class="itemid" name="itemid['+index+']" value="' +data.nguyenlieus[i].id + '">' + data.nguyenlieus[i].manguyenlieu;
			var celltennguyenlieu = '<input type="hidden" name="tennguyenlieu['+index+']" value="' +data.nguyenlieus[i].tennguyenlieu+ '">' + data.nguyenlieus[i].tennguyenlieu +" ("+data.nguyenlieus[i].tendonvitinh +")";
			
			
			
			var celldongia = '<input type="text" name="dongia['+index+']" value="'+dongia+'" class="text number" size=5 />';
			
			
			
			
			
			row+='						<tr id="row'+index+'">';
			row+='                          <td>'+cellid+cellitemid+'</td>';
			row+='                          <td>'+celltennguyenlieu+'</td>';
			
			
			row+='                          <td>'+celldongia+'</td>';
			
			row+='                          <td><input type="button" class="button" value="Xóa" onclick="removeRow('+index+','+id+')"></td>';
			row+='                      </tr>';
		}
		$("#chitiet").append(row);
		
		if(dongia == 0)
			$("#dongia-"+index+"").val(data.nguyenlieus[i].dongia);
		
		index++;
		numberReady();
	});	
}

function removeRow(pos,id)
{
	$("#delchitiet").val($("#delchitiet").val()+","+id);
	$("#row"+pos).remove();
}
//end javascript cho chi tiet
</script>
