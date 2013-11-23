<div class="section">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content">
    	<h3>Số lượng sản phẩm đang tồn kho tính đến ngày <?php echo $this->date->formatMySQLDate($this->date->getTodayNoTime())?></h3>
		<table class="data-table">
            <thead>
                <tr>
                	<th>Mã sản phẩm</th>
                    <th>Tên sản phẩm</th>
                    <th>Số lượng</th>
                    
                    
                </tr>
            </thead>
            <tbody>
            <?php foreach($treeitemaps as $sitemapid => $data_sitemap){ ?>
            	<?php foreach($data_sitemap as $sitemap){ ?>
                <tr>
                	<td colspan="3"><strong style="margin:<?php echo $sitemap['level']*10?>px"><?php echo $sitemap['sitemapname']?></strong></td>
                </tr>
                
                	<?php foreach($sitemap['data_product'] as $media){ ?>
                    	
                <tr>
                	<td><?php echo $media['tonkho']['main']['code']?></td>
                    <td><?php echo $media['tonkho']['main']['title']?></td>
                    <td>
                    	<?php echo $media['tonkho']['main']['tonkho']?>
                        
                    </td>
                </tr>   
                		<?php foreach($media['tonkho']['prices'] as $price){?> 
                <tr class="subprice">
                	<td><?php echo $price['code']?></td>
                    <td><?php echo $media['title']?> - <?php echo $price['title']?></td>
                    <td>
                    	<?php echo $price['tonkho']?>
                        
                    </td>
                </tr>   
                		<?php } ?>
                    <?php } ?>
                <?php } ?>
            <?php } ?>
            </tbody>
        </table>    	
        
        
    </div>
    
</div>
