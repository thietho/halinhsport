                                <table>
                                	<thead>
                                    	<tr>
                                        	<th>Code</th>
                                        	<th><?php echo $lbl_title ?></th>
                                           	
                                            
                                            <th><?php echo $lbl_sale ?></th>
                                            <th><?php echo $lbl_price ?></th>
                                            <th><?php echo $lbl_order ?></th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody>
<?php
	foreach($child as $item)
    {
?>
                                        <tr>
                                            <td>
                                                <?php echo $item['code']?>
                                                
                                            </td>
                                            <td>
                                                <?php echo $item['title']?>
                                                <?php if($item['tenkhuyenmai']){ ?>
                                                (<?php echo $item['tenkhuyenmai']?>)
                                                <?php } ?>
                                            </td>
                                            
                                            
                                            <td class="number"><?php echo $this->string->numberFormate($item['pricepromotion'])?></td>
                                            <td class="number"><?php echo $this->string->numberFormate($item['price'])?></td>
                                            <td>
                                                <input type="text" class="text number price" id="pos-<?php echo $item['mediaid']?>" name="pos[<?php echo $item['mediaid']?>]" value="<?php echo $item['position']?>" size="3" style="text-align:right"/>
                                            </td>
                                            
                                            <td>
                                                
                                                <a class="button editprice" rel="<?php echo $item['mediaid']?>"><?php echo $button_edit ?></a>
                                                <a class="button delprice" rel="<?php echo $item['mediaid']?>"><?php echo $button_delete ?></a>
                                            </td>
                                            
                                        </tr>
<?php
	}
?>                                    
                                    </tbody>
                                	<tfoot>
                                    	<tr>
                                        	<td colspan="3">
                                            	<center>
                                                	<input type="button" class="button" id="btnUpdatePrice" name="btnUpdatePos"  value="<?php echo $button_updateposition ?>" />
                                                    <input type="hidden" name="mainprice" value="<?php echo $child[0]['mainprice']?>" />
                                                </center>
                                            </td>
                                        </tr>
                                    </tfoot>
                                </table>
<script language="javascript">
$(document).ready(function() {
	numberReady();
})

$("#btnUpdatePrice").click(function(){
	$(".price").each(function(index){
		var arr = this.id.split('-');
		var mediaid = arr[1];
		var pos = $(this).val().replace(/,/g,"");
		$.post("?route=core/postcontent/updatePos", 
					{
						mediaid : mediaid, 
						position : pos
					},
		function(data){
			if(data=="true")
			{
				
			    $("#pricelist").load("?route=core/postcontent/loadPrice&mediaid="+$("#mediaid").val());

			}
		});
	})
});
$('.editprice').click(function(e) {
	var mediaid = $(this).attr('rel');
    price.showFormPrice(mediaid);
});
$('.delprice').click(function(e) {
    var mediaid = $(this).attr('rel');
    price.remove(mediaid);
});
</script>