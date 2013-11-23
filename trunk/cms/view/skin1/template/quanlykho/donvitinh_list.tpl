<div class="section">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content">
    	
        <form action="" method="post" id="listitem" name="listitem">
        
        	<div class="button right">
            	<?php if($this->user->checkPermission("quanlykho/donvitinh/insert")==true){ ?>
                <input class="button" value="Thêm" type="button" onclick="linkto('<?php echo $insert?>')">
                <?php } ?>
                <?php if($this->user->checkPermission("quanlykho/donvitinh/delete")==true){ ?>
            	<input class="button" type="button" name="delete_all" value="Xóa" onclick="deleteitem()"/>
                <?php } ?>
            </div>
            <div class="clearer">^&nbsp;</div>
            
            <div class="sitemap treeindex">
                <table class="data-table" cellpadding="0" cellspacing="0">
                <tbody>
                    <tr class="tr-head">
                        <th width="1%"><input class="inputchk" type="checkbox" onclick="$('input[name*=\'delete\']').attr('checked', this.checked);"></th>
                        
                        <th width="25%">Mã đơn vị</th>
                        <th width="25%">Tên đơn vị</th>
                        <th width="25%">Quy đổi</th>
                        <th width="25%">Đơn vị qui đổi</th>                    
                        <th width="10%">Control</th>                                  
                    </tr>
        
        
        <?php
            foreach($datas as $item)
            {
        ?>
                    <tr>
                        <td class="check-column"><input class="inputchk" type="checkbox" name="delete[<?php echo $item['madonvi']?>]" value="<?php echo $item['madonvi']?>" ></td>
                        
                        <td><?php echo $item['madonvi']?></td>
                        <td><?php echo $item['tendonvitinh']?></td>
                        <td class="number"><?php echo $this->string->numberFormate($item['quidoi'])?></td>
                		<td>
                        	<?php echo $this->document->getDonViTinh($item['madonviquydoi'])?>
                            <?php if($item['madonviquydoi']!=""){ ?>
                            (<?php echo $item['madonviquydoi']?>)
                            <?php } ?>
                        </td>
                        <td class="link-control">
                        	<?php if($this->user->checkPermission("quanlykho/donvitinh/update")==true){ ?>
                            <a class="button" href="<?php echo $item['link_edit']?>" title="<?php echo $item['text_edit']?>"><?php echo $item['text_edit']?></a>
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

function deleteitem()
{
	var answer = confirm("Bạn có muốn xóa không?")
	if (answer)
	{
		$.post("?route=quanlykho/donvitinh/delete", 
				$("#listitem").serialize(), 
				function(data)
				{
					if(data!="")
					{
						alert(data);
						window.location.reload();
					}
				}
		);
	}
}


</script>