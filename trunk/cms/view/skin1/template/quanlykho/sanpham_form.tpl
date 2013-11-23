<div class="section" id="sitemaplist">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content padding1">
    
    	<form name="frm" id="frm" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	<input type="button" value="Lưu" class="button" onClick="save()"/>
     	        <input type="button" value="Bỏ qua" class="button" onclick="linkto('?route=quanlykho/sanpham')"/>   
     	        <input type="hidden" name="id" value="<?php echo $item['id']?>">
                <input type="hidden" id="handler" />
             	<input type="hidden" id="outputtype" />
            </div>
            <div class="clearer">^&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
            <div id="container">
                <ul class="tabs-nav">
                    <li class="tabs-selected"><a href="#fragment-thongtin"><span>Thông tin sản phẩm</span></a></li>
                    <li class="tabs"><a href="#fragment-dinhluong"><span>Định lượng</span></a></li>
                </ul>
                <div id="fragment-thongtin">
                    <p>
                        <label>Mã sản phẩm</label><br />
                        <input type="text" id="masanpham" name="masanpham" value="<?php echo $item['masanpham']?>" class="text" size=60 <?php echo $readonly?>/>
                        
                    </p>
                    
                    
                    <p>
                        <label>Tên sản phẩm</label><br />
                        <input type="text" id="tensanpham" name="tensanpham" value="<?php echo $item['tensanpham']?>" class="text" size=60 />
                        
                    </p>
                    <p>
                        <label>Tên hiển thị</label><br />
                        <input type="text" id="tenhienthi" name="tenhienthi" value="<?php echo $item['tenhienthi']?>" class="text" size=60 />
                        
                    </p>
                  
                    <p>
                        <label>Loại</label><br />
                        <select id="loai" name="loai">                   		
                            <?php foreach($loaisanpham as $val){ ?>
                            <option value="<?php echo $val['categoryid']?>"><?php echo $this->string->getPrefix("&nbsp;&nbsp;&nbsp;",$val['level']-1)?><?php echo $val['categoryname']?></option>
                            <?php } ?>
                        </select>
                    </p>
                    <p>
                        <label>Giá bán</label><br />
                        <input type="text" id="giaban" name="giaban" value="<?php echo $item['giaban']?>" class="text number" size=60 />
                    </p>
                    
                    <p>
                        <label>Đơn vị tính</label><br />
                        <select id="madonvi" name="madonvi">
                            <option value=""></option>
                            <?php foreach($donvitinh as $val){ ?>
                            <option value="<?php echo $val['madonvi']?>"><?php echo $val['tendonvitinh']?></option>
                            <?php } ?>
                        </select>
                    </p>
                    
                   
                   
                    <p id="pnImage">
                        <label for="image">Hình</label><br />
                        <a class="button" onclick="browserFileImage()">Chọn hình</a><br />
                        
                        <img id="preview" src="<?php echo $item['imagethumbnail']?>" />
                        <input type="hidden" id="imagepath" name="imagepath" value="<?php echo $item['imagepath']?>" />
                        <input type="hidden" id="imageid" name="imageid" value="<?php echo $item['imageid']?>" />
                        <input type="hidden" id="imagethumbnail" name="imagethumbnail" value="<?php echo $item['imagethumbnail']?>" />
                    </p>
                    
                    
                    <div id="errorupload" class="error" style="display:none"></div>
                    
                    <div class="loadingimage" style="display:none"></div>
                   
                </div>
                <div id="fragment-dinhluong">
                	<table>
                    	<tr>
                            <th>Nguyên liệu</th>
                            <th>Số lượng</th>
                            <th>Đơn vị tính</th>
                            <th></th>
                        </tr>
                        <tbody id="sanphamnguyenlieu">
                        </tbody>
                    </table>
                    <input type="hidden" id="deldinhluong" name="deldinhluong" />
                    <input type="button" class="button" id="btnAddRow" value="Thêm dòng"/>
                </div>
           </div>
            
        </form>
    
    </div>
    
</div>
<?php if(count($data_dinhluong)){ ?>
	<?php foreach($data_dinhluong as $dl){ ?>
<script language="javascript">
$(document).ready(function(e) {
	objdl.addRow("<?php echo $dl['id']?>","<?php echo $dl['nguyenlieuid']?>","<?php echo $dl['tennguyenlieu']?>","<?php echo $dl['soluong']?>","<?php echo $dl['madonvi']?>");
});
</script>
	<?php } ?>
<?php } ?>
<script language="javascript">
$(document).ready(function(e) {
    $('#container').tabs({ fxSlide: true, fxFade: true, fxSpeed: 'slow' });
});
function DinhLuong()
{
	this.index = 0;
	this.addRow = function(id,nguyenlieuid,tennguyenlieu,soluong,madonvi)
	{
		var row = '<tr id="row'+ this.index +'">';
		row +='<td><input type="hidden" id="dinhluongid-'+ this.index +'" name="dinhluongid['+ this.index +']" value="'+ id +'" /><input type="hidden" id="nguyenlieuid-'+ this.index +'" name="nguyenlieuid['+ this.index +']" value="'+ nguyenlieuid +'" />'+ tennguyenlieu +'</td>';
		row +='<td class="number"><input type="text" id="soluong-'+ this.index +'" name="soluong['+ this.index +']" value="'+soluong+'" class="text number" /></td>';
		row +='<td class="number"><select nguyenlieuid="'+nguyenlieuid+'" id="madonvi-'+ this.index +'" name="dlmadonvi['+ this.index +']" value="'+madonvi+'"></section></td>';
		row +='<td><input type="button" class="button" value="Xóa" onclick="objdl.removeRow('+ this.index +')"/></td>';
		row+='</tr>'
		$('#sanphamnguyenlieu').append(row);
		var str = '#madonvi-'+ this.index;
		$.getJSON("?route=quanlykho/nguyenlieu/getListDonVi&nguyenlieuid="+ nguyenlieuid,
			function(data){
				html = "";
				for(i in data)
				{
					//alert(data[i].madonvi)
					html += '<option value="'+data[i].madonvi+'">'+data[i].tendonvitinh+'</option>';
				}
				$(str).html(html);
				$(str).val(madonvi);
			});
		
		this.index++;
		numberReady();
	}
	this.removeRow = function(pos)
	{
		var dinhluongid = $('#dinhluongid-'+pos).val();
		$('#deldinhluong').val(dinhluongid+ "," +$('#deldinhluong').val());
		$('#row'+pos).remove();
	}
}

var objdl = new DinhLuong();

$('#btnAddRow').click(function(e) {
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
						var id = 0;
						var nguyenlieuid = this.id;
						var tennguyenlieu = $(this).attr('tennguyenlieu');
						var soluong = 0;
						var madonvi = $(this).attr('madonvi');
						objdl.addRow(id,nguyenlieuid,tennguyenlieu,soluong,madonvi);
						
                    });
					$('#popup-seletetion').html("");
					$( this ).dialog( "close" );
					
				},
			}
		});
	
		
		$("#popup-content").load("?route=quanlykho/nguyenlieu&opendialog=true",function(){
			$("#popup").dialog("open");
		});
});
function intSelectNguyenLieu()
{
	$('.item').click(function(e) {
	
		if($('#popup-seletetion #'+this.id).html() == undefined)
		{
			var html = "<div><div class='selectitem left' id='"+ this.id +"' manguyenlieu="+$(this).attr('manguyenlieu')+" tennguyenlieu="+$(this).attr('tennguyenlieu')+" madonvi='"+$(this).attr('madonvi')+"'>"+$(this).attr('manguyenlieu')+":"+ $(this).attr('tennguyenlieu') +"   </div><a class='removeitem button right'>X</a><div class='clearer'>^&nbsp;</div></div>";
			$('#popup-seletetion').append(html);
			
			$('.removeitem').click(function(e) {
				$(this).parent().remove();
			});
		}
		
	});	
}
function browserFileImage()
{
	$("#popup").attr('title','Chọn hình');
		$( "#popup" ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: 800,
			height: 600,
			modal: true,
			
		});
	
		
		$("#popup-content").load("?route=core/file&dialog=true&type=single",function(){
			$("#popup").dialog("open");	
		});
}
function intSeleteFile()
{
	$('.filelist').click(function(e) {
        $('#preview').attr('src',$(this).attr('imagethumbnail'));
		$('#imageid').val(this.id);
		$('#imagepath').val($(this).attr('filepath'));
		$('#imagethumbnail').val($(this).attr('imagethumbnail'));
		$("#popup").dialog( "close" );
    });
}

function save()
{
	$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
	$.post("?route=quanlykho/sanpham/save", $("#frm").serialize(),
		function(data){
			if(data == "true")
			{
				window.location = "?route=quanlykho/sanpham";
			}
			else
			{
			
				$('#error').html(data).show('slow');
				$.unblockUI();
				
			}
			
		}
	);
}

$("#manhom").val("<?php echo $item['manhom']?>");
$("#loai").val("<?php echo $item['loai']?>");

$("#madonvi").val("<?php echo $item['madonvi']?>");

var DIR_UPLOADPHOTO = "<?php echo $DIR_UPLOADPHOTO?>";
</script>

