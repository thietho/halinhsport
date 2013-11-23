<?php
class ControllerQuanlykhoNhaCungcap extends Controller
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
		
		
		$this->load->model("quanlykho/nhacungcap");
		$this->load->helper('image');
		$this->load->model("core/category");
		
		$this->load->model("quanlykho/donvitinh");
		$this->load->model("addon/thuchi");
		$this->load->model("quanlykho/phieunhapxuat");
		
		$this->data['loaisanpham'] = array();
		$this->model_core_category->getTree("sanpham",$this->data['loaisanpham']);
		unset($this->data['loaisanpham'][0]);
		$this->data['donvitinh'] = $this->model_quanlykho_donvitinh->getList();
		
   	}
	public function index()
	{
		$this->data['insert'] = $this->url->http('quanlykho/nhacungcap/insert');
		$this->data['delete'] = $this->url->http('quanlykho/nhacungcap/delete');
		
		$this->id='content';
		$this->template="quanlykho/nhacungcap_list.tpl";
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
			$this->model_quanlykho_nhacungcap->delete($id);
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
		
		$datasearchlike['tennhacungcap'] = urldecode($this->request->get['tennhacungcap']);
		$datasearchlike['sodienthoai'] = urldecode($this->request->get['sodienthoai']);
		$datasearchlike['diachi'] = urldecode($this->request->get['diachi']);
		$datasearchlike['email'] = urldecode($this->request->get['email']);
		$datasearchlike['nguoilienhe'] = urldecode($this->request->get['nguoilienhe']);
		$datasearchlike['sodienthoainguoilienhe'] = urldecode($this->request->get['sodienthoainguoilienhe']);
		
		$arr = array();
		foreach($datasearchlike as $key => $item)
		{
			if($item !="")
				$arr[] = " AND " . $key ." like '".$item."%'";
		}
		
		
		
		$where = implode("",$arr);
		
		
		$rows = $this->model_quanlykho_nhacungcap->getList($where);
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
			$this->data['datas'][$i]['link_edit'] = $this->url->http('quanlykho/nhacungcap/update&id='.$this->data['datas'][$i]['id']);
			$this->data['datas'][$i]['text_edit'] = "Sửa";
			;
			//
			
			$imagepreview = "";
			
			$this->data['datas'][$i]['imagethumbnail'] = HelperImage::resizePNG($this->data['datas'][$i]['imagepath'], 100, 0);
			$arr = array($this->data['datas'][$i]['id']);
			$this->data['datas'][$i]['congno'] = $this->loadModule("quanlykho/nhacungcap","getCongNo",$arr);
		}
		$this->data['refres']=$_SERVER['QUERY_STRING'];
		$this->id='content';
		$this->template="quanlykho/nhacungcap_table.tpl";
		
		if($this->request->get['opendialog']=='true')
		{
			$this->layout="";
			$this->data['dialog'] = true;
			
		}
		$this->render();
	}
	
	public function getCongNo($id='')
	{
		if($id=="")
			$id=$this->request->get['nhacungcapid'];
		
		$this->data['nhacungcap'] = $this->model_quanlykho_nhacungcap->getItem($id);
		//Lay tat ca phieu chi thanhtoanncc
		$where = " AND makhachhang = 'NCC-".$id."' AND loaithuchi = 'chi' AND taikhoanthuchi = 'thanhtoanncc'";
		$this->data['data_phieuchi'] = $this->model_addon_thuchi->getList($where);
		$tongchi = 0;
		foreach($this->data['data_phieuchi'] as $item)
		{
			$tongchi += $item['quidoi'];	
		}
		
		//Lay tat ca phieu nhap hang
		$where = " AND loaiphieu = 'NK' AND nhacungcapid = '".$id."'";
		$this->data['data_phieunhapkho'] = $this->model_quanlykho_phieunhapxuat->getList($where);
		$tongno = 0;
		foreach($this->data['data_phieunhapkho'] as $item)
		{
			$tongno += $item['congno'];	
		}
		
		//Lay tat ca phieu xuat hang
		$where = " AND loaiphieu = 'PBH' AND nhacungcapid = '".$id."'";
		$this->data['data_phieubanhang'] = $this->model_quanlykho_phieunhapxuat->getList($where);
		$tongban = 0;
		foreach($this->data['data_phieubanhang'] as $item)
		{
			$tongban += $item['congno'];	
		}
		$congno = $tongno - $tongchi - $tongban;
		
		if($this->request->get['nhacungcapid'])
		{
			
			$this->data['tongno'] = $tongno;
			$this->data['tongchi'] = $tongchi;
			$this->data['tongban'] = $tongban;
			
			
			$this->data['congno'] = $congno;
			$this->id='content';
			$this->template="quanlykho/nhacungcap_congno.tpl";
			if($_GET['dialog']=='print')
			{
				$this->layout='layout/print';
			}
			$this->render();
		}
		else
		{
			$this->data['output'] = $congno;
			$this->id='content';
			$this->template='common/output.tpl';
			$this->render();
			
		}
	}
	
	private function getForm()
	{
		$this->data['DIR_UPLOADPHOTO'] = HTTP_SERVER."index.php?route=common/uploadpreview";
		$sanphamid = $this->request->get['id'];
		if($sanphamid) 
		{
			
      		$this->data['item'] = $this->model_quanlykho_nhacungcap->getItem($this->request->get['id']);
			
			
    	}
		
		$this->id='content';
		$this->template='quanlykho/nhacungcap_form.tpl';
		
		
		$this->render();
	}
	
	public function save()
	{
		$data = $this->request->post;
		
		if($this->validateForm($data))
		{
			
			
			$data['id'] = $this->model_quanlykho_nhacungcap->save($data);
			
			
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
    	if($data['tennhacungcap'] == "")
		{
      		$this->error['tennhacungcap'] = "Bạn chưa nhập tên nhà cung cấp";
    	}
		if($data['email'])
		{
			if ($this->validation->_checkEmail($this->request->post['email']) == false ) 
			{
				$this->error['email'] = "Email khong đúng định dạng";
			}
		}
		if($data['emailnguoilienhe'])
		{
			if ($this->validation->_checkEmail($this->request->post['emailnguoilienhe']) == false ) 
			{
				$this->error['emailnguoilienhe'] = "Email người liên không đúng định dạng";
			}
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