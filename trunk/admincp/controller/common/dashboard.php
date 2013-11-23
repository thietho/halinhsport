<?php
class ControllerCommonDashboard extends Controller
{
	function __construct() 
	{
		$this->data['rowmainbanner'] = 4;
	}
	function index()
	{	
		$this->getForm();
		$this->id='content';
		$this->template='common/dashboard.tpl';
		$this->layout="layout/center";
		$this->render();
	}
	
	private function getForm()
	{
		
		$this->load->model("core/media");
		$this->load->model("core/category");
		$this->data['item']['mediaid'] = "setting";
		$this->data['item']['Title'] = $this->model_core_media->getInformation($this->data['item']['mediaid'], 'Title');
		$this->data['item']['Slogan'] = $this->model_core_media->getInformation($this->data['item']['mediaid'], 'Slogan');
		$this->data['item']['Currency'] = $this->model_core_media->getInformation($this->data['item']['mediaid'], 'Currency');
		$this->data['item']['EmailContact'] = $this->model_core_media->getInformation($this->data['item']['mediaid'], 'EmailContact');
		$this->data['item']['Keyword'] = $this->model_core_media->getInformation($this->data['item']['mediaid'], 'Keyword');
		$this->data['item']['Description'] = $this->model_core_media->getInformation($this->data['item']['mediaid'], 'Description');
		
		
		$this->data['item']['brochure'] = $this->model_core_media->getInformation($this->data['item']['mediaid'], 'brochure');
	}
	
	public function save()
	{
		$data = $this->request->post;
		
		$this->load->model("core/media");
		//Save setting
		$this->model_core_media->saveInformation($data['mediaid'],"Title",$data['Title']);
		$this->model_core_media->saveInformation($data['mediaid'],"Slogan",$data['Slogan']);
		$this->model_core_media->saveInformation($data['mediaid'],"Currency",$data['Currency']);
		$this->model_core_media->saveInformation($data['mediaid'],"EmailContact",$data['EmailContact']);
		$this->model_core_media->saveInformation($data['mediaid'],"Keyword",$data['Keyword']);
		$this->model_core_media->saveInformation($data['mediaid'],"Description",$data['Description']);
		
		$this->model_core_media->saveInformation($data['mediaid'],"brochure",$data['brochure']);
		$this->data['output'] = "true";
		
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
}
?>