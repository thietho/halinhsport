<?php	
    $file_url = urldecode($_GET['url']);
	//$file = pathinfo($file_url);
   	/*header('Content-Type: application/octet-stream');
    header("Content-Transfer-Encoding: Binary"); 
    header("Content-disposition: attachment; filename=\"".$file['filename'].".".$file['extension']."\""); 
    readfile($file_url);
	
	$filename = $_GET['filename']; */
# 
  
# 

# 

//Kết hợp đường dẫn tới file và tên file để tạo đường dẫn đầy đủ. 
# 
$file = $file_url; 
# 
  
# 
// Kiểm tra xem file có tồn tại không. 
# 
//if(!file_exists($file)) die("I'm sorry, the file doesn't seem to exist."); 
# 
  
# 
// Lấy ra dạng file (đuôi file) 
# 
$fileinfo = pathinfo($file_url);
$type = $fileinfo['extension']; 
# 
  
# 
// lấy ngày hiện tại 
# 
$today = date("F j, Y, g:i a"); 
# 
$time = time(); 
# 

$filename =str_replace(" ","-", $fileinfo['filename'].".".$fileinfo['extension']);
# 
// gởi yêu cầu download tới browser 
# 
header("Content-type: $type"); 
# 
header("Content-Disposition: attachment;filename=$filename"); 
# 
header("Content-Transfer-Encoding: binary"); 
# 
header('Pragma: no-cache'); 
# 
header('Expires: 0'); 
# 
# 
set_time_limit(0); 
# 
readfile($file);  
?>