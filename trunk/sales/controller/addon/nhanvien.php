<?php
class ControllerAddonNhanVien extends Controller
{
	private $error = array();
	
	
	public function profile()
	{
		$this->data['nhanvien'] = $this->user->getNhanVien();
		
		$this->id='content';
		$this->template = 'addon/nhanvien_profile.tpl';
		
		$this->render();
	}
}
?>