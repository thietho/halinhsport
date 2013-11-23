<?php
class ControllerLayoutHome extends Controller
{
	public function index()
	{
		
		$this->data['title'] = $this->document->title;
		$this->data['url'] = HTTP_SERVER.substr($_SERVER[REQUEST_URI],1);
		if($this->document->meta_description == "")
			$this->data['meta_description'] = $this->document->setup['Description']." ".$this->string->chuyenvekodau($this->document->title);
		else
			$this->data['meta_description'] = $this->document->meta_description ;
		if($this->document->meta_keyword == "")
			$this->data['meta_keyword'] = $this->document->setup['Keyword']." ".$this->string->chuyenvekodau($this->document->title);
		else
			$this->data['meta_keyword'] = $this->document->meta_keyword;
		//
		@$arr = split(',',$this->document->meta_image);
		$this->data['meta_image'] = "";
		
		if(count($arr))
		{
			foreach($arr as $item)
			{
				if($item)
					$this->data['meta_image'] .= '<meta content="'.$item.'" property="og:image">';
			}
		}
		
		$this->template="layout/home.tpl";
		$this->children=array(
			'common/header',
			'common/footer'
		);
		$this->render();
	}
}
?>