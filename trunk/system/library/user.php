<?php
final class User {
	private $userid;
	private $username;
	private $siteid;
	private $usertypeid;
	public $nhanvien = array();
  	private $permission = array();
	private $Control = array();
	

  	public function __construct() {
		$this->db = Registry::get('db');
		$this->request = Registry::get('request');
		$this->session  = Registry::get('session');
		$this->json  = Registry::get('json');
		$this->string  = Registry::get('string');
		$this->date  = Registry::get('date');
		if($this->request->get['lang'])
		{
			$this->session->set('siteid',$this->request->get['lang']);
		}
		else
		{
			if (!isset($this->session->data['siteid'])) {
				$this->session->set('siteid',SITEID);
			}
		}
		
		$this->siteid = $this->session->data['siteid'];
		
	
    	if (isset($this->session->data['userid'])) {
			$query = $this->db->query("SELECT * FROM user WHERE userid = '" . $this->db->escape($this->session->data['userid']) . "'");
			
			if ($query->num_rows) {
				$this->userid = $query->row['userid'];
				$this->username = $query->row['username'];
				
      			$this->db->query("UPDATE user SET userip = '" . $this->db->escape($this->request->server['REMOTE_ADDR']) . "' WHERE userid = '" . (int)$this->session->data['userid'] . "'");
				$sql = "SELECT permission FROM usertype where usertypeid = (Select usertypeid from user where userid = '" . $this->db->escape($this->session->data['userid']) . "')";
      			$query = $this->db->query($sql);
				$this->setPermission($query->row['permission']);
				$this->nhanvien = $this->getNhanVien();
				
			}elseif(isset($this->session->data['safemode'])){
				$this->userid = $this->session->data['userid'];
				$this->username = $this->session->data['username'];
			} else {
				$this->logout();
			}
    	}
  	}
		
  	public function login($username, $password, $siteid) 
	{
		
		if($username=="" || $password=="")
			return false;
		$sql="SELECT * FROM user WHERE username = '" . $this->db->escape($username) . "' AND password = '" . $this->db->escape(md5($password)) . "' AND status = 'active' AND deletedby = ''";
	   	$query = $this->db->query($sql);
		
    	if ($query->num_rows) 
		{
			$this->session->set('usertypeid',$query->row['usertypeid']);
			$this->session->set('userid',$query->row['userid']);
			$this->session->set('username',$query->row['username']);	
			$this->session->set('siteid',$siteid);
			
			$query = $this->db->query("Select * from `site` where siteid = '".$siteid."'");
			$this->session->set('sitename',$query->row['sitename']);		
			$this->usertypeid = $query->row['usertypeid'];		
			$this->userid = $query->row['userid'];
			$this->username = $query->row['username'];			

      		$query = $this->db->query("SELECT DISTINCT ug.permission FROM user u LEFT JOIN usertype ug ON u.usertypeid = ug.usertypeid WHERE u.userid = '" . (int)$this->session->data['userid'] . "'");

			
	  		$this->setPermission($query->row['permission']);
				
      		return TRUE;
    	} 
		else 
		{
      		return FALSE;
    	}
  	}
	
	public function loginCMS($username, $password) 
	{
		
		if($username=="" || $password=="")
			return false;
		$sql="SELECT * FROM user WHERE username = '" . $this->db->escape($username) . "' AND password = '" . $this->db->escape(md5($password)) . "' AND status = 'active' AND deletedby = ''";
	   	$query = $this->db->query($sql);
		
    	if ($query->num_rows) 
		{
			$this->session->set('usertypeid',$query->row['usertypeid']);
			$this->session->set('userid',$query->row['userid']);
			$this->session->set('cmsuserid',$query->row['userid']);
			$this->session->set('username',$query->row['username']);			
			$this->usertypeid = $query->row['usertypeid'];
			$this->userid = $query->row['userid'];
			$this->username = $query->row['username'];			

      		$query = $this->db->query("SELECT DISTINCT ug.permission FROM user u LEFT JOIN usertype ug ON u.usertypeid = ug.usertypeid WHERE u.userid = '" . (int)$this->session->data['userid'] . "'");


	  		$this->setPermission($query->row['permission']);
			
			if($query->row['usertypeid'] > 1)
			{
				return FALSE;

			}
				
      		return TRUE;
    	} 
		else 
		{
      		return FALSE;
    	}
  	}

	public function logincode($username, $password) 
	{
		
		if($username=="" || $password=="")
			return false;
		$sql="SELECT * FROM user WHERE username = '" . $this->db->escape($username) . "' AND password = '" . $this->db->escape($password) . "' AND status <> 0";
	   	$query = $this->db->query($sql);
		
    	if ($query->num_rows) 
		{
			$this->session->set('userid',$query->row['userid']);
			$this->session->set('username',$query->row['username']);			
			$this->userid = $query->row['userid'];
			$this->username = $query->row['username'];			

      		$query = $this->db->query("SELECT DISTINCT ug.permission FROM user u LEFT JOIN usertype ug ON u.usertypeid = ug.usertypeid WHERE u.userid = '" . (int)$this->session->data['userid'] . "'");

			
	  		$this->setPermission($query->row['permission']);
				
      		return TRUE;
    	} 
		else 
		{
      		return FALSE;
    	}
  	}
	
  	public function logout() {
		unset($_SESSION['safemode']);
		unset($_SESSION['userid']);
		unset($_SESSION['sessionid']);
		unset($this->session->data['sessionid']);
		unset($this->session->data['userid']);	
		$this->userid = '';
		$this->username = '';
		$this->safemode = false;
  	}
	
	public function setPermission($strPermission)
	{
		$this->permission = array();
		
		/*//Lay Mang Permission
		$arr = $this->_getJSONArray($strPermission);
		
		//Lay mang cac module co quyen
		$arrModule = $this->_getModules_Filter($arr);
		
		//Tao mang tung module + quyen & sitemap
		foreach($arrModule as $moduleid)
		{
			$this->permission[$moduleid] = array(
				"Permissions" => $this->_getPermissions($moduleid, $arr),
				"Sitemaps" => $this->_getSitemaps($moduleid, $arr)
			);
		}*/
		
		$this->permission = $this->string->referSiteMapToArray($strPermission);
		
	}

	public function setControl($key, $button)
	{
		$arr = array();
		if(!is_array($button)) {array_push($arr,$button);} else {$arr = $button;}
		$this->Control[$key] = array($arr);
	}
	
	public function getControl()
	{
		return $this->Control;
	}

	public function hasPermission($moduleid, $action) 
	{
		
		if($this->usertypeid == 'admin')
			return true;
		$allow = false;
		if (count($this->permission)) 
		{
			$moduleid = trim($moduleid);
			$action = trim($action);
			foreach($this->permission as $item)
			{
				$arr = split("-",$item);
				if($arr[0] ==$moduleid && $arr[1] == $action )
					$allow = true;
			}
		}
		
		return $allow;
	}
  
  	public function isLogged() {
    	if($this->session->data['userid']){
			$this->usertypeid = $this->session->data['usertypeid'];
			$this->userid = $this->session->data['userid'];
			$this->username = $this->session->data['username'];	
			$this->siteid = $this->session->data['siteid'];		
			return true;
		}
		
		return false;
  	}
	
	public function isCMSLogged() {
    	if($this->session->data['cmsuserid']){
			$this->usertypeid = $this->session->data['usertypeid'];
			$this->userid = $this->session->data['userid'];
			$this->username = $this->session->data['username'];
			
			return true;
		} 
		return false;
  	}
  	
	public function setSessionId($sessionid)
	{
		$this->session->set('sessionid',$sessionid);
	}
	public function getSessionId()
	{
		return $this->session->data['sessionid'];
	}
  	public function getId() {
    	return $this->userid;
  	}
	
	public function getUserTypeId() {
    	return $this->usertypeid;
  	}
	
	public function getSiteId() {
    	return $this->siteid;
  	}
	
  	public function getUserName() {
    	return $this->username;
  	}
	
	public function getPermission() {
		return $this->permission;
	}
	
	public function getLayout()
	{
		
		switch($this->getUserTypeId())
		{
			case 'user':
				$layout="layout/user";
				break;
			case 'admin':
				$layout="layout/center";
		}
		return $layout;
	}
	public function writeLog($detail)
	{
		$logdate = $this->date->getToday();
		$field=array(

						'logdate',
						'detail',
						'userid'
						
						);
						$value=array(

						$logdate,
						$detail,
						$this->userid
						);
						$this->db->insertData("log",$field,$value);

	}

	public function getNhanVien()
	{
		$sql = "Select *
									from `qlknhanvien` 
									where username = '".$this->username."' ";

		$query = $this->db->query($sql);
		return $query->row;
	}
	public function getShop()
	{
		$nhanvien = $this->getNhanVien();
		$staffid = $nhanvien['id'];
		$sql = "Select *
									from `shop_staff` 
									where staffid = '".$staffid."' ";
		$query = $this->db->query($sql);
		
		$shopid = $query->row['shopid'];
		$sql = "Select *
									from `shop` 
									where id = '".$shopid."' ";
		$query = $this->db->query($sql);
		
		return $query->row;
	}
	
	private function getAllModule()
	{
		$sql = "Select *
									from `module`";

		$query = $this->db->query($sql);
		return $query->rows;
	}
	
	public function checkPermission($moduleid)
	{
		if($this->getUserTypeId() == 'admin')
			return true;
		//Nhung module ko co khai bao thi ko can kiem tra
		$data_module = $this->getAllModule();
		$arr_allmodule = $this->string->matrixToArray($data_module,'moduleid');
		if(!in_array($moduleid,$arr_allmodule))
			return true;
		
		$nhanvien = $this->getNhanVien();
		$arr_allowmodule = $this->string->referSiteMapToArray($nhanvien['permission']);
		if(in_array($moduleid,$arr_allowmodule))
			return true;
		else
			return false;
	}
	
	public function getAllowModule()
	{
		$nhanvien = $this->getNhanVien();
		$arr_allowmodule = $this->string->referSiteMapToArray($nhanvien['permission']);
		return $arr_allowmodule;
	}
	
	public function getLogs($where)
	{
		$sql = "Select `log`.*
									from `log` 
									where 1=1 " . $where;

		$query = $this->db->query($sql);
		return $query->rows;
	}
	
//BENGIN PERMISSION JSON
	
	
	//return array
	public function _getJSONArray($strJSON)
	{
		//$this->json  = Registry::get('json');
		$arr = array();
		if($strJSON != "") return $this->json->decode($strJSON);
		return $arr;
	}
	
	//return array
	public function _getModules($arrJSON)
	{
		$arr = array();
		if(count($arrJSON) > 0)
		{
			return $arrJSON[0];
		}
		return $arr;
	}


	public function _getModules_Filter($arrJSON)
	{
		$arr = array();
			
		if(count($arrJSON) > 0)
		{
			
			if(count($arrJSON[0]) > 0)
			{
				foreach($arrJSON[0] as $moduleid)
				{
					$arrP = $this->_getPermissions($moduleid, $arrJSON);
					$arrS = $this->_getSitemaps($moduleid, $arrJSON);
					if(count($arrP) > 0 || count($arrS) > 0)
					{
						array_push($arr, $moduleid);
					}
				}
			}
		}
		return $arr;
	}

	
	//return array
	public function _getPermissions($moduleid, $arrJSON)
	{
		$arr = array();
		
		$arrModule = $this->_getModules($arrJSON);
		
		$index = $this->string->inArray($moduleid, $arrModule) + 1;
		
		if($index > 0 && count($arrJSON[$index][0]) > 0)
		{
			return $arrJSON[$index][0];
		}

		return $arr;
	}
	
	//return array
	public function _getSitemaps($moduleid, $arrJSON)
	{
		$arr = array();
		
		$arrModule = $this->_getModules($arrJSON);
		
		$index = $this->string->inArray($moduleid, $arrModule) + 1;
		
		if($index > 0 && count($arrJSON[$index][1]) > 0)
		{
			return $arrJSON[$index][1];
		}

		return $arr;
	}
//END PERMISSION JSON
	
}
?>