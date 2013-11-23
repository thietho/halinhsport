<?php
class ControllerQuanlykhoDonvitinh extends Controller
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
		
		$this->getList();
	}

	public function insert()
	{
		$this->getForm();
	}

	public function update()
	{
		
		$this->data['readonly'] = 'readonly="readonly"';
		$this->getForm();
	}


	public function delete()
	{
		$listmadonvi=$this->request->post['delete'];
		//$listmadonvi=$_POST['delete'];
		
		if(count($listmadonvi))
		{
			$this->model_quanlykho_donvitinh->deletedatas($listmadonvi);
			$this->data['output'] = "Xóa thành công";
		}
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
	}

	private function getList()
	{
		$this->data['insert'] = $this->url->http('quanlykho/donvitinh/insert');
		$this->data['delete'] = $this->url->http('quanlykho/donvitinh/delete');

		$this->data['datas'] = array();
		$rows = $this->model_quanlykho_donvitinh->getList();
		//Page
		$page = $this->request->get['page'];
		$x=$page;
		$limit = 20;
		$total = count($rows);
		// work out the pager values
		$this->data['pager']  = $this->pager->pageLayout($total, $limit, $page);

		$pager  = $this->pager->getPagerData($total, $limit, $page);
		$offset = $pager->offset;
		$limit  = $pager->limit;
		$page   = $pager->page;
		for($i=$offset;$i < $offset + $limit && count($rows[$i])>0;$i++)
		//for($i=0; $i <= count($this->data['datas'])-1 ; $i++)
		{
			$this->data['datas'][$i] = $rows[$i];
			$this->data['datas'][$i]['link_edit'] = $this->url->http('quanlykho/donvitinh/update&madonvi='.$this->data['datas'][$i]['madonvi']);
			$this->data['datas'][$i]['text_edit'] = "Sửa";
				
				
		}
		$this->data['refres']=$_SERVER['QUERY_STRING'];
		$this->id='content';
		$this->template="quanlykho/donvitinh_list.tpl";
		$this->layout="layout/center";

		$this->render();
	}


	private function getForm()
	{
		$this->data['error'] = @$this->error;

		$where = " AND madonvi <> '".$this->request->get['madonvi']."'";
		$this->data['listdonvitinh'] = $this->model_quanlykho_donvitinh->getList($where);

		if ((isset($this->request->get['madonvi'])) )
		{
			$this->data['item'] = $this->model_quanlykho_donvitinh->getItem($this->request->get['madonvi']);
				
		}

		$this->id='content';
		$this->template='quanlykho/donvitinh_form.tpl';
		$this->layout="layout/center";

		$this->render();
	}

	public function save()
	{
		$data = $this->request->post;
		if($this->validateForm($data))
		{
			$this->load->model("quanlykho/donvitinh");
			$item = $this->model_quanlykho_donvitinh->getItem($data['madonvi']);
			if(count($item)==0)
			{
				$this->model_quanlykho_donvitinh->insert($data);
			}
			else
			{
				$this->model_quanlykho_donvitinh->update($data);
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
		//chua kiem tra trung

		if ((strlen($data['madonvi']) == 0) || (strlen($this->request->post['itemname']) > 50))
		{
			$this->error['madonvi'] = "Mã đơn vị tính không được rỗng";
		}

		if ((strlen($data['tendonvitinh']) == 0))
		{
			$this->error['tendonvitinh'] = "Bạn chưa nhập tên đơn vị tính";
		}

		if (count($this->error)==0) {
			return TRUE;
		} else {
			return FALSE;
		}
	}
	//Cac ham xu ly tren form
	public function getListDonVi()
	{
		$madonvi = $this->request->get['madonvi'];
		$data_donvi = $this->model_quanlykho_donvitinh->getDonViQuyDoi($madonvi);
		$this->data['output'] = json_encode($data_donvi);
		
		$this->id="donvi";
		$this->template="common/output.tpl";
		$this->render();
	}
}
?>