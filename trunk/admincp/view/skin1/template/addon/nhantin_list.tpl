<div class="section">

	<div class="section-title">Danh sách đăng ký nhận tin</div>
    
    <div class="section-content">
    	
        <form action="" method="post" id="listitem" name="listitem">
            <div class="clearer">^&nbsp;</div>
            
            <div class="sitemap treeindex">
                <table class="data-table" cellpadding="0" cellspacing="0">
                <tbody>
                    <tr class="tr-head">
                        
                        
                        <th>Họ tên</th>
                        <th>Email</th>
                        <th>Ngày đăng ký</th>                    
                                                    
                    </tr>
        
        
        <?php
            foreach($datas as $item)
            {
        ?>
                    <tr>
                       
                        
                        <td><?php echo $item['hoten']?></td>
                        <td><?php echo $item['email']?></td>
                		<td><?php echo $this->date->formatMySQLDate($item['ngaydangky'],'longdate')?></td>
                        
                    </tr>
        <?php
            }
        ?>
                        
                                                    
                </tbody>
                </table>
            </div>
        	<?php echo $pager?>
        
        </form>
        
    </div>
    
</div>