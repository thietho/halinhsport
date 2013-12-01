
<script type="text/javascript" language="javascript">
	$(function() {
		$('#sanpham_noibat').carouFredSel({
			width: '100%',
			scroll: 1,
			prev: '#sanpham_noibat_prev',
			next: '#sanpham_noibat_next',
		});
	});
</script>

<style type="text/css" media="all">
 
	.list_carousel {
	}
	.list_carousel ul {
		margin: 0;
		padding: 0;
		list-style: none;
		display: block;
	}
	.list_carousel li {
		color: #999;
		text-align: center;
		padding: 0;
		margin: 2px;
		width:160px;
		margin-right:10px;
		display: block;
		float: left;
	}
	.list_carousel.responsive {
		width: auto;
		margin-left: 0;
	}

	#sanpham_noibat_prev {
		float: left;
		margin-left: 10px;
		font-size:20px;
		position: relative; margin-top:-145px
	}
	#sanpham_noibat_next {
		float: right;
		margin-right: 10px;
		font-size:20px;
		position: relative; margin-top:-145px
	}
	
</style>
<div class="list_carousel responsive">
	<div id="sanpham_noibat">
    	
    	<?php foreach($medias as $media) {?>
        <li class="sanpham_noibat_li link_hover" data-tooltip="sticky1" ref="<?php echo $media['imagetpreview']?>" title="<?php echo $media['title']?>" price="<?php echo $media['pricepromotion']==0?$this->string->numberFormate($media['price']):$this->string->numberFormate($media['pricepromotion']) ?> <?php echo $this->document->setup['Currency']?>" summary="<?php echo strip_tags($media['summary'])?>">
        	
        	<table>
                <tr class="product-list-image">
                    <td>
                        
                        <?php if($media['imagethumbnail'] !=""){ ?>
                        <a class="islink" href="<?php echo $media['link']?>" title="<?php echo $media['title']?><?php if($media['code']!="") echo ' - '.$media['code']?>"><img src="<?php echo $media['imagethumbnail']?>" class='ben-center' alt="<?php echo $media['title']?>" title="<?php echo $media['title']?>"/></a>
                        
                        <?php }?>
                            
                    </td>
                </tr>
                <tr>
                    <td>
                        <div align="center">
                            <a href="<?php echo $media['link']?>" title="<?php echo $media['title']?><?php if($media['code']!="") echo ' - '.$media['code']?>">
                                <h6>
                                    <?php echo $media['title']?>
                                </h6>
                                <?php if($media['code']!="") echo "<h6>".$media['code']."</h6>"?>
                            </a>
                        </div>
                        <?php $cls = '';?>
                        <?php if($media['pricepromotion']!=0){ ?>
                        <div align="center" class="product-pricepromotion">
                                
                                <?php if($media['pricepromotion']){ ?>
                                <?php $cls = 'product-price-no';?>
                                <?php echo $this->string->numberFormate($media['pricepromotion'])?> <?php echo $this->document->setup['Currency']?>
                                <?php } ?>
                        </div>
                        <?php } ?>
                        <div align="center" class="product-price <?php echo $cls?>"><?php echo $this->string->numberFormate($media['price'])?> <?php echo $this->document->setup['Currency']?></div>
                        <div align="center">
                            <!--<a href="<?php echo $media['link']?>" title="<?php echo $media['title']?><?php if($media['code']!="") echo ' - '.$media['code']?>">Chi tiết</a>-->
                            <input type="button" class="cart-order" value="Đặt hàng" onclick="cart.add('<?php echo $media['mediaid']?>')"/>
                        </div>
                    </td>
                </tr>
            </table>
			

			
		</li>
        
        <?php } ?>
		
		
	</div>
		<a class="" style="display: block;" id="sanpham_noibat_prev" href="#"><img src="<?php echo HTTP_SERVER.DIR_IMAGE?>prev.png" alt="prev" height="32" width="32"></a>
		<a class="" style="display: block;" id="sanpham_noibat_next" href="#"><img src="<?php echo HTTP_SERVER.DIR_IMAGE?>next.png" alt="next" height="32" width="32"></a>
</div>
