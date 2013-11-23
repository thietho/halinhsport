<div>
<form id="frmmap">
	<input type="hidden" name="mediaid" value="<?php echo $mediaid?>">
	<p>
    	<label>Module</label>
        <select id="mapmodule">
        	<option value="">Chọn module</option>
            <?php foreach($modules as $key => $val){ ?>
            <option value="<?php echo $key?>"><?php echo $val?></option>
            <?php } ?>
        </select>
    </p>
    <p>
    	<label>Danh mục</label>
        <div id="listsitemap">
        	
        </div>
    </p>
    
    <input type="button" class="button" value="<?php echo $button_save ?>" onClick="save()">
</form>
</div>
<script language="javascript">
var listsitemapid = new Array();

<?php 
foreach($listsitemapid as $val)
{ 
	echo "listsitemapid.push('".$val."');";
}
?>

$('#mapmodule').change(function(e) {
	
    $.get("?route=core/media/getListSiteMap&module="+this.value, 
	function(data) 
	{
		
		$('#listsitemap').html(data);
	});
});
$(document).ready(function(e) {
    $('#mapmodule').val('<?php echo $moduleid?>');
	$('#mapmodule').change();
});
function save()
{
	$.post("?route=core/media/savemap", $("#frmmap").serialize(),
		function(data){
			if(data == "true")
			{
				searchForm();
				$.unblockUI();
			}
			
			
		}
	);
}
</script>