<form name="frmSiteMap" id="frmSiteMap" >
    <input type="hidden" id="id" name="id" value="<?php echo $item['id']?>">
    <input type="hidden" id="sitemapparent" name="sitemapparent" value="<?php echo $item['sitemapparent']?>">
    <input type="hidden" id="moduleid" name="moduleid" value="module/product">
    <input type="hidden" id="status" name="status" value="Active">
    <div id="error" class="error" style="display:none"></div>
    <div>   
        <p>
            <label>Tên danh mục:</label><br />
            <input type="text" id="sitemapname" name="sitemapname" value="<?php echo $item['sitemapname']?>" class="text" size=60 />
        </p>
        <p>
            <label>Mã danh mục</label><br />
            <input type="text" id="sitemapid" name="sitemapid" value="<?php echo $item['sitemapid']?>" class="text" size="80"/>
		</p>
	<?php if($item[id]==""){ ?>
	<script>
		$('#sitemapname').change(function(e) {
		
			$.ajax({
					url: "?route=common/api/getAliasSiteMap&title=" + toBasicText(this.value),
					cache: false,
					success: function(html)
					{
						$("#sitemapid").val(html);
					}
			});
		});
    </script>
	<?php } ?>
    </div>
    
</form>