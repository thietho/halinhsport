<?php
class ControllerSitebarGallery extends Controller
{
	public function index()
	{
		
		$this->id="content";
		$this->template="sitebar/gallery.tpl";
		$this->render();
	}
	

}
?>