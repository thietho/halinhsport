<?php
class ControllerAddonCheckout extends Controller
{
	private $error = array();
	public function index()
	{
		$this->document->breadcrumb .= "Thông tin đơn hàng";
		$this->getList();
		$this->getMemberInfor();
		$this->id="content";
		$this->template="addon/checkout.tpl";
		$this->render();
	}
	
	public function getList()
	{
		$this->data['medias'] =array();
		if(isset($_SESSION['cart']))
		{
			$this->data['medias'] = $_SESSION['cart'];
		}
		
	}
	
	private function getMemberInfor()
	{
		$this->load->model("core/user");
		if($this->member->getId())
		{
			$this->data['member'] = $this->model_core_user->getItem($this->member->getId());
		
			$this->data['readonly'] = 'readonly="readonly"';
		}
	}
	
	public function checkout()
	{
		$data = $this->request->post;
		if($this->validateForm($data))
		{
			$this->load->model("addon/order");
			//Luu thong tin don hang
			$orderid = $this->model_addon_order->insert($data);
			//Luu chi tiet don hang
			foreach($_SESSION['cart'] as $item)
			{
				$detail['orderid'] = $orderid;
				$detail['mediaid'] = $item['mediaid'];
				$detail['quantity'] = $item['qty'];
				$detail['unit'] = $this->document->getMedia($item['mediaid'],'unit');
				$detail['price'] = $item['price'];
				$detail['discount'] = 0;
				$this->model_addon_order->saveOrderProduct($detail);
			}
			unset($_SESSION['cart']);
			//Gui don hang den nguoi nhan lien he
			$arr = array($orderid);
			$description = $this->loadModule('addon/checkoutcomplete','viewOrder',$arr);
			$email = $this->model_core_media->getInformation("setting", 'EmailContact');
			$mail['from'] = $data['email'];
			$mail['FromName'] = $data['customername'];
			$mail['to'] = $email;
			$mail['name'] = "";
			$mail['subject'] =  "Thông tin đặt hàng";
			$arr = array($description);
			$mail['body'] = $this->loadModule('module/contact','createEmailTemplate',$arr);
			$this->mailsmtp->sendMail($mail);
			//Gui don hang den khach hang
			$email = $this->model_core_media->getInformation("setting", 'EmailContact');
			$mail['from'] = "cosmetics@mylanbeauty.net";
			$mail['FromName'] = "Bộ phận bán hàng - ".$this->document->setup['Title'];
			$mail['to'] = $data['email'];
			$mail['name'] = $data['customername'];
			$mail['subject'] =  "Thông tin đặt hàng";
			$arr = array($description);
			$mail['body'] = "<p>".$this->document->setup['Title']." đã nhận được đơn hàng của bạn. Chúng tôi sẻ liên hệ với bạn trong vòng 24h</p>"; 
			$mail['body'] .= $this->loadModule('module/contact','createEmailTemplate',$arr);
			$this->mailsmtp->sendMail($mail);
			
			$this->data['output'] = "true-".$orderid;
		}
		else
		{
			foreach($this->error as $item)
			{
				$this->data['output'] .= $item."<br>";
			}
		}
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
	
	private function validateForm($data)
	{
		
		if(trim($data['customername']) =="")
		{
      		$this->error['customername'] = "Bạn chưa nhập họ tên";
    	}
		
		if ($data['email'] == "") 
		{
      		$this->error['email'] = "Bạn chưa nhập email";
    	}
		else
		{
			if(!$this->validation->_checkEmail($data['email']))
			{
				$this->error['email'] = "Email không đúng định dạng";
			}
		}

		
		
		if (count($this->error)==0) {
	  		return TRUE;
		} else {
	  		return FALSE;
		}
	}
}
?>