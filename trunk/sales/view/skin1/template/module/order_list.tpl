<table>
	<tr>
    	<th>Mã đơn hàng</th>
        <th>Thời gian mua</th>
        <th>Số tiền phải trả</th>
    </tr>
	<?php foreach($group as $data_order){ ?>
    <tr>
    	<td><strong><?php echo $data_order[0]['customername']?></strong></td>
    </tr>
    <?php $sum = 0;?>
    <?php foreach($data_order as $order){ ?>
    	<?php $sum += $order['total'];?>
    <tr>
    	<td>
    		<input type="button" class="button btnSeleteOrder" orderid="<?php echo $order['id']?>"value="<?php echo $order['code']?>">
        </td>
        <td>
        	<?php echo $this->date->formatMySQLDate($order['createtime'],'longdate')?>
        </td>
        <td class="number">
        	<?php echo $this->string->numberFormate($order['total'])?>
        </td>
    </tr>
    <?php }?>
    <tr>
    	<td colspan="2" align="right">Tổng cộng</td>
        <td class="number">
        	<?php echo $this->string->numberFormate($sum)?>
        </td>
    </tr>
    <?php }?>
</table>
<script language="javascript">
$('.btnSeleteOrder').click(function(e) {
    pro.loadOrder($(this).attr('orderid'));
});
</script>
    

