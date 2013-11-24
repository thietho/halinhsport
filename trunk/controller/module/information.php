<?php
class ControllerModuleInformation extends Controller
{
	/*function __construct() 
	{
		$this->iscache = true;
	 	$this->name ="Information".$this->document->sitemapid;
   	}*/
	public function index($sitemapid="")
	{
		$this->load->model("core/media");
		
		if($sitemapid=="")
			$sitemapid = $this->document->sitemapid;
		
		
		$this->data['media'] = $this->model_core_media->getItem($this->member->getSiteId().$sitemapid);
		$this->document->title .= " - ".$this->data['media']['title'];
		if(count($this->data['media']) == 0)
		{
			$this->data['media']['description'] = "Updating...";
		}
		$this->document->meta_description = strip_tags($this->data['media']['description']);
		$this->data['media']['description'] = html_entity_decode($this->data['media']['description']);
		$this->data['child'] = $this->model_core_media->getListByParent($this->member->getSiteId().$sitemapid," AND mediatype = 'subinfor' Order by position");
		
		$this->id="information";
		$this->template="module/information.tpl";
		$this->render();
	}
}
?>