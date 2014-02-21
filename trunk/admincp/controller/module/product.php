<?php
class ControllerModuleProduct extends Controller
{
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
		$this->load->model("quanlykho/phieunhapxuat");
		$this->load->model("core/sitemap");
		$this->load->model("core/media");
		$this->load->model("core/media");
		$this->load->model("core/user");
		$this->load->helper('image');
		$this->load->model("core/category");
	}
	
	function index()
	{	
		
		$this->data['nhanhieu'] = array();
		$this->model_core_category->getTree("nhanhieu",$this->data['nhanhieu']);
		unset($this->data['nhanhieu'][0]);
		
		$siteid = $this->user->getSiteId();
		$this->data['sitemapid'] = urldecode($this->request->get['sitemapid']);
		$this->data['breadcrumb'] = $this->model_core_sitemap->getBreadcrumb($this->data['sitemapid'], $siteid);
		$this->id='content';
		$this->template='module/product.tpl';
		$this->layout='layout/center';
		$this->render();
	}
	
	public function getList()
	{
		$sitemapid = urldecode($this->request->get['sitemapid']);
		$this->data['sitemapid'] = $sitemapid;
		$siteid = $this->user->getSiteId();
		if($sitemapid == "")
		{
			$sitemaps = $this->model_core_sitemap->getListByModule("module/product", $siteid);
			$arrsitemapid = $this->string->matrixToArray($sitemaps,"sitemapid");
		}
		else
		{
			$data = array();
			$sitemaps = $this->model_core_sitemap->getTreeSitemap($sitemapid,$data,$siteid);
			$arrsitemapid = $this->string->matrixToArray($data,"sitemapid");
		}
		$arr = array();
		$where = " AND mediaparent = '' AND mediatype = 'module/product' ";
		if($sitemapid)
			foreach($arrsitemapid as $sitemapid)
			{
				$arr[] = " refersitemap like '%[".$sitemapid."]%'";
			}
		if(count($arr))
			$where .= "AND (". implode($arr," OR ").")";
		
		$keyword = urldecode($this->request->get['keyword']);
		$arrkey = split(' ', $keyword);
		
		if($keyword !="")
		{
			$arr = array();
			$arrcode = array();
			foreach($arrkey as $key)
			{
				$arr[] = "title like '%".$key."%'";
			}
			foreach($arrkey as $key)
			{
				$arrcode[] = "code like '%".$key."%'";
			}
			$where .= " AND ((". implode(" AND ",$arr). ") OR (". implode(" AND ",$arrcode). "))";
			//$where .= " AND ( title like '%".$keyword."%' OR summary like '%".$keyword."%' OR description like '%".$keyword."%')";
		}
		$brand = urldecode($this->request->get['brand']);
		if($brand !="")
		{
			$where .= " AND brand like '".$brand."'";
		}
		$where .= " Order by position, statusdate DESC";
		$rows = $this->model_core_media->getList($where);
		//Page
		$page = $this->request->get['page'];		
		$x=$page;		
		$limit = 20;
		$total = count($rows); 
		// work out the pager values 
		$this->data['pager']  = $this->pager->pageLayoutAjax($total, $limit, $page,"showsanpham");
		
		$pager  = $this->pager->getPagerData($total, $limit, $page); 
		$offset = $pager->offset; 
		$limit  = $pager->limit; 
		$page   = $pager->page;
		$this->data['medias'] = array();
		for($i=$offset;$i < $offset + $limit && count($rows[$i])>0;$i++)
		{
			$this->data['medias'][$i] = $rows[$i];
			$user = $this->model_core_user->getItem($this->data['medias'][$i]['userid']);
			$this->data['medias'][$i]['fullname'] =$user['fullname'];
			$arr = $this->string->referSiteMapToArray($this->data['medias'][$i]['refersitemap']);
			$sitemapid = $arr[0];
			$sitemap = $this->model_core_sitemap->getItem($sitemapid,$this->user->getSiteId());
			
				$this->data['medias'][$i]['imagepreview'] = "<img src='".HelperImage::resizePNG($this->data['medias'][$i]['imagepath'], 100, 100)."' >";
				
			
			$this->data['medias'][$i]['saleprice'] = json_decode($this->data['medias'][$i]['saleprice']);
			
			$mediaid = $this->data['medias'][$i]['mediaid'];
			$this->data['medias'][$i]['tonkho'] = $this->model_core_media->getTonKho($mediaid);
			$data_child = $this->model_core_media->getListByParent($mediaid);
			foreach($data_child as $key =>$child)
			{
				$data_child[$key]['imagepreview'] = "<img src='".HelperImage::resizePNG($child['imagepath'], 100, 100)."' >";
				$data_child[$key]['saleprice'] = json_decode($child['saleprice']);
				$data_child[$key]['tonkho'] = $this->model_core_media->getTonKho($child['mediaid']);
				$data_child[$key]['link_edit'] = $this->url->http('module/product/update&sitemapid='.$sitemap['sitemapid'].'&mediaid='.$child['mediaid'].$parapage);
				$data_child[$key]['text_edit'] = "Edit";
			}
			$this->data['medias'][$i]['child'] = $data_child;
			$parapage = "";
			if($page)
				$parapage = "&page=".$page;
			if($page)
				
			$this->data['medias'][$i]['link_edit'] = $this->url->http('module/product/update&sitemapid='.$sitemap['sitemapid'].'&mediaid='.$this->data['medias'][$i]['mediaid'].$parapage);
			$this->data['medias'][$i]['text_edit'] = "Edit";
			
			$this->data['medias'][$i]['link_addchild'] = $this->url->http('module/product/insert&sitemapid='.$sitemap['sitemapid'].'&mediaparent='.$this->data['medias'][$i]['mediaid'].$parapage);
			$this->data['medias'][$i]['text_addchild'] = "Thêm qui cách";	
			
			$this->data['medias'][$i]['type'] = $sitemap['moduleid'];
			$this->data['medias'][$i]['typename'] = $this->model_core_sitemap->getModuleName($sitemap['moduleid']);
			
			
			
		}
		$this->data['refres']=$_SERVER['QUERY_STRING'];
		$this->id='content';
		$this->template="module/product_list.tpl";
		
		
		$this->render();
	}
	
	public function insert()
	{
		$this->data['output'] = $this->loadModule('core/postcontent');
		$this->id='content';
		$this->template='common/output.tpl';
		$this->layout='layout/center';
		$this->render();
	}
	
	public function update()
	{
		$this->data['output'] = $this->loadModule('core/postcontent');
		$this->id='content';
		$this->template='common/output.tpl';
		$this->layout='layout/center';
		$this->render();
	}
	public function productCat()
	{
		$siteid = $this->user->getSiteId();
		//$where = " AND moduleid = 'module/product' AND sitemapparent = ''";
		
		//$data_catroot = $this->model_core_sitemap->getList($siteid,$where);
		//$this->data['catshow'] = "";
		//foreach($data_catroot as $sitemap)
		//{
		//$this->data['root'] = "san-pham";
		$this->data['root'] = urldecode($this->request->get['root']);
		$this->data['catshow'] .= $this->showTreeSiteMap($this->data['root']);
		//}
		
		$this->id='content';
		$this->template='module/product_cat.tpl';
		$this->render();
	}
	
	private function showTreeSiteMap($parentid)
	{
		$siteid = $this->user->getSiteId();
		$str = "";
		
		$sitemaps = $this->model_core_sitemap->getListByParent($parentid, $siteid);
		
		foreach($sitemaps as $item)
		{
			//if($item['moduleid'] == "module/product")
			{
				$childs = $this->model_core_sitemap->getListByParent($item['sitemapid'], $siteid);
				
				$link = "<a>".$item['sitemapname']."</a> ";
				if($item['moduleid'] == "module/product")
				{
					$link = "<a href='?route=".$item['moduleid']."&sitemapid=".$item['sitemapid']."'>".$item['sitemapname']."</a> ";
					if($this->user->checkPermission("module/product/addcat")==true)
						$link .= "<a class='addcat' cparent='".$item['sitemapid']."'><img src='".DIR_IMAGE."icon/add.png' width='19px'></a>";
					if($this->user->checkPermission("module/product/editcat")==true)
						$link .= "<a class='editcat' sitemapid='".$item['sitemapid']."'><img src='".DIR_IMAGE."icon/edit.png' width='19px'></a>";
					if(count($childs) == 0)
					{
						if($this->user->checkPermission("module/product/delcat")==true)
							$link .= "<a class='delcat' sitemapid='".$item['sitemapid']."'><img src='".DIR_IMAGE."icon/del.png' width='19px'></a>";
					}
				}
				$str .= "<li>";
				
				$str .= $link;
				
				if(count($childs) > 0)
				{
					
					
					
					$str .= "<ul>";
					$str .= $this->showTreeSiteMap($item['sitemapid']);
					$str .= "</ul>";
				}
				else
				{
					
					
					
				}
				$str .= "</li>";
				
			}
		}
		
		return $str;
	}
	
	public function addcat()
	{
		$this->data['item']['sitemapparent'] = $this->request->get['parent'];
		
		$this->id='content';
		$this->template='module/product_cat_form.tpl';
		$this->render();
	}
	
	public function editcat()
	{
		$siteid = $this->user->getSiteId();
		$sitemapid = urldecode($this->request->get['sitemapid']);
		$this->data['item'] = $this->model_core_sitemap->getItem($sitemapid, $siteid);
		$this->id='content';
		$this->template='module/product_cat_form.tpl';
		$this->render();
	}
	
	public function delcat()
	{
		$id = urldecode($this->request->get['id']);
		$this->model_core_sitemap->deleteSitemap($id, $this->user->getSiteId());	
		
		$this->data['output'] = "true";
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
	public function addToList()
	{
		$mediaid = $this->request->get['mediaid'];
		$media = $this->model_core_media->getItem($mediaid);
		$media['imagepreview'] =HelperImage::resizePNG($media['imagepath'], 100, 100);
		$media['qty'] = 1;
		if(!isset($_SESSION['productlist']))
		{
			$_SESSION['productlist'] = array();
		}
		if(!isset($_SESSION['productlist'][$mediaid]))
		{
			$_SESSION['productlist'][$mediaid]=$media;
		}
		$this->data['output'] = "true";
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
	public function updateQty()
	{
		$mediaid = $this->request->get['mediaid'];
		$qty = $this->request->get['qty'];
		$_SESSION['productlist'][$mediaid]['qty'] = $qty;
		
		$this->data['output'] = "true";
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
	public function removeListItem()
	{
		$mediaid = $this->request->get['mediaid'];
		unset($_SESSION['productlist'][$mediaid]);
		
		$this->data['output'] = "true";
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
		
	}
	public function listProductSelected()
	{
		$this->data['medias'] = $_SESSION['productlist'];
		$this->id='content';
		$this->template='module/product_selected.tpl';
		$this->render();
	}
	public function history()
	{
		$mediaid = $this->request->get['mediaid'];
		$this->data['media'] = $this->model_core_media->getItem($mediaid);
		//Nhap kho
		$where = " AND mediaid = '".$mediaid."' AND loaiphieu like 'NK%'";
		$data_nhapkho = $this->model_quanlykho_phieunhapxuat->thongke($where);
		//Xuat kho
		$where = " AND mediaid = '".$mediaid."' AND loaiphieu = 'PBH'";
		$data_xuatkho = $this->model_quanlykho_phieunhapxuat->thongke($where);
		$arrdate = array();
		foreach($data_nhapkho as $item)
		{
			$ngaylap = $this->date->getDate($item['ngaylap']);
			if(!in_array($ngaylap,$arrdate))
			{
				$arrdate[] = $this->date->getDate($item['ngaylap']);
			}
		}
		foreach($data_xuatkho as $item)
		{
			$ngaylap = $this->date->getDate($item['ngaylap']);
			if(!in_array($ngaylap,$arrdate))
			{
				$arrdate[] = $this->date->getDate($item['ngaylap']);
			}
		}
		sort(&$arrdate);
		foreach($arrdate as $date)
		{
			foreach($data_nhapkho as $item)
			{
				$ngaylap = $this->date->getDate($item['ngaylap']);
				if($ngaylap == $date)
				{
					$this->data['nhapxuat'][$date]['nhapkho'][] = $item;
				}
			}
			foreach($data_xuatkho as $item)
			{
				$ngaylap = $this->date->getDate($item['ngaylap']);
				if($ngaylap == $date)
				{
					$this->data['nhapxuat'][$date]['xuatkho'][] = $item;
				}
			}
		}
		//print_r($this->data['nhapxuat']);
		$this->id='content';
		$this->template='module/product_history.tpl';
		$this->render();
	}
	
	public function import()
	{
		$this->id='content';
		$this->template='module/product_import.tpl';
		$this->render();
	}
	
	public function importData()
	{
		
		$arr = split("\.",$_FILES['fileimport']['name']);
		$ext = $arr[1];
		include DIR_COMPONENT.'PHPExcel/Classes/PHPExcel/IOFactory.php';
		//$inputFileName = 'GuiHangChoHo_20131002.xls';
		
		$inputFileName = $_FILES['fileimport']['tmp_name'];
		if($ext =='xls')
			$objReader = new PHPExcel_Reader_Excel5();
		else
			$objReader = new PHPExcel_Reader_Excel2007();
		//$objReader->setLoadSheetsOnly("Sheet1");
		$objPHPExcel = $objReader->load($inputFileName);
		$sheetData = $objPHPExcel->getActiveSheet()->toArray(null,true,true,true);
		//var_dump($sheetData);
		//echo $sheetData[1]['A'];
		
		
		$this->data['output'] = json_encode(array('datas' => $sheetData));
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
	
	public function export()
	{
		require_once DIR_COMPONENT.'PHPExcel/Classes/PHPExcel.php';
		$objPHPExcel = new PHPExcel();
		$objPHPExcel->getProperties()->setCreator("Ho Lan Solutions")
							 ->setLastModifiedBy("Lư Thiết Hồ")
							 ->setTitle("Export data")
							 ->setSubject("Export data")
							 ->setDescription("")
							 ->setKeywords("Ho Lan Solutions")
							 ->setCategory("Product");
		$objPHPExcel->setActiveSheetIndex(0)
            ->setCellValue('A1', 'ID')
			->setCellValue('B1', 'IDParent')
			->setCellValue('C1', 'Mã sản phẩm')
            ->setCellValue('D1', 'Tên sản phẩm')
			->setCellValue('E1', 'Màu sắc')
            ->setCellValue('F1', 'ĐVT')
			->setCellValue('G1', 'Nhãn hiệu')
            ->setCellValue('H1', 'Danh mục')
			->setCellValue('I1', 'Giá bán')
			->setCellValue('J1', 'Giá bán tại cửa hàng')
			->setCellValue('K1', 'Giảm giá%')
			->setCellValue('L1', 'Giá khuyến mãi')
			
			;
		$objPHPExcel->getActiveSheet()->getStyle('A1:L1')->getFont()->setBold(true);
		/*$objPHPExcel->getActiveSheet()->getStyle('A8')->getAlignment()->setWrapText(true);
		$objPHPExcel->getActiveSheet()->setCellValue('A8',"Hello\nWorld");
		$objPHPExcel->getActiveSheet()->getRowDimension(8)->setRowHeight(-1);
		$objPHPExcel->getActiveSheet()->getStyle('A8')->getAlignment()->setWrapText(true);*/
		//Dua du lieu vao
		$where = " AND mediaparent = '' AND mediatype = 'module/product' ";
		$where .= " Order by title";
		$medias = $this->model_core_media->getList($where);
		$data = array();
		foreach($medias as $i => $media)
		{
			$data[] = $media;
			$where = " AND mediaparent = '".$media['mediaid']."' AND mediatype = 'module/product' ";
			$where .= " Order by position, statusdate DESC";
			$childs = $this->model_core_media->getList($where);
			
			if(count($childs))
			{
				foreach($childs as $child)	
				{
					$data[] = $child;
				}
			}
		}
		//print_r($data);
		$key = 2;
		foreach($data as $media)
		{
			$brand = $this->document->getCategory($media['brand']);
			$unit = $this->document->getDonViTinh($media['unit']);
			$arrsitemapid = $this->string->referSiteMapToArray($media['refersitemap']);
			$arrsitemapname = array();
			foreach($arrsitemapid as $sitemapid)
			{
				if($sitemapid)
					$arrsitemapname[] = $this->document->getSiteMap($sitemapid,$this->user->getSiteId());
			}
			$danhmuc = "";
			if(count($arrsitemapname))
			{				
				$danhmuc = implode(",",$arrsitemapname);
			}
			//echo $media['saleprice'];
			$saleprice = json_decode(html_entity_decode($media['saleprice']));
			//print_r($saleprice);
			$shop = "";
			if(count($saleprice))
				foreach($saleprice as $donvi => $price)
				{
					$shop .= $this->document->getDonViTinh($donvi)."-".$price.",";
				}
			//echo $shop;
			$objPHPExcel->setActiveSheetIndex(0)
				->setCellValue('A'.$key, $media['mediaid'])
				->setCellValue('B'.$key, $media['mediaparent'])
				->setCellValue('C'.$key, $media['code'])
				->setCellValue('D'.$key, $media['title'])
				->setCellValue('E'.$key, $media['color'])
				->setCellValue('F'.$key, $unit)
				->setCellValue('G'.$key, $brand)
				->setCellValue('H'.$key, $danhmuc)
				->setCellValue('I'.$key, $media['price'])
				->setCellValue('J'.$key, $shop)
				->setCellValue('K'.$key, $media['discountpercent'])
				->setCellValue('L'.$key, $media['pricepromotion'])
				
				;
			$key++;
		}
		$objPHPExcel->getActiveSheet()->setTitle('Product');
		$objPHPExcel->setActiveSheetIndex(0);
		//
		$objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');
		$filename = "product".time().".xls";
		$objWriter->save(DIR_CACHE.$filename);
		$this->data['output'] = HTTP_IMAGE."cache/".$filename;
		
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
}
?>