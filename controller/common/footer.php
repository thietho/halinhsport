<?php
class ControllerCommonFooter extends Controller
{
	public function index()
	{
		/*$sitemapid = "hotroonline";
		$siteid = $this->member->getSiteId();
		$this->data['sitemap'] = $this->model_core_sitemap->getItem($sitemapid, $siteid);
		$this->data['media'] = $this->model_core_media->getItem($siteid.$sitemapid);
		$this->data['supportonline'] = html_entity_decode($this->data['media']['description']);*/
		$arr=array("thong-tin-footer");
		$this->data['footer'] = $this->loadModule('module/information','index',$arr);
		$arr = array("sododuongdi");	
		$this->data['sododuongdi1'] = $this->loadModule('module/location','loadLocation',$arr);
		
		$arr = array("vi-tri-cua-hang-2");	
		$this->data['sododuongdi2'] = $this->loadModule('module/location','loadLocation',$arr);
		$this->id="footer";
		$this->template="common/footer.tpl";
		$this->render();
	}
}
?>