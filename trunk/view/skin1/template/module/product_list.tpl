<?php echo $content?>
<?php
if(count($medias))
{
?>
<?php if($sorting){ ?>
   	<div class="ben-post">
        <select id="order" class="ben-textbox ben-left" onchange="window.location = '?order='+this.value">
            <option value="new">Mới</option>
            <option value="gt">Giá tăng dần</option>
            <option value="gg">Giá giảm dần</option>
            <option value="az">Tên: A-Z</option>
        </select>
<script language="javascript">
$('#order').val('<?php echo $_GET["order"]?>');
</script>
		<div id="ben-view-type" class="ben-right">
        	<img src="<?php echo HTTP_SERVER.DIR_IMAGE?>viewtype/view_gallery.gif" onclick="setViewType('gallery')"/>
            <img src="<?php echo HTTP_SERVER.DIR_IMAGE?>viewtype/view_des.gif" onclick="setViewType('des')"/>
            <img src="<?php echo HTTP_SERVER.DIR_IMAGE?>viewtype/view_list.gif" onclick="setViewType('list')"/>
            <img src="<?php echo HTTP_SERVER.DIR_IMAGE?>viewtype/view_line.gif" onclick="setViewType('line')"/>
        </div>
        <div class="clearer">&nbsp;</div>
        
    </div>
    	<?php } ?>
    <?php if($paging){ ?>
    <?php echo $pager?>
    <div class="clearer">&nbsp;</div>
    <?php } ?>
    
    <?php
    	switch($_SESSION['productview'])
        {
        	case "":
            case "gallery":
            	include(DIR_TEMPLATE."viewtype/gallery.tpl");
                break;
            case $_SESSION['productview']:	
    	 		include(DIR_TEMPLATE."viewtype/".$_SESSION['productview'].".tpl");
                break; 
        }
     ?>
    


	<div class="clearer">&nbsp;</div>
    <?php if($paging){ ?>
	<?php echo $pager?>
    <?php } ?>
<?php
}
?>
<script language="javascript">
function setViewType(type)
{
	$.get("?route=module/product/setViewType&viewtype="+type,function(){
		window.location.reload();	
	});	
}
</script>