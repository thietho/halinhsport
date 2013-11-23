<div class="section" id="sitemaplist">

	
    
    <div class="section-content padding1">
    	<div class="error hidden"></div>
       <form id="fchangepass" name="f" action="" method="post">
            
            <div class="profile">
            	
                <p>
                	<label><?php echo $text_currentpassword ?></label><br />
					<b><input class="text" size="50" name="oldpassword" type="password" value=""/></b>
                </p>
                
                <p>
                	<label><?php echo $text_newpassword ?></label><br />
					<b><input class="text" size="50" name="newpassword" type="password"/></b>
                </p>
                
                <p>
                	<label><?php echo $text_confirmnewpassword ?></label><br />
					<b><input class="text" size="50" name="confirmpassword" type="password"/></b>
                </p>
            </div>
        
        </form>
    </div>

</div>

<script language="javascript">
function changePass()
{
	$.blockUI({ message: "<h1><?php echo $announ_infor ?></h1>" }); 
	$.post('?route=common/changepassword/update', $("#fchangepass").serialize(), function(data){
		if(data=="true")
		{
			//$.blockUI({ message: "<h1>Your password has been changed</h1>" }); 
			alert("<?php echo $announ_changepass ?>");
			$("#popup").dialog("close");
		}
		else
		{
			$(".error").html(data).show('slow');
			
		}
		$.unblockUI();
	});	
}
</script>
      