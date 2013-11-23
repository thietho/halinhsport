<script src='<?php echo DIR_JS?>ajaxupload.js' type='text/javascript' language='javascript'> </script>
<form id="frm_importproduct" method="post" enctype="multipart/form-data">
	
    <input type="button" class="button" id="importfile" value="Chọn file">
    <div id="viewdata"></div>
</form>
<script language="javascript">
$(document).ready(function(e) {
    new AjaxUpload(jQuery('#importfile'), {
		action: '?route=module/product/importData',
		name: 'fileimport',
		
		responseType: 'json',
		onChange: function(file, ext){
		},
		onSubmit: function(file, ext){
			if (ext && /^(xls|xlsx)$/i.test(ext)) 
			{                            
				
			}
			else 
			{
				alert('Your selection is not excel');
				return false;
			}
		},
		onComplete: function(file, response){
			var table = '<table class="data-table">';
			for(i in response.datas)
			{
				if(i == 1)
					table +='<tr>';
				else
					table +='<tr id="item'+i+'" class="item">';
				for(j in response.datas[i])
				{
					//if(response.datas[i][j]==null)
						//break;
					var value = response.datas[i][j];
					if(value==null)
						value = '';
					if(i==1)
						table+='<th>'+value+'</th>';
					else
						table+='<td id="'+j+'">'+value+'</td>';
				}
				table +='</tr>';
			}
			table += '</table>';
			$('#viewdata').html(table);
			

			
		}
	});	
});
	
</script>