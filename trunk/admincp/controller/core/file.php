<?php
class ControllerCoreFile extends Controller
{
	private $error = array();
	public function index()
	{
		$this->load->model("core/media");
		$this->load->model("core/sitemap");
		
		
		//$this->data['sitemap'] = $this->model_core_sitemap->getListSiteMapCheckBox($media);
		//$this->getList();
		$this->data['DIR_UPLOADPHOTO'] = HTTP_SERVER."index.php?route=common/uploadpreview";
		$this->data['DIR_UPLOADATTACHMENT'] = HTTP_SERVER."index.php?route=common/uploadattachment";
		$this->id='content';
		$this->template="core/file.tpl";
		if($_GET['dialog'] == '')
		{
			//$this->template="core/file_list.tpl";
			$this->layout="layout/center";
		}
		$this->render();
	}

	public function getList()
	{
		$this->load->model("core/media");
		//Loc theo media
		$keyword = $this->request->get['keyword'];
		$folderid = $this->request->get['folderid'];
		$location = $this->request->get['location'];
		$sitemap = trim($this->request->get['sitemap'],",");
		$list = "";
		
		//
		$path = $this->model_core_file->getPath($folderid);
		$arr = array();
		$arr[] = '<a class="folderpath" folderid="0">Root</a>';	
		foreach($path as $f)
		{
			$arr[] = '<a class="folderpath" folderid="'.$f['folderid'].'">'.$f['foldername'].'</a>';	
		}
		$this->data['path'] = implode(" >> ",$arr);
		//
		$this->data['folderchild'] = $this->model_core_file->getFolderChild($folderid);
		$this->load->model("core/sitemap");
		$this->load->helper('image');
		$where="";
		if($list!="")
			$where.=" AND fileid in (".$list.")";
		if($keyword!="")
		{
			$where .= " AND filename like '%".$keyword."%'";	
		}
		if($folderid!="")
			$where .= " AND folderid = ".$folderid;
		$rows = $this->model_core_media->getFiles($where." ORDER BY `file`.`fileid` DESC");
		//Page
		$page = $this->request->get['page'];		
		$x=$page;		
		$limit = 28;
		$total = count($rows); 
		// work out the pager values 
		for($i=0;$i <  count($rows);$i++)
		{
			
			$this->data['files'][$i] = $rows[$i];
			$this->model_core_file->updateFileTemp($this->data['files'][$i]['fileid']);
			$this->data['files'][$i]['imagethumbnail'] = HelperImage::resizePNG($this->data['files'][$i]['filepath'], 130, 130);
			if(!$this->string->isImage($this->data['files'][$i]['extension']))
				$this->data['files'][$i]['imagethumbnail'] = DIR_IMAGE."icon/dinhkem.png";
			
		}
		
		
		$this->id='content';
		$this->template="core/file_grid.tpl";
		$this->render();
	}
	
	public function detail()
	{
		$this->load->model("core/file");
		$this->load->helper('image');
		$fileid = $this->request->get['fileid'];
		
		$this->data['item']=$this->model_core_file->getFile($fileid);
		
		if($this->string->isImage($this->data['item']['extension']))
			$this->data['item']['imagepreview'] = HelperImage::resizePNG($this->data['item']['filepath'], 800, 800);
		//print_r($this->data['file']);
		//$info = pathinfo(HTTP_IMAGE.$this->data['item']['filepath']);
		//print_r($info);
		$this->id='file';
		$this->template = "core/file_detail.tpl";
		$this->render();
	}
	
	
	
	function getFile()
	{
		$width = (int)$this->request->get['width'];
		$height = (int)$this->request->get['height'];
		$this->load->model("core/file");
		$this->load->helper('image');
		$fileid = $this->request->get['fileid'];
		$file=$this->model_core_file->getFile($fileid);
		if($this->string->isImage($file['extension']))
			$file['imagepreview'] = HelperImage::resizePNG($file['filepath'], $width, $height);
		else
			$file['imagepreview'] = DIR_IMAGE."icon/dinhkem.png";
		$this->data['output'] = json_encode(array('file' => $file));
		$this->id='post';
		$this->template="common/output.tpl";
		$this->render();
	}
	public function delFile()
	{
		$this->load->model("core/file");
		$fileid = $this->request->get['fileid'];
		$this->model_core_file->deleteFile($fileid);
		
		$this->data['output'] = "true";
		$this->id='post';
		$this->template="common/output.tpl";
		$this->render();
	}
	
	public function delListFile()
	{
		$this->load->model("core/file");
		$listfileid = $this->request->post['chkfile'];
		foreach($listfileid as $fileid)
			$this->model_core_file->deleteFile($fileid);
		
		$this->data['output'] = "true";
		$this->id='post';
		$this->template="common/output.tpl";
		$this->render();
	}
	
	public function showFolderMoveForm()
	{
		$this->load->model("core/file");
		$this->data['treefolder'] = array();
		$this->model_core_file->getTreeFolder(0, $this->data['treefolder']);
		
		$this->id='post';
		$this->template="core/folder_move_form.tpl";
		$this->render();	
	}
	public function showFolderForm()
	{
		$this->load->model("core/file");
		
		$folderid = $this->request->get['folderid'];
		if($folderid =="")
			$folderid = -1;
		$folderparent = $this->request->get['folderparent'];
		if($folderid!= -1)
			$this->data['item'] = $this->model_core_file->getFolder($folderid);
		else
		{
			$this->data['item']['folderparent'] = $folderparent;
		}
		$this->data['treefolder'] = array();
		$this->model_core_file->getTreeFolder(0, $this->data['treefolder'],$folderid);
		
		$this->id='post';
		$this->template="core/folder_form.tpl";
		$this->render();
	}
	
	public function saveFolder()
	{
		$data = $this->request->post;
		$this->load->model("core/file");
		if($this->validateFolderForm($data))
		{
			$this->model_core_file->saveFolder($data);
			
			$data['error'] = "";
		}
		else
		{
			foreach($this->error as $item)
			{
				$data['error'] .= $item."<br>";
			}
		}
		$this->data['output'] = json_encode($data);
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
	
	private function validateFolderForm($data)
	{
		if ($data['foldername'] == "") 
		{
      		$this->error['foldername'] = "Bạn chưa nhập tên thư mục";
    	}
		
		if (count($this->error)==0) 
		{
	  		return TRUE;
		} else {
	  		return FALSE;
		}
	}
	
	public function getFolderTreeView()
	{
		$this->load->model("core/file");
		$root = @(int)$this->request->get['root'];
		$this->data['output'] = '<ul id="group'.$root.'" class="filetree">'.$this->getFolderTree($root).'</ul>';
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
	
	private function getFolderTree($root = 0)
	{
		
		$folders = $this->model_core_file->getFolderChild($root);
		$str = "";
		foreach($folders as $item)
		{
			$child = $this->model_core_file->getFolderChild($item['folderid']);
			$str.='<li id="node'.$item['folderid'].'" class="closed" ref="'.$root.'">';
			$type = 'folder';
			
			
			$str.='<span id="folder'.$item['folderid'].'" class="'.$type.'"><b><span id="foldername'.$item['folderid'].'" class="folderitem" folderid="'.$item['folderid'].'">'.$item['foldername'].'</span></b> </span>';
			if(count($child))
			{
				$str .= "<ul id='group".$item['folderid']."'>";
				$str .= $this->getFolderTree($item['folderid']);
				$str .= "</ul>";
			}
			$str.='</li>';
		}
		return $str;
	}
	public function updateFolder()
	{
		$fileid = $this->request->get['fileid'];
		$folderid = $this->request->get['folderid'];
		$this->load->model("core/file");
		$this->model_core_file->updateFileCol($fileid,'folderid',$folderid);
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
	
	public function delFolder()
	{
		$folderid = $this->request->get['folderid'];
		$this->load->model("core/file");
		//Kt co thu con khong
		$child = $this->model_core_file->getFolderChild($folderid);
		//Kt co ton tai file trong thi muc ko
		$where .= " AND folderid = ".$folderid;
		$data_file = $this->model_core_file->getFiles($where);
		if(count($child) == 0 && count($data_file) == 0)
		{
			$this->model_core_file->delFolder($folderid);
			$this->data['output'] = "true";
		}
		else
		{
			$this->data['output'] = "Thư mục đang chứa thông tin không xóa được";
		}
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
	
}
?>