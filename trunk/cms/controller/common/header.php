<?php
	class ControllerCommonHeader extends Controller
	{
		public function index()
		{
			$this->load->model("core/media");
			$this->load->helper('image');
			$this->data['username'] = $this->session->data['username'];
			$this->data['sitename'] = $this->session->data['sitename'];
			$this->data['language'] = $this->getLanguageCBX();
			$fileid = $this->model_core_media->getInformation("setting","logowebsite");
			$file = $this->model_core_file->getFile($fileid);
			$file['thumsnail'] = HelperImage::resizePNG($file['filepath'], 150, 70);
			
			if($fileid)
			{
				$this->data['imagepreview'] = "<img class='png' src='".$file['thumsnail']."' >";
			}
						
			$this->id="header";
			$this->template="common/header.tpl";
			$this->render();
		}
		
		private function getLanguageCBX()
		{
			$this->load->model("common/control");
			$languages = $this->language->getLanguageList();
			$data = array();
			foreach($languages as $lang)
			{
				$data[$lang['code']] = $lang['name'];
			}
			
			$selectedvalue = $this->session->data['language'];
			return $this->model_common_control->getComboboxData("language", $data, $selectedvalue);
		}
		
	}
?>