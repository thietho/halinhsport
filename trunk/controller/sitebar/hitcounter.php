<?php
class ControllerSitebarHitcounter extends Controller
{
	public function index()
	{
		
		$this->id="content";
		$this->template="sitebar/hitcounter.tpl";
		$this->render();
	}
	
	
}
?>