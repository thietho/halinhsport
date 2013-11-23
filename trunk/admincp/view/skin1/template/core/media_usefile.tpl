<h3>Các bài viết sử dụng</h3>
<table>
	<?php foreach($medias as $media){ ?>
	<tr>
    	<td><?php echo $media['title']?></td>
        <td><?php echo $this->document->mediatypes[$media['mediatype']]?></td>
    </tr>
    <?php } ?>
</table>