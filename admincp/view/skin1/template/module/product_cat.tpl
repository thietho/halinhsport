<script type="text/javascript">
var CLASSES = ($.treeview.classes = {
		open: "open",
		closed: "closed",
		expandable: "expandable",
		expandableHitarea: "expandable-hitarea",
		lastExpandableHitarea: "lastExpandable-hitarea",
		collapsable: "collapsable",
		collapsableHitarea: "collapsable-hitarea",
		lastCollapsableHitarea: "lastCollapsable-hitarea",
		lastCollapsable: "lastCollapsable",
		lastExpandable: "lastExpandable",
		last: "last",
		hitarea: "hitarea"
	});
	$(function() {
		$("#group0").treeview();
		
	})
	
</script>
<h3>Danh mục sản phẩm</h3>
<?php if($this->user->checkPermission("module/product/addcat")==true){ ?>
<a class="showproduct" href="?route=module/product">Tất cả</a><a class='addcat' cparent="<?php echo $root?>"><img src="<?php echo DIR_IMAGE?>icon/add.png" width="19px"></a>
<?php } ?>
<ul id="group0">
	<?php echo $catshow?>
</ul>


<script language="javascript">
$('.showproduct').click(function(e) {
   $('#showsanpham').load('?route=module/product/getList&sitemapid='+$(this).attr('ref'));
});
$('.addcat').click(function(e) {
	var parent = $(this).attr('cparent');
	$("#popup").attr('title','Thêm danh mục sản phẩm');
					$( "#popup" ).dialog({
						autoOpen: false,
						show: "blind",
						hide: "explode",
						width: 800,
						height: 500,
						modal: true,
						buttons: {
							
							'Lưu': function() {
								
								$.post("?route=core/sitemap/save", $("#frmSiteMap").serialize(),
									function(data){
										var arr = data.split("-");
										if(arr[0] == "true")
										{
											$('#showdanhmuc').load('?route=module/product/productCat');
										}
										else
										{
										
											$('#error').html(data).show('slow');
											
											
										}
										
										
									}
								);
								$( this ).dialog( "close" );
							},
							'Đóng': function() {
								$( this ).dialog( "close" );
							},
							
							
						}
					});
				
					
		$("#popup-content").load('?route=module/product/addcat&parent='+parent,function(){
			$("#popup").dialog("open");	
		});
});
$('.editcat').click(function(e) {
	var sitemapid = $(this).attr('sitemapid');
	$("#popup").attr('title','Cập nhật danh mục sản phẩm');
					$( "#popup" ).dialog({
						autoOpen: false,
						show: "blind",
						hide: "explode",
						width: 800,
						height: 500,
						modal: true,
						buttons: {
							
							'Lưu': function() {
								
								$.post("?route=core/sitemap/save", $("#frmSiteMap").serialize(),
									function(data){
										var arr = data.split("-");
										if(arr[0] == "true")
										{
											$('#showdanhmuc').load('?route=module/product/productCat');
										}
										else
										{
										
											$('#error').html(data).show('slow');
											
											
										}
										
										
									}
								);
								$( this ).dialog( "close" );
							},
							'Đóng': function() {
								$( this ).dialog( "close" );
							},
							
							
						}
					});
				
					
		$("#popup-content").load('?route=module/product/editcat&sitemapid='+sitemapid,function(){
			$("#popup").dialog("open");	
		});
});
$('.delcat').click(function(e) {
	var id = $(this).attr('sitemapid');
	
	$.get("?route=module/product/delcat&id="+id,
		function(data)
		{
			$('#showdanhmuc').load('?route=module/product/productCat');
		});
});
</script>