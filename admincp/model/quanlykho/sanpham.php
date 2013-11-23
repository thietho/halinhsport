<?php
$this->load->model("core/file");
class ModelQuanlykhoSanpham extends ModelCoreFile
{
	public function getItem($id, $where="")
	{
		$sql = "Select `qlksanpham`.*
									from `qlksanpham` 
									where id ='".$id."' ".$where;
		$query = $this->db->query($sql);
		return $query->row;
	}

	public function getList($where="", $from=0, $to=0,$order="")
	{

		$sql = "Select `qlksanpham`.*
									from `qlksanpham` 
									where trangthai <> 'deleted' " . $where;
		if($order=="")
		{
			$order = " Order by tensanpham";
			
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
		$masanpham=$this->db->escape(@$data['masanpham']);
		$tensanpham=$this->db->escape(@$data['tensanpham']);
		$tenhienthi=$this->db->escape(@$data['tenhienthi']);
		$giaban= $this->string->toNumber($this->db->escape(@$data['giaban']));
		$loai=$this->db->escape(@$data['loai']);
		$madonvi=$this->db->escape(@$data['madonvi']);
		$vitri=$this->db->escape(@$data['vitri']);
		$imageid=(int)@$data['imageid'];
		$imagepath=$this->db->escape(@$data['imagepath']);

		$field=array(

						'masanpham',
						'tensanpham',
						'tenhienthi',
						'giaban',
						'loai',
						'madonvi',
						'vitri',
						'trangthai',
						'imageid',
						'imagepath'
						);
		$value=array(

						$masanpham,
						$tensanpham,
						$tenhienthi,
						$giaban,
						$loai,
						$madonvi,
						$vitri,
						'active',
						$imageid,
						$imagepath
						);
		$id = $this->db->insertData("qlksanpham",$field,$value);
		$this->updateFileTemp($imageid);
		return $id;
	}

	public function update($data)
	{

		$id= $this->db->escape(@$data['id']);
		$masanpham=$this->db->escape(@$data['masanpham']);
		$tensanpham=$this->db->escape(@$data['tensanpham']);
		$tenhienthi=$this->db->escape(@$data['tenhienthi']);
		$giaban= $this->string->toNumber($this->db->escape(@$data['giaban']));
		$loai=$this->db->escape(@$data['loai']);
		$madonvi=$this->db->escape(@$data['madonvi']);
		$vitri=$this->db->escape(@$data['vitri']);
		$imageid=(int)@$data['imageid'];
		$imagepath=$this->db->escape(@$data['imagepath']);
		
		$field=array(

						'masanpham',
						'tensanpham',
						'tenhienthi',
						'giaban',
						'loai',
						'madonvi',
						'vitri',
						
						'imageid',
						'imagepath'
						);
		$value=array(

						$masanpham,
						$tensanpham,
						$tenhienthi,
						$giaban,
						$loai,
						$madonvi,
						$vitri,
						
						$imageid,
						$imagepath
						);

		$where="id = '".$id."'";
		$this->db->updateData("qlksanpham",$field,$value,$where);
		$this->updateFileTemp($imageid);
		return true;
	}
	public function updateCol($id,$col,$val)
	{
		$id= $this->db->escape(@$id);
		$col= $this->db->escape(@$col);
		$val= $this->db->escape(@$val);
		
		$field=array(

						$col
						);
		$value=array(

						$val
						);

		$where="id = '".$id."'";
		$this->db->updateData("qlksanpham",$field,$value,$where);
	}
	public function delete($id)
	{
		$this->updateCol($id,'trangthai','deleted');	
	}
	//Dinh luong
	public function getSanPhamNguyenLieu($id)
	{
		$sql = "Select `qlksanpham_nguyenlieu`.*
									from `qlksanpham_nguyenlieu` 
									where id ='".$id."' ".$where;
		$query = $this->db->query($sql);
		return $query->row;
	}
	public function getSanPhamNguyenLieuList($where)
	{
		$sql = "Select `qlksanpham_nguyenlieu`.*
									from `qlksanpham_nguyenlieu` 
									where 1=1 " . $where;
		
		$query = $this->db->query($sql);
		return $query->rows;
	}
	public function saveSanPhamNguyenLieu($data)
	{
		
		$id=(int)@$data['id'];
		$sanphamid=$this->db->escape(@$data['sanphamid']);
		$nguyenlieuid=$this->db->escape(@$data['nguyenlieuid']);
		$soluong=$this->string->toNumber($this->db->escape(@$data['soluong']));
		$madonvi=$this->db->escape(@$data['madonvi']);
		$field=array(
					 	
						'sanphamid',
						'nguyenlieuid',
						'soluong',
						'madonvi'
						);
		$value=array(
						
						$sanphamid,
						$nguyenlieuid,
						$soluong,
						$madonvi
						);

		if((int)@$data['id'] == 0 )
		{
				
			$this->db->insertData("qlksanpham_nguyenlieu",$field,$value);
				
		}
		else
		{
			$where="id = '".$id."'";
			$this->db->updateData("qlksanpham_nguyenlieu",$field,$value,$where);
		}
		return $id;
	}
	public function deleteSanPhamNguyenLieu($id)
	{
		$where="id = '".$id."'";
		$this->db->deleteData("qlksanpham_nguyenlieu",$where);
	}
}
?>