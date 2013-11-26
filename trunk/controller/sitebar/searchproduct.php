<?php
class ControllerSitebarSearchproduct extends Controller
{
	public function index()
	{
		$this->load->model("core/category");
		$this->load->model("core/sitemap");
		$this->data['para'] = array();
		
		$para = $this->string->referSiteMapToArray($_GET['search']);
		
		if(count($para))
		{
			foreach($para as $val)
			{
				$ar = split("=",$val);
				$datasearch[$ar[0]] = $ar[1];	
			}
			
			$this->data['para'] = $datasearch;
		}
		
		$this->data['loaisp'] = array();
		$siteid = $this->member->getSiteId();
		$this->model_core_sitemap->getTreeSitemap("san-pham",$this->data['loaisp'],$siteid);
		unset($this->data['loaisp'][0]);
		
		$this->data['nhanhieu'] = array();
		$this->model_core_category->getTree("nhanhieu",$this->data['nhanhieu']);
		unset($this->data['nhanhieu'][0]);
		
		$this->data['gia'] = array();
		$this->model_core_category->getTree("gia",$this->data['gia']);
		unset($this->data['gia'][0]);
		
		$this->id="content";		
		$this->template="sitebar/searchproduct.tpl";
		
		$this->render();
	}
	
	
}
?>