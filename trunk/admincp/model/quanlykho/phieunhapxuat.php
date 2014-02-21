<?php
class ModelQuanlykhoPhieunhapxuat extends Model
{
	public function getItem($id, $where="")
	{
		$sql = "Select `qlkphieunhapxuat`.*
									from `qlkphieunhapxuat` 
									where id ='".$id."' ".$where;
		$query = $this->db->query($sql);
		return $query->row;
	}

	public function getList($where="", $from=0, $to=0,$order="")
	{

		$sql = "Select `qlkphieunhapxuat`.*
									from `qlkphieunhapxuat` 
									where trangthai <> 'deleted' " . $where;
		if($order=="")
		{
			$order = " Order by id DESC";
			
		}
		$sql.=$order;
		if($to > 0)
		{
			$sql .= " Limit ".$from.",".$to;
		}
		
		$query = $this->db->query($sql);
		return $query->rows;
	}
	
	private function createMaPhieu($prefix="")
	{
		return $this->db->getNextIdVarChar('qlkphieunhapxuat','maphieu',$prefix);
	}
	
	public function save($data)
	{
		$today = $this->date->getToday();
		$year = $this->date->getYear($today);
		$month = $this->date->getMonth($today);
		$id=(int)@$data['id'];
		$loaiphieu=$this->db->escape(@$data['loaiphieu']);
		$maphieu=$this->createMaPhieu($loaiphieu.$year.$this->date->numberFormate($month));
		$nguoilap=$this->user->getUserName();
		if($id==0)
			$ngaylap=$this->date->getToday();
		else
			$ngaylap=$this->db->escape(@$data['ngaylap']);
		$loaiphieu=$this->db->escape(@$data['loaiphieu']);
		$nguoithuchienid=$this->db->escape(@$data['nguoithuchienid']);
		$nguoithuchien=$this->db->escape(@$data['nguoithuchien']);
		$nhacungcapid=$this->db->escape(@$data['nhacungcapid']);
		$tennhacungcap=$this->db->escape(@$data['tennhacungcap']);
		$khachhangid=$this->db->escape(@$data['khachhangid']);
		$tenkhachhang=$this->db->escape(@$data['tenkhachhang']);
		
		$nguoigiao=$this->db->escape(@$data['nguoigiao']);
		$nguoinhanid=$this->db->escape(@$data['nguoinhanid']);
		$nguoinhan=$this->db->escape(@$data['nguoinhan']);
		$tongtien=$this->string->toNumber($this->db->escape(@$data['tongtien']));
		$thanhtoan=$this->string->toNumber($this->db->escape(@$data['thanhtoan']));
		$congno = $this->string->toNumber($this->db->escape(@$data['congno']));
		$ghichu=$this->db->escape(@$data['ghichu']);
		$songaycongno=$this->string->toNumber($this->db->escape(@$data['songaycongno']));
		$trangthai = $this->db->escape(@$data['trangthai']);;
		$lydothu=$this->db->escape(@$data['lydothu']);
		$thuphi=$this->string->toNumber($this->db->escape(@$data['thuphi']));
		
		$field=array(
							
						
						'nguoilap',
						'ngaylap',
						'loaiphieu',
						'nguoithuchienid',
						'nguoithuchien',
						'nhacungcapid',
						'tennhacungcap',
						'khachhangid',
						'tenkhachhang',
						'nguoigiao',
						'nguoinhanid',
						'nguoinhan',
						'tongtien',
						'thanhtoan',
						'congno',
						'ghichu',
						'trangthai',
						'songaycongno',
						'lydothu',
						'thuphi'
					);
		$value=array(
						
						
						$nguoilap,
						$ngaylap,
						$loaiphieu,
						$nguoithuchienid,
						$nguoithuchien,
						$nhacungcapid,
						$tennhacungcap,
						$khachhangid,
						$tenkhachhang,
						$nguoigiao,
						$nguoinhanid,
						$nguoinhan,
						$tongtien,
						$thanhtoan,
						$congno,
						$ghichu,
						$trangthai,
						$songaycongno,
						$lydothu,
						$thuphi
						);
		if((int)$data['id'] == 0)
		{
			$data['id'] = $this->db->insertData("qlkphieunhapxuat",$field,$value);
			$this->updateCol($data['id'],'maphieu',$maphieu);
		}
		else
		{
			$where="id = '".$data['id']."'";
			$this->db->updateData("qlkphieunhapxuat",$field,$value,$where);
		}
		return $data['id'];
	}
	
	public function updateCol($id,$col,$val)
	{
		$id=$this->db->escape(@$id);
		$col=$this->db->escape(@$col);
		$val=$this->db->escape(@$val);
		$field=array(
							
						$col
					);
		$value=array(
						
						$val
						);
		$where="id = '".$id."'";
		$this->db->updateData("qlkphieunhapxuat",$field,$value,$where);
	}
	
	public function delete($id)
	{
		$field = array('trangthai');
		$value = array('deleted');
		
		$where="id = '".$data['id']."'";
		$this->db->updateData("qlkphieunhapxuat",$field,$value,$where);
		$where="phieuid = '".$id."'";
		$this->db->updateData("qlkphieunhapxuat",$field,$value,$where);
	}
	
	public function destroy($id)
	{
		$where="id = '".$id."'";
		$this->db->deleteData("qlkphieunhapxuat",$where);
		$where="phieuid = '".$id."'";
		$this->db->deleteData("qlkphieunhapxuat_media",$where);
	}
	//Chi tiet phieu nhap
	public function getPhieuNhapXuatMedia($id)
	{
		$sql = "Select `qlkphieunhapxuat_media`.*
									from `qlkphieunhapxuat_media` 
									where id ='".$id."' ".$where;
		$query = $this->db->query($sql);
		return $query->row;
	}
	public function getPhieuNhapXuatMediaList($where)
	{
		$sql = "Select `qlkphieunhapxuat_media`.*
									from `qlkphieunhapxuat_media` 
									where trangthai <> 'deleted' " . $where;
		
		$query = $this->db->query($sql);
		return $query->rows;
	}
	public function savePhieuNhapXuatMedia($data)
	{
		
		$id=(int)@$data['id'];
		$phieuid=$this->db->escape(@$data['phieuid']);
		$mediaid=$this->db->escape(@$data['mediaid']);
		$code=$this->db->escape(@$data['code']);
		$title=$this->db->escape(@$data['title']);
		$soluong=$this->string->toNumber($this->db->escape(@$data['soluong']));
		$madonvi=$this->db->escape(@$data['madonvi']);
		$giatien=$this->string->toNumber($this->db->escape(@$data['giatien']));
		$giamgia=$this->string->toNumber($this->db->escape(@$data['giamgia']));
		$phantramgiamgia=$this->string->toNumber($this->db->escape(@$data['phantramgiamgia']));
		$thanhtien=$soluong*($giatien-$giamgia);
		$trangthai = "active";
		$loaiphieu=$this->db->escape(@$data['loaiphieu']);
		
		$maphieu=$this->db->escape(@$data['maphieu']);
		$ngaylap=$this->db->escape(@$data['ngaylap']);
		$ngaylap=$this->db->escape(@$data['ngaylap']);
		
		$nhacungcapid=$this->db->escape(@$data['nhacungcapid']);
		$tennhacungcap=$this->db->escape(@$data['tennhacungcap']);
		$khachhangid=$this->db->escape(@$data['khachhangid']);
		$tenkhachhang=$this->db->escape(@$data['tenkhachhang']);
		$nguoigiao=$this->db->escape(@$data['nguoigiao']);
		$nguoinhanid=$this->db->escape(@$data['nguoinhanid']);
		$nguoinhan=$this->db->escape(@$data['nguoinhan']);
		
		$field=array(
						'phieuid',
						'mediaid',
						'code',
						'title',
						'soluong',
						'madonvi',
						'giatien',
						'giamgia',
						'phantramgiamgia',
						'thanhtien',
						'trangthai',
						'loaiphieu',
						'maphieu',
						'ngaylap',
						'nhacungcapid',
						'tennhacungcap',
						'khachhangid',
						'tenkhachhang',
						'nguoigiao',
						'nguoinhanid',
						'nguoinhan'
						
						);
		$value=array(
						$phieuid,
						$mediaid,
						$code,
						$title,
						$soluong,
						$madonvi,
						$giatien,
						$giamgia,
						$phantramgiamgia,
						$thanhtien,
						$trangthai,
						$loaiphieu,
						$maphieu,
						$ngaylap,
						$nhacungcapid,
						$tennhacungcap,
						$khachhangid,
						$tenkhachhang,
						$nguoigiao,
						$nguoinhanid,
						$nguoinhan
						);

		if((int)@$data['id'] == 0 )
		{
				
			$data['id'] = $this->db->insertData("qlkphieunhapxuat_media",$field,$value);
				
		}
		else
		{
			$where="id = '".$id."'";
			$this->db->updateData("qlkphieunhapxuat_media",$field,$value,$where);
		}
		return $data['id'];
	}
	public function deletePhieuNhapXuatMedia($id)
	{
		$where="id = '".$id."'";
		$this->db->deleteData("qlkphieunhapxuat_media",$where);
	}
	
	public function thongke($where)
	{
		$sql = "Select 
						`qlkphieunhapxuat_media`.*
									from `qlkphieunhapxuat_media` 
									where 1=1 " . $where;
		
		$query = $this->db->query($sql);
		return $query->rows;
	}
	public function getAgvPrice($mediaid,$loaiphieu)
	{
		$where = " AND loaiphieu = '".$loaiphieu."' AND mediaid = '".$mediaid."'";
		$data = $this->getPhieuNhapXuatMediaList($where);
		$sumthanhtien = 0;
		$sumsoluong = 0;
		foreach($data as $item)
		{
			$sumsoluong += $item['soluong'];
			$sumthanhtien += $item['thanhtien'];
		}
		if($sumsoluong ==0)
			return 0;
		else
			return $sumthanhtien/$sumsoluong;
	}
}