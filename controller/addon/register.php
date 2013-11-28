<?php
class ControllerAddonRegister extends Controller
{
	private $error = array();
	public function index()
	{
		if($this->member->getId())
			$this->response->redirect($this->document->createLink('memberinfor'));
		$this->document->breadcrumb .= "Đăng ký thành viên";
		$arr = array("dieu-khoan-dang-ky");
		$this->data['dieukhoan'] = $this->loadModule('module/information','index',$arr);
		$this->id="content";
		$this->template="addon/register.tpl";
		$this->render();
	}
	
	public function emailActive($data,$activecode)
	{
		$this->data['member'] = $data;
		$this->data['member']['activecode'] = $activecode;
		
		$this->id="content";
		$this->template="addon/emailactive.tpl";
		$this->render();
	}
	public function save()
	{
		$data = $this->request->post;
		if($this->validateForm($data))
		{
			$this->load->model("core/user");
			$this->load->model("core/media");
			$data['birthday'] = $this->date->formatViewDate($data['birthday']);
			$data['birthdaykids'] = $this->date->formatViewDate($data['birthdaykids']);
			$data['usertypeid'] = "member";
			$this->model_core_user->insertUser($data);
			$this->model_core_user->saveInformation($data['username'], "birthdaykids", $data['birthdaykids']);
			//Gui ma kich hoat vo email cua member
			$activecode = $this->string->generateRandStr(10);
			
			$arr = array($data,$activecode);
			$description = $this->loadModule('addon/register','emailActive',$arr);
			
			$mail['from'] = $this->model_core_media->getInformation("setting", 'EmailContact');
			$mail['FromName'] = $this->model_core_media->getInformation("setting", 'Title');
			$mail['to'] = $data['email'];
			$mail['name'] = $data['fullname'];
			$mail['subject'] =  "Kích hoạt tài khoản";
			//$mail['body'] = "Mã kích hoạt: ".$activecode;
			//$mail['body'].= "<br>Hoặc bạn click vào <a href='".$this->document->createLink('activelink')."?user=".$data['username']."&code=".md5($activecode)."'>link để kích hoạt tài khoản</a>";
			$arr = array($description);
			$mail['body'] = $this->loadModule('module/contact','createEmailTemplate',$arr);
			
			$this->model_core_user->saveInformation($data['username'], "activecode", $activecode);
			
			$this->mailsmtp->sendMail($mail);
			$this->data['output'] = "true";
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
		
		$this->load->model("core/user");
    	if(trim($data['username']) == "")
		{
      		$this->error['username'] = "Bạn chưa nhập tên đăng nhập";
    	}
		else
		{
			if($this->validation->_isId(trim($data['username'])) == false)
				$this->error['username'] ="Username không được có ký tự đặt biệt";
				
			$item = $this->model_core_user->getItem($data['username']);
			if(count($item)>0)
				$this->error['username'] = "Tên đăng nhập đã đươc sử dụng";
			
		}
		if(trim($data['password']) =="")
		{
      		$this->error['password'] = "Bạn chưa nhập mật khẩu";
    	}
		
		if(trim($data['confirmpassword']) =="")
		{
      		$this->error['confirmpassword'] = "Bạn chưa nhập xác nhận mật khẩu";
    	}
		
		if(trim($data['password']) !="" && trim($data['confirmpassword']) !="" ) 
		{
			if($data['password'] != $data['confirmpassword'])
			{
				$this->error['confirmpassword'] = "Xát nhận mật khẩu không đúng";
			}
		}
		
		if(trim($data['fullname']) =="")
		{
      		$this->error['fullname'] = "Bạn chưa nhập họ tên";
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
			else
			{
				$where = "AND email = '".$data['email']."'";
				$users = $this->model_core_user->getList($where);
				if(count($users))
				{
					$this->error['email'] = "Email đã được sử dụng";
				}
			}
		}

		if(trim($data['chkaccept']) =="")
		{
      		$this->error['chkaccept'] = "Bạn chưa đồng ý với chúng tôi";
    	}
		
		if (count($this->error)==0) {
	  		return TRUE;
		} else {
	  		return FALSE;
		}
	}
	
	public function savenhantin()
	{
		$data = $this->request->post;
		if($this->validateFormNhanTin($data))
		{
			$this->load->model("addon/nhantin");
			
			$this->model_addon_nhantin->insert($data);
			
			//Gui thong bao vo mail
			$mail['from'] = "info@halinhsport.com";
			$mail['FromName'] = "Ha Linh Sport";
			$mail['to'] = $data['email'];
			$mail['name'] = $data['hoten'];
			$mail['subject'] =  "Thong bao nhan tin";
			$mail['body'] = "Ban da dang ky nhan tin tu halinhsport.com thanh cong";
			$this->mailsmtp->sendMail($mail);
			
			$this->data['output'] = "true";
		}
		else
		{
			foreach($this->error as $item)
			{
				$this->data['output'] .= $item."\n";
			}
		}
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
	
	private function validateFormNhanTin($data)
	{
		if(trim($data['hoten']) =="")
		{
      		$this->error['hoten'] = "Bạn chưa nhập họ tên";
    	}
		
		if ($data['email'] == "") 
		{
      		$this->error['email'] = "Bạn chưa nhập email";
    	}
		else
		{
			if(!$this->validation->_checkEmail($data['email']))
			{
				$this->error['email'] = "Email không đúng dịnh dạng";
			}
			else
			{
				$this->load->model("addon/nhantin");
				$where = " AND email = '".$data['email']."'";
				$nhantin = $this->model_addon_nhantin->getList($where);
				if(count($nhantin))
				{
					$this->error['email'] = "Email đã được đăng ký";
				}
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