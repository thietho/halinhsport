<?php
class ControllerThongkeTonkho extends Controller
{
	private $error = array();
	function __construct() 
	{
		$this->load->model("core/module");
		$moduleid = $_GET['route'];
		$this->document->title = $this->model_core_module->getBreadcrumbs($moduleid);
		if($this->user->checkPermission($moduleid)==false)
		{
			$this->response->redirect('?route=page/home');
		}
		$this->load->model("quanlykho/donvitinh");
	}
	public function index()
	{
		$this->thongke();
		$this->id='content';
		$this->template="thongke/tonkho.tpl";
		$this->layout="layout/center";
		$this->render();
	}
	public function thongke()
	{
		$this->load->model("core/sitemap");
		$this->load->model("core/media");
		$this->load->model("quanlykho/phieunhapxuat");
		
		$where = " AND mediatype = 'module/product' ";
		$this->data['medias'] = $this->model_core_media->getList($where);
		foreach($this->data['medias'] as $i => $media)
		{
			$this->data['medias'][$i]['tonkho'] = $this->model_core_media->getTonKho($media['mediaid']);
			$this->data['medias'][$i]['priceimport'] = $this->model_quanlykho_phieunhapxuat->getAgvPrice($media['mediaid'],'NK');
		}
		
	}
	
}
?>