<table class="data-table">
	<tr>
    	<th>Code</th>
        <th>Tên sản phẩm</th>
        <th>Màu</th>
        <th>Giá</th>
        <th>Giảm</th>
        <th>Giá khuyến mãi</th>
        <th>Số lượng</th>
        <th>Hình</th>
    </tr>
    
    <?php 
    if(count($medias))
    	foreach($medias as $media){ ?>
    <tr class="item" mediaid="<?php echo $media['mediaid']?>">
    	<td><?php echo $media['code']?></td>
        <td><?php echo $media['title']?></td>
        <td><?php echo $media['color']?></td>
        
        <td class="number">
            <b><?php echo $this->string->numberFormate($media['price'])?></b>
        </td>
        <td class="number">
            <b><?php echo $this->string->numberFormate($media['discountpercent'])?>%</b>
        </td>
        <td class="number">
            <b><?php echo $this->string->numberFormate($media['pricepromotion'])?>%</b>
        </td>
        <td class="number">
        	<input type="text" class="text number short qty" name="qty[<?php echo $media['mediaid']?>]" value="<?php echo $media['qty']?>" mediaid="<?php echo $media['mediaid']?>"/>
        </td>
        <td><img src="<?php echo $media['imagepreview']?>"></td>
    </tr>
    <?php } ?>
</table>
<script language="javascript">
$(document).ready(function(e) {
    numberReady();
});
$('.item').click(function(e) {
	if($(this).hasClass('itemselected'))
		$(this).removeClass('itemselected');
	else
    	$(this).addClass('itemselected');
});
$('.qty').change(function(e) {
    var mediaid = $(this).attr('mediaid');
	var qty = this.value;
	$.get("?route=module/product/updateQty",{
		mediaid:mediaid,
		qty:qty
	});
});
</script>