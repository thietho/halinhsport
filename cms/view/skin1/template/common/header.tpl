
<div id="top">

<div class="left text-center" id="weblogo"><a href="?route=page/home"> 
	<?php echo $imagepreview ?>
</a></div>

<div class="left">
<h2>Quản trị website</h2>

<div class="clearer">&nbsp;</div>

</div>

<div class="right text-center" id="logo"><a href="?route=page/home"> 
	<img class="png" src="<?php echo DIR_IMAGE?>logo.png" height="70px" alt="" /><br />
</a></div>

<div class="right">
	<table>
    	<tr>
        	
            <td>
            	
                <ul class="nicelist">
                	
                    <li><a href="index.php?route=quanlykho/nhanvien/profile">Logged user: <b><?php echo $username?></b></a></li>
                    <li><a href="index.php?route=common/changepassword"><?php echo $button_change_password?></a></li>
                    <?php if($this->user->getUserTypeId() == 'admin'){?>
                    <li><a href="?route=core/module">Phân quyền</a></li>
                    <?php } ?>
                    <li><a href="logout.php"><?php echo $button_logout?></a></li>
                </ul>
            </td>
        </tr>
    </table>
	
	

</div>

<div class="clearer">&nbsp;</div>

</div>
