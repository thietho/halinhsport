<?php echo $content?>
<?php
if(count($medias))
{
?>
<?php if($sorting){ ?>
   	<div class="ben-post">
        <select id="order" class="ben-textbox ben-right" onchange="window.location = '?order='+this.value">
            <option value="new">Mới</option>
            <option value="gt">Giá tăng dần</option>
            <option value="gg">Giá giảm dần</option>
            <option value="az">Tên: A-Z</option>
        </select>
<script language="javascript">
$('#order').val('<?php echo $_GET["order"]?>');
</script>
        <div class="clearer">&nbsp;</div>
        
    </div>
    	<?php } ?>
        <?php if($paging){ ?>
    <?php echo $pager?>
    <div class="clearer">&nbsp;</div>
    <?php } ?>
<div id="listpoduct">
	<?php foreach($medias as $media) {?>
    <div class="ben-left product link_hover" data-tooltip="sticky1" ref="<?php echo $media['imagetpreview']?>" title="<?php echo $media['keyword']?>">
        <table>
            <tr class="product-list-image">
                <td>
                	<?php if($media['discountpercent']){ ?>
                	<div class="flagdiscount ben-icon">-<?php echo $media['discountpercent']?>%</div>
                    <?php } ?>
                	<?php if(in_array("sanphamhot",$media['properties'])){ ?>
                	<div id="ben-icon-hot" class="ben-icon">
                    	<img src="<?php echo HTTP_SERVER.DIR_IMAGE?>icon/ico-hot.png" />
                    </div>
                    <?php } ?>
                    <?php if(in_array("sanphamkhuyenmai",$media['properties'])){ ?>
                    <div id="ben-icon-sale" class="ben-icon">
                    	<img src="<?php echo HTTP_SERVER.DIR_IMAGE?>icon/ico-sale.png" />
                    </div>
                    <?php } ?>
                    <?php if(in_array("sanphammoi",$media['properties'])){ ?>
                    <div id="ben-icon-new" class="ben-icon">
                    	<img src="<?php echo HTTP_SERVER.DIR_IMAGE?>icon/ico-new.png" />
                    </div>
                    <?php } ?>
                    <?php if($media['imagethumbnail'] !=""){ ?>
                    <a class="islink" href="<?php echo $media['link']?>" title="<?php echo $media['title']?><?php if($media['code']!="") echo ' - '.$media['code']?>"><img src='<?php echo $media['imagethumbnail']?>' class='ben-center' alt="<?php echo $media['title']?>" title="<?php echo $media['title']?>"/></a>
                    
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
                        <a href="<?php echo $media['link']?>" title="<?php echo $media['title']?><?php if($media['code']!="") echo ' - '.$media['code']?>">Chi tiết</a><!-- || <a onclick="cart.add('<?php echo $media['mediaid']?>')">Đặt hàng</a>-->
                    </div>
                </td>
            </tr>
        </table>
        
        
        
        
    </div>
    <?php } ?>
</div>
    


<div class="clearer">&nbsp;</div>
<?php echo $pager?>
<?php
}
?>
