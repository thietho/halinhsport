<?php
class ControllerCoreMedia extends Controller
{
	private $error = array();
	private $route;
	public function __construct() 
	{
		$this->load->model("core/media");
		$this->load->model("quanlykho/donvitinh");
		$this->load->model("core/sitemap");
		$this->load->helper('image');
		
		$this->data['module'] = array(
										
							'module/news'=>'News',
							'module/event' => 'Event',
							'module/banner'=>'Banner',
							'module/album'=>'Album',
							'module/video'=>'Video',
							'module/product'=>'Product',
							'module/download'=>'Download',
							'module/link'=>'Web URL',
							'module/traning'=>'Traning',
							'module/question'=>'Questions',
							'module/location'=>'Location'
							
										);
		$this->load->model('core/user');
		$where = " AND usertypeid <> 'member'";
		$this->data['users'] = $this->model_core_user->getList($where);
	}
	
	public function index()
	{
		$this->document->title = $this->language->get('heading_title');
		
		
		$this->id='content';
		$this->template="core/media_list.tpl";
		$this->layout="layout/center";
		
		$this->render();
	}
	
	public function getList()
	{
		
		$where = " AND mediaparent = '' AND mediatype = ''";
		
		$keyword = urldecode($this->request->get['keyword']);
		$type = urldecode($this->request->get['type']);
		$sitemapid = urldecode($this->request->get['sitemapid']);
		$userid = urldecode($this->request->get['userid']);
		$tungay = urldecode($this->request->get['tungay']);
		$denngay = urldecode($this->request->get['denngay']);
		
		/*if($keyword != '')
		{
			$where .= "AND ( 
							title like '%".$keyword."%' 
							OR summary like '%".$keyword."%' 
							OR description like '%".$keyword."%' 
							)";	
		}*/
		$arrkey = split(' ', $keyword);
		$where = "";
		if($keyword !="")
		{
			$arr = array();
			foreach($arrkey as $key)
			{
				$arr[] = "title like '%".$key."%'";
			}
			$where .= " AND (". implode(" AND ",$arr). ")";
			//$where .= " AND ( title like '%".$keyword."%' OR summary like '%".$keyword."%' OR description like '%".$keyword."%')";
		}
		
		if($type!="")
		{
			$arr = array();
			$sitemaps = $this->model_core_sitemap->getListByModule($type,$this->user->getSiteId());
			foreach($sitemaps as $item)
			{
				$arr[] = " refersitemap like '%[".$item['sitemapid']."]%'";
			}
			$where .= "AND (". implode($arr," OR ").")";
		}
		if($sitemapid!="")
		{
			$where .= " AND refersitemap like '%[".$sitemapid."]%'";	
		}
		if($userid!="")
		{
			$where .= " AND userid = '".$userid."'";	
		}
		if($tungay!="")
		{
			$where .= " AND statusdate >= '".$this->date->formatViewDate($tungay)."'";	
		}
		if($denngay!="")
		{
			$where .= " AND statusdate < '".$this->date->formatViewDate($denngay)." 24:00:00'";	
		}
		
		$rows = $this->model_core_media->getList($where);
		//Page
		$page = $this->request->get['page'];		
		$x=$page;		
		$limit = 20;
		$total = count($rows); 
		// work out the pager values 
		$this->data['pager']  = $this->pager->pageLayoutAjax($total, $limit, $page,"#listmedia");
		
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
				$this->data['medias'][$i]['imagepreview'] = "<img width=100 src='".HelperImage::resizePNG($this->data['medias'][$i]['imagepath'], 100, 100)."' >";
				
			}
			if(count($sitemap)==0)
			{
				$mediaid = $this->data['medias'][$i]['mediaid'];
				$sitemapid = str_replace($this->user->getSiteId(),"",$mediaid);
				$sitemap = $this->model_core_sitemap->getItem($sitemapid,$this->user->getSiteId());
				
				$this->data['medias'][$i]['link_edit'] = $this->url->http($sitemap['moduleid'].'&sitemapid='.$sitemapid);
				$this->data['medias'][$i]['text_edit'] = "Edit";
			}
			else
			{
				$this->data['medias'][$i]['link_edit'] = $this->url->http($sitemap['moduleid'].'&mediaid='.$this->data['medias'][$i]['mediaid']);
				$this->data['medias'][$i]['text_edit'] = "Edit";	
			}
			$this->data['medias'][$i]['type'] = $sitemap['moduleid'];
			$this->data['medias'][$i]['typename'] = $this->model_core_sitemap->getModuleName($sitemap['moduleid']);
			
			
			if($sitemap['moduleid']!="")
			{
				$listsitemapname = array();
				foreach($arr as $item)
				{
					$sitemap = $this->model_core_sitemap->getItem($item,$this->user->getSiteId());
					$listsitemapname[] = $sitemap['sitemapname'];
				}
				$this->data['medias'][$i]['sitemapnames'] = implode(",",$listsitemapname);
			}
			
			$this->data['medias'][$i]['btnMap'] = '<input type="button" class="button" value="Chọn danh mục" onclick="selectSiteMap(\''.$this->data['medias'][$i]['mediaid'].'\',\''.$sitemap['moduleid'].'\')">';
			
		}
		$this->data['refres']=$_SERVER['QUERY_STRING'];
		$this->id='content';
		$this->template="core/media_table.tpl";
		
		
		$this->render();
	}
	
	public function delete()
	{
		$arr=$this->request->post['delete'];
		if(count($arr))
		{
			
			
			foreach($arr as $key=>$val)
			{
				$this->model_core_media->delete($val);
				
			}
			$this->data['output'] = "Xóa thành công";
		}
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
	}
	
	public function mapmoduleform()
	{
		$this->data['mediaid'] = $this->request->get['mediaid'];	
		$this->data['moduleid'] = $this->request->get['moduleid'];
		$media = $this->model_core_media->getitem($this->data['mediaid']);
		$this->data['listsitemapid'] = $this->string->referSiteMapToArray($media['refersitemap']);
		
		$this->data['modules'] = array(
							'module/news'=>'News',
							'module/banner'=>'Banner',
							'module/album'=>'Album',
							'module/video'=>'Video',
							'module/product'=>'Product',
							'module/download'=>'Download',
							'module/link'=>'Web URL',
							'module/traning'=>'Traning',
							'module/question'=>'Questions'
							
									);
		
		$this->id='content';
		$this->template="core/media_map.tpl";
		$this->render();
	}
	
	public function getListSiteMap()
	{
		$module = $this->request->get['module'];
		
		$datas = $this->model_core_sitemap->getListByModule($module,$this->user->getSiteId());
		
		$this->data['output'] = json_encode(array('sitemaps' => $datas));
		$this->id="sitemap";
		$this->template="common/output.tpl";
		$this->render();
	}
	
	public function savemap()
	{
		
		$data = $this->request->post;
		
		$mediaid = $data['mediaid'];
		$listsitemapid = $data['sitemaplist'];
		
		if(count($listsitemapid))
		{
			$refersitemap = $this->string->arrayToString($listsitemapid);	
			$this->model_core_media->updateCol($mediaid,'refersitemap',$refersitemap);
		}
		
		$this->data['output'] = 'true';
		$this->id="sitemap";
		$this->template="common/output.tpl";
		$this->render();	
	}
	
	//Cac ham xu ly tren form
	public function getMedia()
	{
		$col = $this->request->get['col'];
		$val = $this->request->get['val'];
		$operator = $this->request->get['operator'];
		if($operator == "")
			$operator = "equal";
		
		$where = "";
		switch($operator)
		{
			case "equal":
				$where = " AND ".$col." = '".$val."'";
				break;
			case "like":
				$where = " AND ".$col." like '%".$val."%'";
				break;
			case "other":
				$where = " AND ".$col." <> '".$val."'";
				break;
			case "in":
				$where = " AND ".$col." in  (".$val.")";
				break;
			
		}
			
			
		$datas = $this->model_core_media->getList($where);
		foreach($datas as $key => $media)
		{
			$imagepreview = "<img width=100 src='".HelperImage::resizePNG($media['imagepath'], 180, 180)."' >";
			$datas[$key]['imagepreview'] = $imagepreview;
		}
		$this->data['output'] = json_encode(array('medias' => $datas));
		$this->id="media";
		$this->template="common/output.tpl";
		$this->render();
	}
	public function getListDonVi()
	{
		$mediaid = $this->request->get['mediaid'];
		$media = $this->model_core_media->getItem($mediaid);
		$data_donvi = $this->model_quanlykho_donvitinh->getDonViQuyDoi($media['unit']);
		$this->data['output'] = json_encode($data_donvi);
		
		$this->id="donvi";
		$this->template="common/output.tpl";
		$this->render();
	}
}
?>