<?php
class ControllerCommonControl extends Controller
{
	public function numPad()
	{
		
		$this->id='content';
		$this->template='common/numpad.tpl';
		$this->render();
	}
}
?>