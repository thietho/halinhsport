<h3>Số dư đầu kỳ: <?php echo $this->string->numberFormate($tonkytruoc)?></h3>
<table class="data-table">
	<thead>
        <tr>
        	<th colspan="4">Thu</th>
            <th colspan="4">Chi</th>
        </tr>
        <tr>
        	<th>Mã phiếu</th>
        	<th>Loại</th>
        	<th>Công nợ</th>
            <th>Số tiền</th>
            <th>Mã phiếu</th>
            <th>Loại</th>
            <th>Công nợ</th>
            <th>Số tiền</th>
            
        </tr>
    </thead>
    <tbody>
    	
    	<?php foreach($data_thuchi as $date => $item){ ?>
        <tr>
        	<td colspan="6"><strong><?php echo $this->date->formatMySQLDate($date)?></strong></td>
        </tr>
        	<?php $max = max(count($item['thu']),count($item['chi']))?>
        	<?php for($i=0;$i < $max;$i++){ ?>
        <tr class="item">
        	<td><?php echo $item['thu'][$i]['maphieu']?></td>
            <td><?php echo $item['thu'][$i]['loai']?></td>
            <td class="number"><?php echo $this->string->numberFormate($item['thu'][$i]['congno'])?></td>
            <td class="number"><?php echo $this->string->numberFormate($item['thu'][$i]['sotien'])?></td>
            <td><?php echo $item['chi'][$i]['maphieu']?></td>
            <td><?php echo $item['chi'][$i]['loai']?></td>
            <td class="number"><?php echo $this->string->numberFormate($item['chi'][$i]['congno'])?></td>
            <td class="number"><?php echo $this->string->numberFormate($item['chi'][$i]['sotien'])?></td>
        </tr>
            <?php } ?>
        <?php } ?>
        <tr class="item">
        	<td colspan="3" align="right">Tổng thu</td>
            <td class="number"><?php echo $this->string->numberFormate($tongthu)?></td>
            <td colspan="3" align="right">Tổng chi</td>
            <td class="number"><?php echo $this->string->numberFormate($tongchi)?></td>
        </tr>
    </tbody>
</table>

<h3>Số dư trong kỳ: <?php echo $this->string->numberFormate($tontrongky)?></h3>
<h3>Số dư cuối kỳ: <?php echo $this->string->numberFormate($tontrongky + $tonkytruoc)?></h3>
<h2>Tổng kết thu</h2>
<table class="data-table">
	<thead>
        <tr>
            <th width="40%">Danh mục thu</th>
            <th width="30%">Tổng thu</th>
            <th width="30%">Tỷ lệ</th>
        </tr>
    </thead>
    <tbody>
	<?php foreach($taikhoanthu as $tk => $sotien){ ?>
    	<tr class="item">
        	<td><?php echo $this->document->getCategory($tk)?></td>
            <td class="number"><?php echo $this->string->numberFormate($sotien)?></td>
            <td class="number"><?php echo @$this->string->numberFormate($sotien/$tongthu*100,2)?>%</td>
        </tr>
    <?php }?>
    </tbody>
</table>
<h2>Tổng kết chi</h2>
<table class="data-table">
	<thead>
        <tr>
            <th width="40%">Danh mục chi</th>
            <th width="30%">Tổng chi</th>
            <th width="30%">Tỷ lệ</th>
        </tr>
    </thead>
    <tbody>
	<?php foreach($taikhoanchi as $tk => $sotien){ ?>
    	<tr class="item">
        	<td><?php echo $this->document->getCategory($tk)?></td>
            <td class="number"><?php echo $this->string->numberFormate($sotien)?></td>
            <td class="number"><?php echo @$this->string->numberFormate($sotien/$tongchi*100,2)?>%</td>
        </tr>
    <?php }?>
    </tbody>
</table>