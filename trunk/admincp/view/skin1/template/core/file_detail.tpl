<div>
	<label>File name:</label> <?php echo $item['filename']?><br>
    <label>File path:</label> <?php echo $item['filepath']?><br>
    <label>Link:</label> <?php echo HTTP_IMAGE.$item['filepath']?><br>
    <label>File extension:</label> <?php echo $item['extension']?><br>
    <label>File filesize:</label> <?php echo $this->string->numberFormate($item['filesize'],2)?>K<br>
    <input type="hidden" id="filepath" value="<?php echo HTTP_IMAGE.$item['filepath']?>">
    <?php if($item['imagepreview']){ ?>
    <img src="<?php echo $item['imagepreview']?>" />
    <?php } ?>
</div>