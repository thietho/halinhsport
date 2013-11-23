<?php
class ControllerCoreContent extends Controller
{
	private $error = array();
	private $route;
	public function __construct() 
	{
		$this->load->model("core/media");
		$this->load->model("quanlykho/donvitinh");
		$this->load->model("core/sitemap");
		$this->load->helper('image');
		
		
	}
	
	public function index()
	{
		$this->data['sidebar'] = $this->loadModule('common/leftsidebar');
		
		
		$this->id='content';
		$this->template="core/content.tpl";
		$this->layout="layout/center";
		
		$this->render();
	}
}