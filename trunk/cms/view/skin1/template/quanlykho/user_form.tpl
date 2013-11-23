<div class="section" id="sitemaplist">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content padding1">
    
    	<form id="frm" name="frm" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        	
        	<div class="button right">
            	<input type="button" value="Lưu" class="button" onclick="save()"/>
     	        <input type="button" value="Bỏ qua" class="button" onclick="linkto('<?php echo $cancel?>')"/>   
     	        <input type="hidden" name="userid" value="<?php echo $user['userid']?>" />   
                <input type="hidden" name="nhanvienid" value="<?php echo $nhanvien['id']?>" />   
            </div>
			<div class="clearer">^&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
        	<div>
            	
                <p>
                	<label>Mã nhân viên</label><br />
                    <label><?php echo $nhanvien['manhanvien']?></label>
                </p>
                
                 <p>
                	<label>Họ tên</label><br />
                    <label><?php echo $nhanvien['hoten']?></label>
                </p>
                
            	<p>
            		<label>User name</label><br />
					<input type="text" id="username" name="username" value="<?php echo $user['username']?>" class="text" size=60 <?php echo $usernamereadonly?>/>
                    
            	</p>
              	<?php if($haspass){?>
                <p>
            		<label>Password</label><br />
					<input type="password" id="password" name="password" value="<?php echo $user['password']?>" class="text" size=60 />
                    
            	</p>
                <p>
            		<label>Confrim password</label><br />
					<input type="password" id="confrimpassword" name="confrimpassword" value="<?php echo $user['confrimpassword']?>" class="text" size=60 />
                    
            	</p>
                <?php }?>
                <p>
            		<label>User type</label><br />
					<select id="usertypeid" name="usertypeid">
                    <?php
                        foreach($usertype as $item)
                        {
                            $sel="";
                            if($user['usertypeid'] == $item['usertypeid'])
                                $sel='selected="selected"';
                    ?>
						<option value="<?php echo $item['usertypeid']?>" <?php echo $sel?>><?php echo $item[usertypename]?></option>
                    <?php
                        }
                    ?>
                    </select>
            	</p>
            </div>
            
        </form>
    
    </div>
    
</div>

<script language="javascript">
function save()
{
	$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
	$.post("?route=quanlykho/nhanvien/saveuser", $("#frm").serialize(),
		function(data){
			if(data == "true")
			{
				window.location = "?route=quanlykho/nhanvien";
			}
			else
			{
			
				$('#error').html(data).show('slow');
				$.unblockUI();
				
			}
			
		}
	);
}


</script>