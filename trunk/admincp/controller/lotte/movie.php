<?php
class ControllerLotteMovie extends Controller
{
	private $error = array();
	function __construct() 
	{
		
		$this->load->model("core/module");
		$moduleid = $this->getRoute();
		$this->document->title = $this->model_core_module->getBreadcrumbs($moduleid);
		if($this->user->checkPermission($moduleid)==false)
		{
			$this->response->redirect('?route=page/home');
		}
		
		
		
		$this->load->helper('image');
		$this->load->model("lotte/movie");
		$this->load->model("core/file");
		
		
		
   	}
	public function index()
	{
		$this->data['insert'] = $this->url->http('lotte/movie/insert');
		$this->data['delete'] = $this->url->http('lotte/movie/delete');
		
		$this->id='content';
		$this->template="lotte/movie_list.tpl";
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
			$this->model_lotte_movie->delete($id);
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
		
		$datasearchlike['moviename'] = urldecode($this->request->get['moviename']);
		
		
		$arr = array();
		foreach($datasearchlike as $key => $item)
		{
			if($item !="")
				$arr[] = " AND " . $key ." like '".$item."%'";
		}
		
		
		
		$where = implode("",$arr);
		
		$where .= " Order by id desc";
		$rows = $this->model_lotte_movie->getList($where);
		//Page
		$page = $this->request->get['page'];		
		$x=$page;		
		$limit = 20;
		$total = count($rows); 
		// work out the pager values 
		$this->data['pager']  = $this->pager->pageLayoutAjax($total, $limit, $page,"#listmovie");
		
		$pager  = $this->pager->getPagerData($total, $limit, $page); 
		$offset = $pager->offset; 
		$limit  = $pager->limit; 
		$page   = $pager->page;
		for($i=$offset;$i < $offset + $limit && count($rows[$i])>0;$i++)
		//for($i=0; $i <= count($this->data['datas'])-1 ; $i++)
		{
			$this->data['datas'][$i] = $rows[$i];
			$this->data['datas'][$i]['link_edit'] = $this->url->http('lotte/movie/update&id='.$this->data['datas'][$i]['id']);
			$this->data['datas'][$i]['text_edit'] = "Sửa";
			;
			//
			
			
			$file = $this->model_core_file->getFile($this->data['datas'][$i]['icone']);
			$this->data['datas'][$i]['iconethumbnail'] = HelperImage::resizePNG($file['filepath'], 100, 0);
			
			$file = $this->model_core_file->getFile($this->data['datas'][$i]['banner']);
			$this->data['datas'][$i]['bannerthumbnail'] = HelperImage::resizePNG($file['filepath'], 100, 0);
			
			$file = $this->model_core_file->getFile($this->data['datas'][$i]['image']);
			$this->data['datas'][$i]['imagethumbnail'] = HelperImage::resizePNG($file['filepath'], 100, 0);
			
			$arr = array($this->data['datas'][$i]['id']);
			
		}
		$this->data['refres']=$_SERVER['QUERY_STRING'];
		$this->id='content';
		$this->template="lotte/movie_table.tpl";
		
		if($this->request->get['opendialog']=='true')
		{
			$this->layout="";
			$this->data['dialog'] = true;
			
		}
		$this->render();
	}
	
	
	private function getForm()
	{
		
		$sanphamid = $this->request->get['id'];
		if($sanphamid) 
		{
      		$this->data['item'] = $this->model_lotte_movie->getItem($this->request->get['id']);
			$file = $this->model_core_file->getFile($this->data['item']['icone']);
			$this->data['item']['iconethumbnail'] = HelperImage::resizePNG($file['filepath'], 100, 0);
			
			$file = $this->model_core_file->getFile($this->data['item']['banner']);
			$this->data['item']['bannerthumbnail'] = HelperImage::resizePNG($file['filepath'], 100, 0);
			
			$file = $this->model_core_file->getFile($this->data['item']['image']);
			$this->data['item']['imagethumbnail'] = HelperImage::resizePNG($file['filepath'], 100, 0);	
			
    	}
		
		$this->id='content';
		$this->template='lotte/movie_form.tpl';
		$this->layout="layout/center";
		
		$this->render();
	}
	
	public function save()
	{
		$data = $this->request->post;
		$data['icone'] = $data['icone_fileid'];
		$data['banner'] = $data['banner_fileid'];
		$data['image'] = $data['image_fileid'];
		
		if($this->validateForm($data))
		{
			
			
			$data['id'] = $this->model_lotte_movie->save($data);
			
			
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
    	if($data['moviename'] == "")
		{
      		$this->error['moviename'] = "Bạn chưa nhập tên film";
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