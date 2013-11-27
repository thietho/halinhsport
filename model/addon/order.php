<?php
class ModelAddonOrder extends Model
{ 
	public function getItem($orderid, $where="")
	{
		$orderid=$this->db->escape(@$orderid);
		$query = $this->db->query("Select `order`.* 
									from `order` 
									where orderid ='".$orderid."' ".$where);
		$data['order'] = $query->row;
		$sql = "Select `order_product`.*,mediaparent,title, imagepath
									from `order_product` , media
									where order_product.mediaid = media.mediaid and orderid = '".$orderid."'";
		$query = $this->db->query($sql);
		$data['detail']=$query->rows;
		return $data;
	}
	
	public function getList($where="", $from=0, $to=5)
	{
		
		$sql = "Select `order`.* 
									from `order` 
									where 1=1 " . $where;
		if($to > 0)
		{
			$sql .= " Limit ".$from.",".$to;
		}
		
		$query = $this->db->query($sql);
		return $query->rows;
	}
	
	private function nextID($prefix)
	{
		return $this->db->getNextIdVarChar("order","orderid",$prefix);	
	}
	
	public function insert($data)
	{
		$date = getdate();
		$orderid= $this->nextID($date['year'].$this->date->numberFormate($date['mon']));
		$orderdate=$this->date->getToday();
		$userid=$this->db->escape(@$data['userid']);
		$customername=$this->db->escape(@$data['customername']);
		$address=$this->db->escape(@$data['address']);
		$email=$this->db->escape(@$data['email']);
		$phone=$this->db->escape(@$data['phone']);
		$status="new";
		$paymenttype=$this->db->escape(@$data['paymenttype']);
		$comment=$this->db->escape(@$data['comment']);
		$receiver=$this->db->escape(@$data['receiver']);
		$receiverphone=$this->db->escape(@$data['receiverphone']);
		$shipper=$this->db->escape(@$data['shipper']);
		$shippername=$this->db->escape(@$data['shippername']);
		$shipperat=$this->db->escape(@$data['shipperat']);
		$notes=$this->db->escape(@$data['notes']);
		
		$field=array(
						'orderid',
						'orderdate',
						'userid',
						'customername',					
						'address',
						'email',
						'phone',
						'status',
						'paymenttype',
						'comment',
						'receiver',
						'receiverphone',
						'shipper',
						'shippername',
						'shipperat',
						'notes'
					);
		$value=array(
						$orderid,
						$orderdate,
						$userid,
						$customername,
						$address,
						$email,
						$phone,
						$status,
						$paymenttype,
						$comment,
						$receiver,
						$receiverphone,
						$shipper,
						$shippername,
						$shipperat,
						$notes
					);
		$this->db->insertData("order",$field,$value);
		return $orderid;
	}
	
	public function update($data)
	{
		$orderid = $this->db->escape(@$data['orderid']);
		
		$userid=$this->db->escape(@$data['userid']);
		$customername=$this->db->escape(@$data['customername']);
		$address=$this->db->escape(@$data['address']);
		$email=$this->db->escape(@$data['email']);
		$phone=$this->db->escape(@$data['phone']);
		
		$comment=$this->db->escape(@$data['comment']);
		$field=array(
						
						'userid',
						'customername',
						'userid',
						'address',
						'email',
						'phone',
						
						'comment'
					);
		$value=array(
						
						$userid,
						$customername,
						$userid,
						$address,
						$email,
						$phone,
						
						$comment
					);
		
		$where="orderid = '".$orderid."'";
		$this->db->updateData('order',$field,$value,$where);
		return true;
	}
	public function updateCol($orderid,$col,$val)
	{
		$orderid = $this->db->escape(@$orderid);
		$col=$this->db->escape(@$col);
		$val=$this->db->escape(@$val);
		$field=array(
						$col	
					);
		$value=array(
						$val
					);
		
		$where="orderid = '".$orderid."'";
		$this->db->updateData('order',$field,$value,$where);
	}
	public function updateStatus($data)
	{
		$orderid = $this->db->escape(@$data['orderid']);
		$status=$this->db->escape(@$data['status']);
		$field=array(
						
						'status'
						
					);
		$value=array(
						
						$status
					);
		
		$where="orderid = '".$orderid."'";
		$this->db->updateData('order',$field,$value,$where);
		
		$his['orderid'] = $orderid;
		$his['userid'] = $this->user->getId();
		$his['status'] = $status;
		$this->model_addon_order->saveOrderHistory($his);
		
		return true;
	}
	
	public function delete($orderid)
	{
		$status="delete";
		$statusdate = $this->date->getToday();
		$statusby=$this->user->getId();
		
		if($orderid != "")
		{
			$sql = "Update `order` set status='".$status."' where orderid = '".$orderid."'";
			$this->db->query($sql);
		}
	}
	
	//order product
	public function getOrderProduct($orderid,$mediaid)
	{
		$orderid=$this->db->escape(@$orderid);
		$mediaid=$this->db->escape(@$mediaid);
		$sql = "Select `order_product`.* 
									from `order_product` 
									where orderid = '".$orderid."' And mediaid='".$mediaid."'";
		$query = $this->db->query($sql);
		return $query->rows;
	}
	
	public function saveOrderProduct($data)
	{
		$orderid=$this->db->escape(@$data['orderid']);
		$mediaid=$this->db->escape(@$data['mediaid']);
		$quantity=$this->string->toNumber($this->db->escape(@$data['quantity']));
		$unit=$this->db->escape(@$data['unit']);
		$price=$this->string->toNumber($this->db->escape(@$data['price']));
		$discount=$this->string->toNumber($this->db->escape(@$data['discount']));
		$subtotal=$quantity*$price*(1 - $discount/100);
		$field=array(
						'orderid',
						'mediaid',
						'quantity',
						'unit',
						'price',
						'discount',
						'subtotal'
					);
		$value=array(
						$orderid,
						$mediaid,
						$quantity,
						$unit,
						$price,
						$discount,
						$subtotal
					);
		$arr=$this->getOrderProduct($orderid,$mediaid);
		if(count($arr)==0)
		{
			$this->db->insertData("order_product",$field,$value);
		}
		else
		{
			$where="orderid = '".$orderid."' And mediaid='".$mediaid."'";
			$this->db->updateData('order_product',$field,$value,$where);
		}
	}
	public function deleteOrderProduct($id)
	{
		$id = @(int)$id;
		$where="id = '".$id."'";
		$this->db->deleteData("order_product",$where);
	}
	
	//order history
	public function getOrderHistory($id)
	{
		$id=$this->db->escape(@$id);
		
		$sql = "Select `order_history`.* 
									from `order_history` 
									where id = '".$id."'";
		$query = $this->db->query($sql);
		return $query->rows;
	}
	public function getOrderHistoryList($where)
	{
		
		$sql = "Select `order_history`.* 
									from `order_history` 
									where 1=1 ".$where;
		$query = $this->db->query($sql);
		return $query->rows;
	}
	public function saveOrderHistory($data)
	{
		$id=$this->db->escape(@$data['id']);
		$orderid=$this->db->escape(@$data['orderid']);
		$userid=$this->db->escape(@$data['userid']);
		$status=$this->db->escape(@$data['status']);
		$actiondate=$this->date->getToday();
		$field=array(
						'id',
						'orderid',
						'userid',
						'status',
						'actiondate'
						
					);
		$value=array(
						$id,
						$orderid,
						$userid,
						$status,
						$actiondate
						
					);
		$arr=$this->getOrderHistory($id);
		if(count($arr)==0)
		{
			$value[0] = $this->db->getNextId("order_history","id");
			$this->db->insertData("order_history",$field,$value);
		}
		else
		{
			$where="id = '".$id."'";
			$this->db->updateData('order_product',$field,$value,$where);
		}
	}
	
	public function deleteOrderHistory($id)
	{
		$id = @(int)$id;
		$where="id = '".$id."'";
		$this->db->deleteData("order_history",$where);
	}
}
?>