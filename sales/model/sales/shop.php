<?php
class ModelSalesShop extends Model 
{
	private $columns = array(
								'shopname',
								'address',
								'phone'
								
							);
	public function getList($where = "")
	{
		$sql = "Select `shop`.* from `shop` where 1=1 ".$where;
		$query = $this->db->query($sql);
		return $query->rows;
	}

	public function getItem($id)
	{
		$sql = "Select * from `shop` where id = '".$id."'";
		$query = $this->db->query($sql);
		return $query->row;
	}
	
	public function insert($data)
	{
		$curtime = $this->date->getToday();
	
		foreach($this->columns as $val)
		{			
			$field[] = $val;
			$value[] = $this->db->escape($data[$val]);	
		}
		
		$getLastId = $this->db->insertData("shop",$field,$value);
		return $getLastId;
	}
	
	
	public function update($data)
	{	
		$data['createtime']=$this->db->escape(@$this->date->formatViewDate($data['createtime']));
		$data['paymenttime']=$this->db->escape(@$this->date->formatViewDate($data['paymenttime']));
		foreach($this->columns as $val)
		{
	
			if(isset($data[$val]))
			{
				$field[] = $val;
				$value[] = $this->db->escape($data[$val]);	
			}
		}
					
		$where="id = '".$data['id']."'";
		$this->db->updateData("shop",$field,$value,$where);
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
		$this->db->updateData("shop",$field,$value,$where);
	}
	
	//Xóa shop
	public function delete($id)
	{
		$where="id = '".$id."'";
		$this->db->deleteData('shop',$where);
	}
	
	//shop_staff
	public function getShopStaff($staffid)
	{
		$sql = "Select * from `shop_staff` where staffid = '".$staffid."'";
		$query = $this->db->query($sql);
		return $query->row;
	}
	public function getShopStaffList($where = "")
	{
		$sql = "Select * from `shop_staff` where 1=1 ".$where;
		$query = $this->db->query($sql);
		return $query->rows;
	}
	public function saveShopStaff($data)
	{
		$staffid=(int)@$data['staffid'];
		$shopid=$this->db->escape(@$data['shopid']);
		
		
		$field=array(
						'staffid',
						'shopid'
						
						);
		$value=array(
						$staffid,
						$shopid
						
						);
		$staff = $this->getShopStaff($staffid);
		if(count($staff) == 0 )
		{
				
			$this->db->insertData("shop_staff",$field,$value);
				
		}
		else
		{
			$where="staffid = '".$staffid."'";
			$this->db->updateData("shop_staff",$field,$value,$where);
		}
		return $data['id'];
	}
	public function deleteShopStaff($staffid)
	{
		$where="staffid = '".$staffid."'";
		$this->db->deleteData('shop_staff',$where);
	}
}
?>