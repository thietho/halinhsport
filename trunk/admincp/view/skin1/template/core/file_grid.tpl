<?php echo $path?>
<div class="clearer">^&nbsp;</div>
<?php if(count($folderchild)){ ?>
	<?php foreach($folderchild as $folder){ ?>
    <div class="left folderlist" folderid="<?php echo $folder['folderid']?>" title="<?php echo $folder['foldername']?>">
    	<table>
        	<tr>
            	<td><?php echo $folder['foldername']?></td>
            </tr>
        </table>
    	
    </div>
    <?php }?>





<?php } ?>
<?php 
	if(count($files))
   		foreach($files as $file){ ?>
	<div class="left">
    <div class="filelist  text-center" id="<?php echo $file['fileid']?>" imagethumbnail="<?php echo $file['imagethumbnail']?>" filename="<?php echo $file['filename']?>" filepath="<?php echo $file['filepath']?>" style="background:url('<?php echo $file['imagethumbnail']?>') no-repeat center center" title="<?php echo $file['filename']?>">
        
		<p class="filename"><?php echo substr($file['filename'],0,20)?></p>
            
        
        
    </div>
	
</div>
<?php } ?>

<div class="clearer">^&nbsp;</div>


<script language="javascript">
$('.filelist').dblclick(function(e) {
	var fileid = this.id;
    showFileInfor(fileid);
});
$('.filelist').click(function(e) {
	if($(this).hasClass('selectfile'))
		$(this).removeClass('selectfile');
	else
    	$(this).addClass('selectfile');
});
$('.filelist').hover(
	function(){
		$(this).css('background-color','#ccc');
		
	},
	function(){
		$(this).css('background-color','transparent');
		//$(this).children('.filename').css('overflow','hidden');
	});
	
$('.folderlist').click(function(e) {
    var folderid = $(this).attr('folderid');
	selectFolder(folderid);
});
$('.folderpath').click(function(e) {
    var folderid = $(this).attr('folderid');
	selectFolder(folderid);
});
</script>