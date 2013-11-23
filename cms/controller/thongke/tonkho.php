<?php
class ControllerThongkeTonkho extends Controller
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
		$this->load->model("quanlykho/donvitinh");
	}
	public function index()
	{
		$this->thongke();
		$this->id='content';
		$this->template="thongke/tonkho.tpl";
		$this->layout="layout/center";
		$this->render();
	}
	public function thongke()
	{
		$this->load->model("core/sitemap");
		$this->load->model("core/media");
		//Lay cac danh muc san pham
		$where = " AND moduleid = 'module/product' AND sitemapparent =''";
		
		$data_sitemap = $this->model_core_sitemap->getList($this->user->getSiteId(), $where);
		
		
		$this->data["treeitemaps"]=array();
		foreach($data_sitemap as $sitemap)
		{
			$arrSiteMapTree = array();
			$this->model_core_sitemap->getTreeSitemap($sitemap['sitemapid'], $arrSiteMapTree, $this->user->getSiteId());
			foreach($arrSiteMapTree as $key => $item)
			{
				$where = " AND refersitemap like '%[".$item['sitemapid']."]%'";	
				$where .= " Order by position, statusdate DESC";
				$data_pro = $this->model_core_media->getList($where);
				//$this->model_core_media->getTonKho($price['mediaid']);
				foreach($data_pro as $i => $media)
				{
					$data_pro[$i]['tonkho']	= $this->model_core_media->viewTonKho($media['mediaid']);
				}
				$arrSiteMapTree[$key]['data_product'] = $data_pro;
			}
			$this->data["treeitemaps"][$sitemap['sitemapid']] = $arrSiteMapTree;
			
		}
		
		//print_r($this->data["treeitemaps"]);
		
	}
	
}
?>