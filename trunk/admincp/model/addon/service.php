<?php
class ModelAddonService extends ModelCoreFile 
{ 
	private $arr_col = array(
							
							'servicename',
							'servicetype',
							'startday',
							'customerid',
							'customername',
							'status',
							
							);
	public function getItem($id)
	{
		$query = $this->db->query("Select `service`.* 
									from `service` 
									where id ='".$id."' ");
		return $query->row;
	}
	
	
	
	public function getList($where="", $from=0, $to=0)
	{
		
		$sql = "Select `service`.* 
									from `service` 
									where 1=1 " . $where ;
		if($to > 0)
		{
			$sql .= " Limit ".$from.",".$to;
		}
		//echo $sql;
		$query = $this->db->query($sql);
		return $query->rows;
	}
	
	public function updateCol($id,$col,$val)
	{
		$id = $id;
		$col = $col;
		$val = $val;
		
		
		$field=array(
						$col
					);
		$value=array(
						$val
					);
		
		$where="id = '".$id."'";
		$this->db->updateData('service',$field,$value,$where);
	}
	
	public function save($data)
	{
		$service = $this->getItem($data['id']);
		
		$value = array();
		if(count($service))
		{
			foreach($service as $col => $val)
			{
				if(isset($data[$col]))
					$service[$col] = $data[$col];
			}
			$data = $service;
		}
		
		foreach($this->arr_col as $col)
		{
			$value[] = $this->db->escape(@$data[$col]);
		}
		

		$field=$this->arr_col;
		
		if(count($service) == 0)
		{
			$data['id'] = $this->db->insertData("service",$field,$value);
		}
		else
		{
			$where="id = '".$data['id']."'";
			$this->db->updateData("service",$field,$value,$where);
		}
		return $data['id'];
	}
	
	public function delete($id)
	{
		$where="id = '".$id."'";
		$this->db->deleteData("service",$where);
		$where="serviceid = '".$id."'";
		$this->db->deleteData("service_detail",$where);
	}
	
}
?>