<?php
class ControllerQuanlykhoNhanVien extends Controller
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
			
		$this->load->model("quanlykho/nhanvien");
		$this->load->model("core/category");
		
		$this->data['loainhanvien'] = array();
		$this->model_core_category->getTree("loainhanvien",$this->data['loainhanvien']);
		unset($this->data['loainhanvien'][0]);
	}
	public function index()
	{
		$this->data['insert'] = $this->url->http('quanlykho/nhanvien/insert');
		$this->data['delete'] = $this->url->http('quanlykho/nhanvien/delete');
		$this->data['refres']=$_SERVER['QUERY_STRING'];
		$this->id='content';
		$this->template="quanlykho/nhanvien_list.tpl";
		$this->layout="layout/center";
		
		
		if($this->request->get['opendialog']=='true')
		{
			$this->layout="";
			$this->data['dialog'] = true;
			//$this->data['list'] = $this->url->http('quanlykho/nhacungung&opendialog=true');
		}
		$this->render();
	}
	
	public function insert()
	{	
    	$this->getForm();
	}
	
	public function update()
	{
		$this->load->model("quanlykho/nhanvien");
		$this->data['haspass'] = false;
		$this->data['readonly'] = 'readonly="readonly"';
		
		$this->getForm();
		
  	}
	
	public function delete() 
	{
		$listid=$this->request->post['delete'];
		//$listmadonvi=$_POST['delete'];
		$this->load->model("quanlykho/nhanvien");
		if(count($listid))
		{
			$this->model_quanlykho_nhanvien->deletedatas($listid);
			$this->data['output'] = "Xóa thành công";
		}
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
  	}
	
	public function getList() 
	{
		
		$this->load->model("core/user");
		
		
		
		
		
		$this->data['insert'] = $this->url->http('quanlykho/nhanvien/insert');
		$this->data['delete'] = $this->url->http('quanlykho/nhanvien/delete');		
		
		$this->data['datas'] = array();
		$where = "";
		
		$datasearchlike['manhanvien'] = $this->request->get['manhanvien'];
		$datasearchlike['hoten'] = $this->request->get['hoten'];
		$datasearch['loai'] = $this->request->get['loai'];
		
		
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
		
		$where = implode("",$arr);
		
		$rows = $this->model_quanlykho_nhanvien->getList($where);
		//Page
		$page = $this->request->get['page'];		
		$x=$page;		
		$limit = 20;
		$total = count($rows); 
		// work out the pager values 
		$this->data['pager']  = $this->pager->pageLayoutAjax($total, $limit, $page,"#listnhanvien");
		
		$pager  = $this->pager->getPagerData($total, $limit, $page); 
		$offset = $pager->offset; 
		$limit  = $pager->limit; 
		$page   = $pager->page;
		for($i=$offset;$i < $offset + $limit && count($rows[$i])>0;$i++)
		{
			$this->data['datas'][$i] = $rows[$i];
			
			$this->data['datas'][$i]['link_edit'] = $this->url->http('quanlykho/nhanvien/update&id='.$this->data['datas'][$i]['id']);
			$this->data['datas'][$i]['text_edit'] = "Sửa";
			
			
			
			$user = $this->model_core_user->getItem($this->data['datas'][$i]['username']);
			if($this->data['datas'][$i]['username'] == "")
			{
				$this->data['datas'][$i]['link_taikhoan'] = $this->url->http("quanlykho/nhanvien/taotaikhoan&id=".$this->data['datas'][$i]['id']);
				$this->data['datas'][$i]['text_taikhoan'] = "Tạo tài khoản";
			}
			else
			{
				
				$this->data['datas'][$i]['link_phanquyen'] = $this->url->http('quanlykho/nhanvien/phanquyen&id='.$this->data['datas'][$i]['id']);
				$this->data['datas'][$i]['text_phanquyen'] = "Phân quyền";
				$this->data['datas'][$i]['text_resetpass'] = "Reset password";	
			
				if($user['status'] == "lock")	
				{
					$this->data['datas'][$i]['link_taikhoan'] = $this->url->http("quanlykho/nhanvien/motaikhoan&username=".$this->data['datas'][$i]['username']);
					$this->data['datas'][$i]['text_taikhoan'] = "Mở tài khoản";
				}
				
				if($user['status'] == "active")	
				{
					$this->data['datas'][$i]['link_taikhoan'] = $this->url->http("quanlykho/nhanvien/khoataikhoan&username=".$this->data['datas'][$i]['username']);
					$this->data['datas'][$i]['text_taikhoan'] = "Khóa tài khoản";
					
					
				}
				
				
			}
			
		}
		$this->data['refres']=$_SERVER['QUERY_STRING'];
		$this->id='content';
		$this->template="quanlykho/nhanvien_table.tpl";
		
		if($this->request->get['opendialog']=='true')
		{
			$this->layout="";
			$this->data['dialog'] = true;
			
		}
		$this->render();
	}
	
	private function getForm()
	{
		$this->load->helper('image');
		
		if ((isset($this->request->get['id'])) ) 
		{
      		$this->data['item'] = $this->model_quanlykho_nhanvien->getItem($this->request->get['id']);
			$this->data['item']['arrnhom'] = array();
			$this->data['item']['arrnhom'] = $this->string->referSiteMapToArray($this->data['item']['nhom']);
			$this->data['item']['imagethumbnail'] = HelperImage::resizePNG($this->data['item']['imagepath'], 200, 200);
    	}
		$this->data['DIR_UPLOADPHOTO'] = HTTP_SERVER."index.php?route=common/uploadpreview";
		$this->id='content';
		$this->template='quanlykho/nhanvien_form.tpl';
		$this->layout="layout/center";
		
		$this->render();
	}
	
	public function save()
	{
		$data = $this->request->post;
		
		if($this->validateForm($data))
		{
			$this->load->model("quanlykho/nhanvien");
			$item = $this->model_quanlykho_nhanvien->getItem($data['id']);
			$data['ngaysinh'] = $this->date->formatViewDate($data['ngaysinh']);
			$data['ngayvaolam'] = $this->date->formatViewDate($data['ngayvaolam']);
			$data['ngaykyhopdong'] = $this->date->formatViewDate($data['ngaykyhopdong']);
			$data['nhom'] = $this->string->arrayToString($data['nhom']);
			if(count($item)==0)
			{
				$data['id']=$this->model_quanlykho_nhanvien->insert($data);
			}
			else
			{
				$this->model_quanlykho_nhanvien->update($data);
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
    	if($data['manhanvien'] == "")
		{
      		$this->error['manhanvien'] = "Mã nhân viên không được rỗng";
    	}
		else
		{
			if($data['id'] == "")
			{
				$this->load->model("quanlykho/nhanvien");
				$where = " AND manhanvien ='".$data['manhanvien']."'" ;
				$item = $this->model_quanlykho_nhanvien->getList($where);
				if(count($item)>0)
					$this->error['manhanvien'] = "Mã nhân viên đã được sử dụng";
			}
		}
		if(strlen($data['manhanvien']) > 50)
		{
      		$this->error['manhanvien'] = "Mã nhà nhân viên không được vượt quá 50 ký tự";
    	}
		
		if ($data['hoten'] == "") 
		{
      		$this->error['hoten'] = "Bạn chưa nhập tên nhân viên";
    	}
		
		
		
		if ($data['gioitinh'] == "") 
		{
      		$this->error['gioitinh'] = "Bạn chưa chọn giới tính";
    	}
		
		/*if ($data['maphongban'] == "") 
		{
      		$this->error['maphongban'] = "Bạn chưa chọn phòng ban";
    	}*/
		
		if ($data['loai'] == "") 
		{
      		$this->error['loai'] = "Bạn chưa chọn loại";
    	}
		
		/*if ($data['nhom'] == "") 
		{
      		$this->error['nhom'] = "Bạn chưa chọn nhóm";
    	}*/
		
		/*if ($data['chucvu'] == "") 
		{
      		$this->error['chucvu'] = "Bạn chưa chọn chức vụ";
    	}*/
		
		if (count($this->error)==0) 
		{
	  		return TRUE;
		} else {
	  		return FALSE;
		}
	}
	
	//Các hàm xủ lý trên form
	public function getNhanVien()
	{
		$col = $this->request->get['col'];
		$val = $this->request->get['val'];
		$operator = $this->request->get['operator'];
		if($operator == "")
			$operator = "equal";
		$this->load->model("quanlykho/nhanvien");
		$where = "";
		switch($operator)
		{
			case "equal":
				$where = " AND ".$col." = '".$val."'";
				break;
			case "like":
				$where = " AND ".$col." = '%".$val."%'";
				break;
			case "other":
				$where = " AND ".$col." <> '".$val."'";
				break;
			case "in":
				$where = " AND ".$col." in  (".$val.")";
				break;
			
		}
			
		
		$datas = $this->model_quanlykho_nhanvien->getList($where);
		
		$this->data['output'] = json_encode(array('nhanviens' => $datas));
		$this->id="nhanvien";
		$this->template="common/output.tpl";
		$this->render();
	}
	
	public function taotaikhoan()
	{
		if(!$this->user->hasPermission($this->getRoute(), "add"))
		{
			$this->response->redirect("?route=common/permission");
		}
		$this->document->title = $this->language->get('heading_title');
		$this->load->model("core/user");
		$this->load->model("quanlykho/nhanvien");
		$this->data['haspass'] = true;
		
		$this->data['error'] = @$this->error;
		$this->load->model("core/usertype");
		
		$this->data['nhanvien'] = $this->model_quanlykho_nhanvien->getItem($this->request->get['id']);
		$this->data['usertype'] = $this->model_core_usertype->getList("");
		$this->data['cancel'] = $this->url->https('quanlykho/nhanvien');
		
		$this->id='content';
		$this->template='quanlykho/user_form.tpl';
		$this->layout="layout/center";
		
		$this->render();
	}
	
	public function phanquyen()
	{
		$this->load->model("core/usertype");
		$this->load->model("core/usertype");
		$this->data['usertype'] = $this->model_core_usertype->getList(" Order by id");
		
		$this->load->model("quanlykho/nhanvien");
		
		$this->load->model("core/module");
		$this->load->model("core/sitemap");
		
		$this->data['treemodule'] = $this->getTree();
		
		$this->data['nhanvien'] = $this->model_quanlykho_nhanvien->getItem($this->request->get['id']);
		
		
		$this->data['nhanvien']['usertypeid'] = $this->document->getUser($this->data['nhanvien']['username'],'usertypeid');
		
		$this->data['permission'] = $this->string->referSiteMapToArray($this->data['nhanvien']['permission']);
		
		
		
		$this->data['cancel'] = $this->url->https('quanlykho/nhanvien');
		
		$this->id='content';
		$this->template = 'quanlykho/nhanvien_phanquyen.tpl';
		$this->layout="layout/center";
		$this->render();
	}
	
	public function getTreeView()
	{
		
		$root = @(int)$this->request->get['root'];
		$this->data['output'] = $this->getTree($root);
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
	
	private function getTree($root = 0)
	{
		
		$modules = $this->model_core_module->getChild($root);
		$str = "";
		foreach($modules as $item)
		{
			$child = $this->model_core_module->getChild($item['id']);
			$str.='<li id="node'.$item['id'].'" class="closed" ref="'.$root.'">';
			$type = 'folder';
			
			
			$chk = '<input type="checkbox" id="per'.$item['id'].'" class="permission" name="permission[]" value="'.$item['moduleid'].'" parent="'.$item['moduleparent'].'">';
			
			
			$parent = '<input type="hidden" id="nodeparent_'.$item['id'].'" name="parent['.$item['id'].']" value="'.$root.'">';
			$str.='<span id="module'.$item['id'].'" class="'.$type.'">'.$chk.' <b><span id="modulename'.$item['id'].'">'.$item['moduleid']."->".$item['modulename'].'</span></b> '.$parent.'</span>';
			if(count($child))
			{
				$str .= "<ul id='group".$item['id']."'>";
				$str .= $this->getTree($item['id']);
				$str .= "</ul>";
			}
			$str.='</li>';
		}
		return $str;
	}
	
	public function motaikhoan()
	{
		$this->load->model("core/user");
		
		$data = array();
		$data['userid'] = $this->request->get['username'];
		$data['status'] = "active";
		
		$this->model_core_user->updatestatus($data);
		$this->response->redirect("index.php?route=quanlykho/nhanvien");
		
	}
	
	public function khoataikhoan()
	{
		$this->load->model("core/user");
		
		$data = array();
		$data['userid'] = $this->request->get['username'];
		$data['status'] = "lock";
		$this->model_core_user->updatestatus($data);
		
		$this->response->redirect("index.php?route=quanlykho/nhanvien");
	}
	
	public function saveuser()
	{
		$data = $this->request->post;
		
		if($this->validateFormUser($data))
		{
			
			$this->load->model("quanlykho/nhanvien");
			$this->load->model("core/module");
			$userid = $this->model_quanlykho_nhanvien->saveuser($data);
			$this->model_quanlykho_nhanvien->updateusername($data['nhanvienid'], $userid);
			//Lay cac module duoc phep truy cap cua usertype do tu bang module
			$where = " AND permission like '%[".$data['usertypeid']."]%'";
			$data_module = $this->model_core_module->getList($where);
			$arr_module = $this->string->matrixToArray($data_module,'moduleid');
			$permission = $this->string->arrayToString($arr_module);
			
			//Luu cac module duoc phep truy cap vao permission cua nhan vien
			//$nhanvien = $this->model_quanlykho_nhanvien->getItem($data['nhanvienid']);
			$this->model_quanlykho_nhanvien->updateCol($data['nhanvienid'],'permission',$permission);
			
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
	
	public function savePermission()
	{
		$this->load->model("quanlykho/nhanvien");
		$this->load->model("core/user");
		//Cap nhat quyen
		$id = $this->request->post['nhanvienid'];
		$permission = $this->string->arrayToString($this->request->post['permission']);
		$this->model_quanlykho_nhanvien->updateCol($id,'permission',$permission);
		//Cap nhat loai nhan vien
		$userid = $this->request->post['userid'];
		$usertypeid = $this->request->post['usertypeid'];
		$this->model_core_user->updateCol($userid,'usertypeid',$usertypeid);
		
		$this->data['output'] = "true";
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
	}
	
	private function validateFormUser($data)
	{
    	if ((strlen($data['username']) == 0) || (strlen($data['username']) > 30)) 
		{
      		$this->error['username'] = "Bạn chưa nhập tên tài khoản";
    	}
		else
		{
			
			if($this->validation->_isId(trim($data['username'])) == false)
				$this->error['username'] ="tên tài khoản không hợp lệ";
			else
			{
				$this->load->model("core/user");
				$user = $this->model_core_user->getItemByUserName($data['username']);
				
				if(count($user)>0 && $this->request->post['userid'] == '')
					$this->error['username'] = "Tên tài khoản đã được sử dụng";			
			}
		}
		if($this->request->get['userid']=="")
		{
			if (strlen($data['password']) == 0) 
			{
				$this->error['password'] = "Bạn chưa nhập mật khẩu";
			}
			
			if ($this->request->post['confrimpassword'] != $data['password']) 
			{
				$this->error['confrimpassworfd'] = "Mật khẩu mới không trùng khớp";
			}		
		}
		
		if (count($this->error)==0) {
	  		return TRUE;
		} else {
	  		return FALSE;
		}
	}
	//Reset password
	public function resetPass()
	{
		$id = $this->request->get['id'];
		$this->data['nhanvien'] = $this->model_quanlykho_nhanvien->getItem($id);
		$this->id='content';
		$this->template = 'quanlykho/nhanvien_resetpass.tpl';
		$this->render();
	}
	
	public function profile()
	{
		$this->data['nhanvien'] = $this->user->getNhanVien();
		
		$this->id='content';
		$this->template = 'quanlykho/nhanvien_profile.tpl';
		$this->layout="layout/center";
		$this->render();
	}
}
?>