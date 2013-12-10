<?php
class ControllerCommonHeader extends Controller
{
	public function index()
	{
		
		$siteid = $this->member->getSiteId();
		$this->load->model("core/media");
		$this->load->model("core/sitemap");
		
		
		$this->id="header";
		$this->template="common/header.tpl";
		$this->data['mainmenu'] = $this->getMenu("menu-chinh");
		$this->render();
	}
	
	public function showMenu($parentid)
	{
		$str = $this->getMenu($parentid);
		$this->data['output'] = $str;
		$this->id="header";
		$this->template="common/output.tpl";
		
		$this->render();
	}
	
	public function getMenu($parentid)
	{
		$this->load->model("core/sitemap");
		//echo $parentid;
		$siteid = $this->member->getSiteId();
		
		$rootid = $this->model_core_sitemap->getRoot($this->document->sitemapid, $siteid);

		if($this->document->sitemapid == "")
			$rootid = 'trangchu';
		$str = "";
		
		
		$sitemaps = $this->model_core_sitemap->getListByParent($parentid, $siteid);
		
		foreach($sitemaps as $item)
		{
			$childs = $this->model_core_sitemap->getListByParent($item['sitemapid'], $siteid);
			
			$currenttab = "";
			if($item['sitemapid'] == $rootid) 
				$currenttab = "class='current-tab'";
			
			$link = "<a ".$currenttab.">".$item['sitemapname']."</a>";
			switch($item['moduleid'])
			{
				case "group":
					$link = "<a ".$currenttab." title='".$item['sitemapname']."'>".html_entity_decode($item['sitemapname'])."</a>";
					break;	
				case "homepage":
					$link = "<a ".$currenttab." href='".HTTP_SERVER."'>".html_entity_decode($item['sitemapname'])."</a>";
					break;
				case "module/forward":
				default:
					$link = "<a ".$currenttab." href='".$item['forward']."' title='".$item['sitemapname']."'>".html_entity_decode($item['sitemapname'])."</a>";
					break;	
			}
			
			
			
			$str .= "<li>";
			$str .= $link;
			
			if(count($childs) > 0)
			{
				$str .= "<ul>";
				$str .= $this->getMenu($item['sitemapid']);
				$str .= "</ul>";
			}

			$str .= "</li>";
		}
		
		return $str;
		
	}
}
?>