<?php
class ControllerPageDetail extends Controller
{
	function __construct() 
	{
		//$this->iscache = true;
		$arr=array();
		foreach($_GET as $key => $val)
			$arr[] = $key."=".$val;
	 	$this->name ="Pagedetail_".implode("_",$arr);
   	}
	public function index()
	{
		if($this->cachehtml->iscacht($this->name) == false)
		{
			$arr = array('menu-chinh');
			$this->data['mainmenu'] = $this->loadModule('common/header','showMenu',$arr);
			
			$this->load->model("core/sitemap");
			$this->document->sitemapid = $this->request->get['sitemapid'];
			$siteid = $this->member->getSiteId();
			
			
			@$id = $this->request->get['id'];
			
			$this->document->breadcrumb = $this->model_core_sitemap->getBreadcrumb($this->document->sitemapid, $siteid, -1);
			
			if($this->document->sitemapid != "")
			{
				$sitemap = $this->model_core_sitemap->getItem($this->document->sitemapid, $siteid);
				
				switch($sitemap['moduleid'])
				{
					case "":
						$this->data['module'] = $this->loadModule('addon/'.$this->document->sitemapid);
					break;
					case "group":
						$this->data['module'] = $this->loadModule('group/'.$this->document->sitemapid);
					break;
					case "module/information":
						$this->data['module'] = $this->loadModule('module/information');
					break;
					case "module/location":
						$this->data['module'] = $this->loadModule('module/location');
					break;
					case "module/banner":
						if($id == "")
						{
							$template = array(
											  'template' => "module/news_list.tpl",
											  'width' => 180,
											  'height' =>180
											  );
							$arr = array("",10,"",$template);
							
							$this->data['module'] = $this->loadModule('module/pagelist','getList',$arr);
						}
						else
						{
							$template = array(
										  'template' => "module/banner_detail.tpl",
										  'width' => 176,
										  'height' =>176
										  );
							$arr = array("",8,$template);
							$this->data['module'] = $this->loadModule('module/pagedetail','getForm',$arr);
						}
					break;
					case "module/news":
						if($id == "")
						{
							$template = array(
											  'template' => "module/news_list.tpl",
											  'width' => 180,
											  'height' =>180
											  );
							$arr = array("",10,"",$template);
							
							$this->data['module'] = $this->loadModule('module/pagelist','getList',$arr);
						}
						else
						{
							$template = array(
										  'template' => "module/news_detail.tpl",
										  'width' => 176,
										  'height' =>176
										  );
							$arr = array("",8,$template);
							$this->data['module'] = $this->loadModule('module/pagedetail','getForm',$arr);
						}
					break;
					case "module/register":
						if($id == "")
						{
							$this->load->model('core/media');
							$where = " AND refersitemap like '%[".$this->document->sitemapid."]%'";
							$medias = $this->model_core_media->getList($where);
							if(count($medias)==1)
							{
								$link = $this->document->createLink($this->document->sitemapid,$medias[0]['alias']);
								$this->response->redirect($link);
							}
							$template = array(
											  'template' => "module/news_list.tpl",
											  'width' => 180,
											  'height' =>180
											  );
							$arr = array("",10,"",$template);
							
							$this->data['module'] = $this->loadModule('module/pagelist','getList',$arr);
						}
						else
						{
							$template = array(
										  'template' => "module/register_detail.tpl",
										  'width' => 176,
										  'height' =>176
										  );
							$arr = array("",8,$template);
							$this->data['module'] = $this->loadModule('module/pagedetail','getForm',$arr);
						}
					break;
					case "module/download":
						if($id == "")
						{
							$template = array(
											  'template' => "module/news_list.tpl",
											  'width' => 180,
											  'height' =>180
											  );
							$arr = array("",10,"",$template);
							
							$this->data['module'] = $this->loadModule('module/pagelist','getList',$arr);
						}
						else
						{
							$template = array(
										  'template' => "module/download_detail.tpl",
										  'width' => 176,
										  'height' =>176
										  );
							$arr = array("",8,$template);
							$this->data['module'] = $this->loadModule('module/pagedetail','getForm',$arr);
						}
					break;
					case "module/video":
						if($id == "")
						{
							$template = array(
											  'template' => "module/news_list.tpl",
											  'width' => 180,
											  'height' =>180
											  );
							$arr = array("",10,"",$template);
							
							$this->data['module'] = $this->loadModule('module/pagelist','getList',$arr);
						}
						else
						{
							$template = array(
										  'template' => "module/video_detail.tpl",
										  'width' => 176,
										  'height' =>176
										  );
							$arr = array("",8,$template);
							$this->data['module'] = $this->loadModule('module/pagedetail','getForm',$arr);
						}
					break;
					case "module/product":
						if($id == "")
						{
							$template = array(
											  'template' => "module/product_list.tpl",
											  'width' => 170,
											  'height' =>170,
											  'widthpreview' => 450,
						 		 			  'heightpreview' =>450,
											  'paging' => true,
											  'sorting' =>true
											  );
							$arr = array($this->document->sitemapid,12,"",$template);
							$this->data['module'] = $this->loadModule('module/productlist','index',$arr);
	
						}
						else
						{
							$template = array(
										  'template' => "module/product_detail.tpl",
										  'width' => 250,
										  'height' =>250
										  );
							$arr = array($this->document->sitemapid,12,$template);
							$this->data['module'] = $this->loadModule('module/pagedetail','getFormProduct',$arr);
						}
					break;
					case "module/album":
						if($id == "")
						{
							$template = array(
											  'template' => "module/album_list.tpl",
											  'width' => 150,
											  'height' =>114
											  );
							$arr = array($this->document->sitemapid,12,"",$template);
							$this->data['module'] = $this->loadModule('module/productlist','index',$arr);
	
						}
						else
						{
							$template = array(
										  'template' => "module/album_detail.tpl",
										  'width' => 520,
										  'height' =>450
										  );
							$arr = array($this->document->sitemapid,12,$template);
							$this->data['module'] = $this->loadModule('module/pagedetail','getFormProduct',$arr);
						}
					break;
					case "module/contact":
						$this->data['module'] = $this->loadModule('module/contact');
					break;
				}
			}
			//San pham noi bat
			$template = array(
						  'template' => "home/product.tpl",
						  'width' => 150,
						  'height' =>150,
						  'paging' => false,
						  'sorting' =>false
						  );
			
			$medias = $this->getProduct('sanphamhot');
			//print_r($medias);
			$arr = array("",100000,"",$template,$medias);
			$this->data['producthot'] = $this->loadModule('module/productlist','index',$arr);
			$this->loadSiteBar();
		}
		$this->id="content";
		$this->template="page/detail.tpl";
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
		
		//$this->data['leftsitebar']['hitcounter'] = $this->loadModule('sitebar/hitcounter');
		
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