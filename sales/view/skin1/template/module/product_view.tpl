<h2><?php echo $media['title']?>(<?php echo $media['code']?>)</h2>
<?php if(count($media['saleprice'])){ ?>
<strong>Giá:</strong>
	<?php foreach($media['saleprice'] as $madonvi => $price){ ?>
    <p>
        <input type="button" class="button orderpro" value="<?php echo $this->string->numberFormate($price)?>/<?php echo $this->document->getDonViTinh($madonvi)?>" mediaid="<?php echo $media['mediaid']?>" code="<?php echo $media['code']?>" title="<?php echo $media['title']?>" price="<?php echo $price?>" unit="<?php echo $madonvi?>">
    </p>
	<?php } ?>
<?php }else{ ?>
Chưa cài đặt giá
<?php } ?>