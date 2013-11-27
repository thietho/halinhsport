<?php
class ControllerAddonSitemap extends Controller
{
	private $error = array();
	public function index()
	{
		$this->document->breadcrumb .= "Sơ đồ website";
		$arr = array('menu-chinh');
		$this->data['mainmenu'] = $this->loadModule('common/header','showMenu',$arr);
		$arr = array('san-pham');
		$this->data['sanpham'] = $this->loadModule('common/header','showMenu',$arr);
		$this->id="content";
		$this->template="addon/sitemap.tpl";
		$this->render();
	}
	
	
}
?>