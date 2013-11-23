<div class="section">

	<div class="section-title">
    	<?php echo $breadcrumb?>
    </div>
    
    <div class="section-content padding1">
    
    	<div class="left">
            <h3><?php echo $heading_title?></h3>
        </div>
        
    	<div class="right">
        	<?php if($permissionAdd){?>
        	<a class="button" href="<?php echo $DIR_ADD.'&page='.$page?>"><?php echo $button_add?></a>&nbsp;
            <?php }?>
            <?php if($permissionEdit){?>
        	<a class="button" onclick="updatePosition()"><?php echo $button_updateposition?></a>&nbsp;
            <?php }?>
            <?php if($permissionDelete){?>
            <a class="button" id="removelist"><?php echo $button_remove?></a>&nbsp;
            <?php }?>
            <a class="button" href="index.php"><?php echo $button_cancel?></a>
        </div>
        <div class="clearer">&nbsp;</div>
        <div id="search">
        	<label>Code</label>
            <input type="text" class="text" id="code" />
            <label>Quy cách</label>
            <input type="text" class="text" id="sizes" />
            <label><?php echo $column_title?></label>
            <input type="text" class="text" id="title" /><br />
            <input type="button" class="button" value="Tìm kiếm" onclick="searchForm()"/>
            <input type="button" class="button" value="Xem tất cả" />
        </div>
        <div class="clearer">&nbsp;</div>
        <div class="listview">
        	<form id="postlist" name="postlist" method="post" action="">
            
			</form>
        </div>
        <div class="right">
        	<?php if($permissionAdd){?>
        	<a class="button" href="<?php echo $DIR_ADD.'&page='.$page?>"><?php echo $button_add?></a>&nbsp;
            <?php }?>
            <?php if($permissionEdit){?>
        	<a class="button" onclick="updatePosition()"><?php echo $button_updateposition?></a>&nbsp;
            <?php }?>
            <?php if($permissionDelete){?>
            <a class="button" id="removelist"><?php echo $button_remove?></a>&nbsp;
            <?php }?>
            <a class="button" href="index.php"><?php echo $button_cancel?></a>
        </div>
        <div>
        	<!--
        	<?php echo $nextlink?>
            <?php echo $prevlink?>
            -->
            <div class="phantrang"><?php echo $listpage ?></div>
            <div class="clearer">&nbsp;</div>
        </div>
        
       
        
    </div>

</div>

<script>
var DIR_DELETE = '<?php echo $DIR_DELETE?>';
var DIR_UPDATEPOSITION = '<?php echo $DIR_UPDATEPOSITION?>';
$(document).ready(function() { 
	viewAll();
	$('#removelist').attr('title','Delete selected item').click(function(){deletelist();});  
	
});
$('.text').keyup(function(e) {
    searchForm();
});
function loadData(url)
{
	$('#postlist').html(loading);
	$('#postlist').load(url);
}
function viewAll()
{
	loadData("?route=core/postlist/loadData&moduleid=<?php echo $route?>&sitemapid=<?php echo $sitemap['sitemapid']?>");
}
function searchForm()
{
	var url =  "?route=core/postlist/loadData&moduleid=<?php echo $route?>&sitemapid=<?php echo $sitemap['sitemapid']?>";
	if($("#search #code").val() != "")
		url += "&code=" + $("#search #code").val();
	
	if($("#search #sizes").val() != "")
		url += "&sizes="+ encodeURI($("#search #sizes").val());
	
	if($("#search #title").val() != "")
		url += "&title="+ encodeURI($("#search #title").val());

	
	if("<?php echo $_GET['opendialog']?>" == "true")
	{
		url += "&opendialog=true";
	}
	
	loadData(url);
	
}

function deletelist()
{
	$.blockUI({ message: "<h1><?php echo $announ_infor ?></h1>" }); 
	$.post(DIR_DELETE, $("#postlist").serialize(), function(data){
		$('#postlist').load("?route=core/postlist/loadData&moduleid=<?php echo $route?>&sitemapid=<?php echo $sitemap['sitemapid']?>");
		$.unblockUI();
	});	
}
function updatePosition()
{
	$.blockUI({ message: "<h1><?php echo $announ_infor ?></h1>" }); 
	$.post(DIR_UPDATEPOSITION, $("#postlist").serialize(), function(data){
		$('#postlist').load("?route=core/postlist/loadData&moduleid=<?php echo $route?>&sitemapid=<?php echo $sitemap['sitemapid']?>");
		$.unblockUI();
	});	
}

</script>
