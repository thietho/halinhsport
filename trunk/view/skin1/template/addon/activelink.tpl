<div>
	<?php if($active){ ?>
    Tài khoản đã được kích hoạt bạn hãy <a href="<?php echo $this->document->createLink('login')?>">đăng nhập</a> với tài khoản của bạn
    <?php }else{ ?>
    Mã kích hoạt không hợp lệ hoặc tài khoản của bạn đã kích hoạt rồi! Bạn hãy <a href="<?php echo $this->document->createLink('login')?>">đăng nhập</a> với tài khoản của bạn
    <?php }?>
</div>