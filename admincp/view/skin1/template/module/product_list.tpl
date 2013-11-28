			<?php echo $pager?>
			<table class="data-table" width="100%">
            
            	<thead>
                	<th width="10%"><?php echo $column_position?></th>
                    <th>ID</th>
                    <th>Model</th>
                    <th>Tên sản phẩm</th>
                    <th>Giá bán</th>
                    <th>Giá</th>
                    <th>Giảm</th>
                    <th>Giá khuyến mãi</th>
                    <th width="200px">Tồn kho</th>
   
                    
                    <th>ĐVT</th>
                    <th>Nhãn hiệu</th>
                    <th>Trạng thái</th>
                    <th>Hình</th>
                    <th></th>
                </thead>
                
                <tbody>
                    <?php foreach($medias as $key => $media) {?>
                	<tr>
                    	<td>
                        	<input type="checkbox" value="<?php echo $media['mediaid']?>" name="delete[<?php echo $media['mediaid']?>]" class="inputchk">
                            <input type="text" class="text number" name="position[<?php echo $media['mediaid']?>]" value="<?php echo $key+1?>" size="3"/>
                        </td>
                        <td><b><?php echo $media['mediaid']?></b></td>
                        <td><b><?php echo $media['code']?></b></td>
                    	<td>
                        	<b><?php echo $media['title']?></b><br />
                            <?php echo $media['color']?>
                        </td>
                        <td class="number">
                        	<?php if(count($media['saleprice'])){ ?>
                            <ul>
                                <?php foreach($media['saleprice'] as $k => $price){ ?>
                            	<li><?php echo $this->string->numberFormate($price)?>/<?php echo $this->document->getDonViTinh($k)?></li>
                            <?php } ?>
                            </ul>
                            <?php } ?>
                        </td>
                        <td class="number">
                            <b><?php echo $this->string->numberFormate($media['price'])?></b>
                        </td>
                        <td class="number">
                            <b><?php echo $this->string->numberFormate($media['discountpercent'])?>%</b>
                        </td>
                        <td class="number"><b><?php echo $this->string->numberFormate($media['pricepromotion'])?></b></td>
                        <td class="number">
                        	<?php echo $media['tonkho']?>
                            
                        </td>
                       
                        
                        <td><b><?php echo $this->document->getDonViTinh($media['unit'])?></b>&nbsp;</td>
                        <td><?php echo $this->document->getCategory($media['brand'])?></td>
                        <td><?php echo $this->document->status_media[$media['status']]?></td>
                        <td align="center"><?php echo $media['imagepreview']?>&nbsp;</td>
                        <td>
                        	<?php if($this->user->checkPermission("module/product/update")==true){ ?>
                        	
                            <input type="button" class="button" value="<?php echo $media['text_edit']?>" onclick="window.location='<?php echo $media['link_edit']?>'"/>
                            <?php } ?>
                            <?php if($this->user->checkPermission("module/product/insert")==true){ ?>
                  			
                            <input type="button" class="button" value="<?php echo $media['text_addchild']?>" onclick="window.location='<?php echo $media['link_addchild']?>'"/>
                            <input type="button" class="button enterGroup" value="Đưa vào nhóm" onclick="pro.enterGroup('<?php echo $media['mediaid']?>')"/>
                            <input type="button" class="button selectGroup" value="Chọn" onclick="pro.selectGroup('<?php echo $media['mediaid']?>')"/>
                            <?php }?>
                            <input type="button" class="button" value="Lịch sử" onclick="pro.history('<?php echo $media['mediaid']?>')"/>
                            <?php if(count($media['child'])==0){ ?>
                            
                            <input type="button" class="button" value="Đưa vào danh sách" onclick="pro.addToList('<?php echo $media['mediaid']?>')"/>
                            
                            <?php } ?>
                        </td>
                    </tr>
                    	<?php if(count($media['child'])){ ?>
                    
                            <?php foreach($media['child'] as $k => $child){ ?>
                                <tr class="media-child">
                                    <td>
                                        <input type="checkbox" value="<?php echo $child['mediaid']?>" name="delete[<?php echo $child['mediaid']?>]" class="inputchk">
                                        <input type="text" class="text number" name="position[<?php echo $child['mediaid']?>]" value="<?php echo $k +1?>" size="3"/>
                                    </td>
                                    
                                    <td><b><?php echo $child['code']?></b>&nbsp;</td>
                                	<td><b><?php echo $child['title']?></b></td>
                                    <td class="number">
                                    	<?php if(count($child['saleprice'])){ ?>
                                        <ul>
                                        <?php foreach($child['saleprice'] as $k => $price){ ?>
                                        <li><?php echo $this->string->numberFormate($price)?>/<?php echo $this->document->getDonViTinh($k)?></li>
                                        <?php } ?>
                                        </ul>
                                        <?php } ?>
                                    </td>
                                    <td class="number">
                                    
                                        <b><?php echo $this->string->numberFormate($child['price'])?></b>
                                        
                                   
                                    </td>
                                    <td class="number">
                                        <b><?php echo $this->string->numberFormate($child['discountpercent'])?>%</b>
                                    </td>
                                    <td class="number"><b><?php echo $this->string->numberFormate($child['pricepromotion'])?></b>&nbsp;</td>
                                    <td class="number">
                                        <?php echo $child['tonkho']?>
                                    </td>
                                   
                                    
                                    <td><b><?php echo $this->document->getDonViTinh($child['unit'])?></b>&nbsp;</td>
                                    <td><?php echo $this->document->getCategory($child['brand'])?></td>
                                    <td><?php echo $this->document->status_media[$child['status']]?></td>
                                    <td align="center"><?php echo $child['imagepreview']?>&nbsp;</td>
                                    
                                    <td>
                                        <?php if($this->user->checkPermission("module/product/update")==true){ ?>
                                        
                                        <input type="button" class="button" value="<?php echo $media['text_edit']?>" onclick="window.location='<?php echo $child['link_edit']?>'"/>
                                        <?php } ?>
                                       	<input type="button" class="button" value="Ra ngoài nhóm" onclick="pro.outGroup('<?php echo $child['mediaid']?>')"/>
                                        <input type="button" class="button" value="Lịch sử" onclick="pro.history('<?php echo $child['mediaid']?>')"/>
                                        <input type="button" class="button" value="Đưa vào danh sách" onclick="pro.addToList('<?php echo $child['mediaid']?>')"/>
                                    </td>
                                </tr> 
                            <?php } ?>
                            
                        	
                        <?php } ?>
                    <?php } ?>                	
                	
                </tbody>
            
            </table>
            <?php echo $pager?>
            <div class="clearer">&nbsp;</div>
