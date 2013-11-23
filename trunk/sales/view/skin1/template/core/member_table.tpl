			<?php echo $pager?>
            <table class="data-table" cellpadding="0" cellspacing="0">
                <tbody>
                    <tr class="tr-head">
                        <th width="1%"><input class="inputchk" type="checkbox" onclick="$('input[name*=\'delete\']').attr('checked', this.checked);"></th>
                        
                        <th>Tên đăng nhập</th>
                        <th>Tên khách hàng</th>
                        <th>Số điện thoại</th>
                        <th>Địa chỉ</th>
                        <th>Email</th>
                        <th>Công nợ</th>
                        <th>Trang thái</th>
                        <?php if($dialog!=true){ ?>
                        <th width="10%">Control</th>                                  
                        <?php } ?>
                    </tr>
                    
        
        
        <?php
            foreach($users as $user)
            {
        ?>
                    <tr class="item" id="<?php echo $user['id']?>" username="<?php echo $user['username']?>" fullname="<?php echo $user['fullname']?>" phone="<?php echo $user['phone']?>" address="<?php echo $user['address']?>" email="<?php echo $user['email']?>">
                        <td class="check-column"><input class="inputchk" type="checkbox" name="delete[<?php echo $user['id']?>]" value="<?php echo $user['id']?>" ></td>
                        
                        <td><?php echo $user['username']?></td>
                        <td><?php echo $user['fullname']?></td>
                        <td><?php echo $user['phone']?></td>
                        <td><?php echo $user['address']?></td>
                        <td><?php echo $user['email']?></td>
                        <td><a onclick="viewCongNo(<?php echo $user['id']?>)"><?php echo $this->string->numberFormate($user['congno'])?></a></td>
                		<td><?php echo $this->document->userstatus[$user['status']]?></td>
                        <?php if($dialog!=true){ ?>
                        <td class="link-control">
                        	<?php if($this->user->checkPermission("core/member/update")==true){ ?>
                            <input type="button" class="button" value="<?php echo $user['text_edit']?>" onclick="window.location='<?php echo $user['link_edit']?>'"/>
                            <?php } ?>
                            <?php if($this->user->checkPermission("core/member/active")==true){ ?>
                            <input type="button" class="button" value="<?php echo $user['text_active']?>" onclick="activeUser('<?php echo $user['id']?>')"/>
                            <?php } ?>
                            
                        </td>
                        <?php } ?>
                    </tr>
        <?php
            }
        ?>
                        
                                                    
                </tbody>
			</table>
            <?php echo $pager?>
<?php if($dialog){ ?>
<script language="javascript">
	intSelectMember()
</script>
<?php } ?>