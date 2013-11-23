<?php
final class Document {
	public $title;
	public $description;
	public $base;	
	public $charset = 'utf-8';		
	public $language = 'vi';	
	public $direction = 'ltr';		
	public $links = array();		
	public $styles = array();
	public $scripts = array();
	public $breadcrumbs;
	public $sitemapid = '';
	public $media = array();
	public $meta_description = '';
	public $meta_keyword = '';
	public $meta_image = '';
	public $sitebar =array();
	public $text = array();
	public $setting = array();
	public $setup = array();
	public $status = array(
						   'new' => "Đơn hàng mới",
						   'wait' => "Đang xử lý",
						   'pending' => "Xát với khách hàng không được",
						   'confirmed' => "Đã xát nhận",
						   'completed' => "Hoàn thành",
						   'cancel' => "Hủy đơn hàng"
						   );
	public $status_media = array(
						   'active' => "Hiện",
						   'hide' => "Ẩn"
						   
						   );
	public $paymenttype = array(
							'cash'=>'Tiền mặt',
							'bank' =>'Chuyển khoản'
							);
	public $gioitinh = array(
							'male' => "Nam",
							'female' => "Nữ"
							);
	public $status_comment = array(
						   'new' => "Chưa duyệt",
						   'published' => "Duyệt",
						   'denial' => "Không duyệt"
						   );
	public $userstatus = array(
							'active' => "Đang kích hoạt",
							'lock' => "Đã bị khóa"
							);
	public $tiente = array(
						"VND" => "VNĐ",
						"USD" => "USD"
						);
	public $tientechu = array(
						"VND" => "đồng",
						"USD" => "usd"
						);
	public $mediatypes = array(
						'module/product'=>'Product',
						'module/news'=>'News'
						);
	public function toVND($value,$donvi)
	{
		if($donvi == "VND")
			return $value;
		else
		{
			
			return $value * $this->toNumber($this->setup['Exchange']); 	
		}
			
	}
	private $filepath;
	public function __construct() 
	{
		$this->db = Registry::get('db');
		$this->language = Registry::get('language');
		$this->text = $this->language->getData();
		$this->meta_image = HTTP_IMAGE."default/default.png";
		$this->filepath = DIR_FILE."db/setting.json";
		$this->createDB();
		$this->getData();
		$this->loadSetting();
		$this->title = $this->setup['Title'];
	}
	
	private function loadSetting()
	{
		$sql = "Select `media_information`.* 
									from `media_information` Where mediaid = 'setting'";
		$query = $this->db->query($sql);
		foreach($query->rows as $item)
		{
			$this->setup[$item['fieldname']] = $item['fieldvalue'];
		}
		
	}
	
	private function createDB()
	{
		$arr = array();
		if(!is_dir(DIR_FILE."db"))
			mkdir(DIR_FILE."db");
		
		if(!is_file($this->filepath))
		{
			
			$fp = fopen($this->filepath, 'w');
			fwrite($fp, '');
			fclose($fp);	
		}
	}
	
	private function getData()
	{
		$filename = $this->filepath;
		$handle = fopen($filename, "r");
		@$contents = fread($handle, filesize($filename));
		fclose($handle);
		$this->setting = json_decode($contents);
		
	}
	
	public function setValue($key,$value)
	{
		$this->setting->$key = $value;
		$this->saveData();
	}
	
	private function saveData()
	{
		$str = json_encode($this->setting);
		$fp = fopen($this->filepath, 'w');
		fwrite($fp, $str);
		fclose($fp);
	}
	
	public function getSiteMap($sitemapid,$siteid,$name="sitemapname")
	{
		$query = $this->db->query("Select `sitemap`.* 
									from `sitemap` 
									where sitemapid ='".$sitemapid."' AND siteid = '".$siteid."'");
		return $query->row[$name];	
	}
	
	public function getCategory($categoryid,$name="categoryname")
	{
		$query = $this->db->query("Select `category`.* 
									from `category` 
									where categoryid ='".$categoryid."' ");
		return $query->row[$name];	
	}
	
	public function getMedia($mediaid,$name="title")
	{
		$query = $this->db->query("Select `media`.* 
									from `media` 
									where mediaid ='".$mediaid."' ");
		return $query->row[$name];	
	}
	public function getNhanVien($id,$name = 'hoten')
	{
		$sql = "Select `qlknhanvien`.* 
									from `qlknhanvien` 
									where id ='".$id."' ";
		$query = $this->db->query($sql);
		return $query->row[$name];
	}
	
	
	public function getUserType($usertypeid,$name = 'usertypename')
	{
		$sql = "Select `usertype`.* 
									from `usertype` 
									where usertypeid ='".$usertypeid."' ";
		$query = $this->db->query($sql);
		return $query->row[$name];
	}
	
	public function getUser($userid,$name = 'fullname')
	{
		$sql = "Select `user`.* 
									from `user` 
									where userid ='".$userid."' ";
		$query = $this->db->query($sql);
		return $query->row[$name];
	}
	
	public function getModule($id,$name = 'modulename')
	{
		$query = $this->db->query("Select `module`.* 
									from `module` 
									where id ='".$id."' ");
		return $query->row[$name];	
	}
	public function getModuleId($moduleid,$name = 'modulename')
	{
		$query = $this->db->query("Select `module`.* 
									from `module` 
									where moduleid ='".$moduleid."' ");
		return $query->row[$name];	
	}
	public function getTenDonVi($madonvi)
	{
		$query = $this->db->query("Select `qlkdonvitinh`.* 
									from `qlkdonvitinh` 
									where madonvi ='".$madonvi."' ");
		return $query->row['tendonvitinh'];	
	}
	
	public function getDonViTinh($madonvi,$name="tendonvitinh")
	{
		$query = $this->db->query("Select `qlkdonvitinh`.* 
									from `qlkdonvitinh` 
									where madonvi ='".$madonvi."' ");
		return $query->row[$name];	
	}
	
	public function getNguyenLieu($id,$name = 'tennguyenlieu')
	{
		$sql = "Select `qlknguyenlieu`.* 
									from `qlknguyenlieu` 
									where id ='".$id."' ";
		$query = $this->db->query($sql);
		return $query->row[$name];
	}
	public function getNhaCungCap($id,$name = 'tennhacungcap')
	{
		$sql = "Select `qlknhacungcap`.* 
									from `qlknhacungcap` 
									where id ='".$id."' ";
		$query = $this->db->query($sql);
		return $query->row[$name];
	}
	public function getSanPham($id,$name = 'tensanpham')
	{
		$sql = "Select `qlksanpham`.* 
									from `qlksanpham` 
									where id ='".$id."' ";
		$query = $this->db->query($sql);
		return $query->row[$name];
	}
	
	public function createLink($sitemap="",$id="",$key = "",$val = "")
	{
		$link = HTTP_SERVER;
		if($sitemap)
			$link.= $sitemap;
		if($id)
			$link.= '/'.$id;
		if($key)
			$link.= '/'.$key;
		if($val)
			$link.= '/'.$val;
		return $link.'.html';
	}
	
	public function createLinkShare($sitemap="",$id="",$key = "",$val = "")
	{
		$link = HTTP_SERVER;
		if($sitemap)
			$link.= $sitemap;
		if($id)
			$link.= '/'.$id;
		if($key)
			$link.= '/'.$key;
		if($val)
			$link.= '/'.$val;
		return $link.'_'.time().'.html';
	}
	
	public function getPara()
	{
		$uri = $_SERVER['REQUEST_URI'];
		$arr = split("\?",$uri);
		
		$listpara = split("&",$arr[1]);
		$para = array();
		foreach($listpara as $val)
		{
			$ar = split("=",$val);	
			$para[$ar[0]] = $ar[1];
		}
		return $para;
	}
	public function getURI()
	{
		$uri = $_SERVER['REQUEST_URI'];
		
		
		
		return $uri;
	}
	
}
?>