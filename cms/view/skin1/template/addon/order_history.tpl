<div>
	Đơn hàng đặt hàng: <?php echo $this->date->formatMySQLDate($order['orderdate'])?> <?php echo $this->date->getTime($order['orderdate'])?>
    <table>
    	<?php foreach($historys as $item){ ?>
    	<tr>
        	<td><?php echo $this->date->formatMySQLDate($item['actiondate'])?> <?php echo $this->date->getTime($item['actiondate'])?></td>
            <td><?php echo $item['userid']?></td>
            <td class="order-<?php echo $item['status']?>"><?php echo $this->document->status[$item['status']]?></td>
        </tr>
        <?php } ?>
    </table>
    
</div>