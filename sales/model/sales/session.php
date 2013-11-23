<?php
class ModelSalesSession extends Model 
{
	private $columns = array(
								'staffid',
								'starttime',
								'endtime',
								'shopid'
							);
	public function getList($where = "")
	{
		$sql = "Select `session`.* from `session` where 1=1 ".$where;
		$query = $this->db->query($sql);
		return $query->rows;
	}

	public function getItem($id)
	{
		$sql = "Select * from `session` where id = '".$id."'";
		$query = $this->db->query($sql);
		return $query->row;
	}
	
	public function createSession($shopid)
	{
		$curtime = $this->date->getToday();
		$data['starttime'] = $curtime;
		$nhanvien = $this->user->getNhanVien();
		$data['staffid'] = $nhanvien['id'];
		$data['shopid'] = $shopid;
		foreach($this->columns as $val)
		{			
			$field[] = $val;
			$value[] = $this->db->escape($data[$val]);	
		}
		
		$getLastId = $this->db->insertData("session",$field,$value);
		return $getLastId;
	}
	public function closeSession($id)
	{
		$this->updateCol($id,"endtime",$this->date->getToday());
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
		$this->db->updateData("session",$field,$value,$where);
	}
	
	//Xóa session
	public function delete($id)
	{
		$where="id = '".$id."'";
		$this->db->deleteData('session',$where);
	}
}
?>