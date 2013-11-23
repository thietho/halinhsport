<?php
class ControllerQuanlykhoPhieuxuat extends Controller
{
	private $error = array();
	private $loaiphieu = "PBH";
	function __construct() 
	{
		
		$this->load->model("core/module");
		$moduleid = $_GET['route'];
		$this->document->title = $this->model_core_module->getBreadcrumbs($moduleid);
		if($this->user->checkPermission($moduleid)==false)
		{
			$this->response->redirect('?route=page/home');
		}
		
		
		$this->load->model("quanlykho/phieunhapxuat");
		$this->load->helper('image');
		$this->load->model("core/category");
		
		$this->load->model("quanlykho/donvitinh");
		
		$this->data['loaisanpham'] = array();
		$this->model_core_category->getTree("sanpham",$this->data['loaisanpham']);
		unset($this->data['loaisanpham'][0]);
		$this->data['donvitinh'] = $this->model_quanlykho_donvitinh->getList();
		
   	}
	public function index()
	{
		
		$this->data['insertlist'] = $this->url->http('quanlykho/phieuxuat/insertlist');
		$this->data['insert'] = $this->url->http('quanlykho/phieuxuat/insert');
		$this->data['delete'] = $this->url->http('quanlykho/phieuxuat/delete');
		
		$this->id='content';
		$this->template="quanlykho/phieuxuat_list.tpl";
		$this->layout="layout/center";
		
		if($this->request->get['opendialog']=='true')
		{
			$this->layout="";
			$this->data['dialog'] = true;
			
		}
		$this->render();
	}
	
	public function insert()
	{
    	$this->getForm();
	}
	public function insertlist()
	{		
    	$this->id='content';
		$this->template='quanlykho/phieuxuat_form_list.tpl';
		$this->layout="layout/center";
		$this->render();
	}
	
	public function update()
	{
		$this->data['haspass'] = false;
		$this->data['readonly'] = 'readonly="readonly"';
		$this->getForm();		
  	}
	
	public function delete() 
	{
		$listid=$this->request->post['delete'];
		//$listmadonvi=$_POST['delete'];
		
		if(count($listid))
		{
			foreach($listid as $id)
			$this->model_quanlykho_phieunhapxuat->destroy($id);
			$this->data['output'] = "Xóa thành công";
		}
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
  	}
	
	public function getList() 
	{
		
		
		$this->data['datas'] = array();
		$where = " AND loaiphieu='".$this->loaiphieu."'";
		
		$datasearchlike['maphieu'] = urldecode($this->request->get['maphieu']);
		$datasearchlike['nguoinhan'] = urldecode($this->request->get['nguoinhan']);
		$datasearchlike['nguoithuchien'] = urldecode($this->request->get['nguoithuchien']);
		
		$arr = array();
		foreach($datasearchlike as $key => $item)
		{
			if($item !="")
				$arr[] = " AND " . $key ." like '%".$item."%'";
		}
		
		$where .= implode("",$arr);
		$tungay = $this->date->formatViewDate(urldecode($this->request->get['tungay']));
		if($tungay !="")
		{
			$where .= " AND ngaylap >= '".$tungay."'";
		}
		$denngay = $this->date->formatViewDate(urldecode($this->request->get['denngay']));
		if($denngay !="")
		{
			$where .= " AND ngaylap <= '".$denngay." 24:00:00'";
		}
		$rows = $this->model_quanlykho_phieunhapxuat->getList($where);
		//Page
		$page = $this->request->get['page'];		
		$x=$page;		
		$limit = 20;
		$total = count($rows); 
		// work out the pager values 
		$this->data['pager']  = $this->pager->pageLayoutAjax($total, $limit, $page,"#listphieunhap");
		
		$pager  = $this->pager->getPagerData($total, $limit, $page); 
		$offset = $pager->offset; 
		$limit  = $pager->limit; 
		$page   = $pager->page;
		for($i=$offset;$i < $offset + $limit && count($rows[$i])>0;$i++)
		//for($i=0; $i <= count($this->data['datas'])-1 ; $i++)
		{
			$this->data['datas'][$i] = $rows[$i];
			$this->data['datas'][$i]['link_edit'] = $this->url->http('quanlykho/phieuxuat/update&id='.$this->data['datas'][$i]['id']);
			$this->data['datas'][$i]['text_edit'] = "Sửa";
			;
			
		}
		$this->data['refres']=$_SERVER['QUERY_STRING'];
		$this->id='content';
		$this->template="quanlykho/phieuxuat_table.tpl";
		
		if($this->request->get['opendialog']=='true')
		{
			$this->layout="";
			$this->data['dialog'] = true;
			
		}
		$this->render();
	}
	public function view()
	{
		$id = $this->request->get['id'];
		if($id) 
		{
      		$this->data['item'] = $this->model_quanlykho_phieunhapxuat->getItem($id);
			
			$where = " AND phieuid = '".$id."'";
			$this->data['data_nhapkho'] = $this->model_quanlykho_phieunhapxuat->getPhieuNhapXuatMediaList($where);
			
			
    	}
		
		$this->id='content';
		$this->template='quanlykho/phieuxuat_view.tpl';
		if($_GET['opendialog'] == 'print')
			$this->layout="layout/print";
		$this->render();
	}
	
	private function getForm()
	{
		$id = $this->request->get['id'];
		if($id) 
		{
      		$this->data['item'] = $this->model_quanlykho_phieunhapxuat->getItem($id);
			$this->data['item']['imagethumbnail'] = HelperImage::resizePNG($this->data['item']['imagepath'], 200, 200);
			$where = " AND phieuid = '".$id."'";
			$this->data['data_nhapkho'] = $this->model_quanlykho_phieunhapxuat->getPhieuNhapXuatMediaList($where);
    	}
		else
		{
			if(isset($_SESSION['productlist']))
			{
				$medias = $_SESSION['productlist'];
				$i=0;
				foreach($medias as $media)
				{
					$this->data['data_nhapkho'][$i]['mediaid']=$media['mediaid'];
					$this->data['data_nhapkho'][$i]['code']=$media['code'];
					$this->data['data_nhapkho'][$i]['title']=$media['title'];
					if($media['color'])
						$this->data['data_nhapkho'][$i]['title'].= " - ".$media['color'];
					$this->data['data_nhapkho'][$i]['soluong']=$media['qty'];
					$this->data['data_nhapkho'][$i]['madonvi']=$media['unit'];
					$price = $media['price'];
					/*if($media['pricepromotion'])
						$price = $media['pricepromotion'];*/
					$this->data['data_nhapkho'][$i]['giatien']=$price;
					$i++;
				}
			}
		}
		
		$this->id='content';
		$this->template='quanlykho/phieuxuat_form.tpl';
		$this->layout="layout/center";
		
		$this->render();
	}
	
	public function save()
	{
		$data = $this->request->post;
		
		if($this->validateForm($data))
		{
			$nhanvien = $this->user->getNhanVien();
			$data['nguoithuchienid'] = $nhanvien['id'];
			$data['nguoithuchien'] = $nhanvien['hoten'];
			
			//$data['loaiphieu'] = $this->loaiphieu;
			$data['id'] = $this->model_quanlykho_phieunhapxuat->save($data);
			$phieu = $this->model_quanlykho_phieunhapxuat->getItem($data['id']);
			//Xoa dinh luong
			$delnhapkho = $data['delnhapkho'];
			if($delnhapkho)
			{
				$arr_nhapkhoid = split(",",$delnhapkho);
				if(count($arr_nhapkhoid))
				{
					foreach($arr_nhapkhoid as $nhapkhoid)
						$this->model_quanlykho_phieunhapxuat->deletePhieuNhapXuatMedia($nhapkhoid);
				}
			}
			//Save chi tiet phieu nhap
			$tongtien = 0;
			$nhapkhoid = $data['nhapkhoid'];
			$phieuid = $data['id'];
			$arr_mediaid = $data['mediaid'];
			$arr_code = $data['code'];
			$arr_title = $data['title'];
			$arr_soluong = $data['soluong'];
			$arr_madonvi = $data['dlmadonvi'];
			$arr_giatien = $data['giatien'];
			$arr_giamgia = $data['giamgia'];
			$arr_phantramgiamgia = $data['phantramgiamgia'];
			foreach($arr_mediaid as $i => $mediaid)
			{
				$dl['id'] = $nhapkhoid[$i];
				$dl['phieuid'] = $phieuid;
				$dl['mediaid'] = $mediaid;
				$dl['code'] = $arr_code[$i];
				$dl['title'] = $arr_title[$i];
				$dl['soluong'] = $arr_soluong[$i];
				$dl['madonvi'] = $arr_madonvi[$i];
				$dl['giatien'] = $arr_giatien[$i];
				$dl['giamgia'] = $arr_giamgia[$i];
				$dl['phantramgiamgia'] = $arr_phantramgiamgia[$i];
				$dl['loaiphieu'] = $phieu['loaiphieu'];
				
				$dl['maphieu'] = $phieu['maphieu'];
				$dl['ngaylap'] = $phieu['ngaylap'];
				$dl['nguoilap'] = $phieu['nguoilap'];
				$dl['nhacungcapid'] = $phieu['nhacungcapid'];
				$dl['tennhacungcap'] = $phieu['tennhacungcap'];
				$dl['khachhangid'] = $phieu['khachhangid'];
				$dl['tenkhachhang'] = $phieu['tenkhachhang'];
				$dl['nguoigiao'] = $phieu['nguoigiao'];
				$dl['nguoinhanid'] = $phieu['nguoinhanid'];
				$dl['nguoinhan'] = $phieu['nguoinhan'];
				$this->model_quanlykho_phieunhapxuat->savePhieuNhapXuatMedia($dl);
				$tongtien += $this->string->toNumber($dl['soluong'])*$this->string->toNumber($dl['giatien']);
				
			}
			//$this->model_quanlykho_phieunhapxuat->updateCol($phieuid,'tongtien',$tongtien);
			//$this->model_quanlykho_phieunhapxuat->updateCol($phieuid,'congno',$tongtien- $this->string->toNumber($data['thanhtoan']));
			$this->data['output'] = "true-".$data['id'];
			if(isset($_SESSION['productlist']))
			{
				unset($_SESSION['productlist']);	
			}
		}
		else
		{
			foreach($this->error as $item)
			{
				$this->data['output'] .= $item."<br>";
			}
		}
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
	
	private function validateForm($data)
	{
		
		
    	
		if ($data['tenkhachhang'] == "") 
		{
      		$this->error['tenkhachhang'] = "Bạn chưa nhập khách hàng";
    	}

		if (count($this->error)==0) {
	  		return TRUE;
		} else {
	  		return FALSE;
		}
	}
	
	
	
	
	
	
	//Cac ham xu ly tren form
	
	
}
?>