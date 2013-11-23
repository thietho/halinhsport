<div>
	<p>Chào <?php echo $member['fullname']?></p>
    <p>Cảm ơn bạn đã đăng ký là thành viên của <?php echo $this->document->setup['Title']?></p>
    <p>
    	Để hoàn tất thủ tục đăng ký, vui lòng kích hoạt tài khoản của bạn bằng cách click vào đường link bên dưới:<br>
        <a href="<?php echo$this->document->createLink('activelink')?>?user=<?php echo $member['username']?>&code=<?php echo md5($member['activecode'])?>"><?php echo$this->document->createLink('activelink')?>?user=<?php echo $member['username']?>&code=<?php echo md5($member['activecode'])?></a>
	</p>
    <p>
    	*** Nếu link kích hoạt bên trên không thực hiện được, vui lòng mở trình duyệt lên và nhập vào link bên dưới:<br>
		<?php echo $this->document->createLink('active')?><br>
		Bạn điền tên đăng nhập và mã số kích hoạt bên dưới vào ô tương ứng sau đó kích hoạt<br>
        Tên đăng nhập của bạn là: <?php echo $member['username']?><br>
        Mã số kích hoạt của bạn là: <?php echo $member['activecode']?>
    </p>
</div>