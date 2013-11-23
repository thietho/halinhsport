<?php
$this->load->model("core/file");
class ModelQuanlykhoNguyenlieu extends ModelCoreFile
{
	public function getItem($id, $where="")
	{
		$sql = "Select `qlknguyenlieu`.*
									from `qlknguyenlieu` 
									where id ='".$id."' ".$where;
		$query = $this->db->query($sql);
		return $query->row;
	}

	public function getList($where="", $from=0, $to=0,$order="")
	{

		$sql = "Select `qlknguyenlieu`.*
									from `qlknguyenlieu` 
									where trangthai <> 'deleted' " . $where;
		if($order=="")
		{
			$order = " Order by tennguyenlieu";
			
		}
		$sql.=$order;
		if($to > 0)
		{
			$sql .= " Limit ".$from.",".$to;
		}
		
		$query = $this->db->query($sql);
		return $query->rows;
	}

	public function insert($data)
	{
		$id= $this->db->escape(@$data['id']);
		$manguyenlieu=$this->db->escape(@$data['manguyenlieu']);
		$tennguyenlieu=$this->db->escape(@$data['tennguyenlieu']);
		$soluongtrenkg= $this->string->toNumber($this->db->escape(@$data['soluongtrenkg']));
		$tontoithieu= $this->string->toNumber($this->db->escape(@$data['tontoithieu']));
		$tontoida=$this->string->toNumber($this->db->escape(@$data['tontoida']));
		$soluongton=$this->string->toNumber($this->db->escape(@$data['soluongton']));
		$soluongmoilandathang=$this->string->toNumber($this->db->escape(@$data['soluongmoilandathang']));
		$dongia=$this->string->toNumber($this->db->escape(@$data['dongia']));
		$mucdichsudung=$this->db->escape(@$data['mucdichsudung']);
		$ghichu=$this->db->escape(@$data['ghichu']);
		$manhom=$this->db->escape(@$data['manhom']);
		$loai=$this->db->escape(@$data['loai']);
		$madonvi=$this->db->escape(@$data['madonvi']);
		$makho=$this->db->escape(@$data['makho']);
		$imageid=(int)@$data['imageid'];
		$imagepath=$this->db->escape(@$data['imagepath']);

		$field=array(

						'manguyenlieu',
						'tennguyenlieu',
						'soluongtrenkg',
						'tontoithieu',
						'tontoida',
						'soluongton',
						'soluongmoilandathang',
						'dongia',
						'mucdichsudung',
						'ghichu',
						'manhom',
						'loai',
						'madonvi',
						'makho',
						'trangthai',
						'imageid',
						'imagepath'
						);
						$value=array(

						$manguyenlieu,
						$tennguyenlieu,
						$soluongtrenkg,
						$tontoithieu,
						$tontoida,
						$soluongton,
						$soluongmoilandathang,
						$dongia,
						$mucdichsudung,
						$ghichu,
						$manhom,
						$loai,
						$madonvi,
						$makho,
						'active',
						$imageid,
						$imagepath
						);
						$this->db->insertData("qlknguyenlieu",$field,$value);
						$this->updateFileTemp($imageid);
						return $id;
	}

	public function update($data)
	{

		$id= $this->db->escape(@$data['id']);
		$manguyenlieu=$this->db->escape(@$data['manguyenlieu']);
		$tennguyenlieu=$this->db->escape(@$data['tennguyenlieu']);
		$soluongtrenkg= $this->string->toNumber($this->db->escape(@$data['soluongtrenkg']));
		$tontoithieu= $this->string->toNumber($this->db->escape(@$data['tontoithieu']));
		$tontoida=$this->string->toNumber($this->db->escape(@$data['tontoida']));
		$soluongton=$this->string->toNumber($this->db->escape(@$data['soluongton']));
		$soluongmoilandathang=$this->string->toNumber($this->db->escape(@$data['soluongmoilandathang']));
		$dongia=$this->string->toNumber($this->db->escape(@$data['dongia']));
		$mucdichsudung=$this->db->escape(@$data['mucdichsudung']);
		$ghichu=$this->db->escape(@$data['ghichu']);
		$manhom=$this->db->escape(@$data['manhom']);
		$loai=$this->db->escape(@$data['loai']);
		$madonvi=$this->db->escape(@$data['madonvi']);
		$makho=$this->db->escape(@$data['makho']);
		$imageid=(int)@$data['imageid'];
		$imagepath=$this->db->escape(@$data['imagepath']);
		$field=array(

						'manguyenlieu',
						'tennguyenlieu',
						'soluongtrenkg',
						'tontoithieu',
						'tontoida',
						'soluongton',
						'soluongmoilandathang',
						'dongia',
						'mucdichsudung',
						'ghichu',
						'manhom',
						'loai',
						'madonvi',
						'makho',
						'trangthai',
						'imageid',
						'imagepath'
						);
						$value=array(

						$manguyenlieu,
						$tennguyenlieu,
						$soluongtrenkg,
						$tontoithieu,
						$tontoida,
						$soluongton,
						$soluongmoilandathang,
						$dongia,
						$mucdichsudung,
						$ghichu,
						$manhom,
						$loai,
						$madonvi,
						$makho,
						'active',
						$imageid,
						$imagepath
						);

						$where="id = '".$id."'";
						$this->db->updateData("qlknguyenlieu",$field,$value,$where);
						$this->updateFileTemp($imageid);
						return true;
	}

	public function updateNguyenLieuGoc($data)
	{

		$id= $this->db->escape(@$data['id']);
		$nguyenlieugoc=$this->db->escape(@$data['nguyenlieugoc']);

		$field=array(


						'nguyenlieugoc'
						);
						$value=array(


						$nguyenlieugoc

						);

						$where="id = '".$id."'";
						$this->db->updateData("qlknguyenlieu",$field,$value,$where);
						return true;
	}

	public function updateSoLuongTon($id,$soluongton)
	{

		$id= $this->db->escape(@$id);
		$soluongton=$this->db->escape(@$soluongton);

		$field=array(


						'soluongton'
						);
						$value=array(


						$soluongton

						);

						$where="id = '".$id."'";
						$this->db->updateData("qlknguyenlieu",$field,$value,$where);
						return true;
	}

	public function delete($id)
	{
		/*$where="id = '".$id."'";
		 $this->db->deleteData("qlknguyenlieu",$where);*/
		$field=array(

						'trangthai'
						);
						$value=array(


						'deleted'
						);

						$where="id = '".$id."'";
						$this->db->updateData("qlknguyenlieu",$field,$value,$where);
	}

	public function deletedatas($listid)
	{
		foreach($listid as $item)
		{
			$this->delete($item);
		}
	}
	//Nhap xuat
	public function getNguyeLieuXuatNhap($id)
	{
		$sql = "Select `qlknguyenlieu_nhapxuat`.*
									from `qlknguyenlieu_nhapxuat` 
									where id ='".$id."' ";
		$query = $this->db->query($sql);
		return $query->row;
	}

	public function getNguyeLieuXuatNhapList($where="", $from=0, $to=0)
	{

		$sql = "Select `qlknguyenlieu_nhapxuat`.*
									from `qlknguyenlieu_nhapxuat` 
									where 1=1 " . $where . " ORDER BY `ngaylap` DESC";
		if($to > 0)
		{
			$sql .= " Limit ".$from.",".$to;
		}

		$query = $this->db->query($sql);
		return $query->rows;
	}

	public function saveNguyeLieuXuatNhap($data)
	{
		$id=(int)@$data['id'];
		$ngaylap=$this->db->escape(@$data['ngaylap']);
		$nguyenlieuid=$this->db->escape(@$data['nguyenlieuid']);
		$gianhap=$this->string->toNumber($this->db->escape(@$data['gianhap']));
		$soluong=$this->string->toNumber($this->db->escape(@$data['soluong']));
		$nguoinhap=$this->string->toNumber($this->db->escape(@$data['nguoinhap']));
		$ghichu=$this->string->toNumber($this->db->escape(@$data['ghichu']));
		$nhacungcapid=$this->string->toNumber($this->db->escape(@$data['nhacungcapid']));
		
		$field=array(
					 	'ngaylap',
						'nguyenlieuid',
						'gianhap',
						'soluong',
						'nguoinhap',
						'ghichu',
						'nhacungcapid'
						);
		$value=array(
						$ngaylap,
						$nguyenlieuid,
						$gianhap,
						$soluong,
						$nguoinhap,
						$ghichu,
						$nhacungcapid
						);

						if((int)@$data['id'] == 0 )
						{
								
							$id = $this->db->insertData("qlknguyenlieu_nhapxuat",$field,$value);
								
						}
						else
						{
							$where="id = '".$id."'";
							$this->db->updateData("qlknguyenlieu_nhapxuat",$field,$value,$where);
						}
						return $id;
	}

	public function deletedNguyeLieuXuatNhap($id)
	{
		$where="id = '".$id."'";
		$this->db->deleteData("qlknguyenlieu_nhapxuat",$where);
	}
	
	//
	public function getSoLuong($nguyenlieuid,$loaiphieu)
	{
		$sql = "SELECT sum(soluong ) as soluong, madonvi
				FROM  `qlkphieunhapxuat_nguyenlieu` 
				WHERE nguyenlieuid = '".$nguyenlieuid."' AND loaiphieu='".$loaiphieu."'
				Group by madonvi
				";
		$query = $this->db->query($sql);
		$query->rows;
		
		return $query->rows;
	}
	
	public function getTongKho($nguyenlieuid,$loaiphieu)
	{
		$nguyenlieu = $this->getItem($nguyenlieuid);
		$arr_soluong = $this->getSoLuong($nguyenlieuid,$loaiphieu);
		$soluong = $this->model_quanlykho_donvitinh->toDonViTinh($arr_soluong,$nguyenlieu['madonvi']);
		$intsoluong = $this->model_quanlykho_donvitinh->toInt($soluong);
		$data_soluong = $this->model_quanlykho_donvitinh->toDonVi($intsoluong,$nguyenlieu['madonvi']);
		return $this->model_quanlykho_donvitinh->toText($data_soluong);
	}
	
	public function getTonKho($nguyenlieuid)
	{
		$nguyenlieu = $this->getItem($nguyenlieuid);
		
		$arrnhap = $this->getSoLuong($nguyenlieuid,'NK');
		
		$soluongnhap = $this->model_quanlykho_donvitinh->toDonViTinh($arrnhap,$nguyenlieu['madonvi']);
		
		//print_r($soluongnhap);
		$int_nhap = $this->model_quanlykho_donvitinh->toInt($soluongnhap);
		//$arr_nhap = $this->model_quanlykho_donvitinh->toDonVi($int_nhap,$nguyenlieu['madonvi']);
		
		//Xuat kho
		
		$arrxuat = $this->getSoLuong($nguyenlieuid,'XK');
		$soluongxuat = $this->model_quanlykho_donvitinh->toDonViTinh($arrxuat,$nguyenlieu['madonvi']);
		
		
		$int_xuat = $this->model_quanlykho_donvitinh->toInt($soluongxuat);
		//$arr_xuat = $this->model_quanlykho_donvitinh->toDonVi($int_xuat,$nguyenlieu['madonvi']);
		$arr_ton = $this->model_quanlykho_donvitinh->toDonVi($int_nhap - $int_xuat,$nguyenlieu['madonvi']);
		
		return $this->model_quanlykho_donvitinh->toText($arr_ton);
	}
}
?>