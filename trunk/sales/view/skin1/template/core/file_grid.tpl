<?php if(count($files)){ ?>

<?php echo $pager?>
<div class="clearer">^&nbsp;</div>
<?php if($_GET['edit']=='true'){ ?>
<div>
	<input type="checkbox" id="chkAll"/> Seleted all
</div>
<?php } ?>
<?php foreach($files as $file){ ?>
<div class="filelist left text-center" id="<?php echo $file['fileid']?>" imagethumbnail="<?php echo $file['imagethumbnail']?>" filename="<?php echo $file['filename']?>" filepath="<?php echo $file['filepath']?>">
	<img src="<?php echo $file['imagethumbnail']?>" />
	<p class="filename"><?php echo $file['filename']?></p>
    <?php if($_GET['edit']=='true'){ ?>
    <p><input type="checkbox" class="chkfile" name="chkfile[]" value="<?php echo $file['fileid']?>"></p>
    <?php } ?>
</div>
<?php } ?>

<div class="clearer">^&nbsp;</div>
<?php } ?>
<?php if($_GET['edit']=='true'){ ?>
<script language="javascript">
$('.filelist').click(function(e) {
	var fileid = this.id;
    $("#popup").attr('title','Chọn hình');
		$( "#popup" ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: 800,
			height: 600,
			modal: true,
			buttons: {
				
				
				
				'Tải về':function()
				{
					window.location = "<?php echo HTTP_SERVER?>download.php?url="+ encodeURI($('#filepath').val());
				},
				'Đóng': function() 
				{
					
					$( this ).dialog( "close" );
				},
			}
		});
	
		
		$("#popup-content").load("?route=core/file/detail&fileid="+fileid+"&dialog=true",function(){
			$("#popup").dialog("open");	
		});
});
</script>
<?php } ?>
<script language="javascript">
$(document).ready(function(e) {
    $('.chkfile').each(function(index, element) {
        if(arrfileid.indexOf(this.value)!=-1)
		{
			this.checked = true;
		}
    });
});
$('#chkAll').click(function(e) {
	$('.chkfile').attr('checked',this.checked);
	/*$('.chkfile').each(function(index, element) {
		$(this).click();
	});*/
	
});
$('.chkfile').click(function(e) {
	if(this.checked == true)
	{
		//arrfileid.push(this.value);
		//alert(arrfileid)
	}
	else
	{
		/*var pos = arrfileid.indexOf(this.value);
		if(pos > -1)
		{
			arrfileid.splice(pos,1);	
		}*/
		
	}
});	
$('.filelist').hover(
	function(){
		$(this).css('background-color','#ccc');
		
	},
	function(){
		$(this).css('background-color','transparent');
		$(this).children('.filename').css('overflow','hidden');
	});
	

</script>