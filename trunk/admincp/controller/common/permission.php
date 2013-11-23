<?php    
class ControllerCommonPermission extends Controller {    
	
	public function index() {
		
				
	
	}
	
	public function checkPermission() {
		if (isset($this->request->get['route'])) {
			$route = $this->getRoute();
		  
			$part = explode('/', $route);
			
			$ignore = array(
				'page/home',
				'common/login',
				'common/requestpassword',
				'common/logout',
				'common/permission',
				'common/help',
				'common/about',
				'core/cpanel',
				
				'core/user',
				'core/fileadjustment',
				'core/changepassword',
				//'core/file',
				//'core/fileadjust',
				'message/list',
				'message/detail',
				'message/compose',
				'message/selectemail',
				'message/selectuser',
				
				'core/module',
				'core/usertype',
				'media/media',
				'test/receivefilesearch',
				'media/filesearch',
				'media/mediainsertajax'	,
				'core/fileajaxeditor',
				'catalog/productaction',
				'core/sitemap',
				'common/newsaction',
				'core/profile',
				'core/site'
			);
			
			if (!in_array(@$part[0] . '/' . @$part[1], $ignore)) {
				$ModuleID = @$part[0] . '/' . @$part[1];
				
				if(isset($this->request->get['formtype'])){
					$FormType = $this->request->get['formtype'];
				}
				
				if(isset($this->request->post['formtype'])){
					$FormType = $this->request->post['formtype'];
				}
				
				$SiteMapID = $this->request->get['sitemapid'];
				if (!$this->user->hasPermission($ModuleID, $FormType, $SiteMapID)) {
					return $this->forward('error/permission', 'index');
				}
			}
		}
	}
}
?>