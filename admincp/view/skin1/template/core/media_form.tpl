<form id="frmQuickAddMedia">
	<input type="hidden" name="imageid" value="<?php echo $item['fileid']?>">
    <input type="hidden" name="imagepath" value="<?php echo $item['filepath']?>">
    <p>
        <label>Tiêu đề</label><br>
        <input class="text" type="text" id="title" name="title" size="60" />
    </p>
    <p>
        <label>Code</label><br>
        <input class="text" type="text" id="code" name="code"  size="60" />
    </p>
    <p>
        <label>Đơn vị</label><br>
        <select id="unit" name="unit">
            
            <option value=""></option>
            <?php foreach($donvitinh as $val){ ?>
            <option value="<?php echo $val['madonvi']?>"><?php echo $val['tendonvitinh']?></option>
            <?php } ?>
            
        </select>
    </p>
    <p>
    	<label>Loại</label><br>
        <select id="mediatype" name="mediatype">
        	<?php foreach($this->document->mediatypes as $key => $val){ ?>
            <option value="<?php echo $key?>"><?php echo $val?></option>
            <?php } ?>
        </select>
    </p>
    <p>
    	<label>Mô tả ngắn</label><br>
        <textarea class="text" rows="3" cols="70" id="summary" name="summary"></textarea>
    </p>
    
</form>