<?php
class ControllerPageHome extends Controller
{
	function __construct() 
	{
		//$this->iscache = true;
	 	$arr=array();
		foreach($_GET as $key => $val)
			$arr[] = $key."=".$val;
	 	$this->name ="PageHome".implode("_",$arr);
   	}
	public function index()
	{
		if($this->cachehtml->iscacht($this->name) == false)
		{
			$arr = array('menu-chinh');
			$this->data['mainmenu'] = $this->loadModule('common/header','showMenu',$arr);
			//Banner home
			$template = array(
						  'template' => "home/bannerhome.tpl",
						  'width' => 894,
						  'height' =>894
						  );
		
			$arr = array("bannerhome",0,"",$template);
			$this->data['bannerhome'] = $this->loadModule('module/block','getList',$arr);
			//Tin nóng
			$template = array(
						  'template' => "home/news_list.tpl",
						  'width' => 514,
						  'height' =>514,
						  
						  );
			
			$medias = $this->getHomeMedias('module/news');
			
			$arr = array("",13,"",$template,$medias);
			$this->data['newshome'] = $this->loadModule('module/productlist','index',$arr);
			
			//San pham moi
			$template = array(
						  'template' => "module/product_list.tpl",
						  'width' => 170,
						  'height' =>170,
						  'paging' => false,
						  'sorting' =>false
						  );
			
			$medias = $this->getHomeMedias('module/product');
			
			$arr = array("",20,"",$template,$medias);
			$this->data['producthome'] = $this->loadModule('module/productlist','index',$arr);
			
			//San pham noi bat
			$template = array(
						  'template' => "home/product.tpl",
						  'width' => 170,
						  'height' =>170,
						  'paging' => false,
						  'sorting' =>false
						  );
			
			$medias = $this->getProduct('sanphamhot');
			//print_r($medias);
			$arr = array("",100000,"",$template,$medias);
			$this->data['producthot'] = $this->loadModule('module/productlist','index',$arr);
			/*$arr = array("gioithieu");
			$this->data['producthome'] = $this->loadModule('module/information','index',$arr);*/
			//
			
			$this->loadSiteBar();
			$this->document->title = $this->document->setup['Title'] ." - ". $this->document->setup['Slogan'];
			//print_r($this->data['leftsitebar']);
		}
		
		$this->id="content";
		$this->template="page/home.tpl";
		$this->layout="layout/home";
		$this->render();
	}
	
	private function loadSiteBar()
	{
		//Left sitebar
		$arr = array('san-pham');
		$this->data['leftsitebar']['produtcategory'] = $this->loadModule('sitebar/catalogue','index',$arr);
		$this->data['leftsitebar']['search'] = $this->loadModule('sitebar/searchproduct');
		$this->data['leftsitebar']['dknhantinh'] = $this->loadModule('sitebar/dangkynhantin');
		
		//$this->data['leftsitebar']['exchange'] = $this->loadModule('sitebar/exchange');
		
		$this->data['leftsitebar']['hitcounter'] = $this->loadModule('sitebar/hitcounter');
		
		//Rigth sitebar
		$this->data['rightsitebar']['cart'] = $this->loadModule('sitebar/cart');
		$this->data['rightsitebar']['login'] = $this->loadModule('sitebar/login');
		$this->data['rightsitebar']['supportonline'] = $this->loadModule('sitebar/supportonline');
		
		$template = array(
						  'template' => "sitebar/news.tpl",
						  'width' => 50,
						  'height' =>50
						  
						  );
		$arr = array('tin-tuc-san-pham',10,'',$template);
		$this->data['rightsitebar']['newsproduct'] = $this->loadModule('sitebar/news','index',$arr);
		$this->data['rightsitebar']['weblink'] = $this->loadModule('sitebar/weblink');
		//$this->data['rightsitebar']['search'] = $this->loadModule('sitebar/search');
		
		//$this->data['rightsitebar']['banner'] = $this->loadModule('sitebar/banner');
		//$this->data['rightsitebar']['question'] = $this->loadModule('sitebar/question');
	}
	
	function getHomeMedias($mediatype)
	{
		
		$this->load->model('core/media');
		//$siteid = $this->member->getSiteId();
		//$sitemaps = $this->model_core_sitemap->getListByModule("module/product", $siteid);
		//$arrsitemapid = $this->string->matrixToArray($sitemaps,"sitemapid");
		$queryoptions = array();
		$queryoptions['mediaparent'] = '';
		$queryoptions['mediatype'] = $mediatype;
		$queryoptions['refersitemap'] = '%';
		$data = $this->model_core_media->getPaginationList($queryoptions,$step=0,$to=0);
		
		return $data;
	}
	
	function getProduct($status)
	{
		$this->load->model('core/media');
		//$siteid = $this->member->getSiteId();
		//$sitemaps = $this->model_core_sitemap->getListByModule("module/product", $siteid);
		//$arrsitemapid = $this->string->matrixToArray($sitemaps,"sitemapid");
		$queryoptions = array();
		$queryoptions['mediaparent'] = '';
		$queryoptions['mediatype'] = 'module/product';
		$queryoptions['refersitemap'] = '%';
		$queryoptions['groupkeys'] = $status;
		$data = $this->model_core_media->getPaginationList($queryoptions, $step=0, $to=0);
		
		return $data;
	}
}
?>