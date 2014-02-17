<div id="desscription_<?php echo $sitemap['sitemapid']?>" style="display:none">
	<strong><?php echo $item['title']?></strong><br><?php echo html_entity_decode($item['description'])?>
</div>

<script type="text/javascript">

var pos = 0;
var flagedit=false;
var x = parseFloat("<?php echo $location['x']?>");
var y = parseFloat("<?php echo $location['y']?>");
var zoom = parseInt("<?php echo $location['zoom']?>");
	


function initialize(x,y,zoom) 
{
	
	geocoder = new google.maps.Geocoder();
	var latlng = new google.maps.LatLng(x, y);
	var myOptions = 
	{
	  zoom: zoom,
	  center: latlng,
	  mapTypeId: google.maps.MapTypeId.ROADMAP
	}
	var map = new google.maps.Map(document.getElementById("map_canvas_<?php echo $sitemap['sitemapid']?>"), myOptions);
	
	var markerobj = new google.maps.Marker({
			map: map, 
			position: latlng,
			draggable:false
					});
	 var contentString = $("#desscription_<?php echo $sitemap['sitemapid']?>").html();
        
    var infowindow = new google.maps.InfoWindow({
        content: contentString,
        maxWidth: 200
    });
	google.maps.event.addListener(markerobj, 'click', function() {
      infowindow.open(map,markerobj);
    });
	
}


</script>
<div id="map_canvas_<?php echo $sitemap['sitemapid']?>" style="width: 100%; height: 600px;"></div>
<script language="javascript">

	initialize(x,y,zoom);
	
</script>
 