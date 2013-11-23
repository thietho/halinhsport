<?php
class ControllerThongkeBanhang extends Controller
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
		
		$this->id='content';
		$this->template="thongke/banhang.tpl";
		$this->layout="layout/center";
		$this->render();
	}
	public function thongke()
	{
		$this->load->model("quanlykho/phieunhapxuat");
		$data = $this->request->post;
		$tungay = $this->date->formatViewDate($data['tungay']);
		$denngay = $this->date->formatViewDate($data['denngay']);
		$where = " AND loaiphieu = 'PBH'";
		if($tungay != "")
		{
			$where .= " AND ngaylap >= '".$tungay."'";
		}
		if($denngay != "")
		{
			$where .= " AND ngaylap < '".$denngay." 24:00:00'";
		}
		$data_banhang = $this->model_quanlykho_phieunhapxuat->thongke($where ." Order by ngaylap");
		if(count($data_banhang))
		{
			$arrdate = array();
			foreach($data_banhang as $i => $item)
			{
				$data_banhang[$i]['date'] = $this->date->getDate($item['ngaylap']);
				$data_banhang[$i]['time'] = $this->date->getTime($item['ngaylap']);
				if(!in_array($data_banhang[$i]['date'],$arrdate))
					$arrdate[]=$data_banhang[$i]['date'];
			}
			$this->data['data_banhang'] = array();
			foreach($arrdate as $date)
			{
				$this->data['data_banhang'][$date] = array();
				foreach($data_banhang as $item)
				{
					if($item['date']==$date)
					{
						$this->data['data_banhang'][$date][] = $item;
					}
				}
			}
			
			$this->id='content';
			$this->template="thongke/banhang_thongke.tpl";
			
			$this->render();
		}
		else
		{
			$this->data['output'] = "Không có dữ liệu phù hợp";
			$this->id='content';
			$this->template="common/output.tpl";
			$this->render();
		}
	}
	
}
?>