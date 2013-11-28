<?php
class ControllerCorePostcontent extends Controller
{
	private $error = array();
	function __construct() 
	{
	 	$this->load->model("core/user");
		$this->load->model("core/media");
		$this->load->model("core/sitemap");
		$this->load->model("core/file");
		$this->load->model("core/category");
		$this->load->helper('image');
		
		$this->load->model("quanlykho/donvitinh");
		$this->data['donvitinh'] = $this->model_quanlykho_donvitinh->getList();
   	}
	
	function index()
	{	
		if (!$this->user->isLogged()) {
			$this->redirect($this->url->https('page/index'));
		}
		
		$this->getForm();
		
		$this->id='post';
		$this->template='core/post_form.tpl';
		$this->render();
	}
	
	private function getForm()
	{
		$this->load->model("core/media");
		$mediaid = $this->request->get['mediaid'];
		
		$route = $this->getRoute();
		$sitemapid = $this->request->get['sitemapid'];
		$goback = $this->request->get['goback'];
		$siteid = $this->user->getSiteId();

		$this->load->language($route);
		
		$this->data = array_merge($this->data, $this->language->getData());
		
		$sitemap = $this->model_core_sitemap->getItem($sitemapid, $siteid);	
		
		$this->data['color'] = array();
		$this->model_core_category->getTree("color",$this->data['color']);
		unset($this->data['color'][0]);
		
		$this->data['size'] = array();
		$this->model_core_category->getTree("size",$this->data['size']);
		unset($this->data['size'][0]);
		
		$this->data['nhomhuong'] = array();
		$this->model_core_category->getTree("nhomhuong",$this->data['nhomhuong']);
		unset($this->data['nhomhuong'][0]);
		
		$this->data['nhanhieu'] = array();
		$this->model_core_category->getTree("nhanhieu",$this->data['nhanhieu']);
		unset($this->data['nhanhieu'][0]);
		
		$this->data['statuspro'] = array();
		$this->model_core_category->getTree("status",$this->data['statuspro']);
		unset($this->data['statuspro'][0]);
		
		$this->data['post'] =array();
		$this->data['post']['mediatype'] = "content";
		
		switch($route)
		{
			
			case "module/information":
			
				
				//$this->data['post'] = $this->model_core_media->getInformationMedia($sitemapid, "content");
				$this->data['post']['mediaid'] = $this->user->getSiteId().$sitemapid;
				
				
				$this->data['post']=$this->model_core_media->initialization($this->data['post']['mediaid'],$this->data['post']['mediatype']);
				$this->data['post'] = $this->model_core_media->getItem($this->data['post']['mediaid']);
				$this->data['post']['mediatype'] = "information";
				if($this->data['post']['title'] == '' && $route='module/information')
				{
					$this->data['post']['mediaid'] = $this->user->getSiteId().$sitemapid;
					$this->data['post']['title'] = $sitemap['sitemapname'];
					
				}
				break;
			case "module/register":
				//$this->data['post'] = $this->model_core_media->getInformationMedia($sitemapid, "content");
				$this->data['post']['mediaid'] = $this->user->getSiteId().$sitemapid;
				
				
				$this->data['post']=$this->model_core_media->initialization($this->data['post']['mediaid'],$this->data['post']['mediatype']);
				$this->data['post'] = $this->model_core_media->getItem($this->data['post']['mediaid']);
				
				$this->data['post']['mediatype'] = "register";
				
				if($this->data['post']['title'] == '' && $route='module/register')
				{
					$this->data['post']['mediaid'] = $this->user->getSiteId().$sitemapid;
					$this->data['post']['title'] = $sitemap['sitemapname'];
				}
				break;
			case "module/contact":
			
				//$this->data['post'] = $this->model_core_media->getInformationMedia($sitemapid, "content");
				$this->data['post']['mediaid'] = $this->user->getSiteId().$sitemapid;
				
				$this->data['post'] = $this->model_core_media->initialization($this->data['post']['mediaid'],$this->data['post']['mediatype']);
				$this->data['post'] = $this->model_core_media->getItem($this->data['post']['mediaid']);
				$this->data['post']['mediatype'] = "contact";
				if($this->data['post']['title'] == '' && $route='module/contact')
				{
					$this->data['post']['mediaid'] = $this->user->getSiteId().$sitemapid;
					$this->data['post']['title'] = $sitemap['sitemapname'];
				}
				
				$this->data['post']['email1'] = $this->model_core_media->getInformation($this->data['post']['mediaid'], "email1");
				$this->data['post']['email2'] = $this->model_core_media->getInformation($this->data['post']['mediaid'], "email2");
				$this->data['post']['email3'] = $this->model_core_media->getInformation($this->data['post']['mediaid'], "email3");
				break;
			
			default:
				$this->data['post'] = $this->model_core_media->getItem($mediaid);
				$this->data['properties'] = $this->string->referSiteMapToArray($this->data['post']['groupkeys']);
				//print_r($this->data['properties']);
				$this->data['post']['mediatype'] = $route;
				if($mediaid == "")
				{
					//$this->data['post']['mediaid'] = $this->model_core_media->insert($data);
					$this->data['post']['mediaparent'] = $this->request->get['mediaparent'];
					if($this->data['post']['mediaparent'])
					{
						$mediaparent = $this->model_core_media->getItem($this->data['post']['mediaparent']);
						$this->data['post']['title'] = $mediaparent['title'];
						$this->data['post']['summary'] = $mediaparent['summary'];
						$this->data['post']['description'] = $mediaparent['description'];
						$this->data['post']['keyword'] = $mediaparent['keyword'];
						$this->data['post']['unit'] = $mediaparent['unit'];
						$this->data['post']['sizes'] = $mediaparent['sizes'];
						$this->data['post']['imageid'] = $mediaparent['imageid'];
						$this->data['post']['imagepath'] = $mediaparent['imagepath'];
						$this->data['post']['groupkeys'] = $mediaparent['groupkeys'];
					}
				}
				
		}
		
		
		//Thiet ke form	
		$this->data['displaynews'] = "";
		//$this->data['heading_title'] = "Post News Page";
		$this->data['DIR_UPLOADPHOTO'] = HTTP_SERVER."index.php?route=common/uploadpreview";
		$this->data['DIR_UPLOADATTACHMENT'] = HTTP_SERVER."index.php?route=common/uploadattachment";
		$this->data['hasId'] = false;
		$this->data['hasTitle'] = true;
		$this->data['hasSummary'] = true;
		$this->data['hasSource'] = true;
		$this->data['hasFile'] = true;
		$this->data['hasAttachment'] = true;
		$this->data['hasEmail'] = false;
		$this->data['hasTabMap'] = true;
		$this->data['hasTabComment'] = false;
		
		//Define product
		$this->data['hasCode'] = false;
		$this->data['hasPrice'] = false;
		$this->data['hasSubInfor'] = false;
		//Video
		$this->data['hasVideo'] = false;
		$this->data['DIR_CANCEL'] = HTTP_SERVER."?route=".$route."&sitemapid=".$sitemapid;
		//Gallery
		$this->data['hasTabImages'] = false;
		$this->data['hasTabVideos'] = false;
		$this->data['hasTabDocuments'] = false;
		//Event
		$this->data['hasEvent'] = false;
		if($route == "module/event")
		{
			$this->data['hasEvent'] = true;
			$this->data['hasSource'] = false;
		}
		
		if($route == "module/download")
		{
			$this->data['hasSource'] = false;
		}
		
		
		
		if($route == "module/product")
		{
			$this->data['hasId'] = true;
			$this->data['hasCode'] = true;
			$this->data['hasProperties'] = true;
			$this->data['hasPrice'] = true;
			$this->data['hasSubInfor'] = false;
			$this->data['hasProductPrice'] = true;
			$this->data['hasSource'] = false;
			$this->data['hasTabComment'] = true;
		}
		if($route == "module/video")
		{
			$this->data['hasVideo'] = true;
		}
		if($route == "module/audio")
		{
			$this->data['hasAudio'] = true;
		}
		if($route == "module/banner")
		{
			$this->data['hasSource'] = false;
		}
		if($route == "module/gallery")
		{
			$this->data['hasSource'] = false;
			$this->data['hasAttachment'] = false;
			$this->data['hasVideo'] = false;
			$this->data['hasTabImages'] = true;
			$this->data['hasTabVideos'] = true;
			$this->data['hasTabDocuments'] = true;
		}
		/*if($mediaid == "")
		{
			$this->data['hasSubInfor'] = false;
		}*/
		if($route == "module/information")
		{
			
			//$this->data['displaynews'] = "display:none";
			$this->data['heading_title'] = $sitemap['sitemapname'];
			$this->data['hasTabMap'] = false;
			$this->data['hasTitle'] = true;
			
			$this->data['hasFile'] = true;
			$this->data['hasSource'] = false;
			$this->data['hasSubInfor'] = false;
			//$this->data['post']['title'] = $sitemap['sitemapname'];
			$this->data['DIR_CANCEL'] = HTTP_SERVER."?route=core/content";
			if($goback!="")
			{
				
				$this->data['DIR_CANCEL'] = HTTP_SERVER."?route=".$goback."&sitemapid=".$sitemapid;
			}
			
		}
		if($route == "module/register")
		{
			$this->data['heading_title'] = $sitemap['sitemapname'];
			$this->data['hasTabMap'] = false;
			$this->data['hasTitle'] = true;
			
			$this->data['hasFile'] = true;
			$this->data['hasSource'] = false;
			$this->data['hasSubInfor'] = false;
		}
		elseif($route == "module/contact")
		{
			$this->data['heading_title'] = $sitemap['sitemapname'];
			$this->data['hasTabMap'] = false;
			$this->data['hasTitle'] = true;
			$this->data['hasSummary'] = false;
			$this->data['hasFile'] = false;
			$this->data['hasSource'] = false;
			$this->data['hasSubInfor'] = false;
			//$this->data['post']['title'] = $sitemap['sitemapname'];
			$this->data['DIR_CANCEL'] = HTTP_SERVER."?route=core/content";
			$this->data['hasEmail'] = true;
		}
		
		
	
		
		
		//Lay Breadcrumb
		$this->data['breadcrumb'] = $this->model_core_sitemap->getBreadcrumb($sitemapid, $siteid, -1);
		
		
		//get Form
		if($this->data['post']['imagepath'] != "")
		{
			$this->data['imagethumbnail'] = HelperImage::resizePNG($this->data['post']['imagepath'], 200, 200);
		}
		
		
		$listfile = $this->model_core_media->getInformation($mediaid, "attachment");
		$listfileid=array();
		if($listfile)
			$listfileid=split(",",$listfile);
		$this->data['attachment']=array();
		foreach($listfileid as $key => $item)
		{
			$this->data['attachment'][$key] = $this->model_core_file->getFile($item);
			$this->data['attachment'][$key]['imagethumbnail'] = HelperImage::resizePNG($this->data['attachment'][$key]['filepath'], 50, 50);
			if(!$this->string->isImage($this->data['attachment'][$key]['extension']))
				$this->data['attachment'][$key]['imagethumbnail'] = DIR_IMAGE."icon/dinhkem.png";
		}
		$this->data['status'] = $this->data['post']['status'];
		if($this->data['status'] == "")
		{
			$this->data['status'] = "Active";
		}
		
		if($this->data['post']['refersitemap'] == "")
		{
			$this->data['post']['refersitemap'] .= "[".$sitemapid."]";
		}
		$this->data['arrrefersitemap'] = $this->string->referSiteMapToArray($this->data['post']['refersitemap']);
		
		$this->data['listReferSiteMap'] = $this->showTreeSiteMap('');
		
		if($route=="module/contact")
		{
			$this->data['email1'] = $this->data['post']['email1'];
			$this->data['email2'] = $this->data['post']['email2'];
			$this->data['email3'] = $this->data['post']['email3'];
		}
	}
	
	private function validate($data)
	{
		if($data['mediaid']!="")
		{
			if($this->validation->_isId(trim($data['mediaid'])) == false)
			{
				$this->error['mediaid'] ="ID không hợp lệ";	
			}
			if($data['id']=="")
			{
				$media = $this->model_core_media->getItem($data['mediaid']);
				if(count($media))
					$this->error['mediaid'] ="ID đã được sử dụng";	
			}
		}
		
		
		if (count($this->error)==0) {
	  		return TRUE;
		} else {
	  		return FALSE;
		}
	}
	
	public function savepost()
	{
		
		$this->load->model("core/media");
		$this->load->model("core/sitemap");
		$route = $this->getRoute();
		$this->data['post'] = $this->request->post;
		if($this->validate($this->data['post']))
		{
			$sitemapid = $this->request->get['sitemapid'];
			$mediaid = $this->request->get['mediaid'];
			$siteid = $this->user->getSiteId();
				
			$sitemapid = $this->request->get['sitemapid'];
			
			$data = $this->data['post'];
			
			
			$data['userid'] = $this->user->getId();
			//$data['saleprice'] = "";
			if(count($data['saleprice']))
			{
				foreach($data['saleprice'] as $key => $val)
				{
					$data['saleprice'][$key] = $this->string->toNumber($val);
				}
				$data['saleprice'] = json_encode($data['saleprice']);
			}
			
			
			if($data['price'] == "")
				$data['price'] = $this->data['post']['mainprice'];
			
			$data['groupkeys'] = $this->getProperties($this->data['post']);
			
			
			//$data['refersitemap'] = $this->model_core_media->getReferSitemapString($sitemapid,$data['refersitemap']);
			
			$list = $this->model_core_sitemap->getListByModule("module/news",$this->user->getSiteId());
			
			
			/*foreach($list as $item)
			{
				$data['refersitemap'] =  $this->model_core_media->getReferSitemapString($item['sitemapid'], $data['refersitemap'], "delete");
			}*/
			
			$data['refersitemap'] = "";
			if($this->request->post['listrefersitemap'])
			{
				foreach ($this->request->post['listrefersitemap'] as $refersiteid) {
					$data['refersitemap'] .= "[".$refersiteid."]";
				}
			}
			
			
			$this->model_core_media->save($data);
			
			
			$listAttachment=$this->data['post']['attimageid'];
			$this->model_core_media->saveAttachment($data['mediaid'],$listAttachment);
			/*$listdelfile=$this->data['post']['delfile'];
			if(count($listdelfile))
				foreach($listdelfile as $item)
					$this->model_core_file->deleteFile($item);
			$this->model_core_media->clearTempFile();*/
			/*if($route=="module/contact")
			{
				$this->model_core_media->saveInformation($data['mediaid'], "email1", $this->data['post']['email1']);
				$this->model_core_media->saveInformation($data['mediaid'], "email2", $this->data['post']['email2']);
				$this->model_core_media->saveInformation($data['mediaid'], "email3", $this->data['post']['email3']);
			}*/
			$this->data['output'] = "true";
		}
		else
		{
			foreach($this->error as $item)
			{
				$this->data['output'] .= $item."<br>";
			}
		}
		
		
		$this->template="common/output.tpl";
		$this->render();
	}
	
	private function getProperties($data)
	{
		$arr = $data['loaisp'];
		
		$groupkeys = $this->string->arrayToString($arr);
		return $groupkeys;	
	}
	
	public function updatePos()
	{
		$this->load->model("core/media");
		$data = $this->request->post;
		$this->model_core_media->updatePos($data);
		$this->data['output'] = "true";
		$this->template="common/output.tpl";
		$this->render();
	}
	private function showTreeSiteMap($parentid)
	{
		$siteid = $this->user->getSiteId();
		$str = "";
		
		$route = $this->getRoute();
		$sitemaps = $this->model_core_sitemap->getListByParent($parentid, $siteid);
		
		foreach($sitemaps as $item)
		{
			//if($item['moduleid'] == $route)
			{
				$childs = $this->model_core_sitemap->getListByParent($item['sitemapid'], $siteid);
				if($item['moduleid'] == $route)
					$link = '<input id="refersitemap-'.$item['sitemapid'].'" name="listrefersitemap['.$item['sitemapid'].']" type="checkbox" value="'.$item['sitemapid'].'" />'.$item['sitemapname'];
				else
					$link = $item['sitemapname'];
				$str .= "<li>";
				
				$str .= $link;
				
				if(count($childs) > 0)
				{
					
					
					
					$str .= "<ul>";
					$str .= $this->showTreeSiteMap($item['sitemapid']);
					$str .= "</ul>";
				}
				else
				{
					
					
					
				}
				$str .= "</li>";
				
			}
		}
		
		return $str;
	}
	private function getListSiteMapCheckBox($media)
	{
		$strReferSitemap = $media['refersitemap'];
		$route = $this->getRoute();
		$list = $this->model_core_sitemap->getListByModule($route,$this->user->getSiteId());
		$html = "";
		foreach($list as $item)
		{
			$html .= '<tr>';
			$html .= '<td>';
			
			$sitemapid = "[".$item['sitemapid']."]";
			
			$pos = strrpos($strReferSitemap, $sitemapid);
			if ($pos === false) {
				$checked = "";
			}else{
				$checked = "checked=checked";
			}
			$html .= '<label><input name="listrefersitemap['.$item['sitemapid'].']" type="checkbox" value="'.$item['sitemapid'].'" '.$checked.'/> '.$item['sitemapname'].'</label>';
			$path = $this->model_core_sitemap->getBreadcrumb($item['sitemapid'], $this->user->getSiteId());
			$path = strip_tags($path);
			$html .= '</td><td>'.$path.'</td> </tr>';
		}
		
		return $html;
	}
	
	public function loadSubInfor()
	{
		$this->load->model("core/media");
		$this->load->helper('image');
		$mediaid = $this->request->get['mediaid'];
		$this->data['child']=$this->model_core_media->getListByParent($mediaid," AND mediatype = 'subinfor' Order by position");
		
		//$this->data['subImage'] = $this->string->array_Filter($this->data['child'],"mediatype","image");
		
		foreach($this->data['child'] as $key => $item)
		{
			$this->data['child'][$key]['imagepreview'] = "<img width=100 src='".HelperImage::resizePNG($item['imagepath'], 180, 180)."' >";
		} 
		$this->id='post';
		$this->template='core/subinfor_list.tpl';	
		$this->render();
	}
	
	public function loadPrice()
	{
		$this->load->model("core/media");
		$this->load->helper('image');
		$mediaid = $this->request->get['mediaid'];
		$this->data['child']=$this->model_core_media->getListByParent($mediaid," AND mediatype = 'price' Order by position");
		
		$this->id='post';
		$this->template='core/price_list.tpl';	
		$this->render();
	}
	
	public function getPriceFrom()
	{
		$this->load->model("core/media");
		$this->load->helper('image');
		$mediaid = $this->request->get['mediaid'];
		$media=$this->model_core_media->getItem($mediaid);
		
		$this->data['media'] = $media;
		
		$this->id='post';
		$this->template="core/post_form_price.tpl";
		$this->render();
	}
	public function getPrice()
	{
		$this->load->model("core/media");
		$this->load->helper('image');
		$mediaid = $this->request->get['mediaid'];
		$media=$this->model_core_media->getItem($mediaid);
		$para = $this->string->referSiteMapToArray($media['summary']);
		foreach($para as $val)
		{
			$ar = split("=",$val);
			$media[$ar[0]] = $ar[1];	
		}
		
		$this->data['output'] = json_encode(array('price' => $media));
		$this->id='post';
		$this->template="common/output.tpl";
		$this->render();
	}
	
	public function getSubInfor()
	{
		$this->load->model("core/media");
		$this->load->helper('image');
		$mediaid = $this->request->get['mediaid'];
		$subImage=$this->model_core_media->getItem($mediaid);
		$subImage['description'] = html_entity_decode($subImage['description']);
		$subImage['imagepreview'] = HelperImage::resizePNG($subImage['imagepath'], 180, 180);
		$this->data['output'] = json_encode(array('subinfor' => $subImage));
		$this->id='post';
		$this->template="common/output.tpl";
		$this->render();
	}
	
	public function removeSubImage()
	{
		$this->load->model("core/media");
		$this->load->helper('image');
		$mediaid = $this->request->get['mediaid'];
		$this->model_core_media->delete($mediaid);
		$this->id='post';
		$this->template="common/output.tpl";
		$this->render();
	}
}
?>