<?php
class ControllerCorePostlist extends Controller
{
	function __construct() 
	{
		$this->data['permissionAccess'] = true;
		$this->data['permissionAdd'] = true;
		$this->data['permissionEdit'] = true;
		$this->data['permissionDelete'] = true;
		
		$sitemapid = $this->request->get['sitemapid'];
		
		if(!$this->user->hasPermission($sitemapid, "access"))
		{
			$this->data['permissionAccess'] = false;
		}
		if(!$this->user->hasPermission($sitemapid, "add"))
		{
			$this->data['permissionAdd'] = false;
		}
		if(!$this->user->hasPermission($sitemapid, "edit"))
		{
			$this->data['permissionEdit'] = false;
		}
		if(!$this->user->hasPermission($sitemapid, "delete"))
		{
			$this->data['permissionDelete'] = false;
		}
	 	
   	}
	
	function index()
	{	
		if(!$this->data['permissionAccess'])
			$this->response->redirect("?route=common/permission");
		
		$this->load->model("core/user");
		$this->load->model("core/media");
		$this->load->model("core/sitemap");
		$this->load->helper('image');
		
		if (!$this->user->isLogged()) {
			$this->redirect($this->url->https('page/index'));
		}
		
		$this->getList();
		
		$this->id='postlist';
		$this->template='core/post_list.tpl';	
		$this->render();
	}
	
	public function remove()
	{
		$this->load->model("core/media");
		$sitemapid = $this->request->get['sitemapid'];

		if($this->request->post['delete'])
		{
			foreach($this->request->post['delete'] as $mediaid)
			{
				$this->model_core_media->removeSitemap($mediaid, $sitemapid);
			}
		}
		
		$this->id='postlist';
		$this->template='common/output.tpl';	
		$this->render();
	}
	
	public function updatePosition()
	{
		$this->load->model("core/media");
		$sitemapid = $this->request->get['sitemapid'];

		if($this->request->post['position'])
		{
			foreach($this->request->post['position'] as $mediaid => $position)
			{
				
				$this->model_core_media->updateCol($mediaid,"position",$position);
			}
		}
		$this->data['output'] = "true";
		$this->id='postlist';
		$this->template='common/output.tpl';	
		$this->render();
	}
	
	private function getList()
	{
		$this->data['route'] = $this->getRoute();
		$sitemapid = $this->request->get['sitemapid'];
		
		$siteid = $this->user->getSiteId();
		
		
		$this->load->language($this->data['route']);
		$this->data = array_merge($this->data, $this->language->getData());
		
		$sitemap = $this->model_core_sitemap->getItem($sitemapid, $siteid);
		$this->data['sitemap'] = $sitemap;
		if($sitemapid != "")
			$sitemapid = $this->request->get['sitemapid'];
		else
			$this->response->redirect("?route=core/media");
		
		//Thiet ke form
		$this->data['heading_title'] = $sitemap['sitemapname'];
		$this->data['DIR_ADD'] = HTTP_SERVER."?route=".$this->data['route']."/insert&sitemapid=".$sitemapid;
		$this->data['DIR_DELETE'] = HTTP_SERVER."?route=core/postlist/remove&sitemapid=".$sitemapid;
		$this->data['DIR_UPDATEPOSITION'] = HTTP_SERVER."?route=core/postlist/updatePosition";
		//Lay Breadcrumb
		//$this->data['breadcrumb'] = $this->model_core_sitemap->getBreadcrumb($sitemapid, $siteid);
		$this->data['breadcrumb'] = $this->model_core_sitemap->getBreadcrumb($sitemapid, $siteid, -1);
		
	}
	
	public function loadData()
	{
		$this->load->model("core/user");
		$this->load->model("core/media");
		$this->load->model("core/sitemap");
		$this->load->helper('image');
		
		$this->data['route'] = $this->request->get['moduleid'];
		$moduleid = $this->request->get['moduleid'];
		$sitemapid = $this->request->get['sitemapid'];
		$mediaid = $this->request->get['mediaid'];
		$siteid = $this->user->getSiteId();
		$page = $this->request->get['page'];
		
		$code = $this->request->get['code'];
		$sizes = $this->request->get['sizes'];
		$title = $this->request->get['title'];
		
		$this->load->language($moduleid);
		$this->data = array_merge($this->data, $this->language->getData());
		//Get list
		$where = " AND refersitemap like '%[".$sitemapid."]%'";
		if($code)
			$where .= " AND code like '".$code."%'";
		if($sizes)
			$where .= " AND sizes like '%".$sizes."%'";
		if($title)
			$where .= " AND title like '%".$title."%'";
		$where .= " Order by position, statusdate DESC";
		$rows = $this->model_core_media->getList($where);
		
		//Page
		$page = $this->request->get['page'];		
		$x=$page;		
		$limit = 20;
		$total = count($rows); 
		// work out the pager values 
		
		$this->data['pager']  = $this->pager->pageLayoutAjax($total, $limit, $page,'postlist'); 
		
		$pager  = $this->pager->getPagerData($total, $limit, $page); 
		$offset = $pager->offset; 
		$limit  = $pager->limit; 
		$page   = $pager->page;
		$this->data['medias'] = array();
		
		for($i=$offset;$i < $offset + $limit && count($rows[$i])>0;$i++)
		{
			$this->data['medias'][$i] = $rows[$i];
			$user = $this->model_core_user->getItem($this->data['medias'][$i]['userid']);
			$this->data['medias'][$i]['fullname'] =$user['fullname'];
			$arr = $this->string->referSiteMapToArray($this->data['medias'][$i]['refersitemap']);
			$sitemapid = $arr[0];
			$sitemap = $this->model_core_sitemap->getItem($sitemapid,$this->user->getSiteId());
			if($this->data['medias'][$i]['imagepath'] != "")
			{
				$this->data['medias'][$i]['imagepreview'] = "<img src='".HelperImage::resizePNG($this->data['medias'][$i]['imagepath'], 100, 100)."' >";
				
			}
			
			$mediaid = $this->data['medias'][$i]['mediaid'];
			
			
			$this->data['medias'][$i]['link_edit'] = $this->url->http($sitemap['moduleid'].'/update&sitemapid='.$sitemap['sitemapid'].'&mediaid='.$this->data['medias'][$i]['mediaid']);
			$this->data['medias'][$i]['text_edit'] = "Edit";	
			
			$this->data['medias'][$i]['type'] = $sitemap['moduleid'];
			$this->data['medias'][$i]['typename'] = $this->model_core_sitemap->getModuleName($sitemap['moduleid']);
			
			
		}
		$this->id='postlist';
		$this->template='core/post_list_list.tpl';	
		$this->render();
	}
	
	
}
?>