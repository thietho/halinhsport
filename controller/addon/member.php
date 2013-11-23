<?php
class ControllerAddonMember extends Controller
{
	private $error = array();
	public function index()
	{
		$this->document->breadcrumb .= "Thông tin thành viên";
		
		$this->load->model("core/user");
		$this->data['member'] = $this->model_core_user->getItem($this->member->getId());
		$this->id="content";
		$this->template="addon/member.tpl";
		$this->render();
	}
	
}
?>