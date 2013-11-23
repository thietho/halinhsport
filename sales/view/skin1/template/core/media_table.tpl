			<?php echo $pager?>
            <table class="data-table" cellpadding="0" cellspacing="0">
                <tbody>
                    <tr class="tr-head">
                        <th width="1%"><input class="inputchk" type="checkbox" onclick="$('input[name*=\'delete\']').attr('checked', this.checked);"></th>
                        
                        <th><?php echo $lbl_title ?></th>
<!--                    <th>Tắc giả</th>
                        <th>Loại</th>-->                        
                        <th><?php echo $lbl_category ?></th>
                        <th><?php echo $lbl_date ?></th>
                        <th><?php echo $lbl_image ?></th>                 
                        <th width='150px'><?php echo $text_control ?></th>                                  
                    </tr>
        
        
        <?php
            foreach($medias as $item)
            {
        ?>
                    <tr>
                        <td class="check-column"><input class="inputchk" type="checkbox" name="delete[<?php echo $item['mediaid']?>]" value="<?php echo $item['mediaid']?>" ></td>
                        
                        <td><?php echo $item['title']?></td>
                        
                        <!--<td><?php echo $item['fullname']?></td>
                        <td><?php echo $item['typename']?></td>-->
                		<td><?php echo $item['sitemapnames']?></td>
                        <td><?php echo $this->date->formatMySQLDate($item['statusdate'],'longdate')?></td>
                        <td><?php echo $item['imagepreview']?></td>
                        <td class="link-control">
                            <a class="button" href="<?php echo $item['link_edit']?>" title="<?php echo $item['text_edit']?>"><?php echo $button_edit?></a>
                            <?php echo $item['btnMap']?>
                        </td>
                    </tr>
        <?php
            }
        ?>
                        
                                                    
                </tbody>
            </table>
            <?php echo $pager?>