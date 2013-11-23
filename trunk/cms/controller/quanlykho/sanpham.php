<?php
class ControllerQuanlykhoSanpham extends Controller
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
		
		$this->load->model("quanlykho/nguyenlieu");
		$this->load->model("quanlykho/sanpham");
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
		
		$this->data['insertlist'] = $this->url->http('quanlykho/sanpham/insertlist');
		$this->data['insert'] = $this->url->http('quanlykho/sanpham/insert');
		$this->data['delete'] = $this->url->http('quanlykho/sanpham/delete');
		
		$this->id='content';
		$this->template="quanlykho/sanpham_list.tpl";
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
		$this->template='quanlykho/sanpham_form_list.tpl';
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
			$this->model_quanlykho_sanpham->deletedatas($listid);
			$this->data['output'] = "Xóa thành công";
		}
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
  	}
	
	public function getList() 
	{
		
		
		$this->data['datas'] = array();
		$where = "";
		
		$datasearchlike['masanpham'] = urldecode($this->request->get['masanpham']);
		$datasearchlike['tensanpham'] = urldecode($this->request->get['tensanpham']);
		$datasearch['loai'] = $this->request->get['loai'];
		
		$arr = array();
		foreach($datasearchlike as $key => $item)
		{
			if($item !="")
				$arr[] = " AND " . $key ." like '".$item."%'";
		}
		
		foreach($datasearch as $key => $item)
		{
			if($item !="")
				$arr[] = " AND " . $key ." = '".$item."'";
		}
		
		$where = implode("",$arr);
		
		
		$rows = $this->model_quanlykho_sanpham->getList($where);
		//Page
		$page = $this->request->get['page'];		
		$x=$page;		
		$limit = 20;
		$total = count($rows); 
		// work out the pager values 
		$this->data['pager']  = $this->pager->pageLayoutAjax($total, $limit, $page,"#listnguyenlieu");
		
		$pager  = $this->pager->getPagerData($total, $limit, $page); 
		$offset = $pager->offset; 
		$limit  = $pager->limit; 
		$page   = $pager->page;
		for($i=$offset;$i < $offset + $limit && count($rows[$i])>0;$i++)
		//for($i=0; $i <= count($this->data['datas'])-1 ; $i++)
		{
			$this->data['datas'][$i] = $rows[$i];
			$this->data['datas'][$i]['link_edit'] = $this->url->http('quanlykho/sanpham/update&id='.$this->data['datas'][$i]['id']);
			$this->data['datas'][$i]['text_edit'] = "Sửa";
			;
			//
			
			$imagepreview = "";
			$this->data['datas'][$i]['imagethumbnail'] = HelperImage::resizePNG($this->data['datas'][$i]['imagepath'], 100, 0);
			
		}
		$this->data['refres']=$_SERVER['QUERY_STRING'];
		$this->id='content';
		$this->template="quanlykho/sanpham_table.tpl";
		
		if($this->request->get['opendialog']=='true')
		{
			$this->layout="";
			$this->data['dialog'] = true;
			
		}
		$this->render();
	}
	
	
	private function getForm()
	{
		$this->data['DIR_UPLOADPHOTO'] = HTTP_SERVER."index.php?route=common/uploadpreview";
		$sanphamid = $this->request->get['id'];
		if($sanphamid) 
		{
			
      		$this->data['item'] = $this->model_quanlykho_sanpham->getItem($this->request->get['id']);
			$this->data['item']['imagethumbnail'] = HelperImage::resizePNG($this->data['item']['imagepath'], 200, 200);
			$where = " AND sanphamid = '".$sanphamid."'";
			$this->data['data_dinhluong'] = $this->model_quanlykho_sanpham->getSanPhamNguyenLieuList($where);
			foreach($this->data['data_dinhluong'] as $i => $item)
			{
					$this->data['data_dinhluong'][$i]['tennguyenlieu'] = $this->document->getNguyenLieu($item['nguyenlieuid']);
			}
			
    	}
		
		$this->id='content';
		$this->template='quanlykho/sanpham_form.tpl';
		$this->layout="layout/center";
		
		$this->render();
	}
	
	public function save()
	{
		$data = $this->request->post;
		
		if($this->validateForm($data))
		{
			
			$item = $this->model_quanlykho_sanpham->getItem($data['id']);
			if(count($item)==0)
			{
				$data['id'] = $this->model_quanlykho_sanpham->insert($data);
			}
			else
			{
				$this->model_quanlykho_sanpham->update($data);
			}
			//Xoa dinh luong
			$deldinhluong = $data['deldinhluong'];
			$arr_dinhluongid = split(",",$deldinhluong);
			if(count($arr_dinhluongid))
			{
				foreach($arr_dinhluongid as $dinhluongid)
					$this->model_quanlykho_sanpham->deleteSanPhamNguyenLieu($dinhluongid);
			}
			//Save dinh luong
			$dinhluongid = $data['dinhluongid'];
			$sanphamid = $data['id'];
			$arr_nguyenlieuid = $data['nguyenlieuid'];
			$arr_soluong = $data['soluong'];
			$arr_madonvi = $data['dlmadonvi'];
			foreach($arr_nguyenlieuid as $i => $nguyenlieuid)
			{
				$dl['id'] = $dinhluongid[$i];
				$dl['sanphamid'] = $sanphamid;
				$dl['nguyenlieuid'] = $nguyenlieuid;
				$dl['soluong'] = $arr_soluong[$i];
				$dl['madonvi'] = $arr_madonvi[$i];
				$this->model_quanlykho_sanpham->saveSanPhamNguyenLieu($dl);
				
			}
			$this->data['output'] = "true";
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
		
		
    	if($data['masanpham'] == "")
		{
      		$this->error['masanpham'] = "Mã nguyên liệu không được rỗng";
    	}
		else
		{
			if($data['id'] == "")
			{
				
				$where = " AND masanpham ='".$data['masanpham']."'" ;
				$item = $this->model_quanlykho_sanpham->getList($where);
				if(count($item)>0)
					$this->error['masanpham'] = "Mã nguyên liệu đã được sử dụng";
			}
		}
		if(strlen($data['masanpham']) > 50)
		{
      		$this->error['masanpham'] = "Mã nguyên liệu không được vượt quá 50 ký tự";
    	}
		
		if ($data['tensanpham'] == "") 
		{
      		$this->error['tensanpham'] = "Bạn chưa nhập tên nguyên liệu";
    	}
		
		
		
		if ($data['loai'] == "") 
		{
      		$this->error['loai'] = "Bạn chưa chọn loại";
    	}
		
		if ($data['madonvi'] == "") 
		{
      		$this->error['madonvi'] = "Bạn chưa nhập đơn vị tính";
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