<div class="section">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content">
    	
        <form action="" method="post" id="listitem" name="listitem">
        	
        	<div class="button right">
            	<?php if($this->user->checkPermission("addon/phieuthu/insert")==true){ ?>
                <input class="button" type="button" name="btnAdd" value="Thêm" onclick="window.location='<?php echo $insert?>'"/>  
                <?php } ?>
                <?php if($this->user->checkPermission("addon/phieuthu/delete")==true){ ?>
            	<input class="button" type="button" name="delete_all" value="Xóa" onclick="deleteorder()"/>  
                <?php } ?>
            </div>
            <div class="clearer">&nbsp;</div>
            <div id="ben-search">
            	<p>
                    <label>Số phiếu</label>
                    <input type="text" id="sophieu" name="sophieu" class="text"/>
                    <label>Ngày lập</label>
                    từ
                    <input type="text" id="tungay" name="tungay" class="text ben-datepicker" />
                    đến
                    <input type="text" id="denngay" name="denngay" class="text ben-datepicker" />
                    <label>Tên nộp tiền</label>
                    <input type="text" id="tenkhachhang" name="tenkhachhang" class="text"/>
                    <label>Số diện thoai</label>
                    <input type="text" id="dienthoai" name="dienthoai" class="text"/>
                </p>
                <p>
                	<label>Người thu</label>
                    <input type="text" id="nguoithuchien" name="nguoithuchien" class="text"/>
                    <label>Số tiền</label>
                    từ
                    <input type="text" id="sotientu" name="sotientu" class="text number" />
                    đến
                    <input type="text" id="sotienden" name="sotienden" class="text number" />
                    
                    
                    
                </p>
                <input type="button" class="button" name="btnSearch" value="Tìm" onclick="searchForm()"/>
                <input type="button" class="button" name="btnSearch" value="Xem tất cả" onclick="window.location = '?route=addon/phieuthu'"/>
            </div>
            <div class="sitemap treeindex">
                <table class="data-table" cellpadding="0" cellspacing="0">
                <tbody>
                    <tr class="tr-head">
                        <th width="1%"><input class="inputchk" type="checkbox" onclick="$('input[name*=\'delete\']').attr('checked', this.checked);"></th>
                        
                        <th>Số phiếu</th>
                        <th>Ngày lập</th>
                        <th>Số chứng từ</th>
                        <th>Tên nộp tiền</th>
                        <th>Người thu</th>
                        <th>Tài khoản thu</th>
                        <th>Số tiền</th>
                        <th></th>                                  
                    </tr>
        
        
        <?php
            foreach($datas as $item)
            {
        ?>
                    <tr>
                        <td class="check-column"><input class="inputchk" type="checkbox" name="delete[<?php echo $item['maphieu']?>]" value="<?php echo $item['maphieu']?>" ></td>
                        <td><a onclick="view('<?php echo $item['maphieu']?>')"><?php echo $item['sophieu']?></a></td>
                        <td><?php echo $this->date->formatMySQLDate($item['ngaylap'])?></td>
                        <td><?php echo $item['chungtulienquan']?></td>
                        <td><?php echo $item['tenkhachhang']?></td>
                        
                        <td><?php echo $item['nguoithuchien']?></td>
                        <td>
                        	<?php echo $this->document->getCategory($item['taikhoanthuchi'])?>
                            <?php if($item['lydo']) echo " - ".$item['lydo']?>
                        </td>
                        <td class="number"><?php echo $this->string->numberFormate($item['sotien'])?></td>
                        <td class="link-control">
                        	<?php if($this->user->checkPermission("addon/phieuthu/update")==true){ ?>
                            <input type="button" class="button" name="btnEdit" value="Sửa" onClick="window.location='<?php echo $item['link_edit']?>'">
                           	<?php } ?>
                        </td>
                    </tr>
        <?php
            }
        ?>
                        
                                                    
                </tbody>
                </table>
            </div>
        	<?php echo $pager?>
        
        </form>
        
    </div>
    
</div>
<script language="javascript">
function deleteorder()
{
	var answer = confirm("Bạn có muốn xóa không?")
	if (answer)
	{
		$.post("?route=addon/phieuthu/delete", 
				$("#listitem").serialize(), 
				function(data)
				{
					if(data!="")
					{
						alert("Xóa thành công")
						window.location.reload();
					}
				}
		);
	}
}
function view(maphieu)
{
	$("#popup").attr('title','Chọn khách hàng');
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
						'In': function(){
							openDialog("?route=addon/phieuthu/view&maphieu="+maphieu+"&dialog=print",800,500)
							
						},
					}
				});
			
				
	$("#popup-content").load("?route=addon/phieuthu/view&maphieu="+maphieu+"&dialog=true",function(){
		$("#popup").dialog("open");	
	});
}
function searchForm()
{
	var url =  "?route=addon/phieuthu";
	if($("#sophieu").val() != "")
		url += "&sophieu=" + $("#sophieu").val();
	if($("#tungay").val() != "")
		url += "&tungay="+ $("#tungay").val();
	if($("#denngay").val() != "")
		url += "&denngay="+ $("#denngay").val();
	if($("#tenkhachhang").val() != "")
		url += "&tenkhachhang="+ $("#tenkhachhang").val();
	if($("#nguoithuchien").val() != "")
		url += "&nguoithuchien="+ $("#nguoithuchien").val();
	if($("#dienthoai").val() != "")
		url += "&dienthoai="+ $("#dienthoai").val();
	if(parseFloat($("#sotientu").val()) != 0)
		url += "&sotientu=" + $("#sotientu").val();
	if(parseFloat($("#sotienden").val()) != 0)
		url += "&sotienden=" + $("#sotienden").val();
	
	window.location = url;
}

$("#sophieu").val("<?php echo $_GET['sophieu']?>");
$("#tungay").val("<?php echo $_GET['tungay']?>");
$("#denngay").val("<?php echo $_GET['denngay']?>");
$("#tenkhachhang").val("<?php echo $_GET['tenkhachhang']?>");
$("#nguoithuchien").val("<?php echo $_GET['nguoithuchien']?>");
$("#dienthoai").val("<?php echo $_GET['dienthoai']?>");
$("#sotientu").val("<?php echo $_GET['sotientu']?>");
$("#sotienden").val("<?php echo $_GET['sotienden']?>");

</script>