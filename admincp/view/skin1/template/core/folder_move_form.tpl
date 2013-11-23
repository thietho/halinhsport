<label>Chọn thư mục</label><br />
<select id="desfolder">
	<option value="0">Root</option>
	<?php foreach($treefolder as $item){ ?>
    <option value="<?php echo $item['folderid']?>"><?php echo $this->string->getPrefix("&nbsp;&nbsp;&nbsp;&nbsp;",$item['level']) ?><?php echo $item['foldername']?></option>
    <?php } ?>
</select>