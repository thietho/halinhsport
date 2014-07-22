<div class="section">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content">
    	
        <form action="" method="post" id="frm_movie">
        	<div id="ben-search">
            	<label>Tên film</label>
                <input type="text" id="moviename" name="moviename" class="text" value="" />
                
                
                <br />
                <input type="button" class="button" name="btnSearch" value="Tìm" onclick="searchForm()"/>
                <input type="button" class="button" name="btnSearch" value="Xem tất cả" onclick="viewAll()"/>
            </div>
        	<div class="button right">
            	<?php if($dialog==true){ ?>
            	
                
                
                <?php }else{ ?>
                
               
                <?php if($this->user->checkPermission("lotte/movie/insert")==true){ ?>
                <input class="button" value="Thêm" type="button" onclick="window.location='<?php echo $insert?>'">
                <?php } ?>
                <?php if($this->user->checkPermission("lotte/movie/delete")==true){ ?>
            	<input class="button" type="button" name="delete_all" value="Xóa" onclick="deleteitem()"/>
                <?php } ?>
                <?php } ?>
            </div>
            <div class="clearer">^&nbsp;</div>
            
            <div id="listmovie" class="sitemap treeindex">
                
            </div>
        	
        
        </form>
        
    </div>
    
</div>
<script language="javascript">

function deleteitem()
{
	var answer = confirm("Bạn có muốn xóa không?")
	if (answer)
	{
		$.post("?route=lotte/movie/delete", 
				$("#frm_nhacungcap").serialize(), 
				function(data)
				{
					if(data!="")
					{
						alert(data)
						window.location.reload();
					}
				}
		);
	}
}
$(document).ready(function(e) {
    viewAll();
});

$('.text').keyup(function(e) {
    searchForm();
});
$('select').change(function(e) {
    searchForm();
});
function viewAll()
{
	url = "?route=lotte/movie/getList";
	if("<?php echo $_GET['opendialog']?>" == "true")
	{
		url += "&opendialog=true";
	}
	$('#listmovie').html(loading);
	$('#listmovie').load(url);
}

function searchForm()
{
	var url =  "";
	if($("#frm_movie #moviename").val() != "")
		url += "&moviename=" + encodeURI($("#frm_movie #moviename").val());
	
	

	
	if("<?php echo $_GET['opendialog']?>" == "true")
	{
		url += "&opendialog=true";
	}
	$('#listmovie').html(loading);
	$('#listmovie').load("?route=lotte/movie/getList"+url);
}

function moveto(url,eid)
{
	$(eid).html(loading);
	$(eid).load(url);	
}
</script>