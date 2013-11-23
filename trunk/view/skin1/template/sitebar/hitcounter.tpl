<div class="ben-section">

	<div class="ben-section-title">Số lượt truy cập</div>
    
    <div class="ben-section-content">
    	<p>
        	Tổng số lược truy cập: <?php echo $this->member->getHitCounter();?>
        </p>
    	<p>
        	Số người đang online: <?php echo $this->member->getOnline();?>
        </p>
    	<p>
        	Tổng số lược truy cập trong tháng: <?php echo $this->member->getOnlineInMonth();?>
        </p>
    	
    </div>

</div>