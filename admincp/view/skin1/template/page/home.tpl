<div id="main-content">
	<?php foreach($group as $key => $item){ ?>
    <?php if(in_array($item['moduleid'],$allow_modules)){?>
    <div class="qlk_group">
    	<div class="title"><?php echo $item['modulename']?></div>
        <div class="clearer">&nbsp;</div>
        <?php foreach($item['module'] as $module ){ ?>
        <?php if(in_array($module['moduleid'],$allow_modules)){?>
        <a href="?route=<?php echo $module['moduleid']?>">
        	<div class="qlk_icon left">
            	<table>
                	<tr>
                    	<td><?php echo $module['modulename']?></td>
                    </tr>
                </table>
        		
            </div>
        </a>
        <?php } ?>
        <?php } ?>
        <div class="clearer">&nbsp;</div>
    </div>
    <?php } ?>
    <?php } ?>
</div>
