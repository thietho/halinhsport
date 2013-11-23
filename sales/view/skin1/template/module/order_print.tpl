<h2><center>Phiếu tính tiền</center></h2>
<h4>Mã đơn hàng: <?php echo $order['code']?></h4>

Khách hàng: <span id="customernametext"><?php echo $order['customername']?></span>

<table>
    
    <tbody>
    	<?php $sum = 0;?>
    	<?php foreach($data_ct as $ct){ ?>
        <?php $sum += $ct['subtotal']?>
        <tr class="orderrow" ctid="<?php echo $ct['id']?>">
        	
        	<td>
            	<?php echo $ct['title']?>
            	
            	
            </td>
            <td class="number">
            	<?php echo $this->string->numberFormate($ct['quantity'])?>
            	
                
            	
                
                
            </td>
            <td><?php echo $this->document->getDonViTinh($ct['unit'])?></td>
            <td class="number"><?php echo $this->string->numberFormate($ct['price'])?></td>
            <td class="number"><?php echo $this->string->numberFormate($ct['subtotal'])?></td>
        </tr>
        <?php } ?>
        <tr>
        	<td colspan="4" align="right">Tổng</td>
            <td class="number"><?php echo $this->string->numberFormate($sum)?></td>
        </tr>
        <?php if($order['discountpercent']){ ?>
        <tr>
        	<td colspan="4" align="right">
            	Giảm giá%
            </td>
            <td class="number" id="discountpercentshow"><?php echo $this->string->numberFormate($order['discountpercent'])?></td>
        </tr>
        <?php } ?>
        <?php if($order['discount']){ ?>
        <tr>
        	<td colspan="4" align="right">Số tiền giảm</td>
            <td class="number" id="discount"><?php echo $this->string->numberFormate($order['discount'])?></td>
        </tr>
        <?php } ?>
        <tr>
        	<td colspan="4" align="right">Tổng tiền</td>
            <td class="number" id="finaltotal"><?php echo $this->string->numberFormate($order['total'])?></td>
        </tr>
        <?php if($order['payment']){ ?>
        <tr>
        	<td colspan="4" align="right">
            	Khách hàng trả
                
            </td>
            <td class="number" id="paymentshow"><?php echo $this->string->numberFormate($order['payment'])?></td>
        </tr>
        <tr>
        	<td colspan="4" align="right">
            	Thối lại
                
            </td>
            <td class="number" id="remainshow"><?php echo $this->string->numberFormate($order['remain'])?></td>
        </tr>
        <?php }?>
    </tbody>
</table>

