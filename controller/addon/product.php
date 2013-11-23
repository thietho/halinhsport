<?php
class ControllerAddonProduct extends Controller
{
	private $error = array();
	public function index()
	{
		
		$this->document->breadcrumb .= "Tìm kiếm sản phẩm";
		$this->getList();
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
	}
	
	private function getList()
	{
		$this->load->model("core/media");
		$this->load->model("core/sitemap");
		$this->load->helper('image');
		$donvi = 1000;
		$para = $this->string->referSiteMapToArray($_GET['search']);
		if(count($para))
		{
			foreach($para as $val)
			{
				$ar = split("=",$val);
				$datasearch[$ar[0]] = $ar[1];	
			}
			
			$_GET = $datasearch;
			$arr = array();
			
			foreach($datasearch as $key => $item)
			{
				if($item !="" && $key != "gia" && $key != "keyword" && $key != "loaisp")
					$arr[] = " AND groupkeys like '%[".$item."]%'";
					
				if($key == "loaisp")
					$arr[] = " AND refersitemap like '%[".$item."]%'";
				
			}
			
			
			
			$where = implode("",$arr);
			if($datasearch["keyword"]!="")
			{
				
				$where .= " AND ( title like '%".$datasearch["keyword"]."%' OR summary like '%".$datasearch["keyword"]."%' OR description like '%".$datasearch["keyword"]."%')";
			}
		}
		
		$siteid = $this->member->getSiteId();
		
		$arrsitemap = $this->model_core_sitemap->getListByModule('module/product', $siteid);
		foreach($arrsitemap as $item)
			$listsitemapid[] = $item['sitemapid'];
		$arr = array();
		foreach($listsitemapid as $item)
		{
			$arr[] = " refersitemap like '%[".$item."]%'";
		}
		$hasprice = false;
		if($datasearch['gia'] != "")
		{
			$hasprice = true;
			$arrgia = split("-",$datasearch['gia']);
			$giatu = (int)$arrgia[0];
			$giaden = (int)$arrgia[1];
			if($giatu)
				$whereprice = " AND price >= '".$giatu*$donvi ."'";
			if($giaden)
				$whereprice.= " AND price <= '".$giaden*$donvi ."'";
			$whereprice;
			$mediaprice = $this->model_core_media->getList($whereprice);
			
			$listparent = $this->string->matrixToArray($mediaprice,"mediaparent");
		}
		
		$where .= "AND (". implode($arr," OR ").")";
		
		$medias = $this->model_core_media->getList($where);
		
		if(count($listparent))
		{
			$data = array();
			foreach($medias as $key =>$item)
			{
				if(!in_array($item['mediaid'],$listparent))
				{
					unset($medias[$key]);	
				}
				else
				{
					$data[] = $item;	
				}
			}
			$medias = $data;
		}
		else
		{
			if($hasprice)
				$medias = array();	
		}
		
		$template = array(
							  'template' => "module/product_list.tpl",
							  'width' => 170,
							  'height' =>170,
							  'widthpreview' => 450,
						  	  'heightpreview' =>450
							  );
		$arr = array("",12,"Kết quả tìm kiếm",$template,$medias);
		$this->data['output'] = $this->loadModule('module/productlist','index',$arr);
			
			
	}
	
	public function getViewList()
	{
		$this->data['medias'] =array();
		if(isset($_SESSION['proviews']))
		{
			$this->data['medias'] = $_SESSION['proviews'];
		}
		
		$this->id="content";
		$this->template="sitebar/productview_list.tpl";
		$this->render();
	}
	
	public function addViewlist()
	{
		$this->load->model("core/media");
		$this->load->helper('image');
		$data = $this->request->get;
		if(!isset($_SESSION['proviews']))
		{
			$_SESSION['proviews'] = array();	
		}
		$mediaid = $data['mediaid'];
		$media = $this->model_core_media->getItem($mediaid);
		$media['imagethumbnail'] = HelperImage::resizePNG($media['imagepath'], 100, 100);
		$arr = $this->string->referSiteMapToArray($media['refersitemap']);
		$sitemapid = $arr[0];
		$media['link'] = $this->document->createLink($sitemapid,$media['alias']);
		$_SESSION['proviews'][$mediaid] = $media;
		
		$this->data['output'] = "true";
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
}
?>