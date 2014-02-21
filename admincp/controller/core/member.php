<?php
class ControllerCoreMember extends Controller
{
	private $error = array();
	function __construct() 
	{
	 	$this->load->model("core/user");
		$this->load->model("quanlykho/phieunhapxuat");
		$this->load->model("addon/thuchi");
		
   	}
	public function index()
	{
		$this->data['insert'] = $this->url->http('core/member/insert');
		$this->data['delete'] = $this->url->http('core/user/delete');		
		
		
		$this->id='content';
		$this->template="core/member_list.tpl";
		$this->layout=$this->user->getLayout();
		if($this->request->get['opendialog']=='true')
		{
			$this->layout="";
			$this->data['dialog'] = true;
			
		}
		$this->render();
	}
	
	public function insert()
	{
		if(!$this->user->hasPermission($this->getRoute(), "add"))
		{
			$this->response->redirect("?route=common/permission");
		}
		//$this->load->language('core/user');
		//$this->data = array_merge($this->data, $this->language->getData());
		
		$this->document->title = $this->language->get('heading_title');
		
		$this->data['haspass'] = true;
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validateForm())) 
		{
			$this->request->post['birthday'] = $this->date->formatViewDate($this->request->post['birthday']);
			$this->model_core_user->insertuser($this->request->post);
			$this->session->data['success'] = $this->language->get('text_success');
			$this->redirect($this->url->http('core/user'));
		}
    
    	$this->getForm();
	}
	
	public function update()
	{
		if(!$this->user->hasPermission($this->getRoute(), "edit"))
		{
			$this->response->redirect("?route=common/permission");
		}
		else
		{
			//$this->load->language('core/user');
			//$this->data = array_merge($this->data, $this->language->getData());
			
			$this->document->title = $this->language->get('heading_title');
			
			$this->data['haspass'] = false;
			
			
		
			$this->getForm();
		}
		
  	}
	
	public function active()
	{
		$id = $this->request->get['id'];
		
		
		$data['id'] = $id;
		$user=$this->model_core_user->getId($id);
		if($user['status'] == "lock")
			$data['status'] = "active";
		else
			$data['status'] = "lock";
		$this->model_core_user->updateCol($id,'status',$data['status']);
		if($data['status'] == "active")
			$this->data['output']="Kích hoạt thành công";
		if($data['status'] == "lock")
			$this->data['output']="User đã bị khóa";
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
	}
	
	public function delete() 
	{
		$listuserid=$this->request->post['delete'];
		//$listuserid=$_POST['delete'];
		
		if(count($listuserid))
		{
			foreach($listuserid as $id)
			{
				$this->model_core_user->destroy($id);
			}
			$this->data['output'] = "Xóa thành công";
		}
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
  	}
	
	public function getList() 
	{
		$this->data['users'] = array();
		$where = "AND usertypeid = 'member'";
		$data = $this->request->get;
		foreach($data as $key =>$val)
		{
			$data[$key] = urldecode($val);	
		}
		$_GET = $data;
		if(trim($data['username']))
		{
			$where .= " AND username like '%".$data['username']."%'";
		}
		if(trim($data['fullname']))
		{
			$where .= " AND fullname like '%".$data['fullname']."%'";
		}
		if(trim($data['phone']))
		{
			$where .= " AND phone like '%".$data['phone']."%'";
		}
		if(trim($data['address']))
		{
			$where .= " AND address like '%".$data['address']."%'";
		}
		if(trim($data['email']))
		{
			$where .= " AND email like '%".$data['email']."%'";
		}
		if(trim($data['status']))
		{
			$where .= " AND status like '".$data['status']."'";
		}
		$where .= " Order by fullname";
		$rows = $this->model_core_user->getList($where);
		//Page
		$page = $this->request->get['page'];		
		$x=$page;		
		$limit = 20;
		$total = count($rows); 
		// work out the pager values 
		$this->data['pager']  = $this->pager->pageLayoutAjax($total, $limit, $page,"memberlist"); 
		
		$pager  = $this->pager->getPagerData($total, $limit, $page); 
		$offset = $pager->offset; 
		$limit  = $pager->limit; 
		$page   = $pager->page;
		for($i=$offset;$i < $offset + $limit && count($rows[$i])>0;$i++)
		//for($i=0; $i <= count($this->data['users'])-1 ; $i++)
		{
			$this->data['users'][$i] = $rows[$i];
			$this->data['users'][$i]['link_edit'] = $this->url->http('core/member/update&id='.$this->data['users'][$i]['id']);
			$this->data['users'][$i]['text_edit'] = "Edit";
			$this->data['users'][$i]['link_active'] = $this->url->http('core/member/active&id='.$this->data['users'][$i]['id']);
			if($this->data['users'][$i]['status']=='lock')
				$this->data['users'][$i]['text_active'] = "Kích hoạt";
			else
				$this->data['users'][$i]['text_active'] = "Khóa";
			$arr = array($this->data['users'][$i]['id']);
			$this->data['users'][$i]['congno'] = $this->loadModule("core/member","getCongNo",$arr);
		}
		$this->data['refres']=$_SERVER['QUERY_STRING'];
		$this->id='content';
		$this->template="core/member_table.tpl";
		
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
			$id=$this->request->get['khachhangid'];
		
		$this->data['user'] = $this->model_core_user->getId($id);
		//Lay tat ca phieu thu cong no
		$where = " AND makhachhang = 'KH-".$id."' AND loaithuchi = 'thu' AND taikhoanthuchi = 'thuno'";
		$this->data['data_phieuthu'] = $this->model_addon_thuchi->getList($where);
		$tongthu = 0;
		foreach($this->data['data_phieuthu'] as $item)
		{
			$tongthu += $item['quidoi'];	
		}
		//Lay tat ca phieu thu vay no
		$where = " AND makhachhang = 'KH-".$id."' AND loaithuchi = 'thu' AND taikhoanthuchi = 'credit'";
		$this->data['data_phieuthuvayno'] = $this->model_addon_thuchi->getList($where);
		$tongvay = 0;
		foreach($this->data['data_phieuthuvayno'] as $item)
		{
			$tongvay += $item['quidoi'];	
		}
		//Lay tat ca phieu chi tra no
		$where = " AND makhachhang = 'KH-".$id."' AND loaithuchi = 'chi' AND taikhoanthuchi = 'paycredit'";
		$this->data['data_phieuchitrano'] = $this->model_addon_thuchi->getList($where);
		$tongtrano = 0;
		foreach($this->data['data_phieuchitrano'] as $item)
		{
			$tongtrano += $item['quidoi'];	
		}
		
		//Lay tat ca phieu ban hang
		$where = " AND loaiphieu = 'PBH' AND khachhangid = '".$id."'";
		$this->data['data_phieubanhang'] = $this->model_quanlykho_phieunhapxuat->getList($where);
		$tongno = 0;
		foreach($this->data['data_phieubanhang'] as $item)
		{
			$tongno += $item['congno'];	
		}
		//Lay tat ca phieu tra hang
		$where = " AND loaiphieu = 'NK-KHTL' AND khachhangid = '".$id."'";
		$this->data['data_phieutrahang'] = $this->model_quanlykho_phieunhapxuat->getList($where);
		
		$tongnotrahang = 0;
		foreach($this->data['data_phieutrahang'] as $item)
		{
			$tongnotrahang += $item['congno'];	
		}
		
		$congno = $tongno + $tongtrano - $tongthu - $tongvay - $tongnotrahang;
		
		if($this->request->get['khachhangid'])
		{
			
			$this->data['tongno'] = $tongno;
			$this->data['tongnotrahang'] = $tongnotrahang;
			$this->data['tongtrano'] = $tongtrano;
			$this->data['tongphieuthu'] = $tongthu;
			$this->data['tongvay'] = $tongvay;
			
			$this->data['congno'] = $congno;
			$this->id='content';
			$this->template="core/member_congno.tpl";
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
		$this->data['error'] = @$this->error;
		$this->load->model("core/usertype");
		$this->load->model("core/country");
		$this->load->helper('image');
		
		$this->data['DIR_UPLOADPHOTO'] = HTTP_SERVER."index.php?route=common/uploadpreview";
		$this->data['cancel'] = $this->url->https('core/member');
		$id = $this->request->get['id'];
		
		$this->data['user'] = $this->model_core_user->getId($id);
		$this->data['user']['imagethumbnail']=HelperImage::resizePNG($this->data['user']['imagepath'], 200, 200);
    	
		
		$this->id='content';
		$this->template='core/member_form.tpl';
		//$this->layout=$this->user->getLayout();
		
		$this->render();
	}
	
	public function save()
	{
		$data = $this->request->post;
		
		if($this->validateForm($data))
		{
			
			$data['birthday'] = $this->date->formatViewDate($data['birthday']);
			if($data['id']=="")
			{
				$this->model_core_user->insertUser($data);	
			}
			else
			{	
				$this->model_core_user->updateUser($data);	
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
	
	private function validateForm()
	{
    	
		if(trim($this->request->post['fullname'])=="")
		{
			$this->error['fullname'] = "Bạn chưa nhập tên";
			
		}
		
		if(trim($this->request->post['email'])!="")
		{
			if ($this->validation->_checkEmail($this->request->post['email']) == false ) 
			{
				$this->error['email'] = "Email invalidate";
			}
		}
		if (!$this->error) {
	  		return TRUE;
		} else {
	  		return FALSE;
		}
	}
}
?>