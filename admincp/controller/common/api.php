<?php
class ControllerCommonApi extends Controller
{
	public function getAlias()
	{
		$title = urldecode($this->request->get['title']);
		//$title = strtolower($title);
		$alias = $this->string->chuyenvekodau(trim($title));
		//$alias = $this->string->removeKtdatbiet(htmlspecialchars_decode( $alias));
		$alias = strtolower(str_replace(" ",'-',$alias));
		$this->load->model('core/media');
		$media = $this->model_core_media->getByAlias($alias);
		$index = 0;
		//print_r($media);
		while(count($media)>0)
		{
			$index++;
			$temp = $alias.'-'.$index;
			$media = $this->model_core_media->getByAlias($temp);
		}	
		if($index)
			$this->data['output'] = $alias.'-'.$index;
		else
			$this->data['output'] = $alias;
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
	
	public function getAliasSiteMap()
	{
		$title = urldecode($this->request->get['title']);
		//$title = strtolower($title);
		$alias = $this->string->chuyenvekodau(trim($title));
		//$alias = $this->string->removeKtdatbiet(htmlspecialchars_decode( $alias));
		$alias = strtolower(str_replace(" ",'-',$alias));
		$this->load->model('core/sitemap');
		$where = " AND sitemapid = '".$alias."'";
		$data_sitemap = $this->model_core_sitemap->getList($this->user->getSiteId(),$where);
		$index = 0;
		//print_r($media);
		while(count($data_sitemap)>0)
		{
			$index++;
			$temp = $alias.'-'.$index;
			$where = " AND sitemapid = '".$temp."'";
			$data_sitemap = $this->model_core_sitemap->getList($this->user->getSiteId(),$where);
		}	
		if($index)
			$this->data['output'] = $alias.'-'.$index;
		else
			$this->data['output'] = $alias;
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
}
?>