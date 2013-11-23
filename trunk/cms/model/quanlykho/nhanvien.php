<?php

class ModelQuanlykhoNhanvien extends Model
{
	public function getItem($id, $where="")
	{
		$sql = "Select `qlknhanvien`.*
									from `qlknhanvien` 
									where id ='".$id."' ".$where;
		$query = $this->db->query($sql);
		return $query->row;
	}

	public function getItemByUsername($username)
	{
		$sql = "Select `qlknhanvien`.*
									from `qlknhanvien` 
									where username ='".$username."' ";
		$query = $this->db->query($sql);
		return $query->row;
	}

	public function getList($where="", $from=0, $to=0)
	{

		$sql = "Select `qlknhanvien`.*
									from `qlknhanvien` 
									where trangthai <> 'deleted' " . $where . " Order by id";
		if($to > 0)
		{
			$sql .= " Limit ".$from.",".$to;
		}

		$query = $this->db->query($sql);
		return $query->rows;
	}

	private function nextID()
	{
		return $this->db->getNextId('qlknhanvien','id');
	}

	public function insert($data)
	{
		$id= $this->nextID();
		$manhanvien=$this->db->escape(@$data['manhanvien']);
		$hoten=$this->db->escape(@$data['hoten']);
		$ngaysinh=$this->db->escape(@$data['ngaysinh']);
		$cmnd=$this->db->escape(@$data['cmnd']);
		$email=$this->db->escape(@$data['email']);
		$sodienthoai=$this->db->escape(@$data['sodienthoai']);
		$gioitinh=$this->db->escape(@$data['gioitinh']);
		$maphongban= $this->db->escape(@$data['maphongban']);
		$chucvu= $this->db->escape(@$data['chucvu']);
		$nhom= $this->db->escape(@$data['nhom']);
		$loai= $this->db->escape(@$data['loai']);
		$trinhdovanhoa= $this->db->escape(@$data['trinhdovanhoa']);
		$quequan= $this->db->escape(@$data['quequan']);
		$diachithuongtru= $this->db->escape(@$data['diachithuongtru']);
		$diachitamtru= $this->db->escape(@$data['diachitamtru']);
		$imageid= $this->db->escape(@$data['imageid']);
		$imagepath= $this->db->escape(@$data['imagepath']);
		$chuyenmon=$this->db->escape(@$data['chuyenmon']);
		$bangcap=$this->db->escape(@$data['bangcap']);
		$luongcoban=$this->string->toNumber($this->db->escape(@$data['luongcoban']));
		$ngach=$this->db->escape(@$data['ngach']);
		$batluong=$this->db->escape(@$data['batluong']);
		$thang=$this->db->escape(@$data['thang']);
		$heso=$this->string->toNumber($this->db->escape(@$data['heso']));
		$ngayvaolam=$this->db->escape(@$data['ngayvaolam']);
		$ngaykyhopdong=$this->db->escape(@$data['ngaykyhopdong']);
		$bhxh=$this->db->escape(@$data['bhxh']);
		$bhyt=$this->db->escape(@$data['bhyt']);
		//$trangthai=$this->db->escape(@$data['trangthai']);

		$field=array(
						'manhanvien',
						'hoten',
						'ngaysinh',
						'cmnd',
						'email',
						'sodienthoai',
						'gioitinh',
						'maphongban',
						'chucvu',
						'nhom',
						'loai',
						'trinhdovanhoa',
						'quequan',
						'diachithuongtru',
						'diachitamtru',
						'imageid',
						'imagepath',
						'chuyenmon',
						'bangcap',
						'luongcoban',
						'ngach',
						'batluong',
						'thang',
						'heso',
						'ngayvaolam',
						'ngaykyhopdong',
						'bhxh',
						'bhyt',
						'trangthai',
						'username'
						);

						$value=array(

						$manhanvien,
						$hoten,
						$ngach,
						$cmnd,
						$email,
						$sodienthoai,
						$gioitinh,
						$maphongban,
						$chucvu,
						$nhom,
						$loai,
						$trinhdovanhoa,
						$quequan,
						$diachithuongtru,
						$diachitamtru,
						$imageid,
						$imagepath,
						$chuyenmon,
						$bangcap,
						$luongcoban,
						$ngach,
						$batluong,
						$thang,
						$heso,
						$ngayvaolam,
						$ngaykyhopdong,
						$bhxh,
						$bhyt,
						"active",
						""
						);
						$this->db->insertData("qlknhanvien",$field,$value);

						return $id;
	}

	public function update($data)
	{

		$id= (int)@$data['id'];
		$manhanvien=$this->db->escape(@$data['manhanvien']);
		$hoten=$this->db->escape(@$data['hoten']);
		$ngaysinh=$this->db->escape(@$data['ngaysinh']);
		$cmnd=$this->db->escape(@$data['cmnd']);
		$email=$this->db->escape(@$data['email']);
		$sodienthoai=$this->db->escape(@$data['sodienthoai']);
		$gioitinh=$this->db->escape(@$data['gioitinh']);
		$maphongban= $this->db->escape(@$data['maphongban']);
		$chucvu= $this->db->escape(@$data['chucvu']);
		$nhom= $this->db->escape(@$data['nhom']);
		$loai= $this->db->escape(@$data['loai']);
		$trinhdovanhoa= $this->db->escape(@$data['trinhdovanhoa']);
		$quequan= $this->db->escape(@$data['quequan']);
		$diachithuongtru= $this->db->escape(@$data['diachithuongtru']);
		$diachitamtru= $this->db->escape(@$data['diachitamtru']);
		$imageid= $this->db->escape(@$data['imageid']);
		$imagepath= $this->db->escape(@$data['imagepath']);
		$chuyenmon=$this->db->escape(@$data['chuyenmon']);
		$bangcap=$this->db->escape(@$data['bangcap']);
		$luongcoban=$this->string->toNumber($this->db->escape(@$data['luongcoban']));
		$ngach=$this->db->escape(@$data['ngach']);
		$batluong=$this->db->escape(@$data['batluong']);
		$thang=$this->db->escape(@$data['thang']);
		$heso=$this->string->toNumber($this->db->escape(@$data['heso']));
		$ngayvaolam=$this->db->escape(@$data['ngayvaolam']);
		$ngaykyhopdong=$this->db->escape(@$data['ngaykyhopdong']);
		$bhxh=$this->db->escape(@$data['bhxh']);
		$bhyt=$this->db->escape(@$data['bhyt']);

		$field=array(
						'manhanvien',
						'hoten',
						'ngaysinh',
						'cmnd',
						'email',
						'sodienthoai',
						'gioitinh',
						'maphongban',
						'chucvu',
						'nhom',
						'loai',
						'trinhdovanhoa',
						'quequan',
						'diachithuongtru',
						'diachitamtru',
						'imageid',
						'imagepath',
						'chuyenmon',
						'bangcap',
						'luongcoban',
						'ngach',
						'batluong',
						'thang',
						'heso',
						'ngayvaolam',
						'ngaykyhopdong',
						'bhxh',
						'bhyt'
						
						
						);

						$value=array(

						$manhanvien,
						$hoten,
						$ngaysinh,
						$cmnd,
						$email,
						$sodienthoai,
						$gioitinh,
						$maphongban,
						$chucvu,
						$nhom,
						$loai,
						$trinhdovanhoa,
						$quequan,
						$diachithuongtru,
						$diachitamtru,
						$imageid,
						$imagepath,
						$chuyenmon,
						$bangcap,
						$luongcoban,
						$ngach,
						$batluong,
						$thang,
						$heso,
						$ngayvaolam,
						$ngaykyhopdong,
						$bhxh,
						$bhyt
						);

						$where="id = '".$id."'";
						$this->db->updateData("qlknhanvien",$field,$value,$where);
						return true;
	}

	public function delete($id)
	{

		$field=array(

						'trangthai'
						);
						$value=array(


						'deleted'
						);

						$where="id = '".$id."'";
						$this->db->updateData("qlknhanvien",$field,$value,$where);
	}

	public function updateusername($id, $username)
	{

		$field=array(
						'username'
						);
		$value=array(
						$username
						);

						$where="id = '".$id."'";
						$this->db->updateData("qlknhanvien",$field,$value,$where);
	}

	public function	updateCol($id,$col,$val)
	{
		$field=array(
						$col
						);
		$value=array(
						$val
		);

		$where=" id = '".$id."'";
		$this->db->updateData("qlknhanvien",$field,$value,$where);
	}
	
	public function deletedatas($listid)
	{
		foreach($listid as $item)
		{
			$this->delete($item);
		}
	}

	public function saveuser($data)
	{
		$userid=$this->db->escape(@$data['username']);
		$username=$this->db->escape(@$data['username']);
		$usertypeid=$this->db->escape(@$data['usertypeid']);
		$password=$this->db->escape(@$data['password']);
		$status="lock";
		$activedate=$this->date->getToday();
		$updateddate=$this->date->getToday();
		$deleteddate="";
		$activeby=$this->user->getId();
		$updatedby=$this->user->getId();
		$deletedby="";
		$userip=$this->db->escape(@$this->request->server['REMOTE_ADDR']);

		$field=array(
						'`userid`',
						'`username`',
						'`usertypeid`',
						'`password`',
						'`status`',
						'`activedate`',
						'`updateddate`',
						'`deleteddate`',
						'`activeby`',
						'`updatedby`',
						'`deletedby`',
						'`userip`'
						);
						$value=array(
						$userid,
						$username,
						$usertypeid,
						md5($password),
						$status,
						$activedate,
						$updateddate,
						$deleteddate,
						$activeby,
						$updatedby,
						$deletedby,
						$userip
						);
		$this->load->model("core/user");
		$arr = $this->model_core_user->getItemByUserName($username);
		if(count($arr)==0)
		{
			$this->db->insertData("user",$field,$value);
			return $userid;
		}
		else
			return $arr['userid'];
	}

}
?>