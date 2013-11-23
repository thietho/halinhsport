<div class="section" id="sitemaplist">

	<div class="section-title"><?php echo $heading_title?></div>
    
    <div class="section-content padding1">
    
    	<form name="frm" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	
     	        <a class="button" href="index.php?route=addon/order"><?php echo $button_cancel?></a>
                
            </div>
            <div class="clearer">^&nbsp;</div>
        
        	<div class="left" style="width:50%;">
            	<h3>Thông tin khách hàng</h3>
            	<p>
            		<label>Order id</label><br />
					<?php echo $order['orderid']?>
            	</p>
                <p>
            		<label><?php echo $entry_customername?></label><br />
					<?php echo $order['customername']?>
            	</p>
                <p>
            		<label><?php echo $entry_email?></label><br />
					<?php echo $order['email']?>
            	</p><p>
            		<label><?php echo $entry_address?></label><br />
					<?php echo $order['address']?>
            	</p>
                <p>
            		<label><?php echo $entry_phone?></label><br />
					<?php echo $order['phone']?>
            	</p>
                <p>
            		<label><?php echo $entry_orderdate?></label><br />
					<?php echo $this->date->formatMySQLDate($order['orderdate'])?>
            	</p>
			</div>
            <div class="left">
                <h3>Thông tin giao hàng</h3>
                <p>
            		<label>Người nhận hàng</label><br />
					<?php echo $order['receiver']?>
            	</p>
                <p>
            		<label>Số điện thoại</label><br />
					<?php echo $order['receiverphone']?>
            	</p>
               	<p>
            		<label>Địa chỉ nhận</label><br />
					<?php echo $order['shipperat']?>
            	</p>
                <p>
            		<label>Phương thức thanh toán</label><br />
					<?php echo $this->document->paymenttype[$order['paymenttype']]?>
            	</p>
                <p>
            		<label>Ghi chú</label><br />
					<?php echo $order['comment']?>
            	</p>
                <p>
            		<label>Người giao</label><br />
					<?php echo $order['shippername']?>
            	</p>
                <p>
            		<label>Ngày giao</label><br />
					<?php echo $this->date->formatMySQLDate($order['shippdate'])?>
            	</p>
                <p>
            		<label>Ghi nhớ</label><br />
					<?php echo $order['notes']?>
            	</p>
                <?php if($order['status'] != 'completed' && $order['status'] != 'cancel'){ ?>
                <p>
                	<input type="button" class="button" onclick="order.edit('<?php echo $order['orderid']?>')" value="Chỉnh sửa đơn hàng"/>
                </p>
                <?php } ?>
                <?php if($order['status'] == 'wait' || $order['status'] == 'pending'){ ?>
                <p>
                	<!--<input type="button" class="button" onclick="order.editDelivery('<?php echo $order['orderid']?>')" value="Chỉnh sửa thông tin giao hàng"/>-->
                	
                    <input type="button" class="button" onclick="order.confirmOder('<?php echo $order['orderid']?>')" value="Xác nhận đơn hàng với khách hàng"/>
                    <input type="button" class="button" onclick="order.cancel('<?php echo $order['orderid']?>')" value="Hủy"/>
                	
                    
                </p>
                <?php } ?>
                <?php if($order['status'] == 'wait'){ ?>
                <p>
                	
                    
                    <input type="button" class="button" onclick="order.pending('<?php echo $order['orderid']?>')" value="Xác với khách hàng không được"/>
                	
                    
                </p>
                <?php } ?>
                <?php if($order['status'] == 'confirmed'){ ?>
                <p>
                	<input type="button" class="button" onclick="payment()" value="Đã giao hàng"/>
                    <input type="button" class="button" onclick="order.printBill('<?php echo $order['orderid']?>')" value="In hóa đơn"/>
                    <input type="button" class="button" onclick="order.cancel('<?php echo $order['orderid']?>')" value="Hủy"/>
                </p>
                <p id="frm_thanhtoan" style="display:none">
                	<label>Tổng tiền:</label> <span id="tongtien"></span><br />
                    <label>Thanh toán:</label> <input type="text" class="text number" id="thanhtoan" name="thanhtoan"/>
                    <input type="button" class="button" id="btnTraHet" value="Trả hết"/>
                    <input type="button" class="button" id="btnThanhToan" value="Thanh toán"/>
                    
                </p>
                <?php } ?>
                <?php if($order['status'] == 'cancel'){ ?>
                	<p>
                    	<input type="button" class="button" onclick="order.reActive('<?php echo $order['orderid']?>')" value="Kích hoạt lại đơn hàng"/>
                    </p>
                <?php } ?>
                <p>
                	<label onclick="order.viewHistory('<?php echo $order['orderid']?>')">Tình trạng: <?php echo $this->document->status[$order['status']]?></label>
                </p>
                <!--
                <p>
            		<label><?php echo $entry_status?></label><br />
					<select id="status<?php echo $order['orderid']?>" onchange="order.updateStatus('<?php echo $order['orderid']?>',this.value)">
                        <?php foreach($this->document->status as $key => $val) { ?>
                        <option value="<?php echo $key?>" <?php echo ($order['status'] == $key)?'selected="selected"':''?>><?php echo $val?></option>
                        <?php } ?>
                    </select>
            	</p>
                <p>
            		<label><?php echo $entry_message?></label><br />
					<?php echo $order['comment']?>
            	</p>-->
            </div>
            <div class="clearer">^&nbsp;</div>
            <div>
            	<table>
                	<thead>
                    	<tr>
                            <th><?php echo $column_productname?></th>
                            <th><?php echo $column_productimage?></th>
                            <th><?php echo $column_productqty?></th>
                            <th>Đơn vị</th>
                            <th>Giá</th>
                            <th>Thành tiền</th>
                        </tr>
                    </thead>
                    <tbody>
                    <?php 
                    $sum = 0;
                    foreach($detail as $item)
                    {
                    	$sum += $item['subtotal'];
                    ?>
                    	<tr>
                            <td><?php echo $item['title']?></td>
                            <td><?php echo $item['imagepreview']?></td>
                            <td class="number"><?php echo $this->string->numberFormate($item['quantity'])?></td>
                            <td><?php echo $this->document->getDonViTinh($item['unit'])?></td>
                            <td class="number"><?php echo $this->string->numberFormate($item['price'])?></td>
                            <td class="number"><?php echo $this->string->numberFormate($item['subtotal'])?></td>
                        </tr>
                    <?php } ?>
                    </tbody>
                    <tfoot>
                    	<tr>
                        	<td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td class="number"><?php echo $this->string->numberFormate($sum)?></td>
                        </tr>
                    </tfoot>
                </table>
            </div>
        </form>
    
    </div>
    
</div>
<script language="javascript">
$('#btnTraHet').click(function(e) {
    $('#thanhtoan').val("<?php echo $this->string->numberFormate($sum)?>");
});
$('#btnThanhToan').click(function(e) {
    order.completed("<?php echo $order['orderid']?>",stringtoNumber($('#thanhtoan').val()));
});
function payment()
{
	$('#tongtien').html("<?php echo $this->string->numberFormate($sum)?>");
	$('#frm_thanhtoan').show();
}
</script>

