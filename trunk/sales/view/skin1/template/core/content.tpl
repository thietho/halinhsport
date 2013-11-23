		<div>
        	<div class="left" id="sidebar" style="width:20%">
        
                <?php echo $sidebar?>
                
                <div class="clearer">&nbsp;</div>
                
            </div>
            
            <div id="show-content" class="right" style="width:79%">
        
                
            
            </div>
            
            <div class="clearer">&nbsp;</div>

            
        </div>
        
<script language="javascript">

$('.sitebar').click(function(e) {
	url =$(this).attr('ref');
	
	
    control.fload("#show-content",url);
	//window.location.reload();
});
$(document).ready(function(e) {
    if(strurl!="")
		control.fload("#show-content",strurl);
});
</script>