<?php
class ModelQuanlykhoDonvitinh extends Model
{
	public function getItem($madonvi)
	{
		$query = $this->db->query("Select `qlkdonvitinh`.*
									from `qlkdonvitinh` 
									where madonvi ='".$madonvi."' ");
		return $query->row;
	}

	public function getList($where="", $from=0, $to=0)
	{

		$sql = "Select `qlkdonvitinh`.*
									from `qlkdonvitinh` 
									where 1=1 " . $where . " Order by madonvi";
		if($to > 0)
		{
			$sql .= " Limit ".$from.",".$to;
		}

		$query = $this->db->query($sql);
		return $query->rows;
	}

	public function insert($data)
	{
		$madonvi= $this->db->escape(@$data['madonvi']);
		$tendonvitinh=$this->db->escape(@$data['tendonvitinh']);
		$quidoi=$this->db->escape(@$this->string->toNumber($data['quidoi']));
		$madonviquydoi=$this->db->escape(@$data['madonviquydoi']);


		$field=array(
						'madonvi',
						'tendonvitinh',
						'quidoi',
						'madonviquydoi'
						);
						$value=array(
						$madonvi,
						$tendonvitinh,
						$quidoi,
						$madonviquydoi
						);
						$this->db->insertData("qlkdonvitinh",$field,$value);

						return $madonvi;
	}

	public function update($data)
	{
		$madonvi = $this->db->escape(@$data['madonvi']);
		$tendonvitinh=$this->db->escape(@$data['tendonvitinh']);
		$quidoi=$this->db->escape(@$this->string->toNumber($data['quidoi']));
		$madonviquydoi=$this->db->escape(@$data['madonviquydoi']);

		$field=array(
						'tendonvitinh',
						'quidoi',
						'madonviquydoi'
						
						);
						$value=array(
						$tendonvitinh,
						$quidoi,
						$madonviquydoi

						);

						$where="madonvi = '".$madonvi."'";
						$this->db->updateData("qlkdonvitinh",$field,$value,$where);



						return true;
	}

	public function delete($madonvi)
	{
		$where="madonvi = '".$madonvi."'";
		$this->db->deleteData("qlkdonvitinh",$where);
	}

	public function deletedatas($data)
	{
		if(count($data)>0)
		{
			foreach($data as $item)
			$this->delete($item);
		}
	}
	//
	public function getDonViQuyDoi($madonvi)
	{
		$data = array();
		$donvi = $this->getItem($madonvi);
		$data[] = $donvi;
		while($donvi['madonviquydoi']!='')
		{
			$donvi = $this->getItem($donvi['madonviquydoi']);
			$data[] = $donvi;
		}
		return $data;
	}
	
	
	public function toDonViTinh($arr,$madonvi)
	{
		
		$data_donvitinh = $this->getDonViQuyDoi($madonvi);
		
		foreach($data_donvitinh as $i => $donvitinh)
		{
			foreach($arr as $val)
			{
				if($val['madonvi'] == $donvitinh['madonvi'])
				{
					$data_donvitinh[$i]['soluong'] = $val['soluong'];
				}
			}
		}
		
		$data_donvitinh = $this->string->swapArray($data_donvitinh);
		
		foreach($data_donvitinh as $i => $donvitinh)
		{
			if($data_donvitinh[$i+1]['quidoi'] !=0)
			{
				
				$phandu = $data_donvitinh[$i]['soluong'] % $data_donvitinh[$i+1]['quidoi'];
				$phannguyen = floor($data_donvitinh[$i]['soluong'] / $data_donvitinh[$i+1]['quidoi']);
				
				$data_donvitinh[$i]['soluong'] = $phandu;
				$data_donvitinh[$i+1]['soluong'] += $phannguyen;
			}
		}
		return $this->string->swapArray($data_donvitinh);
	}
	
	public function toInt($data_donvi)
	{
		$soluong = 0;
		foreach($data_donvi as $i => $donvi)
		{
			//echo $soluong += $donvi['soluong']*$donvi['quidoi'];
			$hs = 1;
			for($j = $i;$j<count($data_donvi);$j++)
			{
				if($data_donvi[$j]['quidoi']!=0)
				{
					$hs *= $data_donvi[$j]['quidoi'];
				}
			}
			$soluong += $donvi['soluong'] * $hs;
		}
		return $soluong;
	}
	
	public function toDonVi($int,$madonvi)
	{
		
		$data_donvitinh = $this->getDonViQuyDoi($madonvi);
		//$data_donvitinh = $this->string->swapArray($data_donvitinh);
		foreach($data_donvitinh as $i => $donvitinh)
		{
			$hs = 1;
			for($j = $i;$j<count($data_donvitinh);$j++)
			{
				if($data_donvitinh[$j]['quidoi']!=0)
				{
					$hs *= $data_donvitinh[$j]['quidoi'];
				}
			}
			$data_donvitinh[$i]['soluong'] = floor($int/$hs);
			$int = $int%$hs;
		}
		return $data_donvitinh;
	}
	public function toText($data_donvitinh)
	{
		$arr = array();
		
		foreach($data_donvitinh as $donvitinh)
		{
			if($donvitinh['soluong'])
				$arr[] = $donvitinh['soluong']." ".$donvitinh['tendonvitinh'];
		}
		
		return implode(" - ",$arr);
	}
}
?>