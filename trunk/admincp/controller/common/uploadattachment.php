<?php
class ControllerCommonUploadattachment extends Controller
{
	function index()
	{	
		$this->load->helper('image');
		$this->load->model('core/file');
		//$this->data['output'] = json_encode(array('files' => $_FILES));
		$folderid = $this->request->get['folderid'];
		$datas = array();
		//print_r($_FILES['files']['name']);
		foreach($_FILES['files']['name'] as $key => $item)
		{
			if($_FILES['files']['name'][$key] != "")
			{
				$ftemp['name'] = $_FILES['files']['name'][$key];
				$ftemp['type'] = $_FILES['files']['type'][$key];
				$ftemp['tmp_name'] = $_FILES['files']['tmp_name'][$key];
				$ftemp['error'] = $_FILES['files']['error'][$key];
				$ftemp['size'] = $_FILES['files']['size'][$key];
				
				$filepath = "upload/";
				$data['image'] = $this->model_core_file->saveFile($ftemp,$filepath,"any","");
				$this->model_core_file->updateFileCol($data['image']['fileid'],'folderid',$folderid);
				/*if($data['image']['fileid'] == '')
				{
					$arr = array(
						'error' => 'Your upload image is wrong or size of this image more than 2MB!'
					);
					$this->data['output'] = json_encode(array('files' => $arr));
				}
				else*/
				
				{
					$file = $this->model_core_file->getFile($data['image']['fileid']);
					if($this->string->isImage($file['extension']))
					{
						$arr = array(
							'error' => 'none',
							'imageid' => $file['fileid'],
							'imagename' => $file['filename'],
							'imagepath' => $file['filepath'],
							'imagethumbnail' => HelperImage::resizePNG($file['filepath'], 50, 50)
						);
					}
					else
					{
						$arr = array(
							'error' => 'none',
							'imageid' => $file['fileid'],
							'imagename' => $file['filename'],
							'imagepath' => $file['filepath'],
							'imagethumbnail' => DIR_IMAGE."icon/dinhkem.png"
						);
					}
					$datas[] = $arr;
					sleep(1);
					
				}
			}

		}
		$this->data['output'] = json_encode(array('files' => $datas));
		$this->id="uploadpreview";
		$this->template="common/output.tpl";
		$this->render();
	}
	
}
?>