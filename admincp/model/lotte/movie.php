<?php
class ModelLotteMovie extends Model
{ 
	private $arr_col = array(
							
							'moviename',
							'icone',
							'banner',
							'image',
							'timeshow',
							'cinemalocation',
							'movieinfo',
							'ticketprice',
							
							);
	public function getItem($id)
	{
		$query = $this->db->query("Select `lottemovies`.* 
									from `lottemovies` 
									where id ='".$id."' ");
		return $query->row;
	}
	
	
	
	public function getList($where="", $from=0, $to=0)
	{
		
		$sql = "Select `lottemovies`.* 
									from `lottemovies` 
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
		$this->db->updateData('lottemovies',$field,$value,$where);
	}
	
	public function save($data)
	{
		$lottemovies = $this->getItem($data['id']);
		
		$value = array();
		if(count($lottemovies))
		{
			foreach($lottemovies as $col => $val)
			{
				if(isset($data[$col]))
					$lottemovies[$col] = $data[$col];
			}
			$data = $lottemovies;
		}
		
		foreach($this->arr_col as $col)
		{
			$value[] = $this->db->escape(@$data[$col]);
		}
		

		$field=$this->arr_col;
		
		if(count($lottemovies) == 0)
		{
			$data['id'] = $this->db->insertData("lottemovies",$field,$value);
		}
		else
		{
			$where="id = '".$data['id']."'";
			$this->db->updateData("lottemovies",$field,$value,$where);
		}
		return $data['id'];
	}
	
	public function delete($id)
	{
		$where="id = '".$id."'";
		$this->db->deleteData("lottemovies",$where);
		
	}
	
}
?>