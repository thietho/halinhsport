<div class="section">

	<div class="section-title"><?php echo $header_title_user ?></div>
    
    <div class="section-content">
    	
        <form action="" method="post" id="listuser" name="listuser">
        
        	<div class="button right">
                <input class="button" value="<?php echo $button_add ?>" type="button" onclick="linkto('<?php echo $insert?>')">
            	<input class="button" type="button" name="delete_all" value="<?php echo $button_delete ?>" onclick="deleteUser()"/>  
            </div>
            <div class="clearer">^&nbsp;</div>
            
            <div class="sitemap treeindex">
                <table class="data-table" cellpadding="0" cellspacing="0">
                <tbody>
                    <tr class="tr-head">
                        <th width="1%"><input class="inputchk" type="checkbox" onclick="$('input[name*=\'delete\']').attr('checked', this.checked);"></th>
                        
                        <th width="25%"><?php echo $lbl_username ?></th>
                        <th width="25%"><?php echo $text_fullname?></th>
                        <th width="25%"><?php echo $text_status ?></th>                    
                        <th width="20%"><?php echo $text_control ?></th>                                  
                    </tr>
        
        
        <?php
            foreach($users as $user)
            {
        ?>
                    <tr>
                        <td class="check-column"><input class="inputchk" type="checkbox" name="delete[<?php echo $user['userid']?>]" value="<?php echo $user['userid']?>" ></td>
                        
                        <td><?php echo $user['username']?></td>
                        <td><?php echo $user['fullname']?></td>
                		<td><?php echo $user['text_st']?></td>
                        <td class="link-control">
                            <a class="button" href="<?php echo $user['link_edit']?>" title="<?php echo $user['text_edit']?>"><?php echo $user['text_edit']?></a>
                            <a class="button" onclick="activeUser('<?php echo $user['userid']?>')" ><?php echo $user['text_active']?></a>
                        </td>
                    </tr>
        <?php
            }
        ?>
                        
                                                    
                </tbody>
                </table>
            </div>
        	<?php echo $pager?>
        
        </form>
        
    </div>
    
</div>
<script language="javascript">
function activeUser(userid)
{
	$.ajax({
			url: "?route=core/user/active&userid="+userid,
			cache: false,
			success: function(html){
			alert(html)
			linkto("?<?php echo $refres?>")
		  }
	});
}

function deleteUser()
{
	var answer = confirm("<?php echo $announ_del ?>")
	if (answer)
	{
		$.post("?route=core/user/delete", 
				$("#listuser").serialize(), 
				function(data)
				{
					if(data!="")
					{
						alert(data)
						linkto("?<?php echo $refres?>")
					}
				}
		);
	}
}
</script>