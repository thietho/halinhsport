	<div id="listpoduct">
    	<table>
        	<?php for($i=0;$i<count($medias);){ ?>
            <tr>
            	
                <td>
                	<?php $media = $medias[$i]?>
                    <?php $i++?>
                    <?php if(count($media)){ ?>
                    <table class="link_hover" data-tooltip="sticky1" ref="<?php echo $media['imagetpreview']?>" title="<?php echo $media['title']?>" price="<?php echo $media['pricepromotion']==0?$this->string->numberFormate($media['price']):$this->string->numberFormate($media['pricepromotion']) ?> <?php echo $this->document->setup['Currency']?>" summary="<?php echo strip_tags($media['summary'])?>">
                        <tr class="product-list-image">
                            
                            <td width="80%">
                                <div>
                                    <a href="<?php echo $media['link']?>" title="<?php echo $media['title']?><?php if($media['code']!="") echo ' - '.$media['code']?>">
                                        <h6>
                                            <?php echo $media['title']?>
                                        </h6>
                                        <?php if($media['code']!="") echo "<h6>".$media['code']."</h6>"?>
                                    </a>
                                </div>
                            </td>
                            <td>
                                <?php $cls = '';?>
                                <?php if($media['pricepromotion']!=0){ ?>
                                <div class="product-pricepromotion">
                                        
                                        <?php if($media['pricepromotion']){ ?>
                                        <?php $cls = 'product-price-no';?>
                                        <?php echo $this->string->numberFormate($media['pricepromotion'])?> <?php echo $this->document->setup['Currency']?>
                                        <?php } ?>
                                </div>
                                <?php } ?>
                                <div class="product-price <?php echo $cls?>"><?php echo $this->string->numberFormate($media['price'])?> <?php echo $this->document->setup['Currency']?></div>
                                <div>
                                    <!--<a href="<?php echo $media['link']?>" title="<?php echo $media['title']?><?php if($media['code']!="") echo ' - '.$media['code']?>">Chi tiết</a>-->
                                    <input type="button" class="cart-order" value="Đặt hàng" onclick="cart.add('<?php echo $media['mediaid']?>')"/>
                                </div>
                            </td>
                        </tr>
                        
                    </table>
                    <?php } ?>
                </td>
                
            </tr>
            <?php } ?>
        </table>
        
    </div>