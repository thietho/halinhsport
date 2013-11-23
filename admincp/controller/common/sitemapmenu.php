<?php
class ControllerCommonSitemapmenu extends Controller
{
	function index()
	{	
		$this->load->model("core/sitemap");
		$this->load->model("core/file");
		$this->load->model("core/module");	
		
		$this->data = array_merge($this->data, $this->language->getData());
		
		$this->data['safemode'] = $this->session->data['safemode'];
		
		$this->data['menu'] = $this->getMenu("");
		$this->data['addon'] = $this->getAddOnMenu("");
		//$this->data['addonmodule'] = $this->model_core_sitemap->getModuleAddons();
		$this->data['addonmodule'] = array(
										"core/category" => $this->data['category'],
										"core/media" => $this->data['menu_media'],
										"core/file" => $this->data['menu_file'],
								 		"core/sitemap" => $this->data['menu_sitemap'],
										"addon/order" => "Order management <span id='orderwarring'></span>",
								 		"core/member" => "Member management",
										"core/message" => $this->data['message'],
										"core/user" => $this->data['user_management'],
									);
		$this->id='sitemapmenu';
		$this->template='common/sitemapmenu.tpl';
		$this->render();
	}
	
	public function getMenu($parentid)
	{
		$siteid = $this->user->getSiteId();
		$str = "";
		
		$sitemaps = $this->model_core_sitemap->getListByParent($parentid, $siteid, "Active");
		
		foreach($sitemaps as $item)
		{
			$childs = $this->model_core_sitemap->getListByParent($item['sitemapid'], $siteid, "Active");
			
			$link = "<a class='left'>".$item['sitemapname']."</a>";
			
			
			switch($item['moduleid'])
			{
				case 'module/information':
				case 'module/contact':
				
					$link='<a class="left sitebar" href="?route='.$item['moduleid']."&sitemapid=".$item['sitemapid'].'" ref="?route='.$item['moduleid']."&sitemapid=".$item['sitemapid'].'" title="[Detail]">'.$item['sitemapname'].'</a>';
					break;
				case 'module/product':
				case 'module/news':
				case 'module/gallery':
					$link='<a class="left" href="?route='.$item['moduleid']."&sitemapid=".$item['sitemapid'].'">'.$item['sitemapname'].'</a>';
					break;
			}
			
			if($item['moduleid'] != "group" && $item['moduleid'] != "homepage")
			{
				
			}
			
			
			
			$str .= "<li>";
			$str .= "<div class='collape'>";
			$str .= $link;
			
			if(count($childs) > 0)
			{
				$str .= "<span class='collape right'>[+]</span>";
				$str .= '<div class="clearer">&nbsp;</div>';
				$str .= "</div>";
				
				$str .= "<ul>";
				$str .= $this->getMenu($item['sitemapid']);
				$str .= "</ul>";
			}
			else
			{
				$str .= '<div class="clearer">^&nbsp;</div>';
				$str .= "</div>";
				
			}
			$str .= "</li>";
		}
		
		return $str;
		
	}
	
	public function getAddOnMenu($parentid)
	{
		$siteid = $this->user->getSiteId();
		$str = "";
		
		$sitemaps = $this->model_core_sitemap->getListByParent($parentid, $siteid, "Addon");
		
		foreach($sitemaps as $item)
		{
			$childs = $this->model_core_sitemap->getListByParent($item['sitemapid'], $siteid, "Addon");
			
			$link = "<a>".$item['sitemapname']."</a>";
			
			if(substr($item['moduleid'],0,6) == "group/")
			{
				$item['moduleid'] = "module/information";
			}
			
			
			if($item['moduleid'] != "group" && $item['moduleid'] != "homepage")
			{
				$link='<a href="?route='.$item['moduleid']."&sitemapid=".$item['sitemapid'].'" title="[Detail]">'.$item['sitemapname'].'</a>';
			}
			
			$str .= "<li>";
			$str .= "<div class='collape'>";
			$str .= $link;
			
			if(count($childs) > 0)
			{
				$str .= "<span class='collape right'>[+]</span>";
				$str .= '<div class="clearer">&nbsp;</div>';
				$str .= "</div>";
				
				$str .= "<ul>";
				$str .= $this->getAddOnMenu($item['sitemapid']);
				$str .= "</ul>";
			}
			else
			{
				$str .= '<div class="clearer">^&nbsp;</div>';
				$str .= "</div>";
				
			}
			$str .= "</li>";
		}
		
		return $str;
		
	}
	

}
?>