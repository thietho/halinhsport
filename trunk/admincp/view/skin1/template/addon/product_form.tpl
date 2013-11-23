<form id="frmQuickAddProduct">
	<input type="hidden" id="mediatype" name="mediatype" value="module/product" >
    <p>
        <label>Tên sản phẩm</label><br>
        <input class="text" type="text" id="title" name="title" size="60" />
    </p>
    <p>
        <label>Code</label><br>
        <input class="text" type="text" id="code" name="code"  size="60" />
    </p>
    <p>
        <label>Màu sắc</label><br>
        <input class="text" type="text" id="color" name="color"  size="60" />
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
    	<label>Mô tả ngắn</label><br>
        <textarea class="text" rows="3" cols="70" id="summary" name="summary"></textarea>
    </p>
</form>