
<div class="section">

	<div class="section-title"><?php echo $menu_media ?></div>
    
    <div class="section-content">
    	
        <form action="" method="post" id="listitem" name="listitem">
        	<div id="ben-search">
            	<label><?php echo $lbl_key ?></label>
                <input type="text" id="keyword" name="keyword" class="text" value="" />
               	<label>Loại</label>
                <select id="type" name="type">
                    <option value=""></option>
                    <?php foreach($module as $key => $val){ ?>
                    <option value="<?php echo $key?>"><?php echo $val?></option>
                    <?php } ?>
                </select>
                <label>Danh mục</label>
                <select id="sitemapid" name="sitemapid">
                    <option value=""></option>
                    
                </select>
                <label>Tác giả</label>
                <select id="userid" name="userid">
                    <option value=""></option>
                    <?php foreach($users as $key => $val){ ?>
                    <option value="<?php echo $val['userid']?>"><?php echo $val['fullname']?></option>
                    <?php } ?>
                </select>
                <label><?php echo $lbl_fromdate ?></label>
                <script language="javascript">
					$(function() {
						$("#tungay").datepicker({
								changeMonth: true,
								changeYear: true,
								dateFormat: 'dd-mm-yy'
								});
						});
				 </script>
                <input id="tungay" name="tungay" type="text" class="text" />
                <label><?php echo $lbl_todate ?></label>
                <script language="javascript">
					$(function() {
						$("#denngay").datepicker({
								changeMonth: true,
								changeYear: true,
								dateFormat: 'dd-mm-yy'
								});
						});
				 </script>
                <input id="denngay" name="denngay" type="text" class="text" />
               
                <input type="button" class="button" name="btnSearch" value="<?php echo $button_search ?>" onclick="searchForm()"/>
                <input type="button" class="button" name="btnSearch" value="<?php echo $button_viewall ?>" onclick="viewAll()"/>
            </div>
        	<div class="button right">
               
            	<input class="button" type="button" name="delete_all" value="<?php echo $button_delete ?>" onclick="deleteItem()"/>  
            </div>
            <div class="clearer">^&nbsp;</div>
            
            <div id="listmedia" class="sitemap treeindex">
                
            </div>
        	
        
        </form>
        
    </div>
    
</div>
<script language="javascript">

function deleteItem()
{
	var answer = confirm("<?php echo $announ_del ?>")
	if (answer)
	{
		$.post("?route=core/media/delete", 
				$("#listitem").serialize(), 
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

function selectSiteMap(mediaid,moduleid)
{
	$('#popup-content').load('?route=core/media/mapmoduleform&mediaid='+mediaid+'&moduleid='+moduleid,
			function()
			{
				
				showPopup('#popup', 700, 500, true );
				//numberReady();
			});		
}
$(document).ready(function(e) {
    viewAll()
});
$('.text').keyup(function(e) {
    searchForm();
});
$('select').change(function(e) {
    searchForm();
});
function loadData(url)
{
	$('#listmedia').html(loading);
	$('#listmedia').load(url);
}
function viewAll()
{
	var url =  "?route=core/media/getList";
	loadData(url);
}
function searchForm()
{
	var url =  "?route=core/media/getList";
	
	
	if($("#keyword").val() != "")
		url += "&keyword="+ encodeURI($("#keyword").val());
	if($("#type").val() != "")
		url += "&type=" + encodeURI($("#type").val());
	if($("#sitemapid").val() != "")
		url += "&sitemapid=" + encodeURI($("#sitemapid").val());
	if($("#userid").val() != "")
		url += "&userid=" + encodeURI($("#userid").val());
	if($("#tungay").val() != "")
		url += "&tungay=" + encodeURI($("#tungay").val());
	if($("#denngay").val() != "")
		url += "&denngay=" + encodeURI($("#denngay").val());
	if("<?php echo $_GET['opendialog']?>" == "true")
	{
		url += "&opendialog=true";
	}
	
	loadData(url);
}




$('#type').change(function(e) {
    $.getJSON("?route=core/media/getListSiteMap&module="+this.value, 
	function(data) 
	{
		$('#sitemapid').val('<option value=""></option>');
		for(i in data.sitemaps)
		{
			
			var str = '<option value="'+data.sitemaps[i].sitemapid+'">'+data.sitemaps[i].sitemapname+'</option>';
			
			$('#sitemapid').append(str);
		}
		$("#sitemapid").val("<?php echo $_GET['sitemapid']?>");
	});
});
$("#keyword").val("<?php echo $_GET['keyword']?>");
$("#type").val("<?php echo $_GET['type']?>");
$("#userid").val("<?php echo $_GET['userid']?>");
$("#tungay").val("<?php echo $_GET['tungay']?>");
$("#denngay").val("<?php echo $_GET['denngay']?>");
$(document).ready(function(e) {
    $('#type').change();
	
});
function moveto(url,eid)
{
	$(eid).html(loading);
	$(eid).load(url);	
}
</script>