<div id="mediaplayer"></div>
<script type="text/javascript" src="<?php echo HTTP_SERVER.DIR_COMPONENT?>player/jwplayer.js"></script>
<script type="text/javascript">
	jwplayer("mediaplayer").setup({
		autostart: true,
		width:520,
		height:360,
		flashplayer: "<?php echo HTTP_SERVER.DIR_COMPONENT?>player/player.swf",
		file: "<?php echo HTTP_SERVER.DIR_FILE.$post['filepath']?>",
		image: "<?php echo $post['imagethumbnail']?>"
		
	});
</script>