<form id="frm_folder">
	<input type="hidden" name="folderid" value="<?php echo $item['folderid']?>"/>
    
    <p>
    	<label>Thư mục cha</label>
        <select id="folderparent" name="folderparent">
        	<option value="0">Root</option>
            <?php foreach($treefolder as $val){ ?>
            <option value="<?php echo $val['folderid']?>"><?php echo $this->string->getPrefix("&nbsp;&nbsp;&nbsp;&nbsp;",$val['level']) ?><?php echo $val['foldername']?></option>
            <?php } ?>
         </select>
    </p>
    <p>
        <label>Tên thư mục</label>
        <input type="text" class="text" id="foldername" name="foldername" value="<?php echo $item['foldername']?>"/>
    </p>
    
</form>
<script language="javascript">
$(document).ready(function(e) {
	
    $('#folderparent').val("<?php echo $item['folderparent']?>");
});

</script>