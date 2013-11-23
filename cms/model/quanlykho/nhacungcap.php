<?php
class ModelQuanlykhoNhacungcap extends Model
{
	private $arr_col = array(
							'id',
							'tennhacungcap',
							'sodienthoai',
							'diachi',
							'email',
							'nguoilienhe',
							'sodienthoainguoilienhe',
							'emailnguoilienhe',
							'ghichu'
							);
	public function getItem($id, $where="")
	{
		$sql = "Select `qlknhacungcap`.*
									from `qlknhacungcap` 
									where id ='".$id."' ".$where;
		$query = $this->db->query($sql);
		return $query->row;
	}

	public function getList($where="", $from=0, $to=0,$order="")
	{

		$sql = "Select `qlknhacungcap`.*
									from `qlknhacungcap` 
									where 1=1 " . $where;
		if($order=="")
		{
			$order = " Order by tennhacungcap";
			
		}
		$sql.=$order;
		if($to > 0)
		{
			$sql .= " Limit ".$from.",".$to;
		}
		
		$query = $this->db->query($sql);
		return $query->rows;
	}

	public function save($data)
	{
		$value = array();
		foreach($this->arr_col as $col)
		{
			$value[] = $this->db->escape(@$data[$col]);
		}
		

		$field=$this->arr_col;
		if((int)$data['id'] == 0)
		{
			$data['id'] = $this->db->insertData("qlknhacungcap",$field,$value);
		}
		else
		{
			$where="id = '".$data['id']."'";
			$this->db->updateData("qlknhacungcap",$field,$value,$where);
		}
		return $data['id'];
	}
	public function delete($id)
	{
		$where="id = '".$id."'";
		$this->db->deleteData("qlknhacungcap",$where);
	}
}