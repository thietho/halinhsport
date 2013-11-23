<div id="search">
    <label>Từ khóa:</label>
    <input type="text" class="text" id="keyword"/>
    <input type="button" class="button right" value="Trở về" onclick="$('#main-screen').load('?route=page/home/productCat')"/>
    <div class="clearer">^&nbsp;</div>
</div>

<div class="clearer">^&nbsp;</div>
<form id="postlist" name="postlist" method="post" action="">
    <div id="showsanpham" class="sales-scr"></div>
</form>
<script language="javascript">
pro.loadProduct(pro.url + "&sitemapid=<?php echo $sitemapid?>");
$('#keyword').keyup(function(e) {
    pro.searchForm('<?php echo $sitemapid?>');
});
</script>