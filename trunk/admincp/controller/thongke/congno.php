<?php
class ControllerThongkeCongno extends Controller
{
	private $error = array();
	function __construct() 
	{
		$this->load->model("core/module");
		$moduleid = $_GET['route'];
		$this->document->title = $this->model_core_module->getBreadcrumbs($moduleid);
		if($this->user->checkPermission($moduleid)==false)
		{
			$this->response->redirect('?route=page/home');
		}
		$this->load->model("core/user");
		$this->load->model("quanlykho/phieunhapxuat");
		$this->load->model("addon/thuchi");
		$this->load->model("quanlykho/nhacungcap");
	}
	public function index()
	{
		$this->data['users'] = array();
		$rows = $this->model_core_user->getList(" Order by fullname");
		$this->data['tongcongno'] = 0;
		foreach($rows as $i => $row)
		{
			
			$arr = array($row['id']);
			$congno = $this->loadModule("core/member","getCongNo",$arr);
			if($congno!="0")
			{
				$this->data['users'][$i] = $row;
				$this->data['users'][$i]['congno'] = $congno;
				$this->data['tongcongno'] +=  $congno;
			}
		}
		//
		$this->data['nhacungcap'] = array();
		$this->data['tongcongnoncc'] = 0;
		$rows = $this->model_quanlykho_nhacungcap->getList();
		foreach($rows as $i => $row)
		{
			$arr = array($row['id']);
			
			$congno = $this->loadModule("quanlykho/nhacungcap","getCongNo",$arr);
			if($congno!="0")
			{
				$this->data['nhacungcap'][$i]=$row;
				$this->data['nhacungcap'][$i]['congno'] = $congno;
				$this->data['tongcongnoncc'] +=  $congno;
			}
			
		}
		
		$this->id='content';
		$this->template="thongke/congno.tpl";
		$this->layout="layout/center";
		$this->render();
	}
	
	
	
}
?>