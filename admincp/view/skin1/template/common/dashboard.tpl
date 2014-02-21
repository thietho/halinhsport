<div class="section" id="sitemaplist">

	<div class="section-title"><?php echo $dash_header ?></div>
    
    <div class="section-content padding1">
    
    	<form name="frm" id="frm" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	<input type="button" value="<?php echo $button_save ?>" class="button" onClick="save()"/>   
     	        <input type="hidden" name="mediaid" value="<?php echo $item['mediaid']?>">
                
            </div>
            <div class="clearer">^&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
        	<div>
            	<h3><?php echo $dash_infor_header ?></h3><br />
            	<p>
            		<label><?php echo $dash_title ?></label><br />
					<input type="text" name="Title" value="<?php echo $item['Title']?>" class="text" size=60 />
            	</p>
                <p>
            		<label><?php echo $dash_slogan ?></label><br />
					<input type="text" name="Slogan" value="<?php echo $item['Slogan']?>" class="text" size=60 />
            	</p>
                  
                <p>
            		<label><?php echo $dash_currency ?></label><br />
					<input type="text" name="Currency" value="<?php echo $item['Currency']?>" class="text" size=60 />
            	</p>
                
                <p>
            		<label><?php echo $dash_email ?></label><br />
					<input type="text" name="EmailContact" value="<?php echo $item['EmailContact']?>" class="text" size=60 />
            	</p>
                <p>
                    <label>Keyword</label><br />
                    <textarea name="Keyword"><?php echo $item['Keyword']?></textarea>
                        
                </p>
				<p>
                    <label>Mô tả</label><br />
                    <textarea name="Description"><?php echo $item['Description']?></textarea>
                        
                </p>
            </div>
            <div>
            	
                
                <?php for($i=1;$i<=4;$i++){?>
            	<p>
                    <label>Quảng cáo <?php echo $i?></label>
                    <input type="hidden" id="qc<?php echo $i?>_fileid" name="qc<?php echo $i?>_fileid" value="<?php echo $qc[$i]['fileid']?>"/><br />
                    	(250px x 250px)
                        <img id="qc<?php echo $i?>_preview" src="<?php echo $qc[$i]['imagethumbnail']?>"/>
                        <input type="button" class="button" value="<?php echo $entry_photo ?>" onclick="browserFile('qc<?php echo $i?>','single')"/>
                        (1045px x 540px)
                        <input type="hidden" id="qcbanner<?php echo $i?>_fileid" name="qcbanner<?php echo $i?>_fileid" value="<?php echo $qc[$i]['fileid']?>"/>
                        <img id="qcbanner<?php echo $i?>_preview" src="<?php echo $qcbanner[$i]['imagethumbnail']?>"/>
                        <input type="button" class="button" value="<?php echo $entry_photo ?>" onclick="browserFile('qcbanner<?php echo $i?>','single')"/>
                </p>
                <?php }?>
            </div>
        </form>
    
    </div>
    
</div>

<script language="javascript">

function save()
{
	$.blockUI({ message: "<h1><?php echo $announ_infor ?></h1>" }); 
	/*var oEditor = CKEDITOR.instances['editor1'] ;
	var pageValue = oEditor.getData();
	$('textarea#editor1').val(pageValue);*/
	$.post("?route=common/dashboard/save", $("#frm").serialize(),
		function(data){
			if(data == "true")
			{
				//window.location.reload();
			}
			$.unblockUI();
		}
	);
}
var index = 0;
function addRow(obj)
{
	var str ='<tr id="row'+index+'">';
	str += '<td><input type="hidden" id="film'+index+'" name="film['+index+']" value="'+obj.id+'"/><span id="film'+index+'_name">'+obj.moviename+'</span></td>';
	str += '<td><img id="film'+index+'_icon" src="'+obj.icone+'"/></td>';
	str += '<td><input type="button" class="button" value="Chọn film" onclick="selectFilm(\'film'+index+'\',\'edit\')"/><input type="button" class="button" value="X" onclick="$(\'#row'+index+'\').remove()"/></td>';
	str += '</tr>';
	$('#listfilm').append(str);
	index++;
}
var obj = new Object();
<?php foreach($data_film as $f) { ?>
	
	obj.id = "<?php echo $f['id']?>";
	obj.moviename = "<?php echo $f['moviename']?>";
	obj.icone = "<?php echo $f['iconethumbnail']?>";
	addRow(obj);
<?php } ?>
function intSelectMovie()
{
	switch($('#outputtype').val())
	{
		case "add":
			$('.item').click(function(e) {
			var eid = $('#handler').val();
			var obj = new Object();
			obj.id = $(this).attr('id');
			obj.moviename = $(this).attr('moviename');
			obj.icone = $(this).attr('icone');
			addRow(obj);
			$("#filmform").dialog( "close" );
    		});
			break;
		case "edit":
			$('.item').click(function(e) {
			var eid = $('#handler').val();
			$('#'+eid).val($(this).attr('id'));
			$('#'+eid+'_name').html($(this).attr('moviename'));
			$('#'+eid+'_icon').attr('src',$(this).attr('icone'));
			
			$("#filmform").dialog( "close" );
    		});
			break;
	}
	
}
</script>
