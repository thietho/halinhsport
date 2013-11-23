<?php
class ControllerPageHome extends Controller
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
		$this->load->model("core/sitemap");
		$this->load->model("core/media");
		$this->load->model("core/user");
		$this->load->helper('image');
		$this->load->model("core/category");
		
		$this->load->model("sales/session");
		$this->load->model("sales/order");
		$this->load->model("sales/shop");
		
	}
	
	function index()
	{	
		$this->openSession();
		$siteid = $this->user->getSiteId();
		$this->data['sitemapid'] = $this->request->get['sitemapid'];
		$this->data['breadcrumb'] = $this->model_core_sitemap->getBreadcrumb($this->data['sitemapid'], $siteid);
		$this->id='content';
		$this->template='page/home.tpl';
		$this->layout='layout/center';
		$this->render();
		
		
	}
	public function openSession()
	{
		//Kiem tra nhan vien do co dang mo phien lam viec chua
		$nhanvien = $this->user->getNhanVien();
		$staffid = $nhanvien['id'];
		$shop = $this->user->getShop();
		
		$shopid = $shop['id'];
		if($shopid == (int)0)
		{
			$this->redirect($this->url->https('page/warning'));	
		}
		$where = " AND staffid = '".$staffid."' AND endtime = '0000-00-00 00:00:00'";
		$data_session = $this->model_sales_session->getList($where);
		
		if(count($data_session))
		{
			//Dang co phien lam viec chua dong
			//Lay phien lam viec chua dong cua nhan vien do
			$this->user->setSessionId($data_session[0]['id']);
		}
		else
		{
			//Neu chua mo thi tao phien lam viec
			$sessionid = $this->model_sales_session->createSession($shopid);
			$this->user->setSessionId($sessionid);
		}
		//echo $this->user->getSessionId();
	}
	
	public function main()
	{
		$this->id='content';
		$this->template='module/main.tpl';
		$this->render();
	}
	
	public function showProductForm()
	{
		$this->data['sitemapid'] = $this->request->get['sitemapid'];
		$this->id='content';
		$this->template='module/product_show.tpl';
		$this->render();
	}
	
	public function getList()
	{
		$sitemapid = $this->request->get['sitemapid'];
		$siteid = $this->user->getSiteId();
		$this->data['breadcrumb'] = $this->model_core_sitemap->getBreadcrumb($sitemapid, $siteid);
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
			
		}
		
		$where .= " Order by position, statusdate DESC";
		$this->data['medias'] = array();
		$this->data['medias'] = $this->model_core_media->getList($where);
		
		
		foreach($this->data['medias'] as $i => $media)
		{
			
			
			if($this->data['medias'][$i]['imagepath'] != "")
			{
				$this->data['medias'][$i]['imagepreview'] = HelperImage::resizePNG($this->data['medias'][$i]['imagepath'], 140, 140);
				
			}
			
			$mediaid = $this->data['medias'][$i]['mediaid'];
			$this->data['medias'][$i]['tonkho'] = $this->model_core_media->getTonKho($mediaid);
			
			$data_child = $this->model_core_media->getListByParent($mediaid);
			foreach($data_child as $key =>$child)
			{
				$data_child[$key]['imagepreview'] = HelperImage::resizePNG($child['imagepath'], 140, 140);
				$data_child[$key]['tonkho'] = $this->model_core_media->getTonKho($child['mediaid']);
				
			}
			$this->data['medias'][$i]['child'] = $data_child;
			
			
			
		}
		$this->data['refres']=$_SERVER['QUERY_STRING'];
		$this->id='content';
		$this->template="module/product_list.tpl";
		
		
		$this->render();
	}
	
	public function productCat()
	{
		$siteid = $this->user->getSiteId();
		/*$where = " AND moduleid = 'module/product' AND sitemapparent = ''";
		$data_catroot = $this->model_core_sitemap->getList($siteid,$where);*/
		$arrSiteMapTree = array();
		$this->model_core_sitemap->getTreeSitemap("", $arrSiteMapTree, $this->user->getSiteId());
		$this->data['catshow'] = array();
		foreach($arrSiteMapTree as $cat)
		{
			if($cat['moduleid'] == 'module/product')
				$this->data['catshow'][] = $cat;
		}
		//$this->data['catshow'] = "";
		//foreach($data_catroot as $sitemap)
		//{
		//$this->data['catshow'] .= $this->showTreeSiteMap("");
		//}
		
		$this->id='content';
		$this->template='module/product_cat.tpl';
		$this->render();
	}
	
	private function showTreeSiteMap($parentid)
	{
		$siteid = $this->user->getSiteId();
		$str = "";
		
		$sitemaps = $this->model_core_sitemap->getListByParent($parentid, $siteid, "Active");
		
		foreach($sitemaps as $item)
		{
			if($item['moduleid'] == "module/product")
			{
				$childs = $this->model_core_sitemap->getListByParent($item['sitemapid'], $siteid);
				
				$link = "<a href='#sitemapid=".$item['sitemapid']."' class='procat' ref='".$item['sitemapid']."'>".$item['sitemapname']."</a> ";
				//if($this->user->checkPermission("module/product/addcat")==true)
					//$link .= "<a class='addcat' cparent='".$item['sitemapid']."'><img src='".DIR_IMAGE."icon/add.png' width='19px'></a>";
				//if($this->user->checkPermission("module/product/editcat")==true)
					//$link .= "<a class='editcat' sitemapid='".$item['sitemapid']."'><img src='".DIR_IMAGE."icon/edit.png' width='19px'></a>";
				/*if(count($childs) == 0)
				{
					if($this->user->checkPermission("module/product/delcat")==true)
						$link .= "<a class='delcat' sitemapid='".$item['sitemapid']."'><img src='".DIR_IMAGE."icon/del.png' width='19px'></a>";
				}*/
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
	
	public function viewProduct()
	{
		$mediaid = $this->request->get['mediaid'];
		$this->data['media'] = $this->model_core_media->getItem($mediaid);
		$this->data['media']['saleprice'] = json_decode($this->data['media']['saleprice']);
		$this->id='content';
		$this->template='module/product_view.tpl';
		$this->render();
	}
	
	public function addOrder()
	{
		$data = $this->request->post;
		/*$mediaid = $data['mediaid'];
		$soluong = $data['soluong'];
		$madonvi = $data['madonvi'];
		$giaban = $data['giaban'];*/
		if($data['orderid']=="")
		{
			//Tao don hang moi
			$data['orderid'] = $this->model_sales_order->insert();
		}
		//Kiem tra mediaid va uint co trong chua
		$where = " AND orderid = '".$data['orderid']."' AND mediaid = '".$data['mediaid']."' AND unit = '".$data['unit']."'";
		$data_ct = $this->model_sales_order->getOrderDetailList($where);
		if(count($data_ct)==0)
			$this->model_sales_order->saveOrderDetail($data);
		else
		{
			$ct = $data_ct[0];
			$ct['quantity'] += $data['quantity'];
			if($ct['quantity'] >0)
				$this->model_sales_order->saveOrderDetail($ct);
		}
		
		$data['error'] ="";
		$this->data['output'] = json_encode($data);
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
	public function updateOrderDetail()
	{
		$data = $this->request->post;
		/*$mediaid = $data['mediaid'];
		$soluong = $data['soluong'];
		$madonvi = $data['madonvi'];
		$giaban = $data['giaban'];*/
		
		//Kiem tra mediaid va uint co trong chua
		$where = " AND orderid = '".$data['orderid']."' AND mediaid = '".$data['mediaid']."' AND unit = '".$data['unit']."'";
		$data_ct = $this->model_sales_order->getOrderDetailList($where);
		if(count($data_ct)==0)
			$this->model_sales_order->saveOrderDetail($data);
		else
		{
			$ct = $data_ct[0];
			$ct['quantity'] = $data['quantity'];
			if($ct['quantity'] >0)
				$this->model_sales_order->saveOrderDetail($ct);
		}
		
		$data['error'] ="";
		$this->data['output'] = json_encode($data);
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
	public function orderView()
	{
		$orderid = $this->request->get['orderid'];
		$view = $this->request->get['view'];
		$this->data['order'] = $this->model_sales_order->getItem($orderid);
		if($this->data['order']['customername']=="")
			$this->data['order']['customername'] = "Khách vãng lai";
		$where = " AND orderid = '".$orderid."'";
		$this->data['data_ct'] = $this->model_sales_order->getOrderDetailList($where);
		$this->id='content';
		$this->template='module/order_view.tpl';
		if($view == "dialog")
			$this->template='module/order_print.tpl';
		if($view == "print")
		{
			$this->template='module/order_print.tpl';
			$this->layout='layout/print';
		}
		$this->render();
	}
	
	
	public function updateOrder()
	{
		$data = $this->request->post;
		$orderid = $data['orderid'];
		$col = $data['col'];
		$val = $data['val'];
		$this->model_sales_order->updateCol($orderid,$col,$val);
		
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
	public function payment()
	{
		$data = $this->request->post;
		$orderid = $data['orderid'];
		$nhanvien = $this->user->getNhanVien();
		
		$this->model_sales_order->updateCol($orderid,"total",$data['total']);
		$this->model_sales_order->updateCol($orderid,"payment",$data['payment']);
		$this->model_sales_order->updateCol($orderid,"remain",$data['remain']);
		$this->model_sales_order->updateCol($orderid,"discount",$data['discount']);
		$this->model_sales_order->updateCol($orderid,"discountpercent",$data['discountpercent']);
		$this->model_sales_order->updateCol($orderid,"paymenttime",$this->date->getToday());
		$this->model_sales_order->updateCol($orderid,"cashier",$nhanvien['id']);
		$data['error'] ="";
		$this->data['output'] = json_encode($data);
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
	public function delOrderDetail()
	{
		$id = $this->request->get['id'];
		$data['error'] ="";
		$this->model_sales_order->deleteOrderDetail($id);
		
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
	public function getOrder()
	{
		$shop = $this->user->getShop();
		$shopid = $shop['id'];
		$where = " AND shopid = '".$shopid."' AND status = 'new' Order by id desc";
		$this->data['data_order'] = $this->model_sales_order->getList($where);
		$this->data['group'] = array();
		foreach($this->data['data_order'] as $i => $order)
		{
			if($order['customername']=="")
				$order['customername'] = "Khách vãng lai";
			$this->data['group'][$order['customerid']][] = $order;
		}
		ksort($this->data['group']);
		$this->id='content';
		$this->template='module/order_list.tpl';
		$this->render();
	}
	public function income()
	{
		$sessionid = $this->request->get['sessionid'];
		if($sessionid =="")
			$sessionid = $this->user->getSessionId();
		$this->data['nhanvien'] = $this->user->getNhanVien();
		$this->data['session'] = $this->model_sales_session->getItem($sessionid);
		$view = $this->request->get['view'];
		$start = $this->date->timeToInt($this->data['session']['starttime']);
		$now = $this->date->timeToInt($this->date->getToday());
		//print_r($this->data['session']);
		$worktime = $now - $start;
		
		$this->data['session']['worktime'] = $this->date->intToTime($worktime);
		
		$where = " AND sessionid = '".$sessionid."' AND status = 'completed'";
		$data_order = $this->model_sales_order->getList($where);
		
		$arr_orderid = $this->string->matrixToArray($data_order,"id");
		$where = " AND orderid in ('". implode("','",$arr_orderid) ."')";
		$this->data['data_order'] = $data_order;
		$this->data['data_ct'] = $this->model_sales_order->getOrderDetailListTotal($where);
		
		$this->id='content';
		$this->template='module/income.tpl';
		if($view == "print")
		{
			
			$this->layout='layout/print';
		}
		$this->render();
	}
	
	public function closeSession()
	{
		$sessionid = $this->user->getSessionId();
		$this->model_sales_session->closeSession($sessionid);
		
		$this->data['output'] = $sessionid;
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
}
?>