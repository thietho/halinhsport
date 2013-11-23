<div id="login" class="section">

    <div class="section-title"><?php echo $heading_title?></div>

    <div class="section-content">
        <form action="" method="post">
        	<?php if($error['error_warning']) {?>
            <div class="error"><?php echo $error_warning?></div>
             <div class="clearer">&nbsp;</div>
            <?php } ?>
            <div class="col2 left">
                	
                    <div>
                        
                        <p>
                            <label for="username"><?php echo $lbl_username ?></label><br>
                            <input type="text" class="text" id="username" name="username"  value="<?php echo $username?>" />
                        </p>
                        <p>
                            <label for="password"><?php echo $lbl_password ?></label><br>
                            <input type="password" class="text" id="password" name="password" />
                        </p>
                        <!--                        
                        <p>
                            <label for="password">Website</label><br>
                            <select name="siteid">
                                <?php foreach($sites as $site) {?>
                                    <option value="<?php echo $site['siteid']?>"><?php echo $site['sitename']?></option>
                                <?php } ?>
                            </select>
                        </p>
                        -->                        
                        <p>
                            <label for="password"><?php echo $security_code ?></label><br>
                            <img src="<?php echo $security?>" /><br />
                            <input type="text" class="text" name="code" />
                        </p>
                    </div>			
                
            </div>
            
            <div class="col2 right">
                <img width="128" src="<?php echo DIR_IMAGE?>lock.png" alt="" class="left" />
            </div>
            
            <div class="clearer">&nbsp;</div>
            
            <p>
                <input type="submit" class="button" id="btnsubmit" name="btnsubmit" value="<?php echo $button_login ?>" />&nbsp;
                <input type="button" class="button" id="btnsubmit" name="btnquenmatkhau" value="<?php echo $button_forgot_pass ?>" onclick="window.location='?route=common/forgotpassword'"/>
            </p>
        </form>
    </div>
    
</div>