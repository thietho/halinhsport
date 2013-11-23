<?php
class ControllerPageWarning extends Controller
{
	function __construct() 
	{
		
		
	}
	
	function index()
	{	
		
		
		$this->id='content';
		$this->template='page/warning.tpl';
		
		$this->render();
		
		
	}
	
}
?>