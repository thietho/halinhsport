<?php
class ControllerAddonOrder extends Controller
{
	private $error = array();
	
	public function index()
	{
		$this->load->language('addon/order');
		$this->data = array_merge($this->data, $this->language->getData());
		
		$this->document->title = $this->language->get('heading_title');
		
		$this->load->model("addon/order");
		$this->load->model("quanlykho/donvitinh");
		$this->getList();
	}
	
	public function insert()
	{
		$this->edit();
	}
	
	public function edit()
	{
		$this->load->language('addon/order');
		$this->load->model('addon/order');
		$this->load->model('core/media');
		$orderid = $this->request->get['orderid'];
		$this->load->helper('image');
		$this->data = $this->model_addon_order->getItem($orderid);
		
		foreach($this->data['detail'] as $key => $item)
		{
			$parent = $this->model_core_media->getItem($item['mediaparent']);
			if(count($parent)==0)
			{
				$imagepreview = "<img width=100 src='".HelperImage::resizePNG($item['imagepath'], 180, 180)."' >";
				$this->data['detail'][$key]['imagepreview'] = $imagepreview;
				$this->data['detail'][$key]['title'] = $item['title'];
			}
			else
			{
				$imagepreview = "<img width=100 src='".HelperImage::resizePNG($parent['imagepath'], 180, 180)."' >";
				$this->data['detail'][$key]['imagepreview'] = $imagepreview;
				$this->data['detail'][$key]['title'] = $parent['title'] ." - ". $item['title'];
			}
		}
		
		$this->id='content';
		$this->template="addon/order_edit.tpl";
		$this->layout="layout/center";
		$this->render();
	}
	public function createphieuxuat()
	{
		$this->load->model('addon/order');
		$this->load->model('core/media');
		$this->load->model('core/user');
		$this->load->model('quanlykho/phieunhapxuat');
		$orderid = $this->request->get['orderid'];
		$thanhtoan = $this->request->get['thanhtoan'];
		$order = $this->model_addon_order->getItem($orderid);
		$nhanvien = $this->user->getNhanVien();
		if($order['order']['userid'] != "")
			$member = $this->model_core_user->getItem($order['order']['userid']);
		$tongtien = 0;
		
		$data['loaiphieu'] = "PBH";
		$data['nguoithuchienid'] = $nhanvien['id'];
		$data['nguoithuchien'] = $nhanvien['hoten'];
		$data['nhacungcapid'] = "";
		$data['tennhacungcap'] = "";
		$data['nguoigiao'] = $order['order']['shippername'];
		$data['nguoinhanid'] = $member['id'];
		$data['nguoinhan'] = $order['order']['customername'];
		if($order['order']['receiver']!="" && $order['order']['customername'] != $order['order']['receiver'])
			$data['nguoinhan'] .= " - người nhận: ".$order['order']['receiver'];
		$data['tongtien'] = $tongtien;
		$data['thanhtoan'] = $thanhtoan;
		
		if($order['order']['notes'])
			$data['ghichu'] .= " - ". $order['order']['notes'];
		$phieuid = $this->model_quanlykho_phieunhapxuat->save($data);
		print_r($data);
		$data_ct = array();
		foreach($order['detail'] as $item)
		{
			$tongtien += $item['subtotal'];
			$ct['phieuid'] = $phieuid;
			$ct['mediaid'] = $item['mediaid'];
			$media =  $this->model_core_media->getItem($item['mediaid']);
			
			$ct['code'] = $media['code'];
			$parent = $this->model_core_media->getItem($media['mediaparent']);
			if(count($parent)==0)
				$ct['title'] = $media['title'];
			else
				$ct['title'] = $parent['title'] ." - ". $media['title'];
			
			$ct['soluong'] = $item['quantity'];
			$ct['madonvi'] = $media['unit'];
			$ct['giatien'] = $item['price'];
			$ct['thanhtien'] = $item['subtotal'];
			$ct['loaiphieu'] = $data['loaiphieu'];
			
			$this->model_quanlykho_phieunhapxuat->savePhieuNhapXuatMedia($ct);
			
		}
		$this->model_quanlykho_phieunhapxuat->updateCol($phieuid,'tongtien',$tongtien);
		
		$this->model_quanlykho_phieunhapxuat->updateCol($phieuid,'congno',$tongtien - $thanhtoan);
		$this->data['output'] = "true";
		
		
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
		
	}
	public function view()
	{
		$this->load->language('addon/order');
		$this->load->model('addon/order');
		$this->load->model('core/media');
		$orderid = $this->request->get['orderid'];
		$this->load->helper('image');
		$this->data = $this->model_addon_order->getItem($orderid);
		//Neu don hang moi thi cap nha thanh dang xu ly
		if($this->data['order']['status']=='new')
		{
			$data['orderid'] = $orderid;
			$data['status'] = 'wait';
			$this->model_addon_order->updateStatus($data);
			$this->data = $this->model_addon_order->getItem($orderid);
		}
		$this->data = array_merge($this->data, $this->language->getData());
		
		
		
		if($this->data['order']['status']=='')
			$this->data['order']['text_active'] = "New";
		else
			$this->data['order']['text_active'] = "Checked";
		foreach($this->data['detail'] as $key => $item)
		{
			$parent = $this->model_core_media->getItem($item['mediaparent']);
			if(count($parent)==0)
			{
				$imagepreview = "<img width=100 src='".HelperImage::resizePNG($item['imagepath'], 180, 180)."' >";
				$this->data['detail'][$key]['imagepreview'] = $imagepreview;
				$this->data['detail'][$key]['title'] = $item['title'];
			}
			else
			{
				$imagepreview = "<img width=100 src='".HelperImage::resizePNG($parent['imagepath'], 180, 180)."' >";
				$this->data['detail'][$key]['imagepreview'] = $imagepreview;
				$this->data['detail'][$key]['title'] = $parent['title'] ." - ". $item['title'];
			}
		}
		
		$this->id='content';
		$this->template="addon/order_form.tpl";
		$this->layout="layout/center";
		$this->render();
	}
	
	private function getList() 
	{
		$this->data['insert'] = $this->url->http('addon/order/insert');
		$this->data['delete'] = $this->url->http('addon/order/delete');		

		$this->data['orders'] = array();
		$where = "";
		
		$datasearchlike['orderid'] = $this->request->get['orderid'];
		$datasearchlike['customername'] = $this->request->get['customername'];
		$datasearchlike['address'] = $this->request->get['address'];
		$datasearchlike['email'] = $this->request->get['email'];
		$datasearchlike['phone'] = $this->request->get['phone'];
		
		$datasearch['userid'] = $this->request->get['userid'];
		$datasearch['status'] = $this->request->get['status'];
		
		$arr = array();
		foreach($datasearchlike as $key => $item)
		{
			if($item !="")
				$arr[] = " AND " . $key ." like '%".$item."%'";
		}
		
		foreach($datasearch as $key => $item)
		{
			if($item !="")
				$arr[] = " AND " . $key ." = '".$item."'";
		}
		//Truong hop khac
		$datasearch['fromdate'] = $this->date->formatViewDate($this->request->get['fromdate']);
		$datasearch['todate'] = $this->date->formatViewDate($this->request->get['todate']);
		
		if($datasearch['fromdate'] != "")
			$arr[] = " AND orderdate >= '".$datasearch['fromdate']."'";
		
		if($datasearch['todate'] != "")
			$arr[] = " AND orderdate <= '".$datasearch['todate']."'";
		
		
		$where .= implode("",$arr);
		
		$where .= " ORDER BY  `order`.`orderdate` DESC ";
		$this->data['orders'] = $this->model_addon_order->getList($where);
		
		$this->data['refres']=$_SERVER['QUERY_STRING'];
		$this->id='content';
		$this->template="addon/order_list.tpl";
		$this->layout="layout/center";
		$this->render();
	}
	public function viewHistory()
	{
		$this->load->language('addon/order');
		$this->load->model('addon/order');
		$orderid = $this->request->get['orderid'];
		$this->data = $this->model_addon_order->getItem($orderid);
		
		$where = " AND orderid = '".$orderid."'";
		$this->data['historys'] = $this->model_addon_order->getOrderHistoryList($where);
		
		$this->id="content";
		$this->template="addon/order_history.tpl";
		$this->render();
		
		
	}
	public function editDelivery()
	{
		$this->id="content";
		$this->template="addon/order_form_delivery.tpl";
		$this->render();
	}
	public function printBill()
	{
		$this->load->language('addon/order');
		$this->load->model('addon/order');
		$this->load->model('core/media');
		$orderid = $this->request->get['orderid'];
		$this->load->helper('image');
		$this->data = $this->model_addon_order->getItem($orderid);
		
		foreach($this->data['detail'] as $key => $item)
		{
			$parent = $this->model_core_media->getItem($item['mediaparent']);
			if(count($parent)==0)
			{
				$imagepreview = "<img width=100 src='".HelperImage::resizePNG($item['imagepath'], 180, 180)."' >";
				$this->data['detail'][$key]['imagepreview'] = $imagepreview;
				$this->data['detail'][$key]['title'] = $item['title'];
			}
			else
			{
				$imagepreview = "<img width=100 src='".HelperImage::resizePNG($parent['imagepath'], 180, 180)."' >";
				$this->data['detail'][$key]['imagepreview'] = $imagepreview;
				$this->data['detail'][$key]['title'] = $parent['title'] ." - ". $item['title'];
			}
		}
		
		$this->id="content";
		$this->template="addon/order_bill.tpl";
		$this->layout="layout/print";
		$this->render();
	}
	public function save()
	{
		$this->load->model("addon/order");
		$data = $this->request->post;
		
		if($data['orderid'])
		{
			$this->model_addon_order->updateCol($data['orderid'],'userid',$data['userid']);
			$this->model_addon_order->updateCol($data['orderid'],'customername',$data['customername']);
			$this->model_addon_order->updateCol($data['orderid'],'address',$data['address']);
			$this->model_addon_order->updateCol($data['orderid'],'email',$data['email']);
			$this->model_addon_order->updateCol($data['orderid'],'phone',$data['phone']);
			$this->model_addon_order->updateCol($data['orderid'],'receiver',$data['receiver']);
			$this->model_addon_order->updateCol($data['orderid'],'receiverphone',$data['receiverphone']);
			$this->model_addon_order->updateCol($data['orderid'],'shipperat',$data['shipperat']);
			$this->model_addon_order->updateCol($data['orderid'],'shippdate',$this->date->formatViewDate($data['shippdate']));
			$this->model_addon_order->updateCol($data['orderid'],'shipper',$data['shipper']);
			$this->model_addon_order->updateCol($data['orderid'],'shippername',$data['shippername']);
			$this->model_addon_order->updateCol($data['orderid'],'paymenttype',$data['paymenttype']);
			$this->model_addon_order->updateCol($data['orderid'],'notes',$data['notes']);
		}
		else
		{
			$data['shippdate'] = $this->date->formatViewDate($data['shippdate']);
			$data['orderid'] = $this->model_addon_order->insert($data);
		}
		//Xoa nhung id can xoa
		$arrdelid = split(',',$data['delid']);
		foreach($arrdelid as $id)
		{
			if($id)
			{
				$this->model_addon_order->deleteOrderProduct($id);
			}
		}
		
		$arr_id = $data['id'];
		$arr_mediaid = $data['mediaid'];
		$arr_madonvi = $data['madonvi'];
		$arr_quantity = $data['quantity'];
		$arr_price = $data['price'];
		
		foreach($arr_mediaid as $key => $mediaid)
		{
			$orderpro['id'] = $arr_id[$key];
			$orderpro['orderid'] = $data['orderid'];
			$orderpro['mediaid'] = $arr_mediaid[$key];
			$orderpro['unit'] = $arr_madonvi[$key];
			$orderpro['quantity'] = $arr_quantity[$key];
			$orderpro['price'] = $arr_price[$key];
			$orderpro['discount'] = 0;
			
			$this->model_addon_order->saveOrderProduct($orderpro);
		}
		
		$this->data['output'] = "true-".$data['orderid'];
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
	}
	
	public function saveDelivery()
	{
		$this->load->model("addon/order");
		$data = $this->request->post;
		foreach($data as $col =>$val)
		{
			$this->model_addon_order-> updateCol($data['orderid'],$col,$val);
		}
		$this->data['output'] = "true";
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
	}
	
	public function updatestatus()
	{
		$this->load->model("addon/order");
		$orderid = $this->request->get['orderid'];
		$status = $this->request->get['status'];
		//$this->data = $this->model_addon_order->getItem($orderid);
		$data['orderid'] = $orderid;
		$data['status'] = $status;
		$this->model_addon_order->updateStatus($data);
		
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
	}
	
	public function delete()
	{
		$listid=$this->request->post['delete'];
		
		$this->load->model("addon/order");
		if(count($listid))
		{
			foreach($listid as $orderid)
			{
				$this->model_addon_order->delete($orderid);
			}
			$this->data['output'] = "Delete success";
		}
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
	}
	
	public function showProductForm()
	{
		$this->load->model("quanlykho/donvitinh");
		$this->data['donvitinh'] = $this->model_quanlykho_donvitinh->getList();
		$this->id="content";
		$this->template="addon/product_form.tpl";
		$this->render();
	}
	
	
	
	public function browseProduct()
	{
		$this->load->model("core/sitemap");
		
		$arrSiteMapTree = array();
		$this->model_core_sitemap->getTreeSitemap("", $arrSiteMapTree, $this->user->getSiteId());
		
		
		$this->data['data_danhmuc'] = $arrSiteMapTree;
		
		$this->id="content";
		$this->template="addon/browseproduct.tpl";
		$this->render();
	}
	
	public function listProduct()
	{
		$this->load->model("core/user");
		$this->load->model("core/media");
		$this->load->model("core/sitemap");
		$this->load->helper('image');
		
		$keyword = urldecode($this->request->get['keyword']);
		$sitemapid = urldecode($this->request->get['sitemapid']);
		$arrkey = split(' ', $keyword);
		$where = "";
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
		
		if($sitemapid)
			foreach($arrsitemapid as $sitemapid)
			{
				$arr[] = " refersitemap like '%[".$sitemapid."]%'";
			}
		if(count($arr))
			$where .= "AND (". implode($arr," OR ").")";
		
		
		$where .= " AND mediaparent='' Order by position, statusdate DESC";
		$this->data['medias'] = $this->model_core_media->getList($where);
		foreach($this->data['medias'] as $i => $media)
		{
			if($this->data['medias'][$i]['imagepath'])
				$this->data['medias'][$i]['imagepreview'] = HelperImage::resizePNG($this->data['medias'][$i]['imagepath'], 100, 100);
				
			
			
			$data_child = $this->model_core_media->getListByParent($media['mediaid']," Order by position");
			foreach($data_child as $key =>$child)
			{
				if($child['imagepath'])
					$data_child[$key]['imagepreview'] = HelperImage::resizePNG($child['imagepath'], 100, 100);
			}
			$this->data['medias'][$i]['child'] = $data_child;
			
		}
		
		$this->id="content";
		$this->template="addon/listproduct.tpl";
		$this->render();
	}
	
	public function getOrders() 
	{
		$col = $this->request->get['col'];
		$val = $this->request->get['val'];
		$operator = $this->request->get['operator'];
		if($operator == "")
			$operator = "equal";
		$this->load->model("addon/order");
		$where = "";
		switch($operator)
		{
			case "equal":
				$where = " AND ".$col." = '".$val."'";
				break;
			case "like":
				$where = " AND ".$col." like '%".$val."%'";
				break;
			case "other":
				$where = " AND ".$col." <> '".$val."'";
				break;
			case "in":
				$where = " AND ".$col." in  (".$val.")";
				break;
			
		}
		
		$where .= " ORDER BY  `order`.`orderdate` DESC ";
		$datas = $this->model_addon_order->getList($where);
		
		$this->data['output'] = json_encode(array('orders' => $datas));
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
	}
}
?>