<div>
    <input type="hidden" name="price_mediaid" id="price_mediaid" value="<?php echo $media['mediaid']?>"/>
    <p>
        Code sản phẩm:<br />
        <input class="text" type="text" name="price_code" id="price_code" value="<?php echo $media['code']?>" size="40"/> <!--<input type="button" class="button" value="Lấy giá" onclick="price.loadPrice($('#price_code').val())" />-->
    </p>
    <p>
        <label>Qui cách</label><br>
        <textarea cols="50" rows="4" class="text" id="price_sizes" name="price_sizes"><?php echo $media['sizes']?></textarea>
    </p>
    <p>
        <label>Đơn vị</label><br>
        <select id="price_unit" name="price_unit">
            
            <option value=""></option>
            <?php foreach($donvitinh as $val){ ?>
            <option value="<?php echo $val['madonvi']?>"><?php echo $val['tendonvitinh']?></option>
            <?php } ?>
            
        </select>
        <script language="javascript">
            $('#unit').val("<?php echo $media['unit']?>");
        </script>
    </p>
    <p>
        <?php echo $lbl_title ?><br />
        <input class="text" type="text" name="price_title" id="price_title" value="<?php echo $media['title']?>" size="40" />
    </p>
    
      <p>
        <?php echo $lbl_sale ?><br />
        <input class="text number" type="text" name="price_khuyenmai" id="price_khuyenmai" value="" size="40" />
    </p>
    <p>
        <?php echo $lbl_price ?><br />
        <input class="text number" type="text" name="price_gia" id="price_gia" value="<?php echo $media['price']?>" size="40" />
    </p>

    
</div>
<script language="javascript">
numberReady();
</script>