<?php
class ControllerPageHome extends Controller
{
	public function index()
	{
		$this->load->model("core/module");
		$this->user->getUserTypeId();
		//Lay cac module thuot usertype do ngoai admin
		if($this->user->getUserTypeId() != 'admin')
		{
			$this->data['allow_modules'] = $this->user->getAllowModule();
		}
		else
		{
			
			$allow_modules = $this->model_core_module->getList($where);
			$this->data['allow_modules'] = $this->string->matrixToArray($allow_modules,'moduleid');
		}
		
		$this->data['group'] = $this->model_core_module->getChild(0);
		
		foreach($this->data['group'] as $key => $item)
		{
			$this->data['group'][$key]['module'] = $this->model_core_module->getChild($item['id']);
		}
		
		$this->id="content";
		$this->template="page/home.tpl";
		$this->layout="layout/center";
		//$this->response->redirect('?route=core/message');
		$this->render();
	}
}
?>