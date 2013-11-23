<?php
class ControllerCommonValidate extends Controller
{	
	public function isemail()
	{	
		$str=$this->request->get['email'];
		if ($this->validation->_checkEmail($str) == false )
			$this->data['output']="Sai email";
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
	}
	
	public function isIP()
	{
		//print_r($_SERVER);
		//Luu vi tri va ip xuong db
		$this->load->model("core/media");
		$data = $this->request->post;
		$ip = $_SERVER['REMOTE_ADDR'];
		$this->model_core_media->saveInformation("locationallow", $data['location'], $ip);
		
		$this->data['output']="true";
		
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
	}
}
?>