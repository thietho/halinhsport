<?php
class ControllerCoreModule extends Controller
{
	private $error = array();
   	function __construct() 
	{
		
	 	$this->load->model("core/module");
		
		
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
		$this->data['haspass'] = false;
		$this->data['readonly'] = 'readonly="readonly"';
		$this->data['class'] = 'readonly';
		$this->getForm();
  	}
	
	public function move()
	{
		$this->data['item'] = $this->model_core_module->getItem($this->request->get['id']);
		$this->data['modules'] = array();
		$this->model_core_module->getTree(0, $this->data['modules']);
		$this->id='content';
		$this->template='core/module_move.tpl';
		$this->render();
	}
	
	public function permission()
	{
		$this->data['item'] = $this->model_core_module->getItem($this->request->get['id']);
		$this->data['permission'] = $this->string->referSiteMapToArray($this->data['item']['permission']);
		$this->load->model("core/usertype");
		$where = " AND usertypeid <> 'admin' ORDER BY `id` ASC ";
		$this->data['usertypes'] = $this->model_core_usertype->getList($where);
		$this->id='content';
		$this->template='core/module_permission.tpl';
		$this->render();
	}
	
	public function updatePermission()
	{
		$data = $this->request->post;
		$permission = "";
		if(count($data['usertypeid']))
		{
			$permission = $this->string->arrayToString($data['usertypeid']);	
		}
		
		$this->model_core_module->updateCol($data['id'],'permission',$permission);
		$this->data['output'] = "true";
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
	
	public function delete() 
	{
		$listmoduleid=$this->request->post['delete'];
		if(count($listmoduleid))
		{
			foreach($listmoduleid as $moduleid)
			{
				$this->model_core_module->delete($moduleid);	
			}
			$this->data['output'] = "true";
		}
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
  	}
	
	public function remove() 
	{
		$moduleid=$this->request->get['moduleid'];
		if($this->validateRemovemodule($moduleid))
		{
			$module = $this->model_core_module->getItem($moduleid);
			$this->model_core_module->delete($moduleid);	
			
			$arr = array(
						'error' => '',
						'moduleparent' => $module['moduleparent']
						);
			$this->data['output'] = json_encode($arr);
		}
		else
		{
			foreach($this->error as $item)
			{
				$this->data['output'] .= $item."\n";
			}
			$arr = array(
						'error' => $this->data['output']
						);
			$this->data['output'] = json_encode($arr);
		}
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
  	}
	
	private function validateRemovemodule($moduleid)
	{
		
			
		if (count($this->error)==0) {
	  		return TRUE;
		} else {
	  		return FALSE;
		}
	}
	
	private function getList() 
	{
		$this->data['insert'] = $this->url->http('core/module/insert');
		$this->data['delete'] = $this->url->http('core/module/delete');		
		$this->data['treemodule'] = $this->getTree();
		
		$this->id='content';
		$this->template="core/module_list.tpl";
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
			$btnRemove ="";
			if(count($child)==0)
			{
				$type = 'file';
				$btnRemove = '[<a onClick="module.remove(\''.$item['id'].'\')">Remove</a>]';
			}
			$btnEdit ="";
			$btnAdd ="";
			//if($this->data['list_button']['update'])
			$btnEdit = '[<a onClick="module.edit(\''.$item['id'].'\')">Edit</a>]';
			//if($this->data['list_button']['insert'])
			$btnAdd = '[<a onClick="module.add(\''.$item['id'].'\')">Add child</a>]';
			$btnPermission = '[<a onClick="module.permission(\''.$item['id'].'\')">Permission</a>]';
			$btnMove = '<a onClick="module.move('.$item['id'].')">Move</a>';
			$parent = '<input type="hidden" id="nodeparent_'.$item['id'].'" name="parent['.$item['id'].']" value="'.$root.'">';
			$str.='<span id="module'.$item['id'].'" class="'.$type.'"><b><span id="modulename'.$item['id'].'">'.$item['moduleid']."->".$item['modulename'].'</span></b> '.$btnMove.' '.$btnEdit.' '.$btnAdd.'  '.$btnRemove.$btnPermission.$parent.'</span>';
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
	
	
	
	
	private function getForm()
	{		
		
		if ((isset($this->request->get['moduleid'])) ) 
		{
      		$this->data['item'] = $this->model_core_module->getItem($this->request->get['moduleid']);
    	}
		else
		{
			$this->data['item']['moduleparent'] = $this->request->get['parent'];
			$moduleparent = $this->model_core_module->getItem($this->data['item']['moduleparent']);
			$loaimodule = "";
			switch($moduleparent['loaimodule'])
			{
				case "":
					$loaimodule = "tinhthanh";
					break;
				case "tinhthanh":
					$loaimodule = "module";
					break;
				case "module":
					$loaimodule = "module";
					break;
				
			}
				
			$this->data['item']['loaimodule'] = $loaimodule;
		}
		
		$this->id='content';
		$this->template='core/module_form.tpl';
		$this->render();
	}
	
	public function save()
	{
		$data = $this->request->post;
		
		if($this->validateForm($data))
		{
			
			
			if($data['id']==0)
			{
				$data['id'] = $this->model_core_module->insert($data);	
			}
			else
			{
				$this->model_core_module->update($data);	
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
		/*if (trim($data['mamodule']) == "") 
		{
      		$this->error['mamodule'] = "Bạn chưa nhập mã khu vực";
    	}
		else
		{
			$where = " AND mamodule = '".$data['mamodule']."'";
			$kybaos = $this->model_core_module->getList($where);
			if(count($kybaos) > 0 && $data['moduleid'] == "")
			{
				$this->error['mamodule'] = "Mã khu vực đã tồn tại trong hệ thống";	
			}
		}*/
		
		/*if (trim($data['moduleid']) == "") 
		{
      		$this->error['moduleid'] = "Bạn chưa nhập mã module";
    	}*/
		
		if (trim($data['modulename']) == "") 
		{
      		$this->error['modulename'] = "Bạn chưa nhập tên module";
    	}
		
		
	
		if (count($this->error)==0) {
	  		return TRUE;
		} else {
	  		return FALSE;
		}
	}
	//Cac ham xu ly tren form
	public function updateParent()
	{
		$data = $this->request->post;
		$this->model_core_module->updateCol($data['id'],'moduleparent',$data['moduleparent']);
		$this->data['output'] = "true";
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
	
	public function savePostion()
	{
		$data = $this->request->post['parent'];
		
		foreach($data as $key => $val)
		{
			$this->model_core_module->updateCol($key,'moduleparent',$val);
		}
		
		$this->data['output'] = "true";
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
	
	public function getmodule()
	{
		$moduleid = $this->request->get['moduleid'];
		$module = $this->model_core_module->getItem($moduleid);
		
		
		$this->data['output'] = json_encode(array('module' => $module));
		$this->id="kybao";
		$this->template="common/output.tpl";
		$this->render();
	}
}
?>