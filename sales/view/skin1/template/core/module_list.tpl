


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
<script>
	/*$(function() {
		
		$( "ul" ).sortable({
			 connectWith: '.ui-sortable' ,
			 
			 stop: function(event, ui) 
			 {
				  module.drag = this.id; 
				  //$('#drag').html(module.drag);
			   	  $('#'+module.drag).treeview();
				  $('#'+module.drop).treeview();
				  module.updateChild(module.drop);
				
			 },
			 over: function(event, ui) 
			 {
				 module.drop = this.id; 
				 //$('#drop').html(module.drop);
				
			 }
		})
		
		
	});*/
$(document).ready(function(e) {
    
	
});
	
	</script>
<div class="section">

	<div class="section-title">Quản lý module</div>
    
    <div class="section-content">
    	<!--<div id="idcur"></div>
    	<div id="drag"></div>
        <div id="drop"></div>-->
        <form action="" method="post" id="listitem" name="listitem">
        
        	<div class="button right">
            	
                <a class="button add" onclick="module.add(0)">Thêm mới</a>
                
                <a class="button exit" href="?route=page/home">Về trang chủ</a>
                <!--<a class="button save" onclick="module.savePostion()">Cập nhật</a>-->
            </div>
            <div class="clearer">^&nbsp;</div>
            
            <div>
                <ul id="group0" class="filetree">
                	<?php echo $treemodule?>
                </ul>
            </div>
        	
        
        </form>
        
    </div>
    
</div>
<script language="javascript">
function Module()
{
	this.idcur = "";
	this.drag="";
	this.drop="";
	this.edit = function(moduleid)
	{
		$("#popup").attr('title','Module');
					$( "#popup" ).dialog({
						autoOpen: false,
						show: "blind",
						hide: "explode",
						width: 800,
						height: 500,
						modal: true,
						buttons: {
							
							'Lưu': function() {
								module.save()
								$( this ).dialog( "close" );
							},
							'Đóng': function() {
								$( this ).dialog( "close" );
							},
							
							
						}
					});
				
					
		$("#popup-content").load('?route=core/module/update&moduleid='+moduleid,function(){
			$("#popup").dialog("open");	
		});
		
		
	}
	
	this.add = function(parent)
	{
		$("#popup").attr('title','Module');
					$( "#popup" ).dialog({
						autoOpen: false,
						show: "blind",
						hide: "explode",
						width: 800,
						height: 500,
						modal: true,
						buttons: {
							
							'Lưu': function() {
								module.save()
								$( this ).dialog( "close" );
							},
							'Đóng': function() {
								$( this ).dialog( "close" );
							},
							
							
						}
					});
				
					
		$("#popup-content").load('?route=core/module/insert&parent='+parent,function(){
			$("#popup").dialog("open");	
		});
		
	}
	
	this.move = function(id)
	{
		$("#popup").attr('title','Module');
					$( "#popup" ).dialog({
						autoOpen: false,
						show: "blind",
						hide: "explode",
						width: 800,
						height: 500,
						modal: true,
						buttons: {
							
							'Lưu': function() {
								module.updateParent($('#id').val(),$('#moduleparent').val());
								$( this ).dialog( "close" );
							},
							'Đóng': function() {
								$( this ).dialog( "close" );
							},
							
							
						}
					});
				
					
		$("#popup-content").load('?route=core/module/move&id='+id,function(){
			$("#popup").dialog("open");	
		});
		
		
	}
	
	this.permission = function(id)
	{
		$("#popup").attr('title','Phân quyền');
					$( "#popup" ).dialog({
						autoOpen: false,
						show: "blind",
						hide: "explode",
						width: 800,
						height: 500,
						modal: true,
						buttons: {
							
							'Lưu': function() {
								module.savePermission($('#id').val(),$('#moduleparent').val());
								$( this ).dialog( "close" );
							},
							'Đóng': function() {
								$( this ).dialog( "close" );
							},
							
							
						}
					});
				
					
		$("#popup-content").load('?route=core/module/permission&id='+id,function(){
			$("#popup").dialog("open");	
		});
		
		
	}
	
	this.setNode = function(e)
	{
		module.idcur = e;
		//alert('test');
		$('#idcur').html(module.idcur);
	}
	this.updateChild = function(moduleid)
	{
		
		parent = moduleid.replace('group','');
		$('#'+moduleid).children().each(function(index, element) {
           
			itemmoduleid =this.id.replace('node','');
			
			parentitem = $('#nodeparent_'+this.id.replace('node','')).val();
			if(parentitem != parent)
			{
				$('#nodeparent_'+this.id.replace('node','')).val(parent);
				//module.updateParent(itemmoduleid,parent);
			}
        });
	}
	this.remove = function(moduleid)
	{
		anser=confirm("Bạn có chắc muốn xóa "+ $('#modulename'+moduleid).html() +" không?")
	
		if(anser==true)
		{
			$.ajax({
				url: "?route=core/module/remove&moduleid="+moduleid,
				cache: false,
				success: function(html){
					var obj = $.parseJSON(html);
					if(obj.error=="")
					{
						$("#node"+moduleid).remove();
						if($('#group'+obj.moduleparent).html()=="")
							module.folderToFile(obj.moduleparent);
						$('#group'+obj.moduleparent).treeview();
						
						alert("Xóa thành công");
					}
					else
					{
						alert(obj.error)	
					}
				}
			});
		}
	}
	
	this.folderToFile = function(moduleid)
	{
		//$('#module'+moduleid).attr('class','file');
		var parent = $('#node'+moduleid).attr('ref');
		
		$('#group'+parent).load("?route=core/module/getTreeView&root="+parent,function(){
							
			$('#group'+parent).treeview();
		});
		
	}
	this.updateParent = function(id,parent)
	{
		$.post("?route=core/module/updateParent", 
			{
				id:id,
				moduleparent:parent
			},
			function(data){
				if(data == "true")
				{
					/*$('#group'+parent).load("?route=core/module/getTreeView&root="+parent,function(){
							
						$('#group'+parent).treeview();
					});*/
					window.location.reload();
				}
			});
	}
	
	this.savePostion = function()
	{
		$.post("?route=core/module/savePostion", $("#listitem").serialize(),
			function(data){
				if(data == "true")
				{
					window.location.reload();
				}
			});
	}
	
	this.savePermission = function()
	{
		$.post("?route=core/module/updatePermission", $("#frmmodule").serialize(),
			function(data){
				if(data == "true")
				{
					alert("Cập nhật quyền thành công");
				}
			});
	}
	
	this.save = function()
	{
		
		
		$.post("?route=core/module/save", $("#frmmodule").serialize(),
			function(data){
				if(data == "true")
				{
					var id = $('#id').val();
					$('#modulename'+id).html($('#modulename').val());
					$.unblockUI();
					
					//Load cac con
					var khuvutructhuoc = $('#moduleparent').val();
					
					
					if($('#group'+khuvutructhuoc).html() == null)
					{
						//$('#node'+khuvutructhuoc).append('<ul id="group'+khuvutructhuoc+'"></ul>');
						var parent = $('#node'+khuvutructhuoc).attr('ref');
						if(parent == undefined)
						{
							window.location.reload();	
						}
						
						$('#group'+parent).load("?route=core/module/getTreeView&root="+parent,function(){
							
							$('#group'+parent).treeview();
						});
					}
					else
					{
						$('#group'+khuvutructhuoc).load("?route=core/module/getTreeView&root="+$('#moduleparent').val(),function(){
							
							$('#group'+khuvutructhuoc).treeview();
						});
						
					}
					
				}
				else
				{
				
					$('#error').html(data).show('slow');
					
					
				}
				
			}
		);
	}
}
var module = new Module();
</script>