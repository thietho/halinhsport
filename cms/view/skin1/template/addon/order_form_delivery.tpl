<form id="frmDelivery">
	<input type="hidden" name="orderid" value="<?php echo $_GET['orderid']?>" />
	<table class="ben-form">
        <tr>
            <td>Người nhận hàng</td>
            <td><input type="text" id="receiver" name="receiver" class="text" size="40" ></td>
        </tr>
        <tr>
            <td>Số điện thoại</td>
            <td><input type="text" id="receiverphone" name="receiverphone" class="text" size="40" <?php echo $readonly?>></td>
        </tr>
        <tr>
            <td>Địa chỉ giao hàng</td>
            <td><input type="text" id="shipperat" name="shipperat" class="text" size="40" ></td>
        </tr>
    </table>
</form>