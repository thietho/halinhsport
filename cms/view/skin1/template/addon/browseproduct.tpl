<div id="productseach">
	<p>
		<label>Tên sản phẩm</label>
        <input type="text" class="text" id="keyword" name="keyword"/>
        <label>Danh mục</label>
        <select id="sitemapid" name="sitemapid">
        	<option value=""></option>
            <?php foreach($data_danhmuc as $danhmuc){ ?>
            <option value="<?php echo $danhmuc['sitemapid']?>"><?php echo $danhmuc['sitemapname']?></option>
            <?php } ?>
        </select>
    </p>
</div>
<div class="clearer">^&nbsp;</div>
<div id="productlist" class="left">
	
</div>
<div id="productselect" class="right">
	
</div>
<div class="clearer">^&nbsp;</div>
<script language="javascript">
$(document).ready(function(e) {
    loadData("?route=addon/order/listProduct");
});
function loadData(url)
{
	$('#productlist').html(loading);
	$('#productlist').load(url);
}
function searchForm()
{
	var url ="?route=addon/order/listProduct";
	if($("#keyword").val() != "")
		url += "&keyword=" + $('#keyword').val();
	if($("#sitemapid").val() != "")
		url += "&sitemapid=" + $('#sitemapid').val();
    loadData(url);
}
$('#keyword').keyup(function(e) {
	searchForm();
});
$('#sitemapid').change(function(e) {
    searchForm();
});
</script>