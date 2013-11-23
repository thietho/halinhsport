<?php foreach($medias as $media){ ?>
<?php if(count($media['child'])==0){ ?>
<div class="product-item left price-item" ref="<?php echo $media['mediaid']?>" image="<?php echo $media['imagepreview']?>" code="<?php echo $media['code']?>" unit="<?php echo $media['unit']?>" title="<?php echo $media['title']?><?php if($media['color']!="") echo '('.$media['color'].')' ?>" price="<?php echo $media['price']?>" pricepromotion="<?php echo $media['pricepromotion']?>" style="background:url('<?php echo $media['imagepreview']?>') no-repeat center center;">
    <input type="hidden" class="listid" value="<?php echo $media['mediaid']?>">
	<table height="100%">
    	
        <tr valign="middle">
        	<td align="center">
            	<?php echo $media['title']?>(<?php echo $this->document->getDonViTinh($media['unit'])?>)<br />
                <?php if($media['code']!="") echo $media['code']."<br>"?>
                <?php if($media['color']!="") echo "Màu: ".$media['color']."<br>"?>
                Giá: <?php echo $this->string->numberFormate($media['price'])?><br />
                Giá khuyến mãi: <?php echo $this->string->numberFormate($media['pricepromotion'])?>
            </td>
        </tr>
    </table>
</div>
<?php }?>
<?php if(count($media['child'])){ ?>
<?php foreach($media['child'] as $item){ ?>
<div class="product-item left price-item" ref="<?php echo $item['mediaid']?>" image="<?php echo $item['imagepreview']?>" code="<?php echo $item['code']?>" color="<?php echo $item['color']?>" unit="<?php echo $item['unit']?>" title="<?php echo $item['title']?>" price="<?php echo $item['price']?>" pricepromotion="<?php echo $item['pricepromotion']?>" style="background:url('<?php echo $item['imagepreview']?>') no-repeat center center;">
    <input type="hidden" class="listid" value="<?php echo $item['mediaid']?>">
	<table height="100%">
    	
        <tr valign="middle">
        	<td align="center">
            	<?php echo $item['title']?>(<?php echo $this->document->getDonViTinh($item['unit'])?>)<br>
                <?php if($item['code']!="") echo $item['code']."<br>"?>
                <?php if($media['color']!="") echo "Màu: ".$item['color']."<br>"?>
                <br />
                Giá: <?php echo $this->string->numberFormate($item['price'])?><br />
                Giá khuyến mãi: <?php echo $this->string->numberFormate($item['pricepromotion'])?>
            </td>
        </tr>
    </table>
</div>
<?php } ?>
<?php } ?>
<?php } ?>
<div class="clearer">^&nbsp;</div>
