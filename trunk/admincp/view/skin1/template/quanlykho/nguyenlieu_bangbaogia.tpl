<div class="section">

<div class="section-title"><?php echo $this->document->title?></div>

<div class="section-content">

<form action="" method="post" id="listitem" name="listitem">

<div class="button right"> 
	<input class="button" value="Thêm báo giá" type="button" onclick="linkto('<?php echo $insert?>')">
    <input class="button" type="button" name="delete_all" value="Xóa" onclick="deleteitem()" />
</div>
<div class="clearer">^&nbsp;</div>

<div class="sitemap treeindex">
<table class="data-table" cellpadding="0" cellspacing="0">
	<thead>
		<tr class="tr-head">
			<th width="1%">
            	<input class="inputchk" type="checkbox" onclick="$('input[name*=\'delete\']').attr('checked', this.checked);">
			</th>
			<th>STT</th>
			<th>Ngày</th>
			<th>Nhà cung ứng</th>

			
			<th>Control</th>
			
		</tr>
	</thead>
	<tbody>


	<?php
	foreach($datas as $key => $item)

	{
		?>
		<tr>
			<td class="check-column"><input class="inputchk" type="checkbox"
				name="delete[<?php echo $item['id']?>]"
				value="<?php echo $item['id']?>"></td>
			<td><?php echo $key+1 ?></td>
			<td><?php echo $this->date->formatMySQLDate($item['ngay'])?></td>
			<td><?php echo $this->document->getnhaCungUng($item['manhacungung'])?></td>

			
			<td class="link-control">
            	<input type="button" class="button" name="btnEdit" value="<?php echo $item['text_edit']?>" onclick="window.location='<?php echo $item['link_edit']?>'" />
           	</td>
			
		</tr>
		<?php
	}
	?>


	</tbody>
</table>
</div>
	<?php echo $pager?></form>

</div>

</div>
<script language="javascript">

function deleteitem()
{
	var answer = confirm("Bạn có muốn xóa không?")
	if (answer)
	{
		$.post("?route=quanlykho/nguyenlieu/deletedBangBaoGia", 
				$("#listitem").serialize(), 
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

</script>
