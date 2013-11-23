
<div class="section" id="sitemaplist">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content padding1">
    
    	<form name="frm" id="frm" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	<input type="button" value="Lưu" class="button" onClick="save()"/>
     	        <input type="button" value="Bỏ qua" class="button" onclick="linkto('?route=quanlykho/nhanvien')"/>   
     	        <input type="hidden" name="id" value="<?php echo $item['id']?>">
            </div>
            <div class="clearer">^&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
            <div id="container">
        	
                <ul>
                    <li><a href="#fragment-thongtin"><span>Thông tin nhân viên</span></a></li>
                    <li><a href="#fragment-luong"><span>Thông tin lương</span></a></li>
                </ul>
                <div id="fragment-thongtin">
                    <p>
                        <label>Mã nhân viên</label><br />
                        <input type="text" id="manhanvien" name="manhanvien" value="<?php echo $item['manhanvien']?>" class="text" size=60 <?php echo $readonly?>/>
                        
                    </p>
                    
                    
                    <p>
                        <label>Họ tên</label><br />
                        <input type="text" id="hoten" name="hoten" value="<?php echo $item['hoten']?>" class="text" size=60 />
                    </p>
                    <p>
                        <label>Ngày sinh</label><br />
                        
                        <script language="javascript">
                            $(function() {
                                $("#ngaysinh").datepicker({
                                        changeMonth: true,
                                        changeYear: true,
                                        dateFormat: 'dd-mm-yy'
                                        });
                                });
                         </script>
                        <input type="text" id="ngaysinh" name="ngaysinh" value="<?php echo $this->date->formatMySQLDate($item['ngaysinh'])?>" class="text" size=60 />
                    </p>
                    <p>
                        <label>CMND</label><br />
                        <input type="text" id="cmnd" name="cmnd" value="<?php echo $item['cmnd']?>" class="text" size=60 />
                    </p>
                    <p>
                        <label>Email</label><br />
                        <input type="text" id="email" name="email" value="<?php echo $item['email']?>" class="text" size=60 />
                    </p>
                    <p>
                        <label>Số điện thoại</label><br />
                        <input type="text" id="sodienthoai" name="sodienthoai" value="<?php echo $item['sodienthoai']?>" class="text" size=60 />
                    </p>
                    <p>
                        <label>Giới tính</label><br />
                        <select id="gioitinh" name="gioitinh">
                        	<option value=""></option>
                            <?php foreach($this->document->gioitinh as $key => $val){ ?>
                            <option value="<?php echo $key?>"><?php echo $val?></option>
                            <?php } ?>
                        </select>
                    </p>
                   	
                    <p>
                        <label>Loại</label><br />
                        <select id="loai" name="loai">
                            <option value=""></option>
                            <?php foreach($loainhanvien as $val){ ?>
                            <option value="<?php echo $val['categoryid']?>"><?php echo $val['categoryname']?></option>
                            <?php } ?>
                        </select>
                    </p>
                    
                    
                    <p>
                        <label>Trình độ văn hóa</label><br />
                        <input type="text" id="trinhdovanhoa" name="trinhdovanhoa" value="<?php echo $item['trinhdovanhoa']?>" class="text" size=60 />
                    </p>
                    
                    <p>
                        <label>Quê quán</label><br />
                        <input type="text" id="quequan" name="quequan" value="<?php echo $item['quequan']?>" class="text" size=60 />
                    </p>
                    <p>
                        <label>Địa chỉ thường trú</label><br />
                        <input type="text" id="diachithuongtru" name="diachithuongtru" value="<?php echo $item['diachithuongtru']?>" class="text" size=60 />
                    </p>
                    <p>
                        <label>Địa chỉ tạm trú</label><br />
                        <input type="text" id="diachitamtru" name="diachitamtru" value="<?php echo $item['diachitamtru']?>" class="text" size=60 />
                    </p>
                    <p>
                        <label for="image">Hình</label><br />
                        <a class="button" onclick="browserFileImage()">Chọn hình</a><br />
                        
                        <img id="preview" src="<?php echo $item['imagethumbnail']?>" />
                        <input type="hidden" id="imagepath" name="imagepath" value="<?php echo $item['imagepath']?>" />
                        <input type="hidden" id="imageid" name="imageid" value="<?php echo $item['imageid']?>" />
                        <input type="hidden" id="imagethumbnail" name="imagethumbnail" value="<?php echo $item['imagethumbnail']?>" />
                   
                    </p>
                    <p>
                        <label>Chuyên môn</label><br />
                        <input type="text" id="chuyenmon" name="chuyenmon" value="<?php echo $item['chuyenmon']?>" class="text" size=60 />
                    </p>
                    
                    <p>
                        <label>Bằng cấp</label><br />
                        <input type="text" id="bangcap" name="bangcap" value="<?php echo $item['bangcap']?>" class="text" size=60 />
                    </p>
                    
                    <p>
                        <label>Ngày vào làm</label><br />
						<script language="javascript">
                            $(function() {
                                $("#ngayvaolam").datepicker({
                                        changeMonth: true,
                                        changeYear: true,
                                        dateFormat: 'dd-mm-yy'
                                        });
                                });
                         </script>
                        <input type="text" id="ngayvaolam" name="ngayvaolam" value="<?php echo $this->date->formatMySQLDate($item['ngayvaolam'])?>" class="text" size=60 />
                    </p>
                    
                    <p>
                        <label>Ngày ký hợp đồng</label><br />
						<script language="javascript">
                            $(function() {
                                $("#ngaykyhopdong").datepicker({
                                        changeMonth: true,
                                        changeYear: true,
                                        dateFormat: 'dd-mm-yy'
                                        });
                                });
                         </script>
                        <input type="text" id="ngaykyhopdong" name="ngaykyhopdong" value="<?php echo $this->date->formatMySQLDate($item['ngaykyhopdong'])?>" class="text" size=60 />
                    </p>
                    
                    
                    <p>
                        <label>BHXH</label><br />
                        <input type="text" id="bhxh" name="bhxh" value="<?php echo $item['bhxh']?>" class="text" size=60 />
                    </p>
                    
                    <p>
                        <label>BHYT</label><br />
                        <input type="text" id="bhyt" name="bhyt" value="<?php echo $item['bhyt']?>" class="text" size=60 />
                    </p>
                   
                </div>
                <div id="fragment-luong">
                	<p>
                        <label>Lương cơ bản</label><br />
                        <input type="text" class="text number" id="luongcoban" name="luongcoban" value="<?php echo $item['luongcoban']?>" class="text" size=60 />
                    </p>
                    
                    <p>
                        <label>Ngạch</label><br />
                        <input type="text" class="text" id="ngach" name="ngach" value="<?php echo $item['ngach']?>" class="text" size=60 />
                    </p>
                    <p>
                        <label>Bật lương</label><br />
                        <input type="text" class="text number" id="batluong" name="batluong" value="<?php echo $item['batluong']?>" class="text" size=60 />
                    </p>
                    <p>
                        <label>Thang</label><br />
                        <input type="text" class="text" id="thang" name="thang" value="<?php echo $item['thang']?>" class="text" size=60 />
                    </p>
                    
                    <p>
                        <label>Hệ số</label><br />
                        <input type="text" class="text number" id="heso" name="heso" value="<?php echo $item['heso']?>" class="text" size=60 />
                    </p>
                </div>
            </div>
                
            
        </form>
    
    </div>
    
</div>
<script src='<?php echo DIR_JS?>ajaxupload.js' type='text/javascript' language='javascript'> </script>


<script language="javascript">
var DIR_UPLOADPHOTO = "<?php echo $DIR_UPLOADPHOTO?>";
$(document).ready(function() { 
	
	$('#container').tabs({ fxSlide: true, fxFade: true, fxSpeed: 'slow' });
	
});
function save()
{
	$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
	$.post("?route=quanlykho/nhanvien/save", $("#frm").serialize(),
		function(data){
			if(data == "true")
			{
				window.location = "?route=quanlykho/nhanvien";
			}
			else
			{
			
				$('#error').html(data).show('slow');
				$.unblockUI();
				
			}
			
		}
	);
}
$("#gioitinh").val("<?php echo $item['gioitinh']?>");
$("#maphongban").val("<?php echo $item['maphongban']?>");
$("#chucvu").val("<?php echo $item['chucvu']?>");
$("#loai").val("<?php echo $item['loai']?>");

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
</script>
