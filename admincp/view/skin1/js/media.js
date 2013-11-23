function showFile(fileid)
{
	//if(!$(document).has("#fileinformation"))
	$('body').append('<div id="fileinformation" style="display:none"></div>');
	
	$("#fileinformation").attr('title','Thông tin file');
		$( "#fileinformation" ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: 800,
			height: 600,
			modal: true,
			close:function()
				{
					$('#fileinformation').remove();
				},
			buttons: {
				
				
				
				'Tải về':function()
				{
					window.location = "download.php?url="+ encodeURI($('#filepath').val());
				},
				'Đóng': function() 
				{
					
					$("#fileinformation").dialog( "close" );
					
				},
			}
		});
	
		
		$("#fileinformation").load("?route=core/file/detail&fileid="+fileid+"&dialog=true",function(){
			$("#fileinformation").dialog("open");	
		});
}

function showMediaForm(fileid)
{
	$('body').append('<div id="mediaform" style="display:none"></div>');
	
	$("#mediaform").attr('title','Thông tin file');
		$( "#mediaform" ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: 500,
			height: 600,
			modal: true,
			close:function()
				{
					$('#mediaform').remove();
				},
			buttons: {
				
				
				
				'Lưu':function()
				{
					$.post("?route=core/media/addMediaQuick",$('#frmQuickAddMedia').serialize(),
					function(data)
					{
						var obj = $.parseJSON(data);
						if(obj.error=="")
						{
							//loadData("?route=addon/order/listProduct");
							$('#frmAddSanPham').dialog("close");
						}
						else
						{
							alert(obj.error);
						}
					});
				},
				'Đóng': function() 
				{
					
					$("#mediaform").dialog( "close" );
					
				},
			}
		});
	
		
		$("#mediaform").load("?route=core/media/fileToMedia&fileid="+fileid+"&dialog=true",function(){
			$("#mediaform").dialog("open");	
		});
}
function showFolderForm(folderid,folderparent)
{
	$('body').append('<div id="folderform" style="display:none"></div>');
	var eid = "#folderform";
	$(eid).attr('title','Thư mục');
		$( eid ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: 300,
			height: 300,
			modal: true,
			close:function()
				{
					$(eid).remove();
				},
			buttons: {
				
				
				
				'Lưu':function()
				{
					$.post("?route=core/file/saveFolder",$('#frm_folder').serialize(),
					function(data)
					{
						var obj = $.parseJSON(data);
						if(obj.error=="")
						{
							
							$('#folderform').dialog("close");
							$('#foldername' + folderid).html($('#foldername').val());
							loadFolder();
							selectFolder(folderparent);
						}
						else
						{
							alert(obj.error);
						}
					});
				},
				'Đóng': function() 
				{
					
					$(eid).dialog( "close" );
					
				},
			}
		});
	
		
		$(eid).load("?route=core/file/showFolderForm&folderid="+folderid+"&folderparent="+folderparent+"&dialog=true",function(){
			$(eid).dialog("open");	
		});
}
function showFileInfor(fileid)
{
	$('body').append('<div id="fileinfor" style="display:none"></div>');
	var eid = "#fileinfor";
	$(eid).attr('title','Thông tin file');
		$(eid).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: 800,
			height: 600,
			modal: true,
			buttons: {
				'Các bài viết sử dụng':function()
				{
					showMediaUse(fileid);
				},
				'Đưa vào bài viết':function()
				{
					showMediaForm(fileid);
				},
				'Tải về':function()
				{
					window.location = "download.php?url="+ encodeURI($('#filepath').val());
				},
				'Đóng': function() 
				{
					
					$( eid ).dialog( "close" );
				},
			}
		});
	
		
		$(eid).load("?route=core/file/detail&fileid="+fileid+"&dialog=true",function(){
			$(eid).dialog("open");	
		});
}
function showFolderMoveForm()
{
	$('body').append('<div id="folderform" style="display:none"></div>');
	var eid = "#folderform";
	$(eid).attr('title','Thư mục');
		$( eid ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: 300,
			height: 200,
			modal: true,
			close:function()
				{
					$(eid).remove();
				},
			buttons: {
				
				
				
				'Chọn':function()
				{
					$('.selectfile').each(function(index, element) {
                        
							var fileid = this.id;
							var folderid = $('#desfolder').val();
							$.get("?route=core/file/updateFolder&fileid="+fileid+"&folderid="+folderid,
							function(){
								 showResult("?route=core/file/getList&folderid="+$('#folderidcur').val()+"&edit=true");
							});
							
						
						
                    });
					$(eid).dialog( "close" );
				},
				'Đóng': function() 
				{
					
					$(eid).dialog( "close" );
					
				},
			}
		});
	
		
		$(eid).load("?route=core/file/showFolderMoveForm&dialog=true",function(){
			$(eid).dialog("open");	
		});
}
function delFolder(folderid)
{
	$.get("?route=core/file/delFolder&folderid="+folderid,function(data){
		if(data=="true")
			loadFolder();
		else
			alert(data);
	});
}
function showMediaUse(fileid)
{
	$('body').append('<div id="medialist" style="display:none"></div>');
	
	$("#medialist").attr('title','Thông tin file');
		$( "#medialist" ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: 500,
			height: 600,
			modal: true,
			close:function()
				{
					$('#medialist').remove();
				},
			buttons: {
				
				'Đóng': function() 
				{
					
					$("#medialist").dialog( "close" );
					
				},
			}
		});
	
		
		$("#medialist").load("?route=core/media/mediaUse&fileid="+fileid+"&dialog=true",function(){
			$("#medialist").dialog("open");	
		});
}
function addQuickProduct()
{
	$('body').append('<div id="frmAddSanPham" style="display:none"></div>');
	
	$("#frmAddSanPham").attr('title','Thêm nhanh sản phẩm');
	$("#frmAddSanPham").dialog({
		autoOpen: false,
		show: "blind",
		hide: "explode",
		width: 500,
		height: 500,
		modal: true,
		close:function()
				{
					$('#frmAddSanPham').remove();
				},
		buttons: {
			
			
			'Thêm': function() 
			{
				$.post("?route=core/media/addMediaQuick",$('#frmQuickAddProduct').serialize(),
					function(data)
					{
						var obj = $.parseJSON(data);
						if(obj.error=="")
						{
							loadData("?route=addon/order/listProduct");
							$('#frmAddSanPham').dialog("close");
						}
						else
						{
							alert(obj.error);
						}
					});
				
			},
			
		}
	});

	
	$("#frmAddSanPham").load("?route=addon/order/showProductForm",function(){
		$("#frmAddSanPham").dialog("open");	
	});
}
function addProduct(parent,sitemapid)
{
	$('body').append('<div id="frmProduct" style="display:none"></div>');
	
	$("#frmProduct").attr('title','Thông tin sản phẩm');
	$("#frmProduct").dialog({
		autoOpen: false,
		show: "blind",
		hide: "explode",
		width: $(document).width()-100,
		height: 600,
		modal: true,
		close:function()
				{
					$('#frmProduct').remove();
				},
		buttons: {
			
			
			'Lưu': function() 
			{
				if(saveMedia())
				{
					$('#frmAddSanPham').dialog("close");
				}
			},
			
		}
	});

	
	$("#frmProduct").load("?route=module/product/insert&sitemapid="+sitemapid+"&mediaparent="+parent+"&dialog=true",function(){
		$("#frmProduct").dialog("open");	
	});
}
function editProduct(mediaid)
{
	$('body').append('<div id="frmProduct" style="display:none"></div>');
	
	$("#frmProduct").attr('title','Thông tin sản phẩm');
	$("#frmProduct").dialog({
		autoOpen: false,
		show: "blind",
		hide: "explode",
		width: $(document).width()-100,
		height: 600,
		modal: true,
		close:function()
				{
					$('#frmProduct').remove();
				},
		buttons: {
			
			
			'Lưu': function() 
			{
				if(saveMedia())
				{
					$('#frmAddSanPham').dialog("close");
					window.location.reload();
				}
			},
			
		}
	});

	
	$("#frmProduct").load("?route=module/product/update&mediaid="+mediaid+"&dialog=true",function(){
		$("#frmProduct").dialog("open");	
	});
}
function saveMedia()
{
	$.blockUI({ message: "<h1>Please wait!!!</h1>" }); 
	var oEditor = CKEDITOR.instances['editor1'] ;
	var pageValue = oEditor.getData();
	$('textarea#editor1').val(pageValue);
	
	var oEditor = CKEDITOR.instances['summary'] ;
	var pageValue = oEditor.getData();
	$('textarea#summary').val(pageValue);
	
	$.post("?route=core/postcontent/savepost",$('#frmPost').serialize(),
		function(data){
			if(data=="true")
			{
				alert("Lưu thành công");
				window.location.reload();
				
			}
			
			$.unblockUI();
			
		});	
}
function browseProduct()
{
	$('body').append('<div id="popupbrowseproduct" style="display:none"></div>');
	$("#popup").attr('title','Chọn sản phẩm');
		$("#popupbrowseproduct").dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: 800,
			height: 500,
			modal: true,
			close:function()
				{
					$('#popupbrowseproduct').remove();
				},
			
		});
	
		
		$("#popupbrowseproduct").load("?route=addon/order/browseProduct",function(){
			$("#popupbrowseproduct").dialog("open");
			

		});
}
function showMemberForm(memberid,strFun)
{
	$('body').append('<div id="frm_member" style="display:none"></div>');
	var eid = "#frm_member";
	$(eid).attr('title','Thông tin khách hàng');
		$( eid ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			//width: $(document).width()-100,
			width: 600,
			height: 600,
			modal: true,
			close:function()
				{
					$(eid).remove();
				},
			buttons: {
				
				
				
				'Lưu':function()
				{
					
					$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
					$.post("?route=core/member/save", $("#frm").serialize(),
						function(data){
							var arr = data.split("-");
							if(arr[0] == "true")
							{
								//window.location = "?route=core/member";\
								alert("Lưu thành công!");
								if(strFun!="")
									var ret = eval(strFun);
								$(eid).dialog( "close" );
							}
							else
							{
							
								$('#error').html(data).show('slow');
								$.unblockUI();
								
							}
							$.unblockUI();
						}
					);	
						
						
                    
					
				},
				'Đóng': function() 
				{
					
					$(eid).dialog( "close" );
					
				},
			}
		});
		var url = "?route=core/member/insert&dialog=true";
		if(memberid)
		{
			url = "?route=core/member/update&id="+memberid+"&dialog=true";
		}
		$(eid).load(url,function(){
			$(eid).dialog("open");	
		});
}
function showNhaCungCapForm(nhacungcapid,strFun)
{
	$('body').append('<div id="frm_member" style="display:none"></div>');
	var eid = "#frm_member";
	$(eid).attr('title','Thông tin khách hàng');
		$( eid ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			//width: $(document).width()-100,
			width: 600,
			height: 600,
			modal: true,
			close:function()
				{
					$(eid).remove();
				},
			buttons: {
				
				
				
				'Lưu':function()
				{
					
					
					$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
					$.post("?route=quanlykho/nhacungcap/save", $("#frm").serialize(),
						function(data){
							var arr = data.split("-");
							if(arr[0] == "true")
							{
								//window.location = "?route=core/member";\
								alert("Lưu thành công!");
								if(strFun!="")
									var ret = eval(strFun);
								$(eid).dialog( "close" );
							}
							else
							{
							
								$('#error').html(data).show('slow');
								$.unblockUI();
								
							}
							$.unblockUI();
						}
					);	
						
						
                    
					
				},
				'Đóng': function() 
				{
					
					$(eid).dialog( "close" );
					
				},
			}
		});
		var url = "?route=quanlykho/nhacungcap/insert&dialog=true";
		if(nhacungcapid)
		{
			url = "?route=quanlykho/nhacungcap/update&id="+nhacungcapid+"&dialog=true";
		}
		$(eid).load(url,function(){
			$(eid).dialog("open");	
		});
}