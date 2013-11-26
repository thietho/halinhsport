<?php
class ControllerAddonNhantin extends Controller
{
	private $error = array();
   	function __construct() 
	{
		if(!$this->user->hasPermission($this->getRoute(), "access"))
		{
			$this->response->redirect("?route=common/permission");
		}
		$this->data['permissionAdd'] = true;
		$this->data['permissionEdit'] = true;
		$this->data['permissionDelete'] = true;
		if(!$this->user->hasPermission($this->getRoute(), "add"))
		{
			$this->data['permissionAdd'] = false;
		}
		if(!$this->user->hasPermission($this->getRoute(), "edit"))
		{
			$this->data['permissionEdit'] = false;
		}
		if(!$this->user->hasPermission($this->getRoute(), "delete"))
		{
			$this->data['permissionDelete'] = false;
		}
		
		$this->load->model("addon/nhantin");
		
   	}
	
	public function index()
	{
		$this->getList();
	}
	
	private function getList()
	{
		$this->data['datas'] = $this->model_addon_nhantin->getList();
		
		$this->id='content';
		$this->template="addon/nhantin_list.tpl";
		$this->layout="layout/center";
		$this->render();	
	}
}
?>