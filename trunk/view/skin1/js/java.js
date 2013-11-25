window.onscroll = Float
function encode(data)
{
	return encodeURIComponent(data);
}

 
function LoadXmlDoc(url,element_id)
{
element=element_id
xmlHttp=GetXmlHttpObject(stateChanged)
xmlHttp.open("GET", url , true)
xmlHttp.send(null)
}
function LoadXmlDocPost(url,data,element_id)
{
data=data+'&ndacheck=1';
element=element_id
xmlHttp=GetXmlHttpObject(stateChanged)
xmlHttp.open("POST", url , true)
xmlHttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded;");
xmlHttp.send(data)
} 

function stateChanged() 
{ 
if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
{
try{document.getElementById(element).innerHTML=xmlHttp.responseXML.getElementsByTagName('data')[0].firstChild.data;
}catch(e)
{
}

try{
	eval(xmlHttp.responseXML.getElementsByTagName('java')[0].firstChild.data)
}
catch(e)
{	
}

}
}


function GetXmlHttpObject(handler)
{ 
var objXmlHttp=null

if (navigator.userAgent.indexOf("Opera")>=0)
{
	objXmlHttp=new XMLHttpRequest()
	objXmlHttp.onload=handler
	objXmlHttp.onerror=handler 
	return objXmlHttp
}
if (navigator.userAgent.indexOf("MSIE")>=0)
{ 
var strName="Msxml2.XMLHTTP"
if (navigator.appVersion.indexOf("MSIE 5.5")>=0)
{
strName="Microsoft.XMLHTTP"
} 
try
{ 
objXmlHttp=new ActiveXObject(strName)
objXmlHttp.onreadystatechange=handler 
return objXmlHttp
} 
catch(e)
{ 
alert("Error. Scripting for ActiveX might be disabled") 
return 
} 
} 
if (navigator.userAgent.indexOf("Mozilla")>=0)
{
objXmlHttp=new XMLHttpRequest()
objXmlHttp.onload=handler
objXmlHttp.onerror=handler 
return objXmlHttp
}
}


function create_get_element_array(array)
{
	var command="data='button="+array[0]+"';";
	var text_array='';
	var logic_array='';
	var select_one_array='';
	var textarea_array='';
	var frame_array='';
	var select_multiple='';
	var select_multiple_innerHTML='';
	var select_multiple_selected='';
	var select_multiple_selected_value='';
	var type;
	var i=0;
	var k=0;
	for (a in array)
	{
		i++;
		if(i>1 & i<=array.length)
		{
			type=document.getElementById(array[a]).type;
			if(type=='text' || type=='hidden' || type=='password')
			{
				command=command+"data=data+'&"+array[a]+"='+encode(document.getElementById('"+array[a]+"').value);";
				text_array=text_array+' '+array[a];
			}
			if(type=='checkbox')
			{
				command=command+"data=data+'&"+array[a]+"='+logic_to_01(document.getElementById('"+array[a]+"').checked);";
				logic_array=logic_array+' '+array[a];
			}
			if(type=='textarea')
			{
				command=command+"data=data+'&"+array[a]+"='+encode(document.getElementById('"+array[a]+"').value);";
				textarea_array=textarea_array+' '+array[a];
			}
			if(!type)
			{
				command=command+"data=data+'&"+array[a]+"='+encode(document.getElementById('"+array[a]+"').contentWindow.document.body.innerHTML);";
				frame_array=frame_array+' '+array[a];
			}
			
			if(type=='select-one')
			{
				command=command+"data=data+'&"+array[a]+"='+document.getElementById('"+array[a]+"').value;";
				select_one_array=select_one_array+' '+array[a];
			}
			if(type=='select-multiple')
			{
				command=command+"data=data+'&"+array[a]+"='+encode(document.getElementById('"+array[a]+"').value);";
				select_multiple=select_multiple+' '+array[a];
				command=command+"data=data+'&"+array[a]+"innerHTML='+encode(document.getElementById('"+array[a]+"').innerHTML);";
				select_multiple_innerHTML=select_multiple_innerHTML+' '+array[a];
				
				select_multiple_selected_value='';
				for (k=0; k<document.getElementById(array[a]).options.length; k++)
				{
						//alert(k);
					if (document.getElementById(array[a]).options[k].selected) {
					select_multiple_selected_value=select_multiple_selected_value+','+document.getElementById(array[a]).options[k].value;
					}
				}
				abc=select_multiple_selected_value;
				select_multiple_selected=select_multiple_selected+' '+array[a];
				command=command+"data=data+'&"+array[a]+"selected='+encode(abc);";
			}

		}
		
	}

	command=command+"data=data+'&text_array='+'"+text_array+"';";
	command=command+"data=data+'&logic_array='+'"+logic_array+"';";
	command=command+"data=data+'&select_one_array='+'"+select_one_array+"';";
	command=command+"data=data+'&textarea_array='+'"+textarea_array+"';";
	command=command+"data=data+'&frame_array='+'"+frame_array+"';";
	command=command+"data=data+'&select_multiple='+'"+select_multiple+"';";
	command=command+"data=data+'&select_multiple_innerHTML='+'"+select_multiple_innerHTML+"';";
	command=command+"data=data+'&select_multiple_selected='+'"+select_multiple_selected+"';";
	return command;

}
function logic_to_01(value)
{
	if(value==true)
	{	
		return 1;
	}else
	{
		return 0;	
	}
}


function submit_form(echo_id,button_id,xml_file,array,postdata)
{
	try{document.getElementById(button_id).disabled=true;}
	catch(e){}

	ele_array=array.split(",");
	
	new_ele_array=new Array();
	new_ele_array[0]=button_id;
	i=0;
	
	if(ele_array.length>0)
	{
		for (a in ele_array)
		{
			i++;
			if(i<ele_array.length+1)
			{
				new_ele_array[i]=ele_array[a];
			}
		}

	}else
	{
		data='';	
	}

	eval(create_get_element_array(new_ele_array));
	data=data+postdata;
	LoadXmlDocPost(xml_file,data,echo_id);
}

function submit_form2(echo_id,button_id,xml_file,divbao,postdata)
{
	var arr = new Array();
	var elestring='';
	var elems = document.getElementById(divbao).getElementsByTagName("*");
	for(var i = 0; i < elems.length; i++)
	{
	  var elem = elems[i];
	  var id = elem.getAttribute("id");
	  var type = elem.type;
	
	  if(type=='text' || type=='hidden' || type=='password')elestring=elestring+','+id;
	  if(type=='select-one')elestring=elestring+','+id;
	  if(type=='textarea')elestring=elestring+','+id;
	  if(type=='checkbox')elestring=elestring+','+id;
	  if(type=='select-multiple')elestring=elestring+','+id;
	  
	}
	elestring=elestring.substr(1)
	
	submit_form(echo_id,button_id,xml_file,elestring,postdata)
}


function Float() {
	if(document.all) {
		try{document.all.common_echo.style.pixelTop=document.documentElement.scrollTop+0;}catch(e){}// try de chong loi chua kip load
	}else
	{
		if(document.layers) {
			try{document.common_echo.top = window.pageYOffset;}catch(e){}
		}
		if(document.getElementById) {
			try{document.getElementById('common_echo').style.top=window.pageYOffset+0 + 'px';}catch(e){}
		}
	}
}

function showecho(ele,timeout,loi)
{
	if(loi!=1)
	{
		document.getElementById(ele).style.background='#0099cc';
	}else
	{
		document.getElementById(ele).style.background='red';
	}
	
	document.getElementById(ele).style.display='none';
	setTimeout("document.getElementById('"+ele+"').style.display='block';",200)
	setTimeout("document.getElementById('"+ele+"').style.display='none';",timeout)
} 
function error_note(ele,echo)
{
	document.getElementById(ele).style.display="inline";
	document.getElementById(ele).innerHTML='( '+echo+' )';
} 

function blink_now(ele)
{
	if(document.getElementById(ele).style.display=="inline")
	{
		document.getElementById(ele).style.display="none";
	}else
	{
		document.getElementById(ele).style.display="inline";
	}
}
function blink_text(ele)
{
	
	try{clearInterval(blink_event)}catch(e){}
	blink_event=setInterval ( "blink_now('"+ele+"')", 700 );
}
function hidden_element(ele)
{
	document.getElementById(ele).style.display="none";
} 
function lay_cookies_menu()
{
	menu_cookie=getCookie('last_click_left_menu');
	if(menu_cookie!='')
	{
		document.getElementById('div_cap2_id_'+menu_cookie).style.display="block";
	}
}

function web_hien_menu_cap2(id)
{
	
	
	if(document.getElementById('div_cap2_id_'+id).style.display!="block")
	{
		setCookie('last_click_left_menu',id,2)
		document.getElementById('div_cap2_id_'+id).style.display="block";
	}else
	{
		setCookie('last_click_left_menu',id,0)
		document.getElementById('div_cap2_id_'+id).style.display="none";
	}
} 

function dichuyendanhmucdiendan(id)
{
	ajaxwin=dhtmlwindow.open('ajaxbox', 'ajax', 'modules/gianhang_diendan/dichuyendanhmucdiendan_pop.php?id='+id, 'Di chuyển danh mục', 'width=600px,height=250px,resize=1,scrolling=1,center=1');

}

function doi_giaodien_nhanh(id,chonsan)
{
	ajaxwin=dhtmlwindow.open('ajaxbox', 'ajax', 'modules/gianhang_quicksetup/chon_pop.php?id='+id+'&chonsan='+chonsan, 'Thay đổi website nhanh', 'width=700px,height=450px,resize=1,scrolling=1,center=1');

}
function doi_id()
{
	ajaxwin=dhtmlwindow.open('ajaxbox', 'ajax', 'modules/gianhang_sanpham/doi_id_pop.php', 'Thay ID sản phẩm', 'width=700px,height=250px,resize=1,scrolling=1,center=1');

}


function chon_an_hien_bo_cuc(id)
{
	ajaxwin=dhtmlwindow.open('ajaxbox', 'ajax', 'modules/gianhang_bocuc/chon_pop.php?id='+id, 'Tùy chọn hiển thị chức năng', 'width=500px,height=320px,resize=1,scrolling=1,center=1');

}


function chon_giaodien_nhanh(id)
{
	if(id==0)return;
	sanpham=document.getElementById('sanpham').checked;
	if(sanpham==true)
	{
		var answer = confirm('Bạn đã chọn tùy chọn xóa sản phẩm, sản phẩm của bạn sẽ bị xóa đi và thay thế bởi trang mẫu, bạn chắc chắn tiếp tục')
		if (answer){
			submit_form('common_echo','button2','modules/gianhang_quicksetup/chon_xml.php?id='+id,'giaodien,logo,slide,nenkhungtren,banner,sanpham,baiviet,diendan,quangcao,menu');
		}else
		{
			ajaxwin.close();	
		}
	
	}else
	{
		submit_form('common_echo','button2','modules/gianhang_quicksetup/chon_xml.php?id='+id,'giaodien,logo,slide,nenkhungtren,banner,sanpham,baiviet,diendan,quangcao,menu');
	
	}
	

}

function sua_seo(id)
{
	ajaxwin=dhtmlwindow.open('ajaxbox', 'ajax', 'modules/gianhang_sanpham/seo_danhmuc_pop.php?id='+id, 'Tối ưu mã nguồn tìm kiếm', 'width=500px,height=200px,resize=1,scrolling=1,center=1');

}

function sua_seo_tin(id)
{
	ajaxwin=dhtmlwindow.open('ajaxbox', 'ajax', 'modules/gianhang_tin/seo_danhmuc_pop.php?id='+id, 'Tối ưu mã nguồn tìm kiếm', 'width=500px,height=200px,resize=1,scrolling=1,center=1');

}

function gop_don_hang()
{
	ajaxwin=dhtmlwindow.open('ajaxbox', 'ajax', 'modules/gianhang_phanhoi/gop_don_hang_pop.php', 'Gộp đơn hàng', 'width=800px,height=250px,resize=1,scrolling=1,center=1');

}

function sua_anh_danhmuc(id)
{
	ajaxwin=dhtmlwindow.open('ajaxbox', 'ajax', 'modules/gianhang_sanpham/sua_anh_danhmuc_pop.php?id='+id, 'Upload ảnh đại diện cho danh mục', 'width=500px,height=200px,resize=1,scrolling=1,center=1');

}

function sua_anh_menutrai(id)
{
	ajaxwin=dhtmlwindow.open('ajaxbox', 'ajax', 'modules/gianhang_sanpham/sua_anh_menutrai_pop.php?id='+id, 'Upload ảnh Icon cho menu ', 'width=500px,height=200px,resize=1,scrolling=1,center=1');

}



function tinhlai_dungluong()
{
	LoadXmlDoc('xml/gianhang_admin/tinhlai_dungluong.php','','');	
}
function gokhoidonhang(id,item_id)
{
	LoadXmlDoc('xml/gianhang_donhang/gokhoidonhang.php?id='+id+'&item_id='+item_id,'','');	
}
function remove_dot(value)
{
	value=value.replace(".", "");
	value=value.replace(".", "");
	value=value.replace(".", "");
	value=value.replace(".", "");
	value=value.replace(".", "");
	value=value.replace(".", "");
	value=value.replace(".", "");
	return value
}
function doi_gia_tri_mac_dinh_style(ele)
{
	ele_id=ele.id;
	document.getElementById('check_'+ele_id).checked=false;
}
 
function luu_bookmarks(name,url)
{
	data='name='+encode(name);
	data=data+'&url='+encode(url);
	LoadXmlDocPost('xml/web_bookmarks/them.php',data,'common_echo')
}

function choncosan(kieu)
{
	if(kieu==1)
	{
		document.getElementById('chontumau').value=1
		document.getElementById("thongtintimkiem").innerHTML=""
	}else
	{
		document.getElementById('chontumau').value=0
		document.getElementById("chongdongsanpham").innerHTML="";
		document.getElementById("chonhang").innerHTML="";	
		
	}
}

function tat_quang_cao(id)
{
	LoadXmlDoc('modules/gianhang_quangcao/tat.php?id='+id,'');	
}

function logout(id)
{
	LoadXmlDoc('xml/web_taikhoan/logout.php','common_echo');	
}

function tham_cap_con_thamdo(id)
{
	LoadXmlDoc('xml/gianhang_thamdo/them_capcon.php?id='+id,'');	
}


function them_danhmuc_diendan(id)
{
	LoadXmlDoc('modules/gianhang_diendan/them_capcon.php?id='+id,'');	
}

   

function gianhang_chon_trangchu_tin_chi_tiet(id)
{
	LoadXmlDoc('xml/gianhang_trangchu/chon_trangchu_tin_chi_tiet.php?id='+id,'common_echo');	
}

function gianhang_xoa_hoidap(id)
{
	var answer = confirm('Xác nhận xóa mục này ?')
	if (answer){
		LoadXmlDoc('xml/gianhang_phanhoi/xoa.php?id='+id,'common_echo');	
	}
}
function gianhang_xoa_tinnhan(id)
{
	var answer = confirm('Xác nhận xóa mục này ?')
	if (answer){
		LoadXmlDoc('xml/gianhang_phanhoi/xoa_tinnhan.php?id='+id,'common_echo');	
	}
}

function gianhang_xoa_backup(file)
{
	var answer = confirm('Xác nhận xóa file này ?')
	if (answer){
		LoadXmlDoc('modules/gianhang_backup/xoa.php?file='+file,'common_echo');	
	}
}



function gianhang_khoi_phuc(file,i)
{
	if(document.getElementById('ok_'+i).value=='ok')
	{

	var answer = confirm('Khôi phục sẽ làm website của bạn trở về trạng thái vào lúc backup, mọi dữ liệu hiện tại sẽ mất, bạn đã chắc chắn ? ')
	if (answer){
		document.getElementById('khoiphuc_'+i).value="Đang khôi phục, bạn vui lòng đợi";
		document.getElementById('khoiphuc_'+i).disabled=true;
		LoadXmlDoc('modules/gianhang_backup/khoiphuc.php?file='+file+'&i='+i,i);
	}
	
	}else
	{
		alert('Bạn vui lòng nhập ok ở ô nhập bên trái nút khôi phục để xác nhận');	
	}
}







function gianhang_xoa_phanhoi_gallery(id)
{
	var answer = confirm('Xác nhận xóa mục này ?')
	if (answer){
		LoadXmlDoc('xml/gianhang_gallery/xoa_phanhoi.php?id='+id,'common_echo');	
	}
}



function xoa_thamdo(id)
{
	var answer = confirm('Xác nhận xóa thăm dò này ?')
	if (answer){
		LoadXmlDoc('xml/gianhang_thamdo/xoa_thamdo.php?id='+id,'common_echo');	
	}
}




function xoa_danhmuc_diendan(id)
{
	var answer = confirm('Xác nhận xóa diễn đàn?')
	if (answer){
		LoadXmlDoc('modules/gianhang_diendan/xoa_danhmuc_xml.php?id='+id,'common_echo');	
	}
}




function gianhang_xoa_tenmien(id)
{
	LoadXmlDoc('modules/gianhang_tenmien/xoa_tenmien.php?id='+id,'common_echo');	
}



function gianhang_xoa_anh_tin(id)
{
	LoadXmlDoc('modules/gianhang_tin/xoa_anh.php?id='+id,'common_echo');	
}

function gianhang_xoa_anh_danhmuc_diendan(id)
{
	LoadXmlDoc('modules/gianhang_diendan/xoa_anh_danhmuc.php?id='+id,'common_echo');	
}



function gianhang_xoa_nen_body(id)
{
	LoadXmlDoc('xml/gianhang_giaodien/xoa_nen_body.php?id='+id,'common_echo');	
}


function gianhang_xoa_nen_khung_tren()
{
	LoadXmlDoc('xml/gianhang_banner/xoa_nen_khung_tren.php','common_echo');	
}



function gianhang_xoa_sanpham(id)
{
	var answer = confirm('Bạn chắc chắn xóa sản phẩm này ?')
	if (answer){
		LoadXmlDoc('modules/gianhang_sanpham/xoa_sanpham.php?id='+id,'common_echo');	
	}
}


function gianhang_xoa_sanpham_no_confim(id)
{
	LoadXmlDoc('modules/gianhang_sanpham/xoa_sanpham.php?id='+id,'common_echo');	
}

function gianhang_xoa_sanpham_xoa_import(id)
{
	LoadXmlDoc('modules/gianhang_sanpham/xoa_sanpham.php?id='+id+'&xoa_import=1','common_echo');	
}

function xoa_anh_dichvu(id)
{
	LoadXmlDoc('xml/xoa_anh_dichvu.php?id='+id,'common_echo');	
}

function xoa_anh_logo(id)
{
	LoadXmlDoc('xml/xoa_anh_logo.php?id='+id,'common_echo');	
}


function gianhang_xoa_menu(id,menu_sua_id)
{
	LoadXmlDoc('xml/gianhang_suamenu/xoa.php?id='+id+'&menu_sua_id='+menu_sua_id,'common_echo');	
}


function gianhang_xoa_bookmark(id)
{
	LoadXmlDoc('xml/web_bookmarks/xoa.php?id='+id,'common_echo');	
}


function thuhepmorong()
{
	if(document.getElementById('tim_kiem_hidden').style.display=="block")
	{
		document.getElementById('tim_kiem_hidden').style.display="none";
		document.getElementById('thuhepmorong').className="morong";
	}else
	{
		document.getElementById('tim_kiem_hidden').style.display="block";
		document.getElementById('thuhepmorong').className="thuhep";
	}
}

function check_all(className,thisele)
{
	var arr = new Array(); 
	var elems = document.getElementsByTagName("*");
	for(var i = 0; i < elems.length; i++)
	{
	  var elem = elems[i];
	  var id = elem.getAttribute("id");
	  if (navigator.userAgent.indexOf("MSIE")>=0)
		{ 
		var cls = elem.getAttribute("className");
		if(cls==null)var cls = elem.getAttribute("class");
		}
		else
		
		{ var cls = elem.getAttribute("class");	}
	  if(cls == className)
	  {
	  	elem.checked=thisele.checked;
	  }
	}
	
}
function xoa_sanpham_dachon()
{
	var answer = confirm('Bạn không thể khôi phục sau khi đã xóa, xác nhận xóa toàn bộ sản phẩm đã này ?')
	if (answer){
		
	
		var arr = new Array(); 
		var elems = document.getElementsByTagName("*");
		for(var i = 0; i < elems.length; i++)
		{
		  var elem = elems[i];
		  var id = elem.getAttribute("id");
		  if (navigator.userAgent.indexOf("MSIE")>=0)
			{ 
			var cls = elem.getAttribute("className");
			if(cls==null)var cls = elem.getAttribute("class");
			}
			else
			
			{ var cls = elem.getAttribute("class");	}
		  if(cls == 'record_check')
		  {
			if(elem.checked)
			{
				gianhang_xoa_sanpham_no_confim((elem.getAttribute("id")).substr(9));	
			}
		  }
		}
		//alert('a');
		//LoadXmlDoc('xml/xoa_anh_logo.php?id='+id,'common_echo');	
	}
}
function xoa_donhang_dachon()
{
	var answer = confirm('Bạn không thể khôi phục sau khi đã xóa, xác nhận xóa toàn bộ đơn hàng này ?')
	if (answer){
		
	
		var arr = new Array(); 
		var elems = document.getElementsByTagName("*");
		for(var i = 0; i < elems.length; i++)
		{
		  var elem = elems[i];
		  var id = elem.getAttribute("id");
		  if (navigator.userAgent.indexOf("MSIE")>=0)
			{ 
			var cls = elem.getAttribute("className");
			if(cls==null)var cls = elem.getAttribute("class");
			}
			else
			
			{ var cls = elem.getAttribute("class");	}
		  if(cls == 'record_check')
		  {
			if(elem.checked)
			{
				gianhang_xoa_donhang_no_confirm((elem.getAttribute("id")).substr(9));	
			}
		  }
		}
		//alert('a');
		//LoadXmlDoc('xml/xoa_anh_logo.php?id='+id,'common_echo');	
	}
}
function tab_click(tab_id,element,tab_group,hover_class,current_class,back_class)
{
	className='tab_'+tab_group;
	var arr = new Array(); 
	var elems = document.getElementsByTagName("*");
	for(var i = 0; i < elems.length; i++)
	{
	  var elem = elems[i];
	  var id = elem.getAttribute("id");
	  if (navigator.userAgent.indexOf("MSIE")>=0)
		{ 
		var cls = elem.getAttribute("className");
		if(cls==null)var cls = elem.getAttribute("class");
		}
		else
		
		{ var cls = elem.getAttribute("class");	}
	  if(cls == className)
	  {
	  	arr[arr.length] = id;
		
		 elem.style.display="none";
	  }
	}

	document.getElementById('tab_'+tab_group+tab_id).style.display="block";
	chuyen_header_tab_click(element,tab_group,hover_class,current_class,back_class);

}


function chuyen_header_tab_click(ele,tab_group,hover_class,current_class,back_class)
{
	className=current_class;
	var arr = new Array(); 

	var elems = document.getElementById(tab_group).getElementsByTagName("*");


	for(var i = 0; i < elems.length; i++)
	{
	  var elem = elems[i];
	  var id = elem.getAttribute("id");
	  if (navigator.userAgent.indexOf("MSIE")>=0)
		{ var cls = elem.getAttribute("className");}
		if(cls==null)var cls = elem.getAttribute("class");
		else
		{ var cls = elem.getAttribute("class");	}
	  if(cls == className)
	  {
		arr[arr.length] = id;
		
		 elem.className=back_class;
	  }
	}

	ele.className=current_class;
}



function hover_tab(ele,hover_class,current_class,back_class)
{
	if(ele.className==back_class)
	{
		ele.className=hover_class;
	}
}


function out_tab(ele,hover_class,current_class,back_class)
{
	if(ele.className==hover_class)
	{
		ele.className=back_class;
	}
}



function tab_phan_hoi(tab_id)
{
	document.getElementById('phanhoi_tab1').className="last";
	document.getElementById('phanhoi_tab2').className="last";
	document.getElementById('phanhoi_tab'+tab_id).className="active";
	document.getElementById('nut_gui_phan_hoi1').style.display="none";
	document.getElementById('nut_gui_phan_hoi2').style.display="none";
	document.getElementById('nut_gui_phan_hoi'+tab_id).style.display="block";
}


function open_asset(folder,editor_name,type,class_name,select_content)
{
	if(!folder)folder='';
	if(!editor_name)editor_name='';
	if(!class_name)class_name='';
	var curent_file='';

	if(select_content!='')
	{
		var myArray = select_content.split('src="'); 
		if(myArray[1]!='')
		{
			myArray=myArray[1].split('"');
			curent_file=myArray[0];
		}
	}

	window.open('asset_manager.php?editor_name='+editor_name+'&type='+type+'&class='+class_name+'&curent_file='+curent_file,'mywindow','width=800,height=675');
}


function open_asset_select_folder(folder)
{
	window.open('asset_manager.php?folder='+folder+'&sele_folder=1&type=image','mywindow','width=800,height=535');
}


function insert_img(path,file,ele,class_name,option)
{
	if(file=='')
	{
		alert('Bạn vui lòng chọn file ở khung bên phải');
	}else
	{
		if(class_name!='')
		{
			tinyMCE.get(ele).selection.setContent('<span class="'+class_name+'"><img '+option+' src="'+path+file+'" /></span>');
		}else
		{
			tinyMCE.get(ele).selection.setContent('<img '+option+'  src="'+path+file+'" />');
		}
	}
}

function insert_file(path,file,ele)
{
	if(file=='')
	{
		alert('Bạn vui lòng chọn file ở khung bên phải');
	}else
	{
		tinyMCE.get(ele).selection.setContent('<a href="'+path+file+'">'+file+'</a>');
	}
}



function insert_flash(path,file,ele,width,height,option)
{
	if(file=='')
	{
		alert('Bạn vui lòng chọn file ở khung bên phải');
	}else
	{
		html= '<object '+option+' class="flash_preview" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,28,0" width="'+width+'" height="'+height+'"><param name="movie" value="'+path+file+'" /><param name="quality" value="high" /> <param name="wmode" value="opaque" /> <embed src="'+path+file+'" quality="high" pluginspage="http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash" type="application/x-shockwave-flash" width="'+width+'" height="'+height+'" wmode="opaque" ></embed></object>';
		tinyMCE.get(ele).selection.setContent(html);
	}
}



function gianhang_gui_phan_hoi(gh)
{
	try{value=tinyMCE.get('des').getContent();}catch(e){alert('Bạn vui lòng nhập nội dung phản hồi !');}
	
	
	data='des='+encode(value);
	try{data=data+'&phanhoi_email='+document.getElementById('phanhoi_email').value;}catch(e){}
	try{data=data+'&phanhoi_dienthoai='+document.getElementById('phanhoi_dienthoai').value;}catch(e){}
	LoadXmlDocPost('xml/gianhang_phanhoi/them.php?gh='+gh,data,'nut_ket_qua_tin_nhan')
}




function gianhang_gui_tin_nhan(id,gh,loai)
{
	try{value=tinyMCE.get('des').getContent();}catch(e){}
	
	
	data='des='+encode(value);
	try{data=data+'&email='+document.getElementById('email').value;}catch(e){}
	try{data=data+'&nguoigui='+document.getElementById('nguoigui').value;}catch(e){}
 	document.getElementById("nut_gui_phan_hoi2").disabled=true;
	LoadXmlDocPost('xml/gianhang_phanhoi/guitinnhan.php?gh='+gh+'&id='+id+'&loai='+loai,data,'nut_ket_qua_tin_nhan')
}



function gianhang_gui_comment(id,gh,loai)
{
	try{value=tinyMCE.get('des').getContent();}catch(e){}
	data='des='+encode(value);
	try{data=data+'&email='+document.getElementById('email').value;}catch(e){}
	try{data=data+'&nguoigui='+document.getElementById('nguoigui').value;}catch(e){}
	
 	document.getElementById("nut_gui_phan_hoi1").disabled=true;
	LoadXmlDocPost('xml/gianhang_phanhoi/gui_comment.php?gh='+gh+'&id='+id+'&loai='+loai,data,'ket_qua_phanhoi')
}




function gianhang_gui_phan_hoi_traloi(id,gh)
{
	data='phanhoi_traloi_noidung='+document.getElementById('phanhoi_traloi_noidung').value;
	data=data+'&phanhoi_traloi_dienthoai='+document.getElementById('phanhoi_traloi_dienthoai').value;
	data=data+'&phanhoi_traloi_email='+document.getElementById('phanhoi_traloi_email').value;
	LoadXmlDocPost('xml/gianhang_phanhoi/traloi.php?id='+id+'&gh='+gh,data,'thongbao_phanhoi')
}

function gianhang_gui_traloi_dongy(id,gh,loai)
{
	data='phanhoi_traloi_noidung='+document.getElementById('phanhoi_traloi_noidung').value;
	data=data+'&phanhoi_traloi_nguoigui='+document.getElementById('phanhoi_traloi_nguoigui').value;
	data=data+'&phanhoi_traloi_email='+document.getElementById('phanhoi_traloi_email').value;
	LoadXmlDocPost('xml/gianhang_phanhoi/traloi.php?id='+id+'&gh='+gh+'&loai='+loai,data,'thongbao_phanhoi')
}



function web_guiphanhoi(id)
{
	data='phanhoi_noidung='+document.getElementById('phanhoi_noidung').value;
	data=data+'&phanhoi_dienthoai='+document.getElementById('phanhoi_dienthoai').value;
	data=data+'&phanhoi_email='+document.getElementById('phanhoi_email').value;
	data=data+'&phanhoi_ten='+document.getElementById('phanhoi_ten').value;
	data=data+'&phanhoi_website='+document.getElementById('phanhoi_website').value;

	LoadXmlDocPost('xml/web_tin/phanhoi.php?id='+id,data,'thongbao_phanhoi')
}


function submit_sua_trang_lien_he()
{
	value=tinyMCE.get('detail').getContent();
	data='value='+encode(value);
	LoadXmlDocPost('modules/gianhang_mic/form_lienhe_xml.php',data,'common_echo')
}


function submit_sua_hoidap(id)
{
	value=tinyMCE.get('detail').getContent();
	data='value='+encode(value);
	LoadXmlDocPost('modules/gianhang_phanhoi/sua_hoidap_xml.php?id='+id,data,'common_echo')
}

function submit_sua_chan_website()
{
	value=tinyMCE.get('detail').getContent();
	data='value='+encode(value);
	LoadXmlDocPost('modules/gianhang_mic/chanwebsite_xml.php',data,'common_echo')
}


function submit_baivietchung()
{
	value=tinyMCE.get('detail').getContent();
	value2=tinyMCE.get('des').getContent();
	value3=tinyMCE.get('ghichu').getContent();
	value4=tinyMCE.get('ghichu2').getContent();
	value5=tinyMCE.get('ghichu3').getContent();

	data='value='+encode(value);
	data=data+'&value2='+encode(value2);
	data=data+'&value3='+encode(value3);
	data=data+'&value4='+encode(value4);
	data=data+'&value5='+encode(value5);

	LoadXmlDocPost('modules/gianhang_sanpham/baivietchung_xml.php',data,'common_echo')
}


function submit_baiviettin()
{
	value=tinyMCE.get('des').getContent();
	value2=tinyMCE.get('detail').getContent();

	data='value='+encode(value);
	data=data+'&value2='+encode(value2);

	LoadXmlDocPost('modules/gianhang_tin/baivietchung_xml.php',data,'common_echo')
}

function submit_html_khungtren()
{
	value=tinyMCE.get('detail').getContent();
	data='value='+encode(value);
	LoadXmlDocPost('modules/gianhang_mic/html_khungtren_xml.php',data,'common_echo')
}



function submit_sua_lienhe_nho()
{
	value=tinyMCE.get('detail').getContent();
	data='value='+encode(value);
	LoadXmlDocPost('xml/gianhang_admin/lienhenho_sua.php',data,'common_echo')
}



function gianhang_congdong_them_baimoi()
{
	value=tinyMCE.get('detail').getContent();
	data='detail='+encode(value);
	data=data+'&name='+document.getElementById('name').value;
	data=data+'&danhmuc='+document.getElementById('danhmuc').value;
	
	LoadXmlDocPost('modules/gianhang_congdong/them_baimoi.php',data,'common_echo')
}



function gianhang_congdong_gui_phanhoi(id)
{
	document.getElementById("nut_gui_phan_hoi_dien_dan").disabled=true;
	value=tinyMCE.get('detail').getContent();
	data='detail='+encode(value);
	LoadXmlDocPost('modules/gianhang_congdong/gui_phanhoi.php?id='+id,data,'common_echo')
}



function submit_sua_popup()
{
	value=tinyMCE.get('detail').getContent();
	data='value='+encode(value);
	LoadXmlDocPost('xml/gianhang_admin/sua_popup.php',data,'common_echo')
}



function submit_sua_chuchay()
{
	value=tinyMCE.get('detail').getContent();
	data='value='+encode(value);
	LoadXmlDocPost('modules/gianhang_chuchay/sua_xml.php',data,'common_echo')
}


function submit_sua_lienhe()
{
	value=tinyMCE.get('lienhe').getContent();
	data='value='+encode(value);
	
	LoadXmlDocPost('xml/gianhang_phanhoi/gianhang_sua_lienhe.php',data,'common_echo')
}



function sua_topic(id)
{

	detail=encode(tinyMCE.get('detail').getContent());

	data='detail='+detail;
 	data=data+'&name='+document.getElementById('name').value;
	
	LoadXmlDocPost('modules/gianhang_congdong/sua_topic.php?id='+id,data,'common_echo')
}

function sua_comment(id)
{

	detail=encode(tinyMCE.get('detail').getContent());

	data='detail='+detail;
 	
	LoadXmlDocPost('modules/gianhang_congdong/sua_comment_xml.php?id='+id,data,'common_echo')
}


function gianhang_sua_diendan(id)
{
	des=encode(tinyMCE.get('des').getContent());

	data='des='+des;
	data=data+'&name='+encode(document.getElementById('tieudetin').value);
	
	LoadXmlDocPost('modules/gianhang_diendan/suamotadanhmuc_xml.php?id='+id,data,'common_echo')
}



function gianhang_sua_html_diendan(id)
{
	des=encode(tinyMCE.get('des').getContent());
	data='des='+des;
	LoadXmlDocPost('modules/gianhang_diendan/suahtml_xml.php?id='+id,data,'common_echo')
}



function gianhang_sua_tin(id)
{
	des=encode(tinyMCE.get('des').getContent());
	detail=encode(tinyMCE.get('detail').getContent());

	data='des='+des;
	data=data+'&detail='+detail;
	data=data+'&name='+encode(document.getElementById('tieudetin').value);
	data=data+'&date_modi='+encode(document.getElementById('date_modi').value);
	data=data+'&title='+encode(document.getElementById('title').value);
	data=data+'&description='+encode(document.getElementById('description').value);
	data=data+'&keywords='+encode(document.getElementById('keywords').value);
	data=data+'&danhmuc='+document.getElementById('danhmuc').value;
	
	LoadXmlDocPost('modules/gianhang_tin/suatinchitiet.php?id='+id,data,'common_echo')
}


function gianhang_sua_sanpham_danhmuc_noidung(id)
{
 	detail=encode(tinyMCE.get('detail').getContent());

	data='detail='+detail;

	LoadXmlDocPost('modules/gianhang_sanpham/sua_danhmuc_noidung.php?id='+id,data,'common_echo')
}

function gianhang_sua_sanpham_danhmuc_htmltrangchu(id)
{
 	detail=encode(tinyMCE.get('detail').getContent());

	data='detail='+detail;

	LoadXmlDocPost('modules/gianhang_sanpham/sua_danhmuc_htmltrangchu.php?id='+id,data,'common_echo')
}

function gianhang_sua_tin_danhmuc_htmltrangchu(id)
{
 	detail=encode(tinyMCE.get('detail').getContent());

	data='detail='+detail;

	LoadXmlDocPost('modules/gianhang_tin/sua_danhmuc_htmltrangchu.php?id='+id,data,'common_echo')
}




function gianhang_suaten(id_sanpham)
{
	name=encode(document.getElementById('name').value);
	data='name='+name;
	LoadXmlDocPost('modules/gianhang_sanpham/suaten.php?id_sanpham='+id_sanpham,data,'common_echo');
	
	//update_search_sanpham(id_sanpham);
}

function gianhang_suaseo(id_sanpham)
{
	title=encode(document.getElementById('title').value);
	keywords=encode(document.getElementById('keywords').value);
	description=encode(document.getElementById('description').value);
	data='title='+title;
	data=data+'&keywords='+keywords;
	data=data+'&description='+description;
	LoadXmlDocPost('modules/gianhang_sanpham/suaseo.php?id_sanpham='+id_sanpham,data,'common_echo');
	
	//update_search_sanpham(id_sanpham);
}


function gianhang_suaurl(id_sanpham)
{
	url=encode(document.getElementById('url').value);
 	data='url='+url;
	LoadXmlDocPost('modules/gianhang_sanpham/suaurl.php?id_sanpham='+id_sanpham,data,'common_echo');
	
	//update_search_sanpham(id_sanpham);
}

function gianhang_luu_tom_tat(id_sanpham)
{
	
	des=encode(document.getElementById('suatomtat').value);
	data='des='+des;
	
	LoadXmlDocPost('modules/gianhang_sanpham/suatomtat.php?id_sanpham='+id_sanpham,data,'common_echo');
}



function web_them_sanpham(sid)
{
	detail=encode(tinyMCE.get('detail').getContent());
	submit_form2('common_echo','nut','modules/gianhang_sanpham/them_xml.php?sid='+sid,'div_dang_tin','&detail='+detail);
}


function web_import_sanpham(sid)
{
	submit_form2('common_echo','nut','modules/gianhang_sanpham/import_upload.php','div_dang_tin');
}

function web_import_sanpham_mot_sp(sid)
{
	submit_form2('common_echo','nut2','modules/gianhang_sanpham/import_upload.php?mot_sp=1','div_dang_tin');
}


function gallery_import(sid)
{
	submit_form2('common_echo','nut','xml/gianhang_gallery/import.php','div_dang_tin');
}


function web_them_dichvu(sid)
{
	detail=encode(tinyMCE.get('detail').getContent());
	submit_form2('common_echo','nut','xml/web_dichvu/dichvu_them.php?sid='+sid+'&detail='+detail,'div_dang_tin');
}

// Replaces all instances of the given substring.
String.prototype.replaceAll = function(
strTarget, // The substring you want to replace
strSubString // The string you want to replace in.
){
var strText = this;
var intIndexOfMatch = strText.indexOf( strTarget );
 
// Keep looping while an instance of the target string
// still exists in the string.
while (intIndexOfMatch != -1){
// Relace out the current instance.
strText = strText.replace( strTarget, strSubString )
 
// Get the index of any next matching substring.
intIndexOfMatch = strText.indexOf( strTarget );
}
 
// Return the updated string with ALL the target strings
// replaced out with the new substring.
return( strText );
}
function gianhang_sua_chitiet_sanpham(id_sanpham)
{
	detail=getText();
	detail=detail.replaceAll('mce:', '');
	detail=detail.replaceAll('_mce_', '');
	
	data='detail='+encode(detail);
	LoadXmlDocPost('modules/gianhang_sanpham/suachitiet.php?id_sanpham='+id_sanpham,data,'common_echo')
}


function getText(){
	
	//tinymce
    var content = "", body = tinyMCE.activeEditor.getDoc().body;
	/*
    if (body.textContent) {
        // Mozilla (Gecko)
    }
    if (body.innerText) {
        // Internet Explorer
        content = body.innerText;    }
    if (content == "") {
        // other browsers
        content = tinyMCE.activeEditor.getContent();
    }*/
 	 //  content = content.replace(/<\/?[^>]+>/g, "");
        
	content = body.innerHTML;
    return content;
}


function gianhang_chon_danh_muc_ok(id,menu_sua_id)
{
	value=document.getElementById('danhmucid').value;
	if(value==""){alert('Bạn vui lòng chọn cấp danh mục cuối cùng');return}
	
	LoadXmlDoc('xml/gianhang_suamenu/gianhang_suamenu_capnhat_danhmuc_sanpham.php?id='+id+'&menu_sua_id='+menu_sua_id+'&value='+value,'common_echo');	

	ajaxwin.close(); return false;
}


function gianhang_quangcao_html(id)
{
	detail=getText();
	data='detail='+encode(detail);
	LoadXmlDocPost('modules/gianhang_quangcao/capnhat_html.php?id='+id,data,'common_echo')
}



function chon_ss_ok(id,menu_sua_id)
{
	value=document.getElementById('danhmucid').value;
	if(value==""){alert('Bạn vui lòng chọn cấp cuối cùng');return}
	
	LoadXmlDoc('xml/gianhang_suamenu/gianhang_suamenu_capnhat_ss_sanpham.php?id='+id+'&menu_sua_id='+menu_sua_id+'&value='+value,'common_echo');	

	ajaxwin.close(); return false;
}


function chon_danh_muc_cap2_ok(dm_id,id,menu_sua_id)
{
	LoadXmlDoc('xml/gianhang_suamenu/gianhang_suamenu_capnhat_danhmuc_con.php?id='+id+'&dm_id='+dm_id+'&menu_sua_id='+menu_sua_id,'common_echo');	
	ajaxwin.close();
}

function doi_vi_tri_danh_muc(id,menu_sua_id)
{
	LoadXmlDoc('xml/gianhang_suamenu/gianhang_suamenu_doivitri_danhmuc_tuhienthi.php?id='+id+'&menu_sua_id='+menu_sua_id,'common_echo');	
}

function gianhang_mo_rong(id,menu_sua_id)
{
	LoadXmlDoc('xml/gianhang_suamenu/mo_rong.php?id='+id+'&menu_sua_id='+menu_sua_id,'common_echo');	
}

function tin_dm_hientrangchutab(id)
{
	LoadXmlDoc('xml/gianhang_tin/hientrangchutab.php?id='+id,'common_echo');	
}


function tin_dm_hientrangchutin(id)
{
	LoadXmlDoc('xml/gianhang_tin/hientrangchutin.php?id='+id,'common_echo');	
}


function gallery_dm_hientrangchu(id)
{
	LoadXmlDoc('xml/gianhang_gallery/hientrangchu.php?id='+id,'common_echo');	
}


function gianhang_sua_logic(id,logic_id,image_id)
{
	LoadXmlDoc('modules/gianhang_sanpham/sua_logic_xml.php?id='+id+'&logic_id='+logic_id+'&image_id='+image_id,'common_echo');	
}

function doi_kieu_menu_trai(value)
{
	LoadXmlDoc('xml/gianhang_suamenu/doi_kieu_menu_trai.php?value='+value,'common_echo');	
}



function gianhang_sua_logic_tin(id,logic_id)
{
	LoadXmlDoc('xml/gianhang_tin/sua_logic.php?id='+id+'&logic_id='+logic_id,'common_echo');	
}




function gianhang_chon_loai_banner(value)
{
	LoadXmlDoc('modules/gianhang_banner/chon_loai_banner.php?value='+value,'common_echo');	
}

function gianhang_chon_hieu_ung_flash(value)
{
	LoadXmlDoc('modules/gianhang_banner/chon_hieu_ung_flash.php?value='+value,'common_echo');	
}



function tatbatchedoquanly(value)
{
	LoadXmlDoc('xml/chedoquanly/tatbatchedoquanly.php?value='+value,'common_echo');	
}


function tatbatchedoquanlyquangcao(value)
{
	LoadXmlDoc('xml/chedoquanly/tatbatchedoquanlyquangcao.php?value='+value,'common_echo');	
}



function doi_hien_thi(id,menu_sua_id)
{
	LoadXmlDoc('xml/gianhang_suamenu_doihienthi.php?id='+id+'&menu_sua_id='+menu_sua_id,'common_echo');	
}


function doi_hien_thi_danhmuc(id)
{
	LoadXmlDoc('modules/gianhang_sanpham/danhmuc_doihienthi.php?id='+id,'common_echo');	
}




function doi_hien_thi_capcon(id,menu_sua_id)
{
	LoadXmlDoc('xml/gianhang_suamenu_doihienthicapcon.php?id='+id+'&menu_sua_id='+menu_sua_id,'common_echo');	
}




function gianhang_target(id,menu_sua_id)
{
	LoadXmlDoc('xml/gianhang_suamenu/target.php?id='+id+'&menu_sua_id='+menu_sua_id,'common_echo');	
}




function doikieumenu(id,value,menu_sua_id)
{
	LoadXmlDoc('xml/gianhang_suamenu/doikieu.php?id='+id+'&value='+value+'&menu_sua_id='+menu_sua_id,'common_echo');	
}
function doi_nick_loai(id,value)
{
	LoadXmlDoc('modules/gianhang_nick/loai.php?id='+id+'&value='+value,'common_echo');	
}
function doi_quangcao_loai(id,value)
{
	LoadXmlDoc('modules/gianhang_quangcao/doi_loai_xml.php?id='+id+'&value='+value,'common_echo');	
}

function doi_quangcao_vitri_tuychinh(id,value)
{
	LoadXmlDoc('modules/gianhang_quangcao/doi_vitri_tuychinh_xml.php?id='+id+'&value='+value,'common_echo');	
}

function doi_quangcao_vitri_macdinh(id,value)
{
	LoadXmlDoc('modules/gianhang_quangcao/doi_vitri_macdinh_xml.php?id='+id+'&value='+value,'common_echo');	
}

function gianhang_doi_kieu_quang_cao(value,id)
{
	LoadXmlDoc('modules/gianhang_quangcao/doi_kieu_quang_cao_xml.php?id='+id+'&value='+value,'common_echo');
}
	
	


function doi_id_trang(id,value)
{
	LoadXmlDoc('xml/gianhang_doi_id_trang.php?id='+id+'&value='+value,'common_echo');	
}

function gianhang_doi_danh_muc_tin(id,id_dm,menu_sua_id)
{
	LoadXmlDoc('xml/gianhang_suamenu/doi_danhmuctin.php?id='+id+'&id_dm='+id_dm+'&menu_sua_id='+menu_sua_id,'common_echo');	
}

function gianhang_doi_danh_muc_gallery(id,id_dm,menu_sua_id)
{
	LoadXmlDoc('xml/gianhang_suamenu/doi_danhmucgallery.php?id='+id+'&id_dm='+id_dm+'&menu_sua_id='+menu_sua_id,'common_echo');	
}

function gianhang_menu_doi_danhmuc(id,id_dm,menu_sua_id)
{
	LoadXmlDoc('xml/gianhang_suamenu/doi_danhmuc.php?id='+id+'&id_dm='+id_dm+'&menu_sua_id='+menu_sua_id,'common_echo');	
}


function gianhang_doi_danh_muc_dichvu(id,id_dm,menu_sua_id)
{
	LoadXmlDoc('xml/gianhang_suamenu/gianhang_suamenu_danhmucdichvu.php?id='+id+'&id_dm='+id_dm+'&menu_sua_id='+menu_sua_id,'common_echo');	
}


function gianhang_doi_dichvu(id,id_dm,menu_sua_id)
{
	LoadXmlDoc('xml/gianhang_suamenu/gianhang_suamenu_dichvu.php?id='+id+'&id_dm='+id_dm+'&menu_sua_id='+menu_sua_id,'common_echo');	
}


function xoa_nick(id)
{
	LoadXmlDoc('modules/gianhang_nick/xoa_nick.php?id='+id,'common_echo');	
	
}


function xoa_tin_danhmuc(id)
{
	var answer = confirm('Nếu danh mục này chứa các bài viết,các bài viết sẽ không có danh mục mẹ, bạn cần chọn lại danh mục mẹ cho các bài viết, bạn đã chắc chắn xóa danh mục này ?')
	if (answer){
		LoadXmlDoc('xml/gianhang_tin/xoa_danhmuc.php?id='+id,'common_echo');	
	}
	
}

function xoa_gallery_danhmuc(id)
{
	var answer = confirm('Nếu danh mục này chứa các ảnh,các ảnh sẽ không có danh mục mẹ, bạn cần chọn lại danh mục mẹ cho các ảnh, bạn đã chắc chắn xóa danh mục này ?')
	if (answer){
		LoadXmlDoc('xml/gianhang_gallery/xoa_danhmuc.php?id='+id,'common_echo');	
	}
	
}

function xoa_danhmuc(id)
{
	var answer = confirm('Bạn đã chắc chắn xóa danh mục này ?')
	if (answer){
		LoadXmlDoc('modules/gianhang_sanpham/xoa_danhmuc.php?id='+id,'common_echo');	
	}
	
}


function sapxep_sanpham_khach(id,order_mask)
{
	order=document.getElementById('suasapxep_khach_'+id+order_mask).value;
	LoadXmlDoc('xml/gianhang_sanpham/sapxep_sanpham.php?id='+id+'&order='+order,'common_echo');	
}



function luu_gia_sanpham(id)
{
	price=document.getElementById('price').value;
	
	LoadXmlDoc('modules/gianhang_sanpham/luu_gia_sanpham.php?id='+id+'&price='+price,'common_echo');	
}

function luu_gia2_sanpham(id)
{
	price=document.getElementById('price2').value;
	
	LoadXmlDoc('modules/gianhang_sanpham/luu_gia_sanpham2.php?id='+id+'&price='+price,'common_echo');	
}


function gianhang_luu_baohanh(id)
{
	baohanh=encode(document.getElementById('baohanh').value);
	data='baohanh='+baohanh;
	LoadXmlDocPost('modules/gianhang_sanpham/sua_baohanh.php?id='+id,data,'common_echo')
}


function covert_deal()
{
	dealcon=encode(document.getElementById('dealcon').value);
	price=encode(document.getElementById('price').value);
	LoadXmlDoc('modules/gianhang_sanpham/covert_deal.php?value='+dealcon+'&price='+price,'common_echo')
}


function gianhang_luu_deal(id,value)
{
	LoadXmlDoc('modules/gianhang_sanpham/sua_deal.php?id='+id+'&value='+value,'common_echo')
}


function gianhang_luu_deal_time(id)
{
	dealtime=encode(document.getElementById('dealtime').value);
	data='dealtime='+dealtime;
	LoadXmlDocPost('modules/gianhang_sanpham/sua_dealtime.php?id='+id,data,'common_echo')
}


function gianhang_luu_deal_value(id)
{
	dealvalue=encode(document.getElementById('dealvalue').value);
	data='dealvalue='+dealvalue;
	LoadXmlDocPost('modules/gianhang_sanpham/sua_dealvalue.php?id='+id,data,'common_echo')
}


function gianhang_luu_deal_songuoimua(id)
{
	dealvalue=encode(document.getElementById('dealmua').value);
	data='dealmua='+dealvalue;
	LoadXmlDocPost('modules/gianhang_sanpham/sua_dealmua.php?id='+id,data,'common_echo')
}

function gianhang_luu_khuyenmai(id)
{
	khuyenmai=encode(document.getElementById('khuyenmai').value);
	data='khuyenmai='+khuyenmai;
	LoadXmlDocPost('modules/gianhang_sanpham/sua_khuyenmai.php?id='+id,data,'common_echo')
}

function gianhang_luu_thuoctinhphu(id)
{
	thuoctinhphu1=encode(document.getElementById('thuoctinhphu1').value);
	thuoctinhphu2=encode(document.getElementById('thuoctinhphu2').value);
	thuoctinhphu3=encode(document.getElementById('thuoctinhphu3').value);
	thuoctinhphu4=encode(document.getElementById('thuoctinhphu4').value);
	thuoctinhphu5=encode(document.getElementById('thuoctinhphu5').value);
	thuoctinhphu6=encode(document.getElementById('thuoctinhphu6').value);
	data='thuoctinhphu1='+thuoctinhphu1;
	data=data+'&thuoctinhphu2='+thuoctinhphu2;
	data=data+'&thuoctinhphu3='+thuoctinhphu3;
	data=data+'&thuoctinhphu4='+thuoctinhphu4;
	data=data+'&thuoctinhphu5='+thuoctinhphu5;
	data=data+'&thuoctinhphu6='+thuoctinhphu6;
	LoadXmlDocPost('modules/gianhang_sanpham/sua_thuoctinh.php?id='+id,data,'common_echo')
}

 
function gianhang_xoa_tin(id)
{
	var answer = confirm('Xác nhận xóa tin này ?')
	if (answer){
	LoadXmlDoc('xml/gianhang_tin/xoa.php?id='+id,'common_echo');	
	}
}



function gianhang_xoa_slide(id)
{
	var answer = confirm('Xác nhận xóa slide này ?')
	if (answer){
	LoadXmlDoc('xml/gianhang_slide/xoa.php?id='+id,'common_echo');	
	}
}


function gianhang_xoa_thanhvien(id)
{
	var answer = confirm('Xác nhận xóa thành viên này ?')
	if (answer){
	LoadXmlDoc('xml/gianhang_thanhvien/xoa.php?id='+id,'common_echo');	
	}
}


function gianhang_xoa_gallery(id)
{
	LoadXmlDoc('xml/gianhang_gallery/xoa.php?id='+id,'common_echo');	
}



function sapxep_tin_khach(id,order_mask)
{
	order=document.getElementById('suasapxeptin_khach_'+id+order_mask).value;
	LoadXmlDoc('xml/gianhang_tin/sapxep.php?id='+id+'&order='+order,'common_echo');	
}


function gianhang_dichvu_sapxep(id,order_mask)
{
	order=document.getElementById('suasapxepdichvu_khach_'+id+order_mask).value;
	LoadXmlDoc('xml/gianhang_dichvu/sapxep.php?id='+id+'&order='+order,'common_echo');	
}



function gianhang_tin_moi(id)
{
	LoadXmlDoc('xml/gianhang_tin/moi.php?id='+id,'common_echo');	
}

function gianhang_gallery_moi(id)
{
	LoadXmlDoc('xml/gianhang_gallery/moi.php?id='+id,'common_echo');	
}



function gianhang_tin_xuatban(id)
{
	LoadXmlDoc('xml/gianhang_tin/xuatban.php?id='+id,'common_echo');	
}

function gianhang_diendan_danhmuc_khoa(id)
{
	LoadXmlDoc('modules/gianhang_diendan/khoa_xml.php?id='+id,'common_echo');	
}



function gianhang_slide_xuatban(id)
{
	LoadXmlDoc('xml/gianhang_slide/xuatban.php?id='+id,'common_echo');	
}


function gianhang_nick_luon_sang(id)
{
	LoadXmlDoc('modules/gianhang_nick/luonsang.php?id='+id,'common_echo');	
}


function gianhang_user_xuatban(id)
{
	LoadXmlDoc('xml/gianhang_thanhvien/xuatban.php?id='+id,'common_echo');	
}


function gianhang_user_quantri(id)
{
	LoadXmlDoc('xml/gianhang_thanhvien/quantri.php?id='+id,'common_echo');	
}


function gianhang_gallery_xuatban(id)
{
	LoadXmlDoc('xml/gianhang_gallery/xuatban.php?id='+id,'common_echo');	
}


function gianhang_danhmuc_xuatban(id)
{
	LoadXmlDoc('modules/gianhang_sanpham/danhmuc_xuatban.php?id='+id,'common_echo');	
}


function doicauhinhtrangchu(value)
{
	LoadXmlDoc('xml/gianhang_trangchu/doicauhinhtrangchu.php?value='+value,'common_echo');	
}

function gianhang_danhmuc_luonmorong(id)
{
	LoadXmlDoc('modules/gianhang_sanpham/luonmorong_trangchu.php?id='+id,'common_echo');	
}


function gianhang_danhmuc_trangchu(id)
{
	LoadXmlDoc('modules/gianhang_sanpham/danhmuc_trangchu.php?id='+id,'common_echo');	
}

function get_product_folder(id)
{
	id=String(id);
	len=id.length;
	folder=id.substr(0,(len-3));
	return folder+'000';
}

function doi_anh_chi_tiet_san_pham(path)
{
	document.getElementById('anh_chitiet_sanpham').src=path;
	
	
	
	className='anh_sanpham_chitiet_chon';
	var arr = new Array(); 
	var elems = document.getElementsByTagName("*");
	for(var i = 0; i < elems.length; i++)
	{
	  var elem = elems[i];
	  var id = elem.getAttribute("id");
	  if (navigator.userAgent.indexOf("MSIE")>=0)
		{ var cls = elem.getAttribute("className");}
		else
		{ var cls = elem.getAttribute("class");	}
	  if(cls == className)
	  {
		arr[arr.length] = id;
		
		 elem.className="anh_sanpham_chitiet";
	  }
	}
	
	ele.className='anh_sanpham_chitiet_chon';

	
}

function doi_dang_ky(value)
{
	className='dang_ky_gian_hang';
	var arr = new Array(); 
	var elems = document.getElementsByTagName("*");
	for(var i = 0; i < elems.length; i++)
	{
	  var elem = elems[i];
	  var id = elem.getAttribute("id");
	  if (navigator.userAgent.indexOf("MSIE")>=0)
		{ var cls = elem.getAttribute("className");}
		else
		{ var cls = elem.getAttribute("class");	}
	  if(cls == className)
	  {
		  	if(value==0)
			{
			 elem.style.display="none";
			}else
			{
			 elem.style.display="block";
			}
	  }
	}
	

	
}



function doi_anh_chi_tiet(ele,id,pic)
{
	document.getElementById('anh_chitiet_sanpham').src="userfiles/sanpham/"+get_product_folder(id)+"/"+id+"/"+pic;
	
	
}

function add_dot(self)
{
	oldvalue=self.value;
	oldvalue=oldvalue.replace('.','');
	oldvalue=oldvalue.replace('.','');
	oldvalue=oldvalue.replace('.','');
	oldvalue=oldvalue.replace('.','');
	oldvalue=oldvalue.replace('.','');
	
	len=oldvalue.length;
	var returnvalue;
	var part1='';
	var part2='';
	var part3='';
	var part4='';
	
	if(len<=3){part1=oldvalue}
	if(len>3 & len<=6)
		{
			part1=oldvalue.substr(0,len-3);
			part2='.'+oldvalue.substr(len-3,3);
		}
	
	if(len>6 & len<=9)
		{
			part1=oldvalue.substr(0,len-6);
			part2='.'+oldvalue.substr(len-6,3);
			part3='.'+oldvalue.substr(len-3,3);
		}
	
	if(len>9 & len<=11)
		{
			part1=oldvalue.substr(0,len-9);
			part2='.'+oldvalue.substr(len-9,3);
			part3='.'+oldvalue.substr(len-6,3);
			part4='.'+oldvalue.substr(len-3,3);
		}
	
	if(len>11)
		{
			part1=''
		}
	returnvalue=part1+part2+part3+part4;
	
	self.value=returnvalue;
}
function add_dot_price(self)
{
	add_dot(self)
}


 
function email_facebook(url,gh)
{
	
	LoadXmlDoc('modules/gianhang_mic/gui_email_facebook.php?url='+url+'&gh='+gh,'');	

	
}
function gianhang_dathang(productIDVal,gh,soluong)
{
	khong_anh=0;
	khong_co_gio_hang=0;

	try{
		check_deal=document.getElementById('countdown_'+productIDVal).innerHTML;
		if(document.getElementById('countdown_'+productIDVal).innerHTML!='Deal đã hết hạn')
		{
			deal=1
			deal_price=document.getElementById('deal_price_'+productIDVal).innerHTML;
			deal_phamtram=document.getElementById('deal_phamtram_'+productIDVal).innerHTML;
			
		}else
		{
			deal="";deal_price="";deal_phamtram=""
		}
		
		
	}catch(e){
		deal="";deal_price="";deal_phamtram=""}
	
	try
	{
	
	
		try
		{	
		
		
		  productX 		= $("#product_wrap_" + productIDVal).offset().left;
		 productY 		= $("#product_wrap_" + productIDVal).offset().top;
	}catch(e)
		{
			
			try
			{
		 productX 		= $("#nut_dat_hang_chi_tiet" ).offset().left;
		 productY 		= $("#nut_dat_hang_chi_tiet" ).offset().top;
		khong_anh=1;
			}catch(e)
			{
				sanpham_item='';
			
				try{sanpham_item=document.getElementById('sanpham_item').value;}catch(e){}
				
				LoadXmlDoc('xml/gianhang_sanpham/dathang.php?id='+productIDVal+'&gh='+gh+'&soluong='+soluong+'&sanpham_item='+sanpham_item+'&deal_price='+deal_price+'&deal_phamtram='+deal_phamtram+'&khong_anh='+khong_anh,'common_echo');

			}
			
			
		}
		
		
		 basketX 		= $("#giohang").offset().left;
		 basketY 		= $("#giohang").offset().top;
		 gotoX 			= basketX - productX;
		 gotoY 			= basketY - productY+50;
	}catch(e){
	
		try
		{	
		 productX 		= $("#product_wrap_" + productIDVal).offset().left;
		 productY 		= $("#product_wrap_" + productIDVal).offset().top;
		}catch(e)
		{
		 productX 		= $("#nut_dat_hang_chi_tiet" ).offset().left;
		 productY 		= $("#nut_dat_hang_chi_tiet" ).offset().top;
		khong_anh=1;
			
		}
	 
		try
		{	
		 basketX 		= $("#giohang").offset().left;
		 basketY 		= $("#giohang").offset().top;
		 basketX 		= $("#giohang_sosanpham2").offset().left;
		 basketY 		= $("#giohang_sosanpham2").offset().top;
		}catch(e)
		{
			
			try
			{	
				 basketX 		= $("#giohang_sosanpham3").offset().left;
				 basketY 		= $("#giohang_sosanpham3").offset().top;
			}catch(e)
			{
				try
				{	
					 basketX 		= $("#giohang_sosanpham4").offset().left;
					 basketY 		= $("#giohang_sosanpham4").offset().top;
				}catch(e)
				{
					
					khong_co_gio_hang=1;
				}
			}
			
			
		}
		
		if(khong_co_gio_hang==0)
		{
		
		 gotoX 			= basketX - productX;
		 gotoY 			= basketY - productY+50;
		}
		
 		}

	sanpham_item='';

	try{sanpham_item=document.getElementById('sanpham_item').value;}catch(e){}
	
	LoadXmlDoc('xml/gianhang_sanpham/dathang.php?id='+productIDVal+'&gh='+gh+'&soluong='+soluong+'&sanpham_item='+sanpham_item+'&deal_price='+deal_price+'&deal_phamtram='+deal_phamtram+'&khong_anh='+khong_anh,'common_echo');
	
	if(khong_co_gio_hang==1)
	{
		//window.location='/giohang.html';
	}

		
}
function doi_anh_nen(id,template_id)
{
	document.getElementById('anh_nen_hien_tai').value=id;
	submit_form2('common_echo','banner_dongy','xml/gianhang_banner1.php?template_id='+template_id,'suabanner_div' );
				
	
}
function them_danhmuc_trangchu_gianhang(id,reloadvar)
{
	LoadXmlDoc('xml/trangchu/them_danhmuc.php?id='+id+'&reloadvar='+reloadvar,'common_echo');	
}
function dong_popup()
{
	LoadXmlDoc('xml/gianhang_admin/dong_popup.php','');	
}

function reload_danhmuc_trangchu_gianhang()
{
	LoadXmlDoc('xml/gianhang_trangchu_danhmuc_reload.php','danhmuc_dachon');	
}
function gianhang_trangchu_xoadanhmuc(id,reccount)
{
	//reccount = reccount chua xoa
	reccount=reccount-1;
	LoadXmlDoc('xml/trangchu/xoadanhmuc.php?id='+id+'&reccount='+reccount,'danhmuc_dachon');	
}
function gianhang_trangchu_doihienthi(id)
{
	LoadXmlDoc('xml/gianhang_trangchu/gianhang_trangchu_doihienthi.php?id='+id,'common_echo');	
}
	
function doi_giao_dien(id,mau)
{
	
	LoadXmlDoc('xml/gianhang_giaodien/gianhang_doigiaodien.php?id='+id+'&mau='+mau,'common_echo');	
}
	
	
function gianhang_doi_bo_cuc(id)
{
	
	LoadXmlDoc('xml/gianhang_giaodien/gianhang_doi_bo_cuc.php?id='+id,'common_echo');	
}
	
function gianhang_reset_banner()
{
	LoadXmlDoc('xml/gianhang_giaodien/gianhang_reset_banner.php','common_echo');	
}
function gianhang_hoidap_traloi(id,gh)
{
	ajaxwin=dhtmlwindow.open('ajaxbox', 'ajax', 'modules/gianhang_hoidap/traloi_pop.php?id='+id+'&gh='+gh, 'Reply', 'width=430px,height=230px,resize=0,scrolling=0,center=1'); 
}
	
function gianhang_gui_traloi(id,gh,loai)
{
	ajaxwin=dhtmlwindow.open('ajaxbox', 'ajax', 'modules/gianhang_hoidap/traloi_pop.php?id='+id+'&gh='+gh+'&loai='+loai, 'Reply', 'width=430px,height=230px,resize=0,scrolling=0,center=1'); 
}
	
function chon_module(vitri,id)
{
	LoadXmlDoc('xml/gianhang_giaodien/gianhang_chon_module.php?id='+id+'&vitri='+vitri,'common_echo');
}
	
function xoa_chuc_nang(id)
{
	LoadXmlDoc('xml/gianhang_giaodien/xoa.php?id='+id,'common_echo');
}
function them_banner(vitri)
{
	
	try{
	submit_form('','','xml/banner/them.php?vitri='+vitri,'title')
	}catch(e)
	{
	LoadXmlDoc('xml/banner/them.php?vitri='+vitri,'common_echo');
	}
}
	
	
function them_banner_tuychinh(module)
{
	try{
	submit_form('','','xml/banner/them_banner_tuychinh.php?module='+module,'title')
	}catch(e)
	{
	LoadXmlDoc('xml/banner/them_banner_tuychinh.php?module='+module,'common_echo');
	}
}
	
	
	
function banner_len(id,vitri,nhom)
{
	LoadXmlDoc('xml/banner/len.php?id='+id+'&vitri='+vitri+'&nhom='+nhom,'common_echo');
}
	
	
function banner_xuong(id,vitri,nhom,varmax)
{
	LoadXmlDoc('xml/banner/xuong.php?id='+id+'&vitri='+vitri+'&nhom='+nhom+'&max='+varmax,'common_echo');
}
	
function gianhang_fix()
{
	LoadXmlDoc('xml/web_taikhoan/fix.php','common_echo');
}
function xoa_banner(id)
{
	var answer = confirm('Xác nhận xóa quảng cáo này ?')
	if (answer){
		LoadXmlDoc('xml/banner/xoa.php?id='+id,'common_echo');
	}

}


function gianhang_xoa_donhang(id)
{
	var answer = confirm('Xác nhận đơn hàng này ?')
	if (answer){
		LoadXmlDoc('xml/gianhang_phanhoi/xoa_donhang.php?id='+id,'common_echo');
	}

}

function gianhang_xoa_donhang_no_confirm(id)
{
	LoadXmlDoc('xml/gianhang_phanhoi/xoa_donhang.php?id='+id,'common_echo');
}


function gianhang_xoa_lienhe(id)
{
	var answer = confirm('Xác nhận thư liên hệ này ?')
	if (answer){
		LoadXmlDoc('xml/gianhang_phanhoi/xoa_lienhe.php?id='+id,'common_echo');	
	}
}



function dangnhap()
{
	ajaxwin=dhtmlwindow.open('ajaxbox', 'ajax', 'modules/web_taikhoan/login_pop.php', 'Đăng nhập', 'width=400px,height=180px,resize=0,scrolling=0,center=1'); 
}

function dangnhapreload()
{
	ajaxwin=dhtmlwindow.open('ajaxbox', 'ajax', 'modules/web_taikhoan/login_pop.php?reload=1', 'Đăng nhập', 'width=400px,height=180px,resize=0,scrolling=0,center=1'); 
}


function dangnhapdiendan()
{
	ajaxwin=dhtmlwindow.open('ajaxbox', 'ajax', 'modules/web_taikhoan/login_pop.php?diendan=1', 'Đăng nhập', 'width=400px,height=180px,resize=0,scrolling=0,center=1'); 
}

function dangnhapdl()
{
	ajaxwin=dhtmlwindow.open('ajaxbox', 'ajax', 'modules/web_dl/login_pop.php', 'Đăng nhập', 'width=400px,height=180px,resize=0,scrolling=0,center=1'); 
}

function chonban(id)
{
	ajaxwin=dhtmlwindow.open('ajaxbox', 'ajax', 'modules/gianhang_admin/chonban_pop.php?id='+id, 'Chọn giá bán', 'width=400px,height=230px,resize=0,scrolling=0,center=1'); 
}

function doi_danh_muc_rieng(value,id)
{
	LoadXmlDoc('xml/gianhang_sanpham/doi_danh_muc_rieng.php?id='+id+'&value='+value,'common_echo');
}


function danhmuc_them_cap_con(id)
{
	ajaxwin=dhtmlwindow.open('ajaxbox', 'ajax', 'modules/gianhang_sanpham/danhmuc_them_cap_con.php?id='+id, 'Thêm cấp con', 'width=500px,height=130px,resize=0,scrolling=0,center=1'); 
}



function danhmuc_them_thuoctinh(id)
{
	ajaxwin=dhtmlwindow.open('ajaxbox', 'ajax', 'modules/gianhang_sanpham/danhmuc_them_thuoctinh.php?id='+id, 'Thêm thuộc tính', 'width=500px,height=130px,resize=0,scrolling=0,center=1'); 
}

function danhmuc_di_chuyen(id)
{
	ajaxwin=dhtmlwindow.open('ajaxbox', 'ajax', 'modules/gianhang_sanpham/danhmuc_di_chuyen.php?id='+id, 'Di chuyển danh mục', 'width=560px,height=330px,resize=0,scrolling=0,center=1'); 
}


function danhmuc_di_chuyen_xml(id_goc)
{
	id_dich=document.getElementById('danhmuc').value;
	LoadXmlDoc('modules/gianhang_sanpham/danhmuc_di_chuyen_xml.php?id_goc='+id_goc+'&id_dich='+id_dich,'common_echo');	

}



function diendan_danhmuc_di_chuyen_xml(id_goc)
{
	id_dich=document.getElementById('danhmuc').value;
	LoadXmlDoc('modules/gianhang_diendan/danhmuc_di_chuyen_xml.php?id_goc='+id_goc+'&id_dich='+id_dich,'common_echo');	

}



function danhmuc_them_tinhchat(id)
{
	ajaxwin=dhtmlwindow.open('ajaxbox', 'ajax', 'modules/gianhang_sanpham/danhmuc_them_tinhchat.php?id='+id, 'Thêm tính chất', 'width=500px,height=130px,resize=0,scrolling=0,center=1'); 
}




function setCookie(c_name,value,expiredays)
{
	var exdate=new Date();
	exdate.setDate(exdate.getDate()+expiredays);
	document.cookie=c_name+ "=" +escape(value)+
	((expiredays==null) ? "" : ";expires="+exdate.toGMTString());
}

function getCookie(c_name)
{
	if (document.cookie.length>0)
	  {
	  c_start=document.cookie.indexOf(c_name + "=");
	  if (c_start!=-1)
		{
		c_start=c_start + c_name.length+1;
		c_end=document.cookie.indexOf(";",c_start);
		if (c_end==-1) c_end=document.cookie.length;
		return unescape(document.cookie.substring(c_start,c_end));
		}
	  }
	return "";
}

function danhgia(value)
{
	document.getElementById('danhgia_hidden').value=value;
	for(var i = 1; i < 6; i++)
	{
		document.getElementById('dangia'+i).className='danhgia_off';
	}

	for(j = 1; j <= value; j++)
	{
		document.getElementById('dangia'+j).className='danhgia_on';
	}

}


function get_select_default(element,value)
{
	ele=document.getElementById(element);
	len = ele.length
	i = 0
	for (i = 0; i < len; i++) 
	{
		if (ele[i].value==value)ele.selectedIndex=i;
	}

	
}
function web_hien_thuoc_tinh_an(id)
{
	if(document.getElementById('bangan_'+id).style.display=="block")
	{
		document.getElementById('bangan_'+id).style.display="none";
		document.getElementById('nut_xem_them_'+id).innerHTML="Thêm";
	}else
	{
		document.getElementById('bangan_'+id).style.display="block";
		document.getElementById('nut_xem_them_'+id).innerHTML="Ẩn";
	}
}

function resize_thumb(ele)
{
	var width = ele.naturalWidth;
	var height = ele.naturalHeight;
	if(width>height)
	{
		ele.style.width="40px";	
		ele.style.height="auto";	
	}else
	{
		ele.style.height="auto";	
	}
}
	
	
function gianhang_tu_them_menutrai(id)
{
	LoadXmlDoc('xml/gianhang_suamenu/tu_them_menutrai.php?id='+id,'common_echo');
}

	
function tat_khung_tim_kiem()
{
	LoadXmlDoc('xml/gianhang_sanpham/tat_khung_tim_kiem.php','common_echo');
}

	
	
function gianhang_tu_them_menutrai_dm_rieng(id)
{
	LoadXmlDoc('xml/gianhang_suamenu/tu_them_menutrai_dm_rieng.php?id='+id,'common_echo');
}

function gianhang_tu_them_dm_trangchu(id)
{
	them_danhmuc_trangchu_gianhang(id,1);
	//LoadXmlDoc('xml/gianhang_trangchu/gianhang_tu_them_dm_trangchu.php?id='+id,'common_echo');
}

function laysanphamvg(url,danhmucid,user_id,capnhat)
{
	LoadXmlDoc('xml/web_tool/chitiet_sanpham_vg.php?danhmucid='+danhmucid+'&url='+url+'&user_id='+user_id+'&capnhat='+capnhat,'common_echo');
}

function taocache_vg(url,danhmucid,user_id)
{
LoadXmlDoc('xml/web_tool/taocache_vg.php?danhmucid='+danhmucid+'&url='+url+'&user_id='+user_id,'common_echo');
}
function laysanphamdanhsachvg(url,danhmucid,user_id)
{

LoadXmlDoc('xml/web_tool/sanpham_vatgia.php?danhmucid='+danhmucid+'&url='+url+'&user_id='+user_id,'common_echo');
}

function doi_ss(id,ele)
{
	document.getElementById('danhmucid').value=id;
	className='menu_cap_3';
	var arr = new Array(); 
	var elems = document.getElementsByTagName("*");
	for(var i = 0; i < elems.length; i++)
	{
	  var elem = elems[i];
	  var id = elem.getAttribute("id");
	  if (navigator.userAgent.indexOf("MSIE")>=0)
		{ 
		var cls = elem.getAttribute("className");
		if(cls==null)var cls = elem.getAttribute("class");
		}
		else
		
		{ var cls = elem.getAttribute("class");	}
	  if(cls == className)
	  {
	  	arr[arr.length] = id;
		
		 elem.style.fontWeight="normal";
	  }
	}


	ele.style.fontWeight="bold";
	
}


function mo_rong_tom_tat(id)
{
	if(document.getElementById('nut_morong_'+id).innerHTML=="Thu hẹp")
	{
		document.getElementById('tomtat_'+id).style.height="55px";	
		document.getElementById('nut_morong_'+id).innerHTML="Mở rộng";
		document.getElementById('nut_morong_'+id).style.backgroundImage="url(templates/images/mo_rong_nho.gif)";
	}else
	{
		document.getElementById('tomtat_'+id).style.height="auto";	
		document.getElementById('nut_morong_'+id).innerHTML="Thu hẹp"	;
		document.getElementById('nut_morong_'+id).style.backgroundImage="url(templates/images/thu_hep_nho.gif)";
	}
	
}



 

// start storing the mouse position every 100 milliseconds




function at_show_aux(parent, child)
{
  var p = document.getElementById(parent);
  var c = document.getElementById(child );

  var top  = (c["at_position"] == "y") ? p.offsetHeight+2 : 0;
  var left = (c["at_position"] == "x") ? p.offsetWidth +2 : 0;

  for (; p; p = p.offsetParent)
  {
    top  += p.offsetTop;
    left += p.offsetLeft;
  }
var winW = 630, winH = 460;

if (parseInt(navigator.appVersion)>3) {
 if (navigator.appName=="Netscape") {
  winW = window.innerWidth;
  winH = window.innerHeight;
 }
 if (navigator.appName.indexOf("Microsoft")!=-1) {
  winW = document.body.offsetWidth;
  winH = document.body.offsetHeight;
 }
}
//left=winW/2-250;
   c.style.position   = "absolute";
  //c.style.width        = '200' +'px';
  c.style.top        = top +'px';
   
   try{
  if (menu_bang == 1)
  {
	 // alert(document.getElementById('div_body_noidung').style.left);
 //  c.style.left       = document.getElementById('div_body_noidung').style.left;
  //alert(c.style.left);
 }
   }catch(e){
   c.style.left       = left+'px';
	   }
  c.style.visibility = "visible";
   
 }

// ***** at_show *****

function at_show()
{
  var p = document.getElementById(this["at_parent"]);
  var c = document.getElementById(this["at_child" ]);

  at_show_aux(p.id, c.id);
  clearTimeout(c["at_timeout"]);
}

// ***** at_hide *****

function at_hide()
{
  var p = document.getElementById(this["at_parent"]);
  var c = document.getElementById(this["at_child" ]);

  c["at_timeout"] = setTimeout("document.getElementById('"+c.id+"').style.visibility = 'hidden'", 10);
}

// ***** at_click *****

function at_click()
{
  var p = document.getElementById(this["at_parent"]);
  var c = document.getElementById(this["at_child" ]);

  if (c.style.visibility != "visible") at_show_aux(p.id, c.id); else c.style.visibility = "hidden";
  return false;
}

// ***** at_attach *****

// PARAMETERS:
// parent   - id of the parent html element
// child    - id of the child  html element that should be droped down
// showtype - "click" = drop down child html element on mouse click
//            "hover" = drop down child html element on mouse over
// position - "x" = display the child html element to the right
//            "y" = display the child html element below
// cursor   - omit to use default cursor or specify CSS cursor name

function at_attach(parent, child, showtype, position, cursor)
{
  var p = document.getElementById(parent);
  var c = document.getElementById(child);

  p["at_parent"]     = p.id;
  c["at_parent"]     = p.id;
  p["at_child"]      = c.id;
  c["at_child"]      = c.id;
  p["at_position"]   = position;
  c["at_position"]   = position;

  c.style.position   = "absolute";
  c.style.visibility = "hidden";

  if (cursor != undefined) p.style.cursor = cursor;

  switch (showtype)
  {
    case "click":
      p.onclick     = at_click;
      p.onmouseout  = at_hide;
      c.onmouseover = at_show;
      c.onmouseout  = at_hide;
      break;
    case "hover":
      p.onmouseover = at_show;
      p.onmouseout  = at_hide;
      c.onmouseover = at_show;
      c.onmouseout  = at_hide;
      break;
  }
}
function at_attach_bang(parent, child, showtype, position, cursor)
{
	menu_bang=1;
at_attach(parent, child, showtype, position, cursor)

}

function view_vote(id,path)
{
	url='xml/thamdo_xemketqua.php?id='+id;
	var LeftPosition;
	var TopPosition;
	LeftPosition = (screen.width)/2-200;
	TopPosition = (screen.height)/2-200;
	newwindow=window.open(url,'name','height=300,width=500,top='+TopPosition+',left='+LeftPosition);
	if (window.focus) {newwindow.focus()}
	return false;
}

function gianhang_login_1(gh)
{
	setTimeout(function(){submit_form2('thongbao_form_login_1','login_button_1','xml/gianhang_thanhvien/login.php?gh='+gh,'form_login_1')},1);
	
}

function gianhang_login_2(gh)
{
	submit_form2('thongbao_form_login_2','login_button_2','xml/gianhang_thanhvien/login_2.php?gh='+gh,'form_login_2');
}
function thanhvien_thoat()
{
	LoadXmlDoc('xml/gianhang_thanhvien/logout.php','');
}

function save_pass(id,pass)
{
	LoadXmlDoc('xml/gianhang_thanhvien/doimatkhau.php?id='+id+'&pass='+pass,'common_echo');	
}

function doi_ptgg(id,value)
{
	LoadXmlDoc('xml/gianhang_thanhvien/doi_ptgg.php?id='+id+'&value='+value,'common_echo');	
}

function save_email(id,email)
{
	
	LoadXmlDoc('xml/gianhang_thanhvien/doiemail.php?id='+id+'&email='+email,'common_echo');	
}
function sap_xep_lang(id,value)
{
	
	LoadXmlDoc('xml/web_tool/sap_xep_lang.php?id='+id+'&value='+value,'common_echo');	
}

function doi_lang(id,value)
{
	
	LoadXmlDoc('xml/web_tool/doi_lang.php?id='+id+'&value='+value,'common_echo');	
}

function sua_ten_nhanh(id,value)
{
	data='name='+value;
	LoadXmlDocPost('modules/gianhang_sanpham/suaten.php?id_sanpham='+id,data,'common_echo')
}


function sua_mota_nhanh(id,value)
{
	data='des='+value;
	LoadXmlDocPost('modules/gianhang_sanpham/sua_mota_nhanh.php?id_sanpham='+id,data,'common_echo')
}



function sua_gia_nhanh(id,value)
{
	LoadXmlDoc('modules/gianhang_sanpham/luu_gia_sanpham.php?id='+id+'&price='+value,'common_echo')
}


function xu_ly_don_hang(id,value)
{
	LoadXmlDoc('xml/gianhang_phanhoi/xu_ly_don_hang.php?id='+id+'&value='+value,'common_echo')
}



function sua_gia_nhanh2(id,value)
{
	LoadXmlDoc('modules/gianhang_sanpham/luu_gia_sanpham2.php?id='+id+'&price='+value,'common_echo')
}


function sua_khoi_luong(id,value)
{
	LoadXmlDoc('modules/gianhang_sanpham/sua_khoi_luong_xml.php?id='+id+'&value='+value,'common_echo')
}


function sua_so_luong(id,value)
{
	LoadXmlDoc('modules/gianhang_sanpham/sua_so_luong_xml.php?id='+id+'&value='+value,'common_echo')
}


function gianhang_doi_nhan(id)
{
	value=encode(document.getElementById('value_'+id).value);
	data='value='+value;
	LoadXmlDocPost('xml/gianhang_admin/doi_nhan.php?id='+id,data,'common_echo')
}


function import_sanpham_item(id)
{
	value=encode(document.getElementById('sanpham_item_import').value);
	data='value='+value;
	LoadXmlDocPost('xml/gianhang_sanpham/sanpham_item_import.php?id='+id,data,'common_echo')
}


function gianhang_xoa_loai_datmua(id)
{
	var answer = confirm('Bạn chắc chắn xóa ?')
	if (answer){
		id=document.getElementById('sanpham_item').value;
		LoadXmlDoc('xml/gianhang_sanpham/sanpham_item_xoa.php?id='+id,'sanpham_item')
	}
	
}

function cho_diem_san_pham(id,gh)
{
	value=document.getElementById('vote_select').value;
	
	LoadXmlDoc('xml/gianhang_sanpham/vote.php?id='+id+'&value='+value+'&gh='+gh,'vote_result')
}

function suabox(id)
{
	submit_form2('preview','button1','modules/gianhang_tuychinhgiaodien/suabox_xml.php?id='+id,'tuy_chon_div');
}

function suanoidung(id)
{
	submit_form2('preview','button1','modules/gianhang_tuychinhgiaodien/suanoidung_xml.php?id='+id,'tuy_chon_div');
}

function suanen(id)
{
	submit_form2('preview','button1','modules/gianhang_tuychinhgiaodien/suanen_xml.php?id='+id,'tuy_chon_div');
}
function suanutmuahang(id)
{
	submit_form2('preview','button1','modules/gianhang_tuychinhgiaodien/nutmuahang_xml.php?id='+id,'tuy_chon_div');
}


function suatvmenu(id)
{
	submit_form2('preview','button1','modules/gianhang_tuychinhgiaodien/suatvmenu_xml.php?id='+id,'tuy_chon_div');
}

function suatvmenutrai(id)
{
	submit_form2('preview','button1','modules/gianhang_tuychinhgiaodien/suatvmenutrai_xml.php?id='+id,'tuy_chon_div');
}


function gianhang_clone_box_tv(id)
{
	LoadXmlDoc('modules/gianhang_tuychinhgiaodien/clone_box.php?id='+id,'common_echo')
}


function gianhang_clone_menungang_tv(id)
{
	LoadXmlDoc('modules/gianhang_tuychinhgiaodien/clone_menungang.php?id='+id,'common_echo')
}


function gianhang_clone_menutrai_tv(id)
{
	LoadXmlDoc('modules/gianhang_tuychinhgiaodien/clone_menutrai.php?id='+id,'common_echo')
}

function gianhang_xoa_box_tv(id)
{
	//var answer = confirm('Bạn chắc chắn xóa ?')
	//if (answer){
		LoadXmlDoc('modules/gianhang_tuychinhgiaodien/xoa_box.php?id='+id,'common_echo')
	//}
}

function doi_ngay_u(v,id)
{
	LoadXmlDoc('modules/web_dl/doi_ngay_u_xml.php?id='+id+'&v='+v,'common_echo')
}


function gianhang_xoa_nen_tv(id)
{
	//var answer = confirm('Bạn chắc chắn xóa ?')
	//if (answer){
		LoadXmlDoc('modules/gianhang_tuychinhgiaodien/xoa_nen.php?id='+id,'common_echo')
	//}
}


function gianhang_xoa_menutrai_tv(id)
{
	//var answer = confirm('Bạn chắc chắn xóa ?')
	//if (answer){
		LoadXmlDoc('modules/gianhang_tuychinhgiaodien/xoa_menutrai.php?id='+id,'common_echo')
	//}
}



function gianhang_xoa_menungang_tv(id)
{
	var answer = confirm('Bạn chắc chắn xóa ?')
	if (answer){
		LoadXmlDoc('modules/gianhang_tuychinhgiaodien/xoa_menungang.php?id='+id,'common_echo')
	}
}







function gianhang_apdung_box_cho_module(bocuc_id,mau_id)
{
	LoadXmlDoc('modules/gianhang_tuychinhgiaodien/apdung_box_cho_module_xml.php?bocuc_id='+bocuc_id+'&mau_id='+mau_id,'common_echo')
}

function gianhang_apdung_menungang_cho_module(bocuc_id,mau_id)
{
	LoadXmlDoc('modules/gianhang_tuychinhgiaodien/apdung_menungang_cho_module_xml.php?bocuc_id='+bocuc_id+'&mau_id='+mau_id,'common_echo')
}

function gianhang_apdung_menutrai_cho_module(bocuc_id,mau_id)
{
	LoadXmlDoc('modules/gianhang_tuychinhgiaodien/apdung_menutrai_cho_module_xml.php?bocuc_id='+bocuc_id+'&mau_id='+mau_id,'common_echo')
}

function chon_mau_noidung(mau_id)
{
	LoadXmlDoc('modules/gianhang_tuychinhgiaodien/apdung_mau_noidung_xml.php?mau_id='+mau_id,'chonnhanh_'+mau_id)
}


function chon_mau_nen(mau_id)
{
	LoadXmlDoc('modules/gianhang_tuychinhgiaodien/apdung_mau_nen_xml.php?mau_id='+mau_id,'chonnhanh_'+mau_id)
}

 
function chon_mau_nutmuahang(mau_id)
{
	LoadXmlDoc('modules/gianhang_tuychinhgiaodien/apdung_mau_nutmuahang_xml.php?mau_id='+mau_id,'chonnhanh_'+mau_id)
}


function chon_mau_nen_kc(mau_id)
{
	LoadXmlDoc('modules/gianhang_tuychinhgiaodien/apdung_mau_nen_xml.php?kc=1&mau_id='+mau_id,'chonnhanh_kc_'+mau_id)
}


function chon_mau_nen_chan(mau_id)
{
	LoadXmlDoc('modules/gianhang_tuychinhgiaodien/apdung_mau_nen_xml.php?chan=1&mau_id='+mau_id,'chonnhanh_chan_'+mau_id)
}

function xoabieutuong()
{
	LoadXmlDoc('modules/gianhang_admin/xoabieutuong_xml.php','')
}

function call(c)
{
	LoadXmlDoc('modules/command/command.php?c='+c,'common_echo')
}


function xoafilenganluong()
{
	LoadXmlDoc('modules/gianhang_admin/xoafilenganluong_xml.php','')
}

function xoasitemap()
{
	LoadXmlDoc('modules/gianhang_admin/xoasitemap_xml.php','')
}

function xoarobots()
{
	LoadXmlDoc('modules/gianhang_admin/xoarobots_xml.php','')
}
function bat_chuc_nang_giao_dien()
{
	LoadXmlDoc('modules/gianhang_tuychinhgiaodien/bat_chuc_nang_giao_dien_xml.php','')
}
function doi_khoang_gia(value)
{
	document.getElementById('tk_khoanggia').value=value
}
function timkiemnangcao()
{
	submit_form2('timnangcao_echo','nuttimnangcao','xml/gianhang_sanpham/timkiemnangcao.php','timkiemnangcao');
}

function gianhang_diendan_guibaimoi(id)
{
	try{value=tinyMCE.get('detail').getContent();}catch(e){alert('Bạn vui lòng nhập nội dung bài viết !');}
	
	data='detail='+encode(value);
	data=data+'&name='+encode(document.getElementById('tieudetopic').value);
	data=data+'&captcha='+encode(document.getElementById('captcha').value);
	
	LoadXmlDocPost('modules/gianhang_diendan/themmoi_xml.php?id='+id,data,'ketquathem');
}


function gianhang_diendan_suabaiviet(id)
{
	try{value=tinyMCE.get('detail').getContent();}catch(e){alert('Bạn vui lòng nhập nội dung bài viết !');}
	
	data='detail='+encode(value);
	data=data+'&name='+encode(document.getElementById('tieudetopic').value);
	data=data+'&danhmuc='+encode(document.getElementById('danhmuc').value);
	
	LoadXmlDocPost('modules/gianhang_diendan/suabaiviet_xml.php?id='+id,data,'ketquathem');
}


function xoa_bai_viet_dien_dan(id)
{
	var answer = confirm('Bạn chắc chắn xóa ?')
	if (answer){
		LoadXmlDoc('modules/gianhang_diendan/xoa_baiviet.php?id='+id,'');
	}
}


function xoa_chu_de_diendan(id)
{
	var answer = confirm('Bạn chắc chắn xóa ?')
	if (answer){
		LoadXmlDoc('modules/gianhang_diendan/xoa_chude.php?id='+id,'');
	}
}

function khoa_chu_de_diendan(id)
{
	LoadXmlDoc('modules/gianhang_diendan/khoa_chude.php?id='+id,'');
}


function uutien_chude_diendan(id)
{
	LoadXmlDoc('modules/gianhang_diendan/uutien_chude_diendan.php?id='+id,'');
}


function gianhang_diendan_guiphanhoi(id)
{
	try{value=tinyMCE.get('detail').getContent();}catch(e){alert('Bạn vui lòng nhập nội dung bài viết !');}
	
	data='detail='+encode(value);
	data=data+'&captcha='+encode(document.getElementById('captcha').value);

	LoadXmlDocPost('modules/gianhang_diendan/guiphanhoi_xml.php?id='+id,data,'ketquathem');
}
// END
































// -------------------------------------------------------------------
// DHTML Window Widget- By Dynamic Drive, available at: http://www.dynamicdrive.com
// v1.0: Script created Feb 15th, 07'
// v1.01: Feb 21th, 07' (see changelog.txt)
// v1.02: March 26th, 07' (see changelog.txt)
// v1.03: May 5th, 07' (see changelog.txt)
// v1.1:  Oct 29th, 07' (see changelog.txt)
// -------------------------------------------------------------------

var dhtmlwindow={
imagefiles:['java/dhtml_window/min.png', 'java/dhtml_window/close.png', 'java/dhtml_window/restore.png', 'java/resize.png'], //Path to 4 images used by script, in that order
ajaxbustcache: true, //Bust caching when fetching a file via Ajax?
ajaxloadinghtml: '<b>&#272;ang t&#7843;i d&#7919; li&#7879;u, b&#7841;n vui l&#242;ng &#273;&#7907;i</b>', //HTML to show while window fetches Ajax Content?

minimizeorder: 0,
zIndexvalue:100,
tobjects: [], //object to contain references to dhtml window divs, for cleanup purposes
lastactivet: {}, //reference to last active DHTML window

init:function(t){
	var domwindow=document.createElement("div") //create dhtml window div
	domwindow.id=t
	domwindow.className="dhtmlwindow"
	var domwindowdata=''
	domwindowdata='<div class="drag-handle">'
	domwindowdata+='DHTML Window <div class="drag-controls"><img src="'+this.imagefiles[0]+'" title="Minimize" /><img src="'+this.imagefiles[1]+'" title="Close" /></div>'
	domwindowdata+='</div>'
	domwindowdata+='<div class="drag-contentarea"></div>'
	domwindowdata+='<div class="drag-statusarea"><div class="drag-resizearea" style="background: transparent url('+this.imagefiles[3]+') top right no-repeat;">&nbsp;</div></div>'
	domwindowdata+='</div>'
	domwindow.innerHTML=domwindowdata
	document.getElementById("dhtmlwindowholder").appendChild(domwindow)
	this.zIndexvalue=2000;
	//this.zIndexvalue=(this.zIndexvalue)? this.zIndexvalue+1 : 100 //z-index value for DHTML window: starts at 0, increments whenever a window has focus
	var t=document.getElementById(t)
	var divs=t.getElementsByTagName("div")
	for (var i=0; i<divs.length; i++){ //go through divs inside dhtml window and extract all those with class="drag-" prefix
		if (/drag-/.test(divs[i].className))
			t[divs[i].className.replace(/drag-/, "")]=divs[i] //take out the "drag-" prefix for shorter access by name
	}
	//t.style.zIndex=this.zIndexvalue //set z-index of this dhtml window
	t.handle._parent=t //store back reference to dhtml window
	t.resizearea._parent=t //same
	t.controls._parent=t //same
	t.onclose=function(){return true} //custom event handler "onclose"
	t.onmousedown=function(){dhtmlwindow.setfocus(this)} //Increase z-index of window when focus is on it
	t.handle.onmousedown=dhtmlwindow.setupdrag //set up drag behavior when mouse down on handle div
	t.resizearea.onmousedown=dhtmlwindow.setupdrag //set up drag behavior when mouse down on resize div
	t.controls.onclick=dhtmlwindow.enablecontrols
	t.show=function(){dhtmlwindow.show(this)} //public function for showing dhtml window
	t.hide=function(){dhtmlwindow.hide(this)} //public function for hiding dhtml window
	t.close=function(){dhtmlwindow.close(this)} //public function for closing dhtml window (also empties DHTML window content)
	t.setSize=function(w, h){dhtmlwindow.setSize(this, w, h)} //public function for setting window dimensions
	t.moveTo=function(x, y){dhtmlwindow.moveTo(this, x, y)} //public function for moving dhtml window (relative to viewpoint)
	t.isResize=function(bol){dhtmlwindow.isResize(this, bol)} //public function for specifying if window is resizable
	t.isScrolling=function(bol){dhtmlwindow.isScrolling(this, bol)} //public function for specifying if window content contains scrollbars
	t.load=function(contenttype, contentsource, title){dhtmlwindow.load(this, contenttype, contentsource, title)} //public function for loading content into window
	this.tobjects[this.tobjects.length]=t
	return t //return reference to dhtml window div
},

open:function(t, contenttype, contentsource, title, attr, recalonload){
	var d=dhtmlwindow //reference dhtml window object
	function getValue(Name){
		var config=new RegExp(Name+"=([^,]+)", "i") //get name/value config pair (ie: width=400px,)
		return (config.test(attr))? parseInt(RegExp.$1) : 0 //return value portion (int), or 0 (false) if none found
	}
	if (document.getElementById(t)==null) //if window doesn't exist yet, create it
		t=this.init(t) //return reference to dhtml window div
	else
		t=document.getElementById(t)
	this.setfocus(t)
	t.setSize(getValue(("width")), (getValue("height"))) //Set dimensions of window
	var xpos=getValue("center")? "middle" : getValue("left") //Get x coord of window
	var ypos=getValue("center")? "middle" : getValue("top") //Get y coord of window
	//t.moveTo(xpos, ypos) //Position window
	if (typeof recalonload!="undefined" && recalonload=="recal" && this.scroll_top==0){ //reposition window when page fully loads with updated window viewpoints?
		if (window.attachEvent && !window.opera) //In IE, add another 400 milisecs on page load (viewpoint properties may return 0 b4 then)
			this.addEvent(window, function(){setTimeout(function(){t.moveTo(xpos, ypos)}, 400)}, "load")
		else
			this.addEvent(window, function(){t.moveTo(xpos, ypos)}, "load")
	}
	t.isResize(getValue("resize")) //Set whether window is resizable
	t.isScrolling(getValue("scrolling")) //Set whether window should contain scrollbars
	t.style.visibility="visible"
	t.style.display="block"
	t.contentarea.style.display="block"
	t.moveTo(xpos, ypos) //Position window
	t.load(contenttype, contentsource, title)
	if (t.state=="minimized" && t.controls.firstChild.title=="Restore"){ //If window exists and is currently minimized?
		t.controls.firstChild.setAttribute("src", dhtmlwindow.imagefiles[0]) //Change "restore" icon within window interface to "minimize" icon
		t.controls.firstChild.setAttribute("title", "Minimize")
		t.state="fullview" //indicate the state of the window as being "fullview"
	}
	return t
},

setSize:function(t, w, h){ //set window size (min is 150px wide by 100px tall)
	t.style.width=Math.max(parseInt(w), 150)+"px"
	t.contentarea.style.height=Math.max(parseInt(h), 100)+"px"
},

moveTo:function(t, x, y){ //move window. Position includes current viewpoint of document
	this.getviewpoint() //Get current viewpoint numbers
	t.style.left=(x=="middle")? this.scroll_left+(this.docwidth-t.offsetWidth)/2+"px" : this.scroll_left+parseInt(x)+"px"
	t.style.top=(y=="middle")? this.scroll_top+(this.docheight-t.offsetHeight)/2+"px" : this.scroll_top+parseInt(y)+"px"
},

isResize:function(t, bol){ //show or hide resize inteface (part of the status bar)
	t.statusarea.style.display=(bol)? "block" : "none"
	t.resizeBool=(bol)? 1 : 0
},

isScrolling:function(t, bol){ //set whether loaded content contains scrollbars
	t.contentarea.style.overflow=(bol)? "auto" : "hidden"
},

load:function(t, contenttype, contentsource, title){ //loads content into window plus set its title (3 content types: "inline", "iframe", or "ajax")
	if (t.isClosed){
		alert("DHTML Window has been closed, so no window to load contents into. Open/Create the window again.")
		return
	}
	var contenttype=contenttype.toLowerCase() //convert string to lower case
	if (typeof title!="undefined")
		t.handle.firstChild.nodeValue=title
	if (contenttype=="inline")
		t.contentarea.innerHTML=contentsource
	else if (contenttype=="div"){
		var inlinedivref=document.getElementById(contentsource)
		t.contentarea.innerHTML=(inlinedivref.defaultHTML || inlinedivref.innerHTML) //Populate window with contents of inline div on page
		if (!inlinedivref.defaultHTML)
			inlinedivref.defaultHTML=inlinedivref.innerHTML //save HTML within inline DIV
		inlinedivref.innerHTML="" //then, remove HTML within inline DIV (to prevent duplicate IDs, NAME attributes etc in contents of DHTML window
		inlinedivref.style.display="none" //hide that div
	}
	else if (contenttype=="iframe"){
		t.contentarea.style.overflow="hidden" //disable window scrollbars, as iframe already contains scrollbars
		if (!t.contentarea.firstChild || t.contentarea.firstChild.tagName!="IFRAME") //If iframe tag doesn't exist already, create it first
			t.contentarea.innerHTML='<iframe src="" style="margin:0; padding:0; width:100%; height: 100%" name="_iframe-'+t.id+'"></iframe>'
		window.frames["_iframe-"+t.id].location.replace(contentsource) //set location of iframe window to specified URL
		}
	else if (contenttype=="ajax"){
		this.ajax_connect(contentsource, t) //populate window with external contents fetched via Ajax
	}
	t.contentarea.datatype=contenttype //store contenttype of current window for future reference
},

setupdrag:function(e){
	var d=dhtmlwindow //reference dhtml window object
	var t=this._parent //reference dhtml window div
	d.etarget=this //remember div mouse is currently held down on ("handle" or "resize" div)
	var e=window.event || e
	d.initmousex=e.clientX //store x position of mouse onmousedown
	d.initmousey=e.clientY
	d.initx=parseInt(t.offsetLeft) //store offset x of window div onmousedown
	d.inity=parseInt(t.offsetTop)
	d.width=parseInt(t.offsetWidth) //store width of window div
	d.contentheight=parseInt(t.contentarea.offsetHeight) //store height of window div's content div
	if (t.contentarea.datatype=="iframe"){ //if content of this window div is "iframe"
		t.style.backgroundColor="#F8F8F8" //colorize and hide content div (while window is being dragged)
		t.contentarea.style.visibility="hidden"
	}
	document.onmousemove=d.getdistance //get distance travelled by mouse as it moves
	document.onmouseup=function(){
		if (t.contentarea.datatype=="iframe"){ //restore color and visibility of content div onmouseup
			t.contentarea.style.backgroundColor="white"
			t.contentarea.style.visibility="visible"
		}
		d.stop()
	}
	return false
},

getdistance:function(e){
	var d=dhtmlwindow
	var etarget=d.etarget
	var e=window.event || e
	d.distancex=e.clientX-d.initmousex //horizontal distance travelled relative to starting point
	d.distancey=e.clientY-d.initmousey
	if (etarget.className=="drag-handle") //if target element is "handle" div
		d.move(etarget._parent, e)
	else if (etarget.className=="drag-resizearea") //if target element is "resize" div
		d.resize(etarget._parent, e)
	return false //cancel default dragging behavior
},

getviewpoint:function(){ //get window viewpoint numbers
	var ie=document.all && !window.opera
	var domclientWidth=document.documentElement && parseInt(document.documentElement.clientWidth) || 100000 //Preliminary doc width in non IE browsers
	this.standardbody=(document.compatMode=="CSS1Compat")? document.documentElement : document.body //create reference to common "body" across doctypes
	this.scroll_top=(ie)? this.standardbody.scrollTop : window.pageYOffset
	this.scroll_left=(ie)? this.standardbody.scrollLeft : window.pageXOffset
	this.docwidth=(ie)? this.standardbody.clientWidth : (/Safari/i.test(navigator.userAgent))? window.innerWidth : Math.min(domclientWidth, window.innerWidth-16)
	this.docheight=(ie)? this.standardbody.clientHeight: window.innerHeight
},

rememberattrs:function(t){ //remember certain attributes of the window when it's minimized or closed, such as dimensions, position on page
	this.getviewpoint() //Get current window viewpoint numbers
	t.lastx=parseInt((t.style.left || t.offsetLeft))-dhtmlwindow.scroll_left //store last known x coord of window just before minimizing
	t.lasty=parseInt((t.style.top || t.offsetTop))-dhtmlwindow.scroll_top
	t.lastwidth=parseInt(t.style.width) //store last known width of window just before minimizing/ closing
},

move:function(t, e){
	t.style.left=dhtmlwindow.distancex+dhtmlwindow.initx+"px"
	t.style.top=dhtmlwindow.distancey+dhtmlwindow.inity+"px"
},

resize:function(t, e){
	t.style.width=Math.max(dhtmlwindow.width+dhtmlwindow.distancex, 150)+"px"
	t.contentarea.style.height=Math.max(dhtmlwindow.contentheight+dhtmlwindow.distancey, 100)+"px"
},

enablecontrols:function(e){
	var d=dhtmlwindow
	var sourceobj=window.event? window.event.srcElement : e.target //Get element within "handle" div mouse is currently on (the controls)
	if (/Minimize/i.test(sourceobj.getAttribute("title"))) //if this is the "minimize" control
		d.minimize(sourceobj, this._parent)
	else if (/Restore/i.test(sourceobj.getAttribute("title"))) //if this is the "restore" control
		d.restore(sourceobj, this._parent)
	else if (/Close/i.test(sourceobj.getAttribute("title"))) //if this is the "close" control
		d.close(this._parent)
	return false
},

minimize:function(button, t){
	dhtmlwindow.rememberattrs(t)
	button.setAttribute("src", dhtmlwindow.imagefiles[2])
	button.setAttribute("title", "Restore")
	t.state="minimized" //indicate the state of the window as being "minimized"
	t.contentarea.style.display="none"
	t.statusarea.style.display="none"
	if (typeof t.minimizeorder=="undefined"){ //stack order of minmized window on screen relative to any other minimized windows
		dhtmlwindow.minimizeorder++ //increment order
		t.minimizeorder=dhtmlwindow.minimizeorder
	}
	t.style.left="10px" //left coord of minmized window
	t.style.width="200px"
	var windowspacing=t.minimizeorder*10 //spacing (gap) between each minmized window(s)
	t.style.top=dhtmlwindow.scroll_top+dhtmlwindow.docheight-(t.handle.offsetHeight*t.minimizeorder)-windowspacing+"px"
},

restore:function(button, t){
	dhtmlwindow.getviewpoint()
	button.setAttribute("src", dhtmlwindow.imagefiles[0])
	button.setAttribute("title", "Minimize")
	t.state="fullview" //indicate the state of the window as being "fullview"
	t.style.display="block"
	t.contentarea.style.display="block"
	if (t.resizeBool) //if this window is resizable, enable the resize icon
		t.statusarea.style.display="block"
	t.style.left=parseInt(t.lastx)+dhtmlwindow.scroll_left+"px" //position window to last known x coord just before minimizing
	t.style.top=parseInt(t.lasty)+dhtmlwindow.scroll_top+"px"
	t.style.width=parseInt(t.lastwidth)+"px"
},


close:function(t){
	try{
		var closewinbol=t.onclose()
	}
	catch(err){ //In non IE browsers, all errors are caught, so just run the below
		var closewinbol=true
 }
	finally{ //In IE, not all errors are caught, so check if variable isn't defined in IE in those cases
		if (typeof closewinbol=="undefined"){
			alert("An error has occured somwhere inside your \"onclose\" event handler")
			var closewinbol=true
		}
	}
	if (closewinbol){ //if custom event handler function returns true
		if (t.state!="minimized") //if this window isn't currently minimized
			dhtmlwindow.rememberattrs(t) //remember window's dimensions/position on the page before closing
		if (window.frames["_iframe-"+t.id]) //if this is an IFRAME DHTML window
			window.frames["_iframe-"+t.id].location.replace("about:blank")
		else
			t.contentarea.innerHTML=""
		t.style.display="none"
		t.isClosed=true //tell script this window is closed (for detection in t.show())
	}
	return closewinbol
},


setopacity:function(targetobject, value){ //Sets the opacity of targetobject based on the passed in value setting (0 to 1 and in between)
	if (!targetobject)
		return
	if (targetobject.filters && targetobject.filters[0]){ //IE syntax
		if (typeof targetobject.filters[0].opacity=="number") //IE6
			targetobject.filters[0].opacity=value*100
		else //IE 5.5
			targetobject.style.filter="alpha(opacity="+value*100+")"
		}
	else if (typeof targetobject.style.MozOpacity!="undefined") //Old Mozilla syntax
		targetobject.style.MozOpacity=value
	else if (typeof targetobject.style.opacity!="undefined") //Standard opacity syntax
		targetobject.style.opacity=value
},

setfocus:function(t){ //Sets focus to the currently active window
	this.zIndexvalue++
	t.style.zIndex=this.zIndexvalue
	t.isClosed=false //tell script this window isn't closed (for detection in t.show())
	this.setopacity(this.lastactivet.handle, 0.5) //unfocus last active window
	this.setopacity(t.handle, 1) //focus currently active window
	this.lastactivet=t //remember last active window
},


show:function(t){
	if (t.isClosed){
		alert("DHTML Window has been closed, so nothing to show. Open/Create the window again.")
		return
	}
	if (t.lastx) //If there exists previously stored information such as last x position on window attributes (meaning it's been minimized or closed)
		dhtmlwindow.restore(t.controls.firstChild, t) //restore the window using that info
	else
		t.style.display="block"
	this.setfocus(t)
	t.state="fullview" //indicate the state of the window as being "fullview"
},

hide:function(t){
	t.style.display="none"
},

ajax_connect:function(url, t){
	var page_request = false
	var bustcacheparameter=""
	if (window.XMLHttpRequest) // if Mozilla, IE7, Safari etc
		page_request = new XMLHttpRequest()
	else if (window.ActiveXObject){ // if IE6 or below
		try {
		page_request = new ActiveXObject("Msxml2.XMLHTTP")
		} 
		catch (e){
			try{
			page_request = new ActiveXObject("Microsoft.XMLHTTP")
			}
			catch (e){}
		}
	}
	else
		return false
	t.contentarea.innerHTML=this.ajaxloadinghtml
	page_request.onreadystatechange=function(){dhtmlwindow.ajax_loadpage(page_request, t)}
	if (this.ajaxbustcache) //if bust caching of external page
		bustcacheparameter=(url.indexOf("?")!=-1)? "&"+new Date().getTime() : "?"+new Date().getTime()
	page_request.open('GET', url+bustcacheparameter, true)
	page_request.send(null)
},

ajax_loadpage:function(page_request, t){
	if (page_request.readyState == 4 && (page_request.status==200 || window.location.href.indexOf("http")==-1)){
	t.contentarea.innerHTML=page_request.responseText
	}
},


stop:function(){
	dhtmlwindow.etarget=null //clean up
	document.onmousemove=null
	document.onmouseup=null
},

addEvent:function(target, functionref, tasktype){ //assign a function to execute to an event handler (ie: onunload)
	var tasktype=(window.addEventListener)? tasktype : "on"+tasktype
	if (target.addEventListener)
		target.addEventListener(tasktype, functionref, false)
	else if (target.attachEvent)
		target.attachEvent(tasktype, functionref)
},

cleanup:function(){
	for (var i=0; i<dhtmlwindow.tobjects.length; i++){
		dhtmlwindow.tobjects[i].handle._parent=dhtmlwindow.tobjects[i].resizearea._parent=dhtmlwindow.tobjects[i].controls._parent=null
	}
	window.onload=null
}

} //End dhtmlwindow object

document.write('<div id="dhtmlwindowholder"><span style="display:none">.</span></div>') //container that holds all dhtml window divs on page
window.onunload=dhtmlwindow.cleanup
































/***********************************************
* Show Hint script- © Dynamic Drive (www.dynamicdrive.com)
* This notice MUST stay intact for legal use
* Visit http://www.dynamicdrive.com/ for this script and 100s more.
***********************************************/
		
var horizontal_offset="9px" //horizontal offset of hint box from anchor link

/////No further editting needed

var vertical_offset="0" //horizontal offset of hint box from anchor link. No need to change.
var ie=document.all
var ns6=document.getElementById&&!document.all

function getposOffset(what, offsettype){
var totaloffset=(offsettype=="left")? what.offsetLeft : what.offsetTop;
var parentEl=what.offsetParent;
while (parentEl!=null){
totaloffset=(offsettype=="left")? totaloffset+parentEl.offsetLeft : totaloffset+parentEl.offsetTop;
parentEl=parentEl.offsetParent;
}
return totaloffset;
}

function iecompattest(){
return (document.compatMode && document.compatMode!="BackCompat")? document.documentElement : document.body
}

function clearbrowseredge(obj, whichedge){
var edgeoffset=(whichedge=="rightedge")? parseInt(horizontal_offset)*-1 : parseInt(vertical_offset)*-1
if (whichedge=="rightedge"){
var windowedge=ie && !window.opera? iecompattest().scrollLeft+iecompattest().clientWidth-30 : window.pageXOffset+window.innerWidth-40
dropmenuobj.contentmeasure=dropmenuobj.offsetWidth
if (windowedge-dropmenuobj.x < dropmenuobj.contentmeasure)
edgeoffset=dropmenuobj.contentmeasure+obj.offsetWidth+parseInt(horizontal_offset)
}
else{
var windowedge=ie && !window.opera? iecompattest().scrollTop+iecompattest().clientHeight-15 : window.pageYOffset+window.innerHeight-18
dropmenuobj.contentmeasure=dropmenuobj.offsetHeight
if (windowedge-dropmenuobj.y < dropmenuobj.contentmeasure)
edgeoffset=dropmenuobj.contentmeasure-obj.offsetHeight
}
return edgeoffset
}

function showhint(menucontents, obj, e, tipwidth){
if ((ie||ns6) && document.getElementById("hintbox")){
dropmenuobj=document.getElementById("hintbox")
dropmenuobj.innerHTML=menucontents
dropmenuobj.style.left=dropmenuobj.style.top=-500
if (tipwidth!=""){
dropmenuobj.widthobj=dropmenuobj.style
dropmenuobj.widthobj.width=tipwidth
}
dropmenuobj.x=getposOffset(obj, "left")
dropmenuobj.y=getposOffset(obj, "top")
dropmenuobj.style.left=dropmenuobj.x-clearbrowseredge(obj, "rightedge")+obj.offsetWidth+"px"
dropmenuobj.style.top=dropmenuobj.y-clearbrowseredge(obj, "bottomedge")+"px"
dropmenuobj.style.visibility="visible"
obj.onmouseout=hidetip
}
}

function hidetip(e){
dropmenuobj.style.visibility="hidden"
dropmenuobj.style.left="-500px"
}

function createhintbox(){
var divblock=document.createElement("div")
divblock.setAttribute("id", "hintbox")
document.body.appendChild(divblock)
}

if (window.addEventListener)
window.addEventListener("load", createhintbox, false)
else if (window.attachEvent)
window.attachEvent("onload", createhintbox)
else if (document.getElementById)
window.onload=createhintbox
















/***********************************************
* VietAd (www.vietad.vn) Ajax ToolTip
***********************************************/

var offsetxpoint = -60; //Customize x offset of tooltip
var offsetypoint = 20; //Customize y offset of tooltip
var ie = document.all;
var ns6 = document.getElementById && !document.all;
var enabletip = false;

var tipobj;

function ietruebody()
{
	return (document.compatMode && document.compatMode != "BackCompat")? document.documentElement : document.body;
}

// Ajax Show Tooltip


function ShowTooltipGallery(id,gh,ext)
{
	if((document.readyState == "complete") || (!ie))
	{
		if(!document.getElementById('AdTooltip'))
		{
			try
			{		
				/* Create tooltip content div */
				tipobj = document.createElement('DIV'); 
				tipobj.className = 'AdTooltip';
				tipobj.id = 'AdTooltip';		
				tipobj.style.position = 'absolute';
				tipobj.style.top= '-1000px';

				document.body.appendChild(tipobj);
			}
			catch(e)
			{	
				return;		
			}
		}		
		
	}
	
	LoadXmlDoc('xml/gianhang_gallery/tooltip.php?id='+id+'&gh='+gh,'AdTooltip')
	
}
function ShowTooltip(id,gh,ext,pic)
{
	if((document.readyState == "complete") || (!ie))
	{
		if(!document.getElementById('AdTooltip'))
		{
			try
			{		
				/* Create tooltip content div */
				tipobj = document.createElement('DIV'); 
				tipobj.className = 'AdTooltip';
				tipobj.id = 'AdTooltip';		
				tipobj.style.position = 'absolute';
				tipobj.style.top= '-1000px';

				document.body.appendChild(tipobj);
			}
			catch(e)
			{	
				return;		
			}
		}		
		
	}
	
	LoadXmlDoc('xml/gianhang_sanpham/tooltip.php?id='+id+'&gh='+gh+'&ext='+ext+'&pic='+pic,'AdTooltip')
}
function ShowTooltipReady(id)
{	
}

// Positioning Tooltip
function PositionTooltip(e)
{
	if (enabletip)
	{
		try{var tipel = e.target || e.srcElement;}catch(e){}
		try{var tipel = event.target || event.srcElement;}catch(e){}
		
		try{document.getElementById('fixloi').innerHTML=tipel.src;}catch(e){}

		try{
			if(document.getElementById('fixloi').innerHTML=='undefined')
			{
				HideTooltip();
				return;
			}
		}catch(e){}

		try{offsetH=tipobj.offsetHeight}catch(e){offsetH=0;}
		if(offsetH>300)
		{
			
		
		
			var curX = (ns6) ? e.pageX : event.clientX+ietruebody().scrollLeft;
			var curY = (ns6) ? e.pageY : event.clientY+ietruebody().scrollTop;
			
			//Find out how close the mouse is to the corner of the window
			var rightedge  = ie&&!window.opera ? ietruebody().clientWidth-event.clientX-offsetxpoint : window.innerWidth-e.clientX-offsetxpoint-20;
			var bottomedge = ie&&!window.opera ? ietruebody().clientHeight-event.clientY-offsetypoint : window.innerHeight-e.clientY-offsetypoint-20;
	
			var leftedge = (offsetxpoint<0) ? offsetxpoint*(-1) : -1000;
	
			//if the horizontal distance isn't enough to accomodate the width of the context menu
			if (rightedge < tipobj.offsetWidth)
			{
				//move the horizontal position of the menu to the left by it's width
				//tipobj.style.left = ie ? ietruebody().scrollLeft + event.clientX-tipobj.offsetWidth + "px" : window.pageXOffset + e.clientX - tipobj.offsetWidth + "px";
			}
			else if (curX < leftedge)
			{
				//tipobj.style.left = "5px";
			}
			else
			{
				//position the horizontal position of the menu where the mouse is positioned
				//tipobj.style.left = curX + offsetxpoint + "px";
			}
	
			//same concept with the vertical position
			if (bottomedge < tipobj.offsetHeight)
			{
				//tipobj.style.top = ie ? ietruebody().scrollTop + event.clientY-tipobj.offsetHeight - offsetypoint + "px" : window.pageYOffset + e.clientY - tipobj.offsetHeight - offsetypoint + "px";
			}
			else
			{
				//tipobj.style.top = curY + offsetypoint + "px";
			}
				//alert(tipobj.offsetHeight)
				
			if (parseInt(navigator.appVersion)>3) {
			 if (navigator.appName=="Netscape") {
			  winW = window.innerWidth-16;
			  winH = window.innerHeight-16;
			 }else
			 {
			  winW = document.documentElement.clientWidth-20;
			  winH =  document.documentElement.clientHeight-20;
			 }
			}
			if(ie)
			{
				
				//(winH-tipobj.offsetHeight)/2+window.pageYOffset+'px';
				tipobj.style.top=(winH-tipobj.offsetHeight)/2 +ietruebody().scrollTop+ "px"


				cachtrai=curX + offsetxpoint;
				
				
				if(cachtrai<winW/2)
				{
					tipobj.style.left=event.clientX +20+'px';
				}else
				{
					tipobj.style.left=event.clientX -tipobj.offsetWidth-20+'px';
				}
				//document.getElementById('test').innerHTML=cachtrai;
				
			}else
			{
				tipobj.style.top=(winH-tipobj.offsetHeight)/2+window.pageYOffset+'px';
				cachtrai=window.pageXOffset + e.clientX;
				if(cachtrai<winW/2)
				{
					tipobj.style.left=window.pageXOffset + e.clientX+20+'px';
				}else
				{
					tipobj.style.left=window.pageXOffset + e.clientX-tipobj.offsetWidth-20+'px';
				}
				//document.getElementById('test').innerHTML=window.pageXOffset + e.clientX;
			}
			
	
				
			tipobj.style.visibility = "visible";
		}else
		{
			
			
			var curX = (ns6) ? e.pageX : event.clientX+ietruebody().scrollLeft;
			var curY = (ns6) ? e.pageY : event.clientY+ietruebody().scrollTop;
			
			//Find out how close the mouse is to the corner of the window
			var rightedge  = ie&&!window.opera ? ietruebody().clientWidth-event.clientX-offsetxpoint : window.innerWidth-e.clientX-offsetxpoint-20;
			var bottomedge = ie&&!window.opera ? ietruebody().clientHeight-event.clientY-offsetypoint : window.innerHeight-e.clientY-offsetypoint-20;
	
			var leftedge = (offsetxpoint<0) ? offsetxpoint*(-1) : -1000;
	
			//if the horizontal distance isn't enough to accomodate the width of the context menu		
			var check_offset_width=0;
			try{check_offset_width=tipobj.offsetWidth}catch(e){}
			
			if(check_offset_width)
			{
				
				if (rightedge < tipobj.offsetWidth)
				{
					//move the horizontal position of the menu to the left by it's width
					tipobj.style.left = ie ? ietruebody().scrollLeft + event.clientX-tipobj.offsetWidth + "px" : window.pageXOffset + e.clientX - tipobj.offsetWidth + "px";
				}
				else if (curX < leftedge)
				{
					tipobj.style.left = "5px";
				}
				else
				{
					//position the horizontal position of the menu where the mouse is positioned
					tipobj.style.left = curX + offsetxpoint + "px";
				}
		
				//same concept with the vertical position
				if (bottomedge < tipobj.offsetHeight)
				{
					tipobj.style.top = ie ? ietruebody().scrollTop + event.clientY-tipobj.offsetHeight - offsetypoint + "px" : window.pageYOffset + e.clientY - tipobj.offsetHeight - offsetypoint + "px";
				}
				else
				{
					tipobj.style.top = curY + offsetypoint + "px";
				}
				tipobj.style.visibility = "visible";
			}
			
		}
	}
}

// Hide Tooltip
function HideTooltip()
{
	if ((ns6||ie) && (tipobj))
	{
		enabletip = false;
		
		tipobj.style.visibility = "hidden";
		tipobj.style.left = "-1000px";
		tipobj.style.backgroundColor = '';
		tipobj.style.width = '';
	}
}

document.onmousemove = PositionTooltip;














/*! jQuery v1.8.3 jquery.com | jquery.org/license */
(function(e,t){function _(e){var t=M[e]={};return v.each(e.split(y),function(e,n){t[n]=!0}),t}function H(e,n,r){if(r===t&&e.nodeType===1){var i="data-"+n.replace(P,"-$1").toLowerCase();r=e.getAttribute(i);if(typeof r=="string"){try{r=r==="true"?!0:r==="false"?!1:r==="null"?null:+r+""===r?+r:D.test(r)?v.parseJSON(r):r}catch(s){}v.data(e,n,r)}else r=t}return r}function B(e){var t;for(t in e){if(t==="data"&&v.isEmptyObject(e[t]))continue;if(t!=="toJSON")return!1}return!0}function et(){return!1}function tt(){return!0}function ut(e){return!e||!e.parentNode||e.parentNode.nodeType===11}function at(e,t){do e=e[t];while(e&&e.nodeType!==1);return e}function ft(e,t,n){t=t||0;if(v.isFunction(t))return v.grep(e,function(e,r){var i=!!t.call(e,r,e);return i===n});if(t.nodeType)return v.grep(e,function(e,r){return e===t===n});if(typeof t=="string"){var r=v.grep(e,function(e){return e.nodeType===1});if(it.test(t))return v.filter(t,r,!n);t=v.filter(t,r)}return v.grep(e,function(e,r){return v.inArray(e,t)>=0===n})}function lt(e){var t=ct.split("|"),n=e.createDocumentFragment();if(n.createElement)while(t.length)n.createElement(t.pop());return n}function Lt(e,t){return e.getElementsByTagName(t)[0]||e.appendChild(e.ownerDocument.createElement(t))}function At(e,t){if(t.nodeType!==1||!v.hasData(e))return;var n,r,i,s=v._data(e),o=v._data(t,s),u=s.events;if(u){delete o.handle,o.events={};for(n in u)for(r=0,i=u[n].length;r<i;r++)v.event.add(t,n,u[n][r])}o.data&&(o.data=v.extend({},o.data))}function Ot(e,t){var n;if(t.nodeType!==1)return;t.clearAttributes&&t.clearAttributes(),t.mergeAttributes&&t.mergeAttributes(e),n=t.nodeName.toLowerCase(),n==="object"?(t.parentNode&&(t.outerHTML=e.outerHTML),v.support.html5Clone&&e.innerHTML&&!v.trim(t.innerHTML)&&(t.innerHTML=e.innerHTML)):n==="input"&&Et.test(e.type)?(t.defaultChecked=t.checked=e.checked,t.value!==e.value&&(t.value=e.value)):n==="option"?t.selected=e.defaultSelected:n==="input"||n==="textarea"?t.defaultValue=e.defaultValue:n==="script"&&t.text!==e.text&&(t.text=e.text),t.removeAttribute(v.expando)}function Mt(e){return typeof e.getElementsByTagName!="undefined"?e.getElementsByTagName("*"):typeof e.querySelectorAll!="undefined"?e.querySelectorAll("*"):[]}function _t(e){Et.test(e.type)&&(e.defaultChecked=e.checked)}function Qt(e,t){if(t in e)return t;var n=t.charAt(0).toUpperCase()+t.slice(1),r=t,i=Jt.length;while(i--){t=Jt[i]+n;if(t in e)return t}return r}function Gt(e,t){return e=t||e,v.css(e,"display")==="none"||!v.contains(e.ownerDocument,e)}function Yt(e,t){var n,r,i=[],s=0,o=e.length;for(;s<o;s++){n=e[s];if(!n.style)continue;i[s]=v._data(n,"olddisplay"),t?(!i[s]&&n.style.display==="none"&&(n.style.display=""),n.style.display===""&&Gt(n)&&(i[s]=v._data(n,"olddisplay",nn(n.nodeName)))):(r=Dt(n,"display"),!i[s]&&r!=="none"&&v._data(n,"olddisplay",r))}for(s=0;s<o;s++){n=e[s];if(!n.style)continue;if(!t||n.style.display==="none"||n.style.display==="")n.style.display=t?i[s]||"":"none"}return e}function Zt(e,t,n){var r=Rt.exec(t);return r?Math.max(0,r[1]-(n||0))+(r[2]||"px"):t}function en(e,t,n,r){var i=n===(r?"border":"content")?4:t==="width"?1:0,s=0;for(;i<4;i+=2)n==="margin"&&(s+=v.css(e,n+$t[i],!0)),r?(n==="content"&&(s-=parseFloat(Dt(e,"padding"+$t[i]))||0),n!=="margin"&&(s-=parseFloat(Dt(e,"border"+$t[i]+"Width"))||0)):(s+=parseFloat(Dt(e,"padding"+$t[i]))||0,n!=="padding"&&(s+=parseFloat(Dt(e,"border"+$t[i]+"Width"))||0));return s}function tn(e,t,n){var r=t==="width"?e.offsetWidth:e.offsetHeight,i=!0,s=v.support.boxSizing&&v.css(e,"boxSizing")==="border-box";if(r<=0||r==null){r=Dt(e,t);if(r<0||r==null)r=e.style[t];if(Ut.test(r))return r;i=s&&(v.support.boxSizingReliable||r===e.style[t]),r=parseFloat(r)||0}return r+en(e,t,n||(s?"border":"content"),i)+"px"}function nn(e){if(Wt[e])return Wt[e];var t=v("<"+e+">").appendTo(i.body),n=t.css("display");t.remove();if(n==="none"||n===""){Pt=i.body.appendChild(Pt||v.extend(i.createElement("iframe"),{frameBorder:0,width:0,height:0}));if(!Ht||!Pt.createElement)Ht=(Pt.contentWindow||Pt.contentDocument).document,Ht.write("<!doctype html><html><body>"),Ht.close();t=Ht.body.appendChild(Ht.createElement(e)),n=Dt(t,"display"),i.body.removeChild(Pt)}return Wt[e]=n,n}function fn(e,t,n,r){var i;if(v.isArray(t))v.each(t,function(t,i){n||sn.test(e)?r(e,i):fn(e+"["+(typeof i=="object"?t:"")+"]",i,n,r)});else if(!n&&v.type(t)==="object")for(i in t)fn(e+"["+i+"]",t[i],n,r);else r(e,t)}function Cn(e){return function(t,n){typeof t!="string"&&(n=t,t="*");var r,i,s,o=t.toLowerCase().split(y),u=0,a=o.length;if(v.isFunction(n))for(;u<a;u++)r=o[u],s=/^\+/.test(r),s&&(r=r.substr(1)||"*"),i=e[r]=e[r]||[],i[s?"unshift":"push"](n)}}function kn(e,n,r,i,s,o){s=s||n.dataTypes[0],o=o||{},o[s]=!0;var u,a=e[s],f=0,l=a?a.length:0,c=e===Sn;for(;f<l&&(c||!u);f++)u=a[f](n,r,i),typeof u=="string"&&(!c||o[u]?u=t:(n.dataTypes.unshift(u),u=kn(e,n,r,i,u,o)));return(c||!u)&&!o["*"]&&(u=kn(e,n,r,i,"*",o)),u}function Ln(e,n){var r,i,s=v.ajaxSettings.flatOptions||{};for(r in n)n[r]!==t&&((s[r]?e:i||(i={}))[r]=n[r]);i&&v.extend(!0,e,i)}function An(e,n,r){var i,s,o,u,a=e.contents,f=e.dataTypes,l=e.responseFields;for(s in l)s in r&&(n[l[s]]=r[s]);while(f[0]==="*")f.shift(),i===t&&(i=e.mimeType||n.getResponseHeader("content-type"));if(i)for(s in a)if(a[s]&&a[s].test(i)){f.unshift(s);break}if(f[0]in r)o=f[0];else{for(s in r){if(!f[0]||e.converters[s+" "+f[0]]){o=s;break}u||(u=s)}o=o||u}if(o)return o!==f[0]&&f.unshift(o),r[o]}function On(e,t){var n,r,i,s,o=e.dataTypes.slice(),u=o[0],a={},f=0;e.dataFilter&&(t=e.dataFilter(t,e.dataType));if(o[1])for(n in e.converters)a[n.toLowerCase()]=e.converters[n];for(;i=o[++f];)if(i!=="*"){if(u!=="*"&&u!==i){n=a[u+" "+i]||a["* "+i];if(!n)for(r in a){s=r.split(" ");if(s[1]===i){n=a[u+" "+s[0]]||a["* "+s[0]];if(n){n===!0?n=a[r]:a[r]!==!0&&(i=s[0],o.splice(f--,0,i));break}}}if(n!==!0)if(n&&e["throws"])t=n(t);else try{t=n(t)}catch(l){return{state:"parsererror",error:n?l:"No conversion from "+u+" to "+i}}}u=i}return{state:"success",data:t}}function Fn(){try{return new e.XMLHttpRequest}catch(t){}}function In(){try{return new e.ActiveXObject("Microsoft.XMLHTTP")}catch(t){}}function $n(){return setTimeout(function(){qn=t},0),qn=v.now()}function Jn(e,t){v.each(t,function(t,n){var r=(Vn[t]||[]).concat(Vn["*"]),i=0,s=r.length;for(;i<s;i++)if(r[i].call(e,t,n))return})}function Kn(e,t,n){var r,i=0,s=0,o=Xn.length,u=v.Deferred().always(function(){delete a.elem}),a=function(){var t=qn||$n(),n=Math.max(0,f.startTime+f.duration-t),r=n/f.duration||0,i=1-r,s=0,o=f.tweens.length;for(;s<o;s++)f.tweens[s].run(i);return u.notifyWith(e,[f,i,n]),i<1&&o?n:(u.resolveWith(e,[f]),!1)},f=u.promise({elem:e,props:v.extend({},t),opts:v.extend(!0,{specialEasing:{}},n),originalProperties:t,originalOptions:n,startTime:qn||$n(),duration:n.duration,tweens:[],createTween:function(t,n,r){var i=v.Tween(e,f.opts,t,n,f.opts.specialEasing[t]||f.opts.easing);return f.tweens.push(i),i},stop:function(t){var n=0,r=t?f.tweens.length:0;for(;n<r;n++)f.tweens[n].run(1);return t?u.resolveWith(e,[f,t]):u.rejectWith(e,[f,t]),this}}),l=f.props;Qn(l,f.opts.specialEasing);for(;i<o;i++){r=Xn[i].call(f,e,l,f.opts);if(r)return r}return Jn(f,l),v.isFunction(f.opts.start)&&f.opts.start.call(e,f),v.fx.timer(v.extend(a,{anim:f,queue:f.opts.queue,elem:e})),f.progress(f.opts.progress).done(f.opts.done,f.opts.complete).fail(f.opts.fail).always(f.opts.always)}function Qn(e,t){var n,r,i,s,o;for(n in e){r=v.camelCase(n),i=t[r],s=e[n],v.isArray(s)&&(i=s[1],s=e[n]=s[0]),n!==r&&(e[r]=s,delete e[n]),o=v.cssHooks[r];if(o&&"expand"in o){s=o.expand(s),delete e[r];for(n in s)n in e||(e[n]=s[n],t[n]=i)}else t[r]=i}}function Gn(e,t,n){var r,i,s,o,u,a,f,l,c,h=this,p=e.style,d={},m=[],g=e.nodeType&&Gt(e);n.queue||(l=v._queueHooks(e,"fx"),l.unqueued==null&&(l.unqueued=0,c=l.empty.fire,l.empty.fire=function(){l.unqueued||c()}),l.unqueued++,h.always(function(){h.always(function(){l.unqueued--,v.queue(e,"fx").length||l.empty.fire()})})),e.nodeType===1&&("height"in t||"width"in t)&&(n.overflow=[p.overflow,p.overflowX,p.overflowY],v.css(e,"display")==="inline"&&v.css(e,"float")==="none"&&(!v.support.inlineBlockNeedsLayout||nn(e.nodeName)==="inline"?p.display="inline-block":p.zoom=1)),n.overflow&&(p.overflow="hidden",v.support.shrinkWrapBlocks||h.done(function(){p.overflow=n.overflow[0],p.overflowX=n.overflow[1],p.overflowY=n.overflow[2]}));for(r in t){s=t[r];if(Un.exec(s)){delete t[r],a=a||s==="toggle";if(s===(g?"hide":"show"))continue;m.push(r)}}o=m.length;if(o){u=v._data(e,"fxshow")||v._data(e,"fxshow",{}),"hidden"in u&&(g=u.hidden),a&&(u.hidden=!g),g?v(e).show():h.done(function(){v(e).hide()}),h.done(function(){var t;v.removeData(e,"fxshow",!0);for(t in d)v.style(e,t,d[t])});for(r=0;r<o;r++)i=m[r],f=h.createTween(i,g?u[i]:0),d[i]=u[i]||v.style(e,i),i in u||(u[i]=f.start,g&&(f.end=f.start,f.start=i==="width"||i==="height"?1:0))}}function Yn(e,t,n,r,i){return new Yn.prototype.init(e,t,n,r,i)}function Zn(e,t){var n,r={height:e},i=0;t=t?1:0;for(;i<4;i+=2-t)n=$t[i],r["margin"+n]=r["padding"+n]=e;return t&&(r.opacity=r.width=e),r}function tr(e){return v.isWindow(e)?e:e.nodeType===9?e.defaultView||e.parentWindow:!1}var n,r,i=e.document,s=e.location,o=e.navigator,u=e.jQuery,a=e.$,f=Array.prototype.push,l=Array.prototype.slice,c=Array.prototype.indexOf,h=Object.prototype.toString,p=Object.prototype.hasOwnProperty,d=String.prototype.trim,v=function(e,t){return new v.fn.init(e,t,n)},m=/[\-+]?(?:\d*\.|)\d+(?:[eE][\-+]?\d+|)/.source,g=/\S/,y=/\s+/,b=/^[\s\uFEFF\xA0]+|[\s\uFEFF\xA0]+$/g,w=/^(?:[^#<]*(<[\w\W]+>)[^>]*$|#([\w\-]*)$)/,E=/^<(\w+)\s*\/?>(?:<\/\1>|)$/,S=/^[\],:{}\s]*$/,x=/(?:^|:|,)(?:\s*\[)+/g,T=/\\(?:["\\\/bfnrt]|u[\da-fA-F]{4})/g,N=/"[^"\\\r\n]*"|true|false|null|-?(?:\d\d*\.|)\d+(?:[eE][\-+]?\d+|)/g,C=/^-ms-/,k=/-([\da-z])/gi,L=function(e,t){return(t+"").toUpperCase()},A=function(){i.addEventListener?(i.removeEventListener("DOMContentLoaded",A,!1),v.ready()):i.readyState==="complete"&&(i.detachEvent("onreadystatechange",A),v.ready())},O={};v.fn=v.prototype={constructor:v,init:function(e,n,r){var s,o,u,a;if(!e)return this;if(e.nodeType)return this.context=this[0]=e,this.length=1,this;if(typeof e=="string"){e.charAt(0)==="<"&&e.charAt(e.length-1)===">"&&e.length>=3?s=[null,e,null]:s=w.exec(e);if(s&&(s[1]||!n)){if(s[1])return n=n instanceof v?n[0]:n,a=n&&n.nodeType?n.ownerDocument||n:i,e=v.parseHTML(s[1],a,!0),E.test(s[1])&&v.isPlainObject(n)&&this.attr.call(e,n,!0),v.merge(this,e);o=i.getElementById(s[2]);if(o&&o.parentNode){if(o.id!==s[2])return r.find(e);this.length=1,this[0]=o}return this.context=i,this.selector=e,this}return!n||n.jquery?(n||r).find(e):this.constructor(n).find(e)}return v.isFunction(e)?r.ready(e):(e.selector!==t&&(this.selector=e.selector,this.context=e.context),v.makeArray(e,this))},selector:"",jquery:"1.8.3",length:0,size:function(){return this.length},toArray:function(){return l.call(this)},get:function(e){return e==null?this.toArray():e<0?this[this.length+e]:this[e]},pushStack:function(e,t,n){var r=v.merge(this.constructor(),e);return r.prevObject=this,r.context=this.context,t==="find"?r.selector=this.selector+(this.selector?" ":"")+n:t&&(r.selector=this.selector+"."+t+"("+n+")"),r},each:function(e,t){return v.each(this,e,t)},ready:function(e){return v.ready.promise().done(e),this},eq:function(e){return e=+e,e===-1?this.slice(e):this.slice(e,e+1)},first:function(){return this.eq(0)},last:function(){return this.eq(-1)},slice:function(){return this.pushStack(l.apply(this,arguments),"slice",l.call(arguments).join(","))},map:function(e){return this.pushStack(v.map(this,function(t,n){return e.call(t,n,t)}))},end:function(){return this.prevObject||this.constructor(null)},push:f,sort:[].sort,splice:[].splice},v.fn.init.prototype=v.fn,v.extend=v.fn.extend=function(){var e,n,r,i,s,o,u=arguments[0]||{},a=1,f=arguments.length,l=!1;typeof u=="boolean"&&(l=u,u=arguments[1]||{},a=2),typeof u!="object"&&!v.isFunction(u)&&(u={}),f===a&&(u=this,--a);for(;a<f;a++)if((e=arguments[a])!=null)for(n in e){r=u[n],i=e[n];if(u===i)continue;l&&i&&(v.isPlainObject(i)||(s=v.isArray(i)))?(s?(s=!1,o=r&&v.isArray(r)?r:[]):o=r&&v.isPlainObject(r)?r:{},u[n]=v.extend(l,o,i)):i!==t&&(u[n]=i)}return u},v.extend({noConflict:function(t){return e.$===v&&(e.$=a),t&&e.jQuery===v&&(e.jQuery=u),v},isReady:!1,readyWait:1,holdReady:function(e){e?v.readyWait++:v.ready(!0)},ready:function(e){if(e===!0?--v.readyWait:v.isReady)return;if(!i.body)return setTimeout(v.ready,1);v.isReady=!0;if(e!==!0&&--v.readyWait>0)return;r.resolveWith(i,[v]),v.fn.trigger&&v(i).trigger("ready").off("ready")},isFunction:function(e){return v.type(e)==="function"},isArray:Array.isArray||function(e){return v.type(e)==="array"},isWindow:function(e){return e!=null&&e==e.window},isNumeric:function(e){return!isNaN(parseFloat(e))&&isFinite(e)},type:function(e){return e==null?String(e):O[h.call(e)]||"object"},isPlainObject:function(e){if(!e||v.type(e)!=="object"||e.nodeType||v.isWindow(e))return!1;try{if(e.constructor&&!p.call(e,"constructor")&&!p.call(e.constructor.prototype,"isPrototypeOf"))return!1}catch(n){return!1}var r;for(r in e);return r===t||p.call(e,r)},isEmptyObject:function(e){var t;for(t in e)return!1;return!0},error:function(e){throw new Error(e)},parseHTML:function(e,t,n){var r;return!e||typeof e!="string"?null:(typeof t=="boolean"&&(n=t,t=0),t=t||i,(r=E.exec(e))?[t.createElement(r[1])]:(r=v.buildFragment([e],t,n?null:[]),v.merge([],(r.cacheable?v.clone(r.fragment):r.fragment).childNodes)))},parseJSON:function(t){if(!t||typeof t!="string")return null;t=v.trim(t);if(e.JSON&&e.JSON.parse)return e.JSON.parse(t);if(S.test(t.replace(T,"@").replace(N,"]").replace(x,"")))return(new Function("return "+t))();v.error("Invalid JSON: "+t)},parseXML:function(n){var r,i;if(!n||typeof n!="string")return null;try{e.DOMParser?(i=new DOMParser,r=i.parseFromString(n,"text/xml")):(r=new ActiveXObject("Microsoft.XMLDOM"),r.async="false",r.loadXML(n))}catch(s){r=t}return(!r||!r.documentElement||r.getElementsByTagName("parsererror").length)&&v.error("Invalid XML: "+n),r},noop:function(){},globalEval:function(t){t&&g.test(t)&&(e.execScript||function(t){e.eval.call(e,t)})(t)},camelCase:function(e){return e.replace(C,"ms-").replace(k,L)},nodeName:function(e,t){return e.nodeName&&e.nodeName.toLowerCase()===t.toLowerCase()},each:function(e,n,r){var i,s=0,o=e.length,u=o===t||v.isFunction(e);if(r){if(u){for(i in e)if(n.apply(e[i],r)===!1)break}else for(;s<o;)if(n.apply(e[s++],r)===!1)break}else if(u){for(i in e)if(n.call(e[i],i,e[i])===!1)break}else for(;s<o;)if(n.call(e[s],s,e[s++])===!1)break;return e},trim:d&&!d.call("\ufeff\u00a0")?function(e){return e==null?"":d.call(e)}:function(e){return e==null?"":(e+"").replace(b,"")},makeArray:function(e,t){var n,r=t||[];return e!=null&&(n=v.type(e),e.length==null||n==="string"||n==="function"||n==="regexp"||v.isWindow(e)?f.call(r,e):v.merge(r,e)),r},inArray:function(e,t,n){var r;if(t){if(c)return c.call(t,e,n);r=t.length,n=n?n<0?Math.max(0,r+n):n:0;for(;n<r;n++)if(n in t&&t[n]===e)return n}return-1},merge:function(e,n){var r=n.length,i=e.length,s=0;if(typeof r=="number")for(;s<r;s++)e[i++]=n[s];else while(n[s]!==t)e[i++]=n[s++];return e.length=i,e},grep:function(e,t,n){var r,i=[],s=0,o=e.length;n=!!n;for(;s<o;s++)r=!!t(e[s],s),n!==r&&i.push(e[s]);return i},map:function(e,n,r){var i,s,o=[],u=0,a=e.length,f=e instanceof v||a!==t&&typeof a=="number"&&(a>0&&e[0]&&e[a-1]||a===0||v.isArray(e));if(f)for(;u<a;u++)i=n(e[u],u,r),i!=null&&(o[o.length]=i);else for(s in e)i=n(e[s],s,r),i!=null&&(o[o.length]=i);return o.concat.apply([],o)},guid:1,proxy:function(e,n){var r,i,s;return typeof n=="string"&&(r=e[n],n=e,e=r),v.isFunction(e)?(i=l.call(arguments,2),s=function(){return e.apply(n,i.concat(l.call(arguments)))},s.guid=e.guid=e.guid||v.guid++,s):t},access:function(e,n,r,i,s,o,u){var a,f=r==null,l=0,c=e.length;if(r&&typeof r=="object"){for(l in r)v.access(e,n,l,r[l],1,o,i);s=1}else if(i!==t){a=u===t&&v.isFunction(i),f&&(a?(a=n,n=function(e,t,n){return a.call(v(e),n)}):(n.call(e,i),n=null));if(n)for(;l<c;l++)n(e[l],r,a?i.call(e[l],l,n(e[l],r)):i,u);s=1}return s?e:f?n.call(e):c?n(e[0],r):o},now:function(){return(new Date).getTime()}}),v.ready.promise=function(t){if(!r){r=v.Deferred();if(i.readyState==="complete")setTimeout(v.ready,1);else if(i.addEventListener)i.addEventListener("DOMContentLoaded",A,!1),e.addEventListener("load",v.ready,!1);else{i.attachEvent("onreadystatechange",A),e.attachEvent("onload",v.ready);var n=!1;try{n=e.frameElement==null&&i.documentElement}catch(s){}n&&n.doScroll&&function o(){if(!v.isReady){try{n.doScroll("left")}catch(e){return setTimeout(o,50)}v.ready()}}()}}return r.promise(t)},v.each("Boolean Number String Function Array Date RegExp Object".split(" "),function(e,t){O["[object "+t+"]"]=t.toLowerCase()}),n=v(i);var M={};v.Callbacks=function(e){e=typeof e=="string"?M[e]||_(e):v.extend({},e);var n,r,i,s,o,u,a=[],f=!e.once&&[],l=function(t){n=e.memory&&t,r=!0,u=s||0,s=0,o=a.length,i=!0;for(;a&&u<o;u++)if(a[u].apply(t[0],t[1])===!1&&e.stopOnFalse){n=!1;break}i=!1,a&&(f?f.length&&l(f.shift()):n?a=[]:c.disable())},c={add:function(){if(a){var t=a.length;(function r(t){v.each(t,function(t,n){var i=v.type(n);i==="function"?(!e.unique||!c.has(n))&&a.push(n):n&&n.length&&i!=="string"&&r(n)})})(arguments),i?o=a.length:n&&(s=t,l(n))}return this},remove:function(){return a&&v.each(arguments,function(e,t){var n;while((n=v.inArray(t,a,n))>-1)a.splice(n,1),i&&(n<=o&&o--,n<=u&&u--)}),this},has:function(e){return v.inArray(e,a)>-1},empty:function(){return a=[],this},disable:function(){return a=f=n=t,this},disabled:function(){return!a},lock:function(){return f=t,n||c.disable(),this},locked:function(){return!f},fireWith:function(e,t){return t=t||[],t=[e,t.slice?t.slice():t],a&&(!r||f)&&(i?f.push(t):l(t)),this},fire:function(){return c.fireWith(this,arguments),this},fired:function(){return!!r}};return c},v.extend({Deferred:function(e){var t=[["resolve","done",v.Callbacks("once memory"),"resolved"],["reject","fail",v.Callbacks("once memory"),"rejected"],["notify","progress",v.Callbacks("memory")]],n="pending",r={state:function(){return n},always:function(){return i.done(arguments).fail(arguments),this},then:function(){var e=arguments;return v.Deferred(function(n){v.each(t,function(t,r){var s=r[0],o=e[t];i[r[1]](v.isFunction(o)?function(){var e=o.apply(this,arguments);e&&v.isFunction(e.promise)?e.promise().done(n.resolve).fail(n.reject).progress(n.notify):n[s+"With"](this===i?n:this,[e])}:n[s])}),e=null}).promise()},promise:function(e){return e!=null?v.extend(e,r):r}},i={};return r.pipe=r.then,v.each(t,function(e,s){var o=s[2],u=s[3];r[s[1]]=o.add,u&&o.add(function(){n=u},t[e^1][2].disable,t[2][2].lock),i[s[0]]=o.fire,i[s[0]+"With"]=o.fireWith}),r.promise(i),e&&e.call(i,i),i},when:function(e){var t=0,n=l.call(arguments),r=n.length,i=r!==1||e&&v.isFunction(e.promise)?r:0,s=i===1?e:v.Deferred(),o=function(e,t,n){return function(r){t[e]=this,n[e]=arguments.length>1?l.call(arguments):r,n===u?s.notifyWith(t,n):--i||s.resolveWith(t,n)}},u,a,f;if(r>1){u=new Array(r),a=new Array(r),f=new Array(r);for(;t<r;t++)n[t]&&v.isFunction(n[t].promise)?n[t].promise().done(o(t,f,n)).fail(s.reject).progress(o(t,a,u)):--i}return i||s.resolveWith(f,n),s.promise()}}),v.support=function(){var t,n,r,s,o,u,a,f,l,c,h,p=i.createElement("div");p.setAttribute("className","t"),p.innerHTML="  <link/><table></table><a href='/a'>a</a><input type='checkbox'/>",n=p.getElementsByTagName("*"),r=p.getElementsByTagName("a")[0];if(!n||!r||!n.length)return{};s=i.createElement("select"),o=s.appendChild(i.createElement("option")),u=p.getElementsByTagName("input")[0],r.style.cssText="top:1px;float:left;opacity:.5",t={leadingWhitespace:p.firstChild.nodeType===3,tbody:!p.getElementsByTagName("tbody").length,htmlSerialize:!!p.getElementsByTagName("link").length,style:/top/.test(r.getAttribute("style")),hrefNormalized:r.getAttribute("href")==="/a",opacity:/^0.5/.test(r.style.opacity),cssFloat:!!r.style.cssFloat,checkOn:u.value==="on",optSelected:o.selected,getSetAttribute:p.className!=="t",enctype:!!i.createElement("form").enctype,html5Clone:i.createElement("nav").cloneNode(!0).outerHTML!=="<:nav></:nav>",boxModel:i.compatMode==="CSS1Compat",submitBubbles:!0,changeBubbles:!0,focusinBubbles:!1,deleteExpando:!0,noCloneEvent:!0,inlineBlockNeedsLayout:!1,shrinkWrapBlocks:!1,reliableMarginRight:!0,boxSizingReliable:!0,pixelPosition:!1},u.checked=!0,t.noCloneChecked=u.cloneNode(!0).checked,s.disabled=!0,t.optDisabled=!o.disabled;try{delete p.test}catch(d){t.deleteExpando=!1}!p.addEventListener&&p.attachEvent&&p.fireEvent&&(p.attachEvent("onclick",h=function(){t.noCloneEvent=!1}),p.cloneNode(!0).fireEvent("onclick"),p.detachEvent("onclick",h)),u=i.createElement("input"),u.value="t",u.setAttribute("type","radio"),t.radioValue=u.value==="t",u.setAttribute("checked","checked"),u.setAttribute("name","t"),p.appendChild(u),a=i.createDocumentFragment(),a.appendChild(p.lastChild),t.checkClone=a.cloneNode(!0).cloneNode(!0).lastChild.checked,t.appendChecked=u.checked,a.removeChild(u),a.appendChild(p);if(p.attachEvent)for(l in{submit:!0,change:!0,focusin:!0})f="on"+l,c=f in p,c||(p.setAttribute(f,"return;"),c=typeof p[f]=="function"),t[l+"Bubbles"]=c;return v(function(){var n,r,s,o,u="padding:0;margin:0;border:0;display:block;overflow:hidden;",a=i.getElementsByTagName("body")[0];if(!a)return;n=i.createElement("div"),n.style.cssText="visibility:hidden;border:0;width:0;height:0;position:static;top:0;margin-top:1px",a.insertBefore(n,a.firstChild),r=i.createElement("div"),n.appendChild(r),r.innerHTML="<table><tr><td></td><td>t</td></tr></table>",s=r.getElementsByTagName("td"),s[0].style.cssText="padding:0;margin:0;border:0;display:none",c=s[0].offsetHeight===0,s[0].style.display="",s[1].style.display="none",t.reliableHiddenOffsets=c&&s[0].offsetHeight===0,r.innerHTML="",r.style.cssText="box-sizing:border-box;-moz-box-sizing:border-box;-webkit-box-sizing:border-box;padding:1px;border:1px;display:block;width:4px;margin-top:1%;position:absolute;top:1%;",t.boxSizing=r.offsetWidth===4,t.doesNotIncludeMarginInBodyOffset=a.offsetTop!==1,e.getComputedStyle&&(t.pixelPosition=(e.getComputedStyle(r,null)||{}).top!=="1%",t.boxSizingReliable=(e.getComputedStyle(r,null)||{width:"4px"}).width==="4px",o=i.createElement("div"),o.style.cssText=r.style.cssText=u,o.style.marginRight=o.style.width="0",r.style.width="1px",r.appendChild(o),t.reliableMarginRight=!parseFloat((e.getComputedStyle(o,null)||{}).marginRight)),typeof r.style.zoom!="undefined"&&(r.innerHTML="",r.style.cssText=u+"width:1px;padding:1px;display:inline;zoom:1",t.inlineBlockNeedsLayout=r.offsetWidth===3,r.style.display="block",r.style.overflow="visible",r.innerHTML="<div></div>",r.firstChild.style.width="5px",t.shrinkWrapBlocks=r.offsetWidth!==3,n.style.zoom=1),a.removeChild(n),n=r=s=o=null}),a.removeChild(p),n=r=s=o=u=a=p=null,t}();var D=/(?:\{[\s\S]*\}|\[[\s\S]*\])$/,P=/([A-Z])/g;v.extend({cache:{},deletedIds:[],uuid:0,expando:"jQuery"+(v.fn.jquery+Math.random()).replace(/\D/g,""),noData:{embed:!0,object:"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000",applet:!0},hasData:function(e){return e=e.nodeType?v.cache[e[v.expando]]:e[v.expando],!!e&&!B(e)},data:function(e,n,r,i){if(!v.acceptData(e))return;var s,o,u=v.expando,a=typeof n=="string",f=e.nodeType,l=f?v.cache:e,c=f?e[u]:e[u]&&u;if((!c||!l[c]||!i&&!l[c].data)&&a&&r===t)return;c||(f?e[u]=c=v.deletedIds.pop()||v.guid++:c=u),l[c]||(l[c]={},f||(l[c].toJSON=v.noop));if(typeof n=="object"||typeof n=="function")i?l[c]=v.extend(l[c],n):l[c].data=v.extend(l[c].data,n);return s=l[c],i||(s.data||(s.data={}),s=s.data),r!==t&&(s[v.camelCase(n)]=r),a?(o=s[n],o==null&&(o=s[v.camelCase(n)])):o=s,o},removeData:function(e,t,n){if(!v.acceptData(e))return;var r,i,s,o=e.nodeType,u=o?v.cache:e,a=o?e[v.expando]:v.expando;if(!u[a])return;if(t){r=n?u[a]:u[a].data;if(r){v.isArray(t)||(t in r?t=[t]:(t=v.camelCase(t),t in r?t=[t]:t=t.split(" ")));for(i=0,s=t.length;i<s;i++)delete r[t[i]];if(!(n?B:v.isEmptyObject)(r))return}}if(!n){delete u[a].data;if(!B(u[a]))return}o?v.cleanData([e],!0):v.support.deleteExpando||u!=u.window?delete u[a]:u[a]=null},_data:function(e,t,n){return v.data(e,t,n,!0)},acceptData:function(e){var t=e.nodeName&&v.noData[e.nodeName.toLowerCase()];return!t||t!==!0&&e.getAttribute("classid")===t}}),v.fn.extend({data:function(e,n){var r,i,s,o,u,a=this[0],f=0,l=null;if(e===t){if(this.length){l=v.data(a);if(a.nodeType===1&&!v._data(a,"parsedAttrs")){s=a.attributes;for(u=s.length;f<u;f++)o=s[f].name,o.indexOf("data-")||(o=v.camelCase(o.substring(5)),H(a,o,l[o]));v._data(a,"parsedAttrs",!0)}}return l}return typeof e=="object"?this.each(function(){v.data(this,e)}):(r=e.split(".",2),r[1]=r[1]?"."+r[1]:"",i=r[1]+"!",v.access(this,function(n){if(n===t)return l=this.triggerHandler("getData"+i,[r[0]]),l===t&&a&&(l=v.data(a,e),l=H(a,e,l)),l===t&&r[1]?this.data(r[0]):l;r[1]=n,this.each(function(){var t=v(this);t.triggerHandler("setData"+i,r),v.data(this,e,n),t.triggerHandler("changeData"+i,r)})},null,n,arguments.length>1,null,!1))},removeData:function(e){return this.each(function(){v.removeData(this,e)})}}),v.extend({queue:function(e,t,n){var r;if(e)return t=(t||"fx")+"queue",r=v._data(e,t),n&&(!r||v.isArray(n)?r=v._data(e,t,v.makeArray(n)):r.push(n)),r||[]},dequeue:function(e,t){t=t||"fx";var n=v.queue(e,t),r=n.length,i=n.shift(),s=v._queueHooks(e,t),o=function(){v.dequeue(e,t)};i==="inprogress"&&(i=n.shift(),r--),i&&(t==="fx"&&n.unshift("inprogress"),delete s.stop,i.call(e,o,s)),!r&&s&&s.empty.fire()},_queueHooks:function(e,t){var n=t+"queueHooks";return v._data(e,n)||v._data(e,n,{empty:v.Callbacks("once memory").add(function(){v.removeData(e,t+"queue",!0),v.removeData(e,n,!0)})})}}),v.fn.extend({queue:function(e,n){var r=2;return typeof e!="string"&&(n=e,e="fx",r--),arguments.length<r?v.queue(this[0],e):n===t?this:this.each(function(){var t=v.queue(this,e,n);v._queueHooks(this,e),e==="fx"&&t[0]!=="inprogress"&&v.dequeue(this,e)})},dequeue:function(e){return this.each(function(){v.dequeue(this,e)})},delay:function(e,t){return e=v.fx?v.fx.speeds[e]||e:e,t=t||"fx",this.queue(t,function(t,n){var r=setTimeout(t,e);n.stop=function(){clearTimeout(r)}})},clearQueue:function(e){return this.queue(e||"fx",[])},promise:function(e,n){var r,i=1,s=v.Deferred(),o=this,u=this.length,a=function(){--i||s.resolveWith(o,[o])};typeof e!="string"&&(n=e,e=t),e=e||"fx";while(u--)r=v._data(o[u],e+"queueHooks"),r&&r.empty&&(i++,r.empty.add(a));return a(),s.promise(n)}});var j,F,I,q=/[\t\r\n]/g,R=/\r/g,U=/^(?:button|input)$/i,z=/^(?:button|input|object|select|textarea)$/i,W=/^a(?:rea|)$/i,X=/^(?:autofocus|autoplay|async|checked|controls|defer|disabled|hidden|loop|multiple|open|readonly|required|scoped|selected)$/i,V=v.support.getSetAttribute;v.fn.extend({attr:function(e,t){return v.access(this,v.attr,e,t,arguments.length>1)},removeAttr:function(e){return this.each(function(){v.removeAttr(this,e)})},prop:function(e,t){return v.access(this,v.prop,e,t,arguments.length>1)},removeProp:function(e){return e=v.propFix[e]||e,this.each(function(){try{this[e]=t,delete this[e]}catch(n){}})},addClass:function(e){var t,n,r,i,s,o,u;if(v.isFunction(e))return this.each(function(t){v(this).addClass(e.call(this,t,this.className))});if(e&&typeof e=="string"){t=e.split(y);for(n=0,r=this.length;n<r;n++){i=this[n];if(i.nodeType===1)if(!i.className&&t.length===1)i.className=e;else{s=" "+i.className+" ";for(o=0,u=t.length;o<u;o++)s.indexOf(" "+t[o]+" ")<0&&(s+=t[o]+" ");i.className=v.trim(s)}}}return this},removeClass:function(e){var n,r,i,s,o,u,a;if(v.isFunction(e))return this.each(function(t){v(this).removeClass(e.call(this,t,this.className))});if(e&&typeof e=="string"||e===t){n=(e||"").split(y);for(u=0,a=this.length;u<a;u++){i=this[u];if(i.nodeType===1&&i.className){r=(" "+i.className+" ").replace(q," ");for(s=0,o=n.length;s<o;s++)while(r.indexOf(" "+n[s]+" ")>=0)r=r.replace(" "+n[s]+" "," ");i.className=e?v.trim(r):""}}}return this},toggleClass:function(e,t){var n=typeof e,r=typeof t=="boolean";return v.isFunction(e)?this.each(function(n){v(this).toggleClass(e.call(this,n,this.className,t),t)}):this.each(function(){if(n==="string"){var i,s=0,o=v(this),u=t,a=e.split(y);while(i=a[s++])u=r?u:!o.hasClass(i),o[u?"addClass":"removeClass"](i)}else if(n==="undefined"||n==="boolean")this.className&&v._data(this,"__className__",this.className),this.className=this.className||e===!1?"":v._data(this,"__className__")||""})},hasClass:function(e){var t=" "+e+" ",n=0,r=this.length;for(;n<r;n++)if(this[n].nodeType===1&&(" "+this[n].className+" ").replace(q," ").indexOf(t)>=0)return!0;return!1},val:function(e){var n,r,i,s=this[0];if(!arguments.length){if(s)return n=v.valHooks[s.type]||v.valHooks[s.nodeName.toLowerCase()],n&&"get"in n&&(r=n.get(s,"value"))!==t?r:(r=s.value,typeof r=="string"?r.replace(R,""):r==null?"":r);return}return i=v.isFunction(e),this.each(function(r){var s,o=v(this);if(this.nodeType!==1)return;i?s=e.call(this,r,o.val()):s=e,s==null?s="":typeof s=="number"?s+="":v.isArray(s)&&(s=v.map(s,function(e){return e==null?"":e+""})),n=v.valHooks[this.type]||v.valHooks[this.nodeName.toLowerCase()];if(!n||!("set"in n)||n.set(this,s,"value")===t)this.value=s})}}),v.extend({valHooks:{option:{get:function(e){var t=e.attributes.value;return!t||t.specified?e.value:e.text}},select:{get:function(e){var t,n,r=e.options,i=e.selectedIndex,s=e.type==="select-one"||i<0,o=s?null:[],u=s?i+1:r.length,a=i<0?u:s?i:0;for(;a<u;a++){n=r[a];if((n.selected||a===i)&&(v.support.optDisabled?!n.disabled:n.getAttribute("disabled")===null)&&(!n.parentNode.disabled||!v.nodeName(n.parentNode,"optgroup"))){t=v(n).val();if(s)return t;o.push(t)}}return o},set:function(e,t){var n=v.makeArray(t);return v(e).find("option").each(function(){this.selected=v.inArray(v(this).val(),n)>=0}),n.length||(e.selectedIndex=-1),n}}},attrFn:{},attr:function(e,n,r,i){var s,o,u,a=e.nodeType;if(!e||a===3||a===8||a===2)return;if(i&&v.isFunction(v.fn[n]))return v(e)[n](r);if(typeof e.getAttribute=="undefined")return v.prop(e,n,r);u=a!==1||!v.isXMLDoc(e),u&&(n=n.toLowerCase(),o=v.attrHooks[n]||(X.test(n)?F:j));if(r!==t){if(r===null){v.removeAttr(e,n);return}return o&&"set"in o&&u&&(s=o.set(e,r,n))!==t?s:(e.setAttribute(n,r+""),r)}return o&&"get"in o&&u&&(s=o.get(e,n))!==null?s:(s=e.getAttribute(n),s===null?t:s)},removeAttr:function(e,t){var n,r,i,s,o=0;if(t&&e.nodeType===1){r=t.split(y);for(;o<r.length;o++)i=r[o],i&&(n=v.propFix[i]||i,s=X.test(i),s||v.attr(e,i,""),e.removeAttribute(V?i:n),s&&n in e&&(e[n]=!1))}},attrHooks:{type:{set:function(e,t){if(U.test(e.nodeName)&&e.parentNode)v.error("type property can't be changed");else if(!v.support.radioValue&&t==="radio"&&v.nodeName(e,"input")){var n=e.value;return e.setAttribute("type",t),n&&(e.value=n),t}}},value:{get:function(e,t){return j&&v.nodeName(e,"button")?j.get(e,t):t in e?e.value:null},set:function(e,t,n){if(j&&v.nodeName(e,"button"))return j.set(e,t,n);e.value=t}}},propFix:{tabindex:"tabIndex",readonly:"readOnly","for":"htmlFor","class":"className",maxlength:"maxLength",cellspacing:"cellSpacing",cellpadding:"cellPadding",rowspan:"rowSpan",colspan:"colSpan",usemap:"useMap",frameborder:"frameBorder",contenteditable:"contentEditable"},prop:function(e,n,r){var i,s,o,u=e.nodeType;if(!e||u===3||u===8||u===2)return;return o=u!==1||!v.isXMLDoc(e),o&&(n=v.propFix[n]||n,s=v.propHooks[n]),r!==t?s&&"set"in s&&(i=s.set(e,r,n))!==t?i:e[n]=r:s&&"get"in s&&(i=s.get(e,n))!==null?i:e[n]},propHooks:{tabIndex:{get:function(e){var n=e.getAttributeNode("tabindex");return n&&n.specified?parseInt(n.value,10):z.test(e.nodeName)||W.test(e.nodeName)&&e.href?0:t}}}}),F={get:function(e,n){var r,i=v.prop(e,n);return i===!0||typeof i!="boolean"&&(r=e.getAttributeNode(n))&&r.nodeValue!==!1?n.toLowerCase():t},set:function(e,t,n){var r;return t===!1?v.removeAttr(e,n):(r=v.propFix[n]||n,r in e&&(e[r]=!0),e.setAttribute(n,n.toLowerCase())),n}},V||(I={name:!0,id:!0,coords:!0},j=v.valHooks.button={get:function(e,n){var r;return r=e.getAttributeNode(n),r&&(I[n]?r.value!=="":r.specified)?r.value:t},set:function(e,t,n){var r=e.getAttributeNode(n);return r||(r=i.createAttribute(n),e.setAttributeNode(r)),r.value=t+""}},v.each(["width","height"],function(e,t){v.attrHooks[t]=v.extend(v.attrHooks[t],{set:function(e,n){if(n==="")return e.setAttribute(t,"auto"),n}})}),v.attrHooks.contenteditable={get:j.get,set:function(e,t,n){t===""&&(t="false"),j.set(e,t,n)}}),v.support.hrefNormalized||v.each(["href","src","width","height"],function(e,n){v.attrHooks[n]=v.extend(v.attrHooks[n],{get:function(e){var r=e.getAttribute(n,2);return r===null?t:r}})}),v.support.style||(v.attrHooks.style={get:function(e){return e.style.cssText.toLowerCase()||t},set:function(e,t){return e.style.cssText=t+""}}),v.support.optSelected||(v.propHooks.selected=v.extend(v.propHooks.selected,{get:function(e){var t=e.parentNode;return t&&(t.selectedIndex,t.parentNode&&t.parentNode.selectedIndex),null}})),v.support.enctype||(v.propFix.enctype="encoding"),v.support.checkOn||v.each(["radio","checkbox"],function(){v.valHooks[this]={get:function(e){return e.getAttribute("value")===null?"on":e.value}}}),v.each(["radio","checkbox"],function(){v.valHooks[this]=v.extend(v.valHooks[this],{set:function(e,t){if(v.isArray(t))return e.checked=v.inArray(v(e).val(),t)>=0}})});var $=/^(?:textarea|input|select)$/i,J=/^([^\.]*|)(?:\.(.+)|)$/,K=/(?:^|\s)hover(\.\S+|)\b/,Q=/^key/,G=/^(?:mouse|contextmenu)|click/,Y=/^(?:focusinfocus|focusoutblur)$/,Z=function(e){return v.event.special.hover?e:e.replace(K,"mouseenter$1 mouseleave$1")};v.event={add:function(e,n,r,i,s){var o,u,a,f,l,c,h,p,d,m,g;if(e.nodeType===3||e.nodeType===8||!n||!r||!(o=v._data(e)))return;r.handler&&(d=r,r=d.handler,s=d.selector),r.guid||(r.guid=v.guid++),a=o.events,a||(o.events=a={}),u=o.handle,u||(o.handle=u=function(e){return typeof v=="undefined"||!!e&&v.event.triggered===e.type?t:v.event.dispatch.apply(u.elem,arguments)},u.elem=e),n=v.trim(Z(n)).split(" ");for(f=0;f<n.length;f++){l=J.exec(n[f])||[],c=l[1],h=(l[2]||"").split(".").sort(),g=v.event.special[c]||{},c=(s?g.delegateType:g.bindType)||c,g=v.event.special[c]||{},p=v.extend({type:c,origType:l[1],data:i,handler:r,guid:r.guid,selector:s,needsContext:s&&v.expr.match.needsContext.test(s),namespace:h.join(".")},d),m=a[c];if(!m){m=a[c]=[],m.delegateCount=0;if(!g.setup||g.setup.call(e,i,h,u)===!1)e.addEventListener?e.addEventListener(c,u,!1):e.attachEvent&&e.attachEvent("on"+c,u)}g.add&&(g.add.call(e,p),p.handler.guid||(p.handler.guid=r.guid)),s?m.splice(m.delegateCount++,0,p):m.push(p),v.event.global[c]=!0}e=null},global:{},remove:function(e,t,n,r,i){var s,o,u,a,f,l,c,h,p,d,m,g=v.hasData(e)&&v._data(e);if(!g||!(h=g.events))return;t=v.trim(Z(t||"")).split(" ");for(s=0;s<t.length;s++){o=J.exec(t[s])||[],u=a=o[1],f=o[2];if(!u){for(u in h)v.event.remove(e,u+t[s],n,r,!0);continue}p=v.event.special[u]||{},u=(r?p.delegateType:p.bindType)||u,d=h[u]||[],l=d.length,f=f?new RegExp("(^|\\.)"+f.split(".").sort().join("\\.(?:.*\\.|)")+"(\\.|$)"):null;for(c=0;c<d.length;c++)m=d[c],(i||a===m.origType)&&(!n||n.guid===m.guid)&&(!f||f.test(m.namespace))&&(!r||r===m.selector||r==="**"&&m.selector)&&(d.splice(c--,1),m.selector&&d.delegateCount--,p.remove&&p.remove.call(e,m));d.length===0&&l!==d.length&&((!p.teardown||p.teardown.call(e,f,g.handle)===!1)&&v.removeEvent(e,u,g.handle),delete h[u])}v.isEmptyObject(h)&&(delete g.handle,v.removeData(e,"events",!0))},customEvent:{getData:!0,setData:!0,changeData:!0},trigger:function(n,r,s,o){if(!s||s.nodeType!==3&&s.nodeType!==8){var u,a,f,l,c,h,p,d,m,g,y=n.type||n,b=[];if(Y.test(y+v.event.triggered))return;y.indexOf("!")>=0&&(y=y.slice(0,-1),a=!0),y.indexOf(".")>=0&&(b=y.split("."),y=b.shift(),b.sort());if((!s||v.event.customEvent[y])&&!v.event.global[y])return;n=typeof n=="object"?n[v.expando]?n:new v.Event(y,n):new v.Event(y),n.type=y,n.isTrigger=!0,n.exclusive=a,n.namespace=b.join("."),n.namespace_re=n.namespace?new RegExp("(^|\\.)"+b.join("\\.(?:.*\\.|)")+"(\\.|$)"):null,h=y.indexOf(":")<0?"on"+y:"";if(!s){u=v.cache;for(f in u)u[f].events&&u[f].events[y]&&v.event.trigger(n,r,u[f].handle.elem,!0);return}n.result=t,n.target||(n.target=s),r=r!=null?v.makeArray(r):[],r.unshift(n),p=v.event.special[y]||{};if(p.trigger&&p.trigger.apply(s,r)===!1)return;m=[[s,p.bindType||y]];if(!o&&!p.noBubble&&!v.isWindow(s)){g=p.delegateType||y,l=Y.test(g+y)?s:s.parentNode;for(c=s;l;l=l.parentNode)m.push([l,g]),c=l;c===(s.ownerDocument||i)&&m.push([c.defaultView||c.parentWindow||e,g])}for(f=0;f<m.length&&!n.isPropagationStopped();f++)l=m[f][0],n.type=m[f][1],d=(v._data(l,"events")||{})[n.type]&&v._data(l,"handle"),d&&d.apply(l,r),d=h&&l[h],d&&v.acceptData(l)&&d.apply&&d.apply(l,r)===!1&&n.preventDefault();return n.type=y,!o&&!n.isDefaultPrevented()&&(!p._default||p._default.apply(s.ownerDocument,r)===!1)&&(y!=="click"||!v.nodeName(s,"a"))&&v.acceptData(s)&&h&&s[y]&&(y!=="focus"&&y!=="blur"||n.target.offsetWidth!==0)&&!v.isWindow(s)&&(c=s[h],c&&(s[h]=null),v.event.triggered=y,s[y](),v.event.triggered=t,c&&(s[h]=c)),n.result}return},dispatch:function(n){n=v.event.fix(n||e.event);var r,i,s,o,u,a,f,c,h,p,d=(v._data(this,"events")||{})[n.type]||[],m=d.delegateCount,g=l.call(arguments),y=!n.exclusive&&!n.namespace,b=v.event.special[n.type]||{},w=[];g[0]=n,n.delegateTarget=this;if(b.preDispatch&&b.preDispatch.call(this,n)===!1)return;if(m&&(!n.button||n.type!=="click"))for(s=n.target;s!=this;s=s.parentNode||this)if(s.disabled!==!0||n.type!=="click"){u={},f=[];for(r=0;r<m;r++)c=d[r],h=c.selector,u[h]===t&&(u[h]=c.needsContext?v(h,this).index(s)>=0:v.find(h,this,null,[s]).length),u[h]&&f.push(c);f.length&&w.push({elem:s,matches:f})}d.length>m&&w.push({elem:this,matches:d.slice(m)});for(r=0;r<w.length&&!n.isPropagationStopped();r++){a=w[r],n.currentTarget=a.elem;for(i=0;i<a.matches.length&&!n.isImmediatePropagationStopped();i++){c=a.matches[i];if(y||!n.namespace&&!c.namespace||n.namespace_re&&n.namespace_re.test(c.namespace))n.data=c.data,n.handleObj=c,o=((v.event.special[c.origType]||{}).handle||c.handler).apply(a.elem,g),o!==t&&(n.result=o,o===!1&&(n.preventDefault(),n.stopPropagation()))}}return b.postDispatch&&b.postDispatch.call(this,n),n.result},props:"attrChange attrName relatedNode srcElement altKey bubbles cancelable ctrlKey currentTarget eventPhase metaKey relatedTarget shiftKey target timeStamp view which".split(" "),fixHooks:{},keyHooks:{props:"char charCode key keyCode".split(" "),filter:function(e,t){return e.which==null&&(e.which=t.charCode!=null?t.charCode:t.keyCode),e}},mouseHooks:{props:"button buttons clientX clientY fromElement offsetX offsetY pageX pageY screenX screenY toElement".split(" "),filter:function(e,n){var r,s,o,u=n.button,a=n.fromElement;return e.pageX==null&&n.clientX!=null&&(r=e.target.ownerDocument||i,s=r.documentElement,o=r.body,e.pageX=n.clientX+(s&&s.scrollLeft||o&&o.scrollLeft||0)-(s&&s.clientLeft||o&&o.clientLeft||0),e.pageY=n.clientY+(s&&s.scrollTop||o&&o.scrollTop||0)-(s&&s.clientTop||o&&o.clientTop||0)),!e.relatedTarget&&a&&(e.relatedTarget=a===e.target?n.toElement:a),!e.which&&u!==t&&(e.which=u&1?1:u&2?3:u&4?2:0),e}},fix:function(e){if(e[v.expando])return e;var t,n,r=e,s=v.event.fixHooks[e.type]||{},o=s.props?this.props.concat(s.props):this.props;e=v.Event(r);for(t=o.length;t;)n=o[--t],e[n]=r[n];return e.target||(e.target=r.srcElement||i),e.target.nodeType===3&&(e.target=e.target.parentNode),e.metaKey=!!e.metaKey,s.filter?s.filter(e,r):e},special:{load:{noBubble:!0},focus:{delegateType:"focusin"},blur:{delegateType:"focusout"},beforeunload:{setup:function(e,t,n){v.isWindow(this)&&(this.onbeforeunload=n)},teardown:function(e,t){this.onbeforeunload===t&&(this.onbeforeunload=null)}}},simulate:function(e,t,n,r){var i=v.extend(new v.Event,n,{type:e,isSimulated:!0,originalEvent:{}});r?v.event.trigger(i,null,t):v.event.dispatch.call(t,i),i.isDefaultPrevented()&&n.preventDefault()}},v.event.handle=v.event.dispatch,v.removeEvent=i.removeEventListener?function(e,t,n){e.removeEventListener&&e.removeEventListener(t,n,!1)}:function(e,t,n){var r="on"+t;e.detachEvent&&(typeof e[r]=="undefined"&&(e[r]=null),e.detachEvent(r,n))},v.Event=function(e,t){if(!(this instanceof v.Event))return new v.Event(e,t);e&&e.type?(this.originalEvent=e,this.type=e.type,this.isDefaultPrevented=e.defaultPrevented||e.returnValue===!1||e.getPreventDefault&&e.getPreventDefault()?tt:et):this.type=e,t&&v.extend(this,t),this.timeStamp=e&&e.timeStamp||v.now(),this[v.expando]=!0},v.Event.prototype={preventDefault:function(){this.isDefaultPrevented=tt;var e=this.originalEvent;if(!e)return;e.preventDefault?e.preventDefault():e.returnValue=!1},stopPropagation:function(){this.isPropagationStopped=tt;var e=this.originalEvent;if(!e)return;e.stopPropagation&&e.stopPropagation(),e.cancelBubble=!0},stopImmediatePropagation:function(){this.isImmediatePropagationStopped=tt,this.stopPropagation()},isDefaultPrevented:et,isPropagationStopped:et,isImmediatePropagationStopped:et},v.each({mouseenter:"mouseover",mouseleave:"mouseout"},function(e,t){v.event.special[e]={delegateType:t,bindType:t,handle:function(e){var n,r=this,i=e.relatedTarget,s=e.handleObj,o=s.selector;if(!i||i!==r&&!v.contains(r,i))e.type=s.origType,n=s.handler.apply(this,arguments),e.type=t;return n}}}),v.support.submitBubbles||(v.event.special.submit={setup:function(){if(v.nodeName(this,"form"))return!1;v.event.add(this,"click._submit keypress._submit",function(e){var n=e.target,r=v.nodeName(n,"input")||v.nodeName(n,"button")?n.form:t;r&&!v._data(r,"_submit_attached")&&(v.event.add(r,"submit._submit",function(e){e._submit_bubble=!0}),v._data(r,"_submit_attached",!0))})},postDispatch:function(e){e._submit_bubble&&(delete e._submit_bubble,this.parentNode&&!e.isTrigger&&v.event.simulate("submit",this.parentNode,e,!0))},teardown:function(){if(v.nodeName(this,"form"))return!1;v.event.remove(this,"._submit")}}),v.support.changeBubbles||(v.event.special.change={setup:function(){if($.test(this.nodeName)){if(this.type==="checkbox"||this.type==="radio")v.event.add(this,"propertychange._change",function(e){e.originalEvent.propertyName==="checked"&&(this._just_changed=!0)}),v.event.add(this,"click._change",function(e){this._just_changed&&!e.isTrigger&&(this._just_changed=!1),v.event.simulate("change",this,e,!0)});return!1}v.event.add(this,"beforeactivate._change",function(e){var t=e.target;$.test(t.nodeName)&&!v._data(t,"_change_attached")&&(v.event.add(t,"change._change",function(e){this.parentNode&&!e.isSimulated&&!e.isTrigger&&v.event.simulate("change",this.parentNode,e,!0)}),v._data(t,"_change_attached",!0))})},handle:function(e){var t=e.target;if(this!==t||e.isSimulated||e.isTrigger||t.type!=="radio"&&t.type!=="checkbox")return e.handleObj.handler.apply(this,arguments)},teardown:function(){return v.event.remove(this,"._change"),!$.test(this.nodeName)}}),v.support.focusinBubbles||v.each({focus:"focusin",blur:"focusout"},function(e,t){var n=0,r=function(e){v.event.simulate(t,e.target,v.event.fix(e),!0)};v.event.special[t]={setup:function(){n++===0&&i.addEventListener(e,r,!0)},teardown:function(){--n===0&&i.removeEventListener(e,r,!0)}}}),v.fn.extend({on:function(e,n,r,i,s){var o,u;if(typeof e=="object"){typeof n!="string"&&(r=r||n,n=t);for(u in e)this.on(u,n,r,e[u],s);return this}r==null&&i==null?(i=n,r=n=t):i==null&&(typeof n=="string"?(i=r,r=t):(i=r,r=n,n=t));if(i===!1)i=et;else if(!i)return this;return s===1&&(o=i,i=function(e){return v().off(e),o.apply(this,arguments)},i.guid=o.guid||(o.guid=v.guid++)),this.each(function(){v.event.add(this,e,i,r,n)})},one:function(e,t,n,r){return this.on(e,t,n,r,1)},off:function(e,n,r){var i,s;if(e&&e.preventDefault&&e.handleObj)return i=e.handleObj,v(e.delegateTarget).off(i.namespace?i.origType+"."+i.namespace:i.origType,i.selector,i.handler),this;if(typeof e=="object"){for(s in e)this.off(s,n,e[s]);return this}if(n===!1||typeof n=="function")r=n,n=t;return r===!1&&(r=et),this.each(function(){v.event.remove(this,e,r,n)})},bind:function(e,t,n){return this.on(e,null,t,n)},unbind:function(e,t){return this.off(e,null,t)},live:function(e,t,n){return v(this.context).on(e,this.selector,t,n),this},die:function(e,t){return v(this.context).off(e,this.selector||"**",t),this},delegate:function(e,t,n,r){return this.on(t,e,n,r)},undelegate:function(e,t,n){return arguments.length===1?this.off(e,"**"):this.off(t,e||"**",n)},trigger:function(e,t){return this.each(function(){v.event.trigger(e,t,this)})},triggerHandler:function(e,t){if(this[0])return v.event.trigger(e,t,this[0],!0)},toggle:function(e){var t=arguments,n=e.guid||v.guid++,r=0,i=function(n){var i=(v._data(this,"lastToggle"+e.guid)||0)%r;return v._data(this,"lastToggle"+e.guid,i+1),n.preventDefault(),t[i].apply(this,arguments)||!1};i.guid=n;while(r<t.length)t[r++].guid=n;return this.click(i)},hover:function(e,t){return this.mouseenter(e).mouseleave(t||e)}}),v.each("blur focus focusin focusout load resize scroll unload click dblclick mousedown mouseup mousemove mouseover mouseout mouseenter mouseleave change select submit keydown keypress keyup error contextmenu".split(" "),function(e,t){v.fn[t]=function(e,n){return n==null&&(n=e,e=null),arguments.length>0?this.on(t,null,e,n):this.trigger(t)},Q.test(t)&&(v.event.fixHooks[t]=v.event.keyHooks),G.test(t)&&(v.event.fixHooks[t]=v.event.mouseHooks)}),function(e,t){function nt(e,t,n,r){n=n||[],t=t||g;var i,s,a,f,l=t.nodeType;if(!e||typeof e!="string")return n;if(l!==1&&l!==9)return[];a=o(t);if(!a&&!r)if(i=R.exec(e))if(f=i[1]){if(l===9){s=t.getElementById(f);if(!s||!s.parentNode)return n;if(s.id===f)return n.push(s),n}else if(t.ownerDocument&&(s=t.ownerDocument.getElementById(f))&&u(t,s)&&s.id===f)return n.push(s),n}else{if(i[2])return S.apply(n,x.call(t.getElementsByTagName(e),0)),n;if((f=i[3])&&Z&&t.getElementsByClassName)return S.apply(n,x.call(t.getElementsByClassName(f),0)),n}return vt(e.replace(j,"$1"),t,n,r,a)}function rt(e){return function(t){var n=t.nodeName.toLowerCase();return n==="input"&&t.type===e}}function it(e){return function(t){var n=t.nodeName.toLowerCase();return(n==="input"||n==="button")&&t.type===e}}function st(e){return N(function(t){return t=+t,N(function(n,r){var i,s=e([],n.length,t),o=s.length;while(o--)n[i=s[o]]&&(n[i]=!(r[i]=n[i]))})})}function ot(e,t,n){if(e===t)return n;var r=e.nextSibling;while(r){if(r===t)return-1;r=r.nextSibling}return 1}function ut(e,t){var n,r,s,o,u,a,f,l=L[d][e+" "];if(l)return t?0:l.slice(0);u=e,a=[],f=i.preFilter;while(u){if(!n||(r=F.exec(u)))r&&(u=u.slice(r[0].length)||u),a.push(s=[]);n=!1;if(r=I.exec(u))s.push(n=new m(r.shift())),u=u.slice(n.length),n.type=r[0].replace(j," ");for(o in i.filter)(r=J[o].exec(u))&&(!f[o]||(r=f[o](r)))&&(s.push(n=new m(r.shift())),u=u.slice(n.length),n.type=o,n.matches=r);if(!n)break}return t?u.length:u?nt.error(e):L(e,a).slice(0)}function at(e,t,r){var i=t.dir,s=r&&t.dir==="parentNode",o=w++;return t.first?function(t,n,r){while(t=t[i])if(s||t.nodeType===1)return e(t,n,r)}:function(t,r,u){if(!u){var a,f=b+" "+o+" ",l=f+n;while(t=t[i])if(s||t.nodeType===1){if((a=t[d])===l)return t.sizset;if(typeof a=="string"&&a.indexOf(f)===0){if(t.sizset)return t}else{t[d]=l;if(e(t,r,u))return t.sizset=!0,t;t.sizset=!1}}}else while(t=t[i])if(s||t.nodeType===1)if(e(t,r,u))return t}}function ft(e){return e.length>1?function(t,n,r){var i=e.length;while(i--)if(!e[i](t,n,r))return!1;return!0}:e[0]}function lt(e,t,n,r,i){var s,o=[],u=0,a=e.length,f=t!=null;for(;u<a;u++)if(s=e[u])if(!n||n(s,r,i))o.push(s),f&&t.push(u);return o}function ct(e,t,n,r,i,s){return r&&!r[d]&&(r=ct(r)),i&&!i[d]&&(i=ct(i,s)),N(function(s,o,u,a){var f,l,c,h=[],p=[],d=o.length,v=s||dt(t||"*",u.nodeType?[u]:u,[]),m=e&&(s||!t)?lt(v,h,e,u,a):v,g=n?i||(s?e:d||r)?[]:o:m;n&&n(m,g,u,a);if(r){f=lt(g,p),r(f,[],u,a),l=f.length;while(l--)if(c=f[l])g[p[l]]=!(m[p[l]]=c)}if(s){if(i||e){if(i){f=[],l=g.length;while(l--)(c=g[l])&&f.push(m[l]=c);i(null,g=[],f,a)}l=g.length;while(l--)(c=g[l])&&(f=i?T.call(s,c):h[l])>-1&&(s[f]=!(o[f]=c))}}else g=lt(g===o?g.splice(d,g.length):g),i?i(null,o,g,a):S.apply(o,g)})}function ht(e){var t,n,r,s=e.length,o=i.relative[e[0].type],u=o||i.relative[" "],a=o?1:0,f=at(function(e){return e===t},u,!0),l=at(function(e){return T.call(t,e)>-1},u,!0),h=[function(e,n,r){return!o&&(r||n!==c)||((t=n).nodeType?f(e,n,r):l(e,n,r))}];for(;a<s;a++)if(n=i.relative[e[a].type])h=[at(ft(h),n)];else{n=i.filter[e[a].type].apply(null,e[a].matches);if(n[d]){r=++a;for(;r<s;r++)if(i.relative[e[r].type])break;return ct(a>1&&ft(h),a>1&&e.slice(0,a-1).join("").replace(j,"$1"),n,a<r&&ht(e.slice(a,r)),r<s&&ht(e=e.slice(r)),r<s&&e.join(""))}h.push(n)}return ft(h)}function pt(e,t){var r=t.length>0,s=e.length>0,o=function(u,a,f,l,h){var p,d,v,m=[],y=0,w="0",x=u&&[],T=h!=null,N=c,C=u||s&&i.find.TAG("*",h&&a.parentNode||a),k=b+=N==null?1:Math.E;T&&(c=a!==g&&a,n=o.el);for(;(p=C[w])!=null;w++){if(s&&p){for(d=0;v=e[d];d++)if(v(p,a,f)){l.push(p);break}T&&(b=k,n=++o.el)}r&&((p=!v&&p)&&y--,u&&x.push(p))}y+=w;if(r&&w!==y){for(d=0;v=t[d];d++)v(x,m,a,f);if(u){if(y>0)while(w--)!x[w]&&!m[w]&&(m[w]=E.call(l));m=lt(m)}S.apply(l,m),T&&!u&&m.length>0&&y+t.length>1&&nt.uniqueSort(l)}return T&&(b=k,c=N),x};return o.el=0,r?N(o):o}function dt(e,t,n){var r=0,i=t.length;for(;r<i;r++)nt(e,t[r],n);return n}function vt(e,t,n,r,s){var o,u,f,l,c,h=ut(e),p=h.length;if(!r&&h.length===1){u=h[0]=h[0].slice(0);if(u.length>2&&(f=u[0]).type==="ID"&&t.nodeType===9&&!s&&i.relative[u[1].type]){t=i.find.ID(f.matches[0].replace($,""),t,s)[0];if(!t)return n;e=e.slice(u.shift().length)}for(o=J.POS.test(e)?-1:u.length-1;o>=0;o--){f=u[o];if(i.relative[l=f.type])break;if(c=i.find[l])if(r=c(f.matches[0].replace($,""),z.test(u[0].type)&&t.parentNode||t,s)){u.splice(o,1),e=r.length&&u.join("");if(!e)return S.apply(n,x.call(r,0)),n;break}}}return a(e,h)(r,t,s,n,z.test(e)),n}function mt(){}var n,r,i,s,o,u,a,f,l,c,h=!0,p="undefined",d=("sizcache"+Math.random()).replace(".",""),m=String,g=e.document,y=g.documentElement,b=0,w=0,E=[].pop,S=[].push,x=[].slice,T=[].indexOf||function(e){var t=0,n=this.length;for(;t<n;t++)if(this[t]===e)return t;return-1},N=function(e,t){return e[d]=t==null||t,e},C=function(){var e={},t=[];return N(function(n,r){return t.push(n)>i.cacheLength&&delete e[t.shift()],e[n+" "]=r},e)},k=C(),L=C(),A=C(),O="[\\x20\\t\\r\\n\\f]",M="(?:\\\\.|[-\\w]|[^\\x00-\\xa0])+",_=M.replace("w","w#"),D="([*^$|!~]?=)",P="\\["+O+"*("+M+")"+O+"*(?:"+D+O+"*(?:(['\"])((?:\\\\.|[^\\\\])*?)\\3|("+_+")|)|)"+O+"*\\]",H=":("+M+")(?:\\((?:(['\"])((?:\\\\.|[^\\\\])*?)\\2|([^()[\\]]*|(?:(?:"+P+")|[^:]|\\\\.)*|.*))\\)|)",B=":(even|odd|eq|gt|lt|nth|first|last)(?:\\("+O+"*((?:-\\d)?\\d*)"+O+"*\\)|)(?=[^-]|$)",j=new RegExp("^"+O+"+|((?:^|[^\\\\])(?:\\\\.)*)"+O+"+$","g"),F=new RegExp("^"+O+"*,"+O+"*"),I=new RegExp("^"+O+"*([\\x20\\t\\r\\n\\f>+~])"+O+"*"),q=new RegExp(H),R=/^(?:#([\w\-]+)|(\w+)|\.([\w\-]+))$/,U=/^:not/,z=/[\x20\t\r\n\f]*[+~]/,W=/:not\($/,X=/h\d/i,V=/input|select|textarea|button/i,$=/\\(?!\\)/g,J={ID:new RegExp("^#("+M+")"),CLASS:new RegExp("^\\.("+M+")"),NAME:new RegExp("^\\[name=['\"]?("+M+")['\"]?\\]"),TAG:new RegExp("^("+M.replace("w","w*")+")"),ATTR:new RegExp("^"+P),PSEUDO:new RegExp("^"+H),POS:new RegExp(B,"i"),CHILD:new RegExp("^:(only|nth|first|last)-child(?:\\("+O+"*(even|odd|(([+-]|)(\\d*)n|)"+O+"*(?:([+-]|)"+O+"*(\\d+)|))"+O+"*\\)|)","i"),needsContext:new RegExp("^"+O+"*[>+~]|"+B,"i")},K=function(e){var t=g.createElement("div");try{return e(t)}catch(n){return!1}finally{t=null}},Q=K(function(e){return e.appendChild(g.createComment("")),!e.getElementsByTagName("*").length}),G=K(function(e){return e.innerHTML="<a href='#'></a>",e.firstChild&&typeof e.firstChild.getAttribute!==p&&e.firstChild.getAttribute("href")==="#"}),Y=K(function(e){e.innerHTML="<select></select>";var t=typeof e.lastChild.getAttribute("multiple");return t!=="boolean"&&t!=="string"}),Z=K(function(e){return e.innerHTML="<div class='hidden e'></div><div class='hidden'></div>",!e.getElementsByClassName||!e.getElementsByClassName("e").length?!1:(e.lastChild.className="e",e.getElementsByClassName("e").length===2)}),et=K(function(e){e.id=d+0,e.innerHTML="<a name='"+d+"'></a><div name='"+d+"'></div>",y.insertBefore(e,y.firstChild);var t=g.getElementsByName&&g.getElementsByName(d).length===2+g.getElementsByName(d+0).length;return r=!g.getElementById(d),y.removeChild(e),t});try{x.call(y.childNodes,0)[0].nodeType}catch(tt){x=function(e){var t,n=[];for(;t=this[e];e++)n.push(t);return n}}nt.matches=function(e,t){return nt(e,null,null,t)},nt.matchesSelector=function(e,t){return nt(t,null,null,[e]).length>0},s=nt.getText=function(e){var t,n="",r=0,i=e.nodeType;if(i){if(i===1||i===9||i===11){if(typeof e.textContent=="string")return e.textContent;for(e=e.firstChild;e;e=e.nextSibling)n+=s(e)}else if(i===3||i===4)return e.nodeValue}else for(;t=e[r];r++)n+=s(t);return n},o=nt.isXML=function(e){var t=e&&(e.ownerDocument||e).documentElement;return t?t.nodeName!=="HTML":!1},u=nt.contains=y.contains?function(e,t){var n=e.nodeType===9?e.documentElement:e,r=t&&t.parentNode;return e===r||!!(r&&r.nodeType===1&&n.contains&&n.contains(r))}:y.compareDocumentPosition?function(e,t){return t&&!!(e.compareDocumentPosition(t)&16)}:function(e,t){while(t=t.parentNode)if(t===e)return!0;return!1},nt.attr=function(e,t){var n,r=o(e);return r||(t=t.toLowerCase()),(n=i.attrHandle[t])?n(e):r||Y?e.getAttribute(t):(n=e.getAttributeNode(t),n?typeof e[t]=="boolean"?e[t]?t:null:n.specified?n.value:null:null)},i=nt.selectors={cacheLength:50,createPseudo:N,match:J,attrHandle:G?{}:{href:function(e){return e.getAttribute("href",2)},type:function(e){return e.getAttribute("type")}},find:{ID:r?function(e,t,n){if(typeof t.getElementById!==p&&!n){var r=t.getElementById(e);return r&&r.parentNode?[r]:[]}}:function(e,n,r){if(typeof n.getElementById!==p&&!r){var i=n.getElementById(e);return i?i.id===e||typeof i.getAttributeNode!==p&&i.getAttributeNode("id").value===e?[i]:t:[]}},TAG:Q?function(e,t){if(typeof t.getElementsByTagName!==p)return t.getElementsByTagName(e)}:function(e,t){var n=t.getElementsByTagName(e);if(e==="*"){var r,i=[],s=0;for(;r=n[s];s++)r.nodeType===1&&i.push(r);return i}return n},NAME:et&&function(e,t){if(typeof t.getElementsByName!==p)return t.getElementsByName(name)},CLASS:Z&&function(e,t,n){if(typeof t.getElementsByClassName!==p&&!n)return t.getElementsByClassName(e)}},relative:{">":{dir:"parentNode",first:!0}," ":{dir:"parentNode"},"+":{dir:"previousSibling",first:!0},"~":{dir:"previousSibling"}},preFilter:{ATTR:function(e){return e[1]=e[1].replace($,""),e[3]=(e[4]||e[5]||"").replace($,""),e[2]==="~="&&(e[3]=" "+e[3]+" "),e.slice(0,4)},CHILD:function(e){return e[1]=e[1].toLowerCase(),e[1]==="nth"?(e[2]||nt.error(e[0]),e[3]=+(e[3]?e[4]+(e[5]||1):2*(e[2]==="even"||e[2]==="odd")),e[4]=+(e[6]+e[7]||e[2]==="odd")):e[2]&&nt.error(e[0]),e},PSEUDO:function(e){var t,n;if(J.CHILD.test(e[0]))return null;if(e[3])e[2]=e[3];else if(t=e[4])q.test(t)&&(n=ut(t,!0))&&(n=t.indexOf(")",t.length-n)-t.length)&&(t=t.slice(0,n),e[0]=e[0].slice(0,n)),e[2]=t;return e.slice(0,3)}},filter:{ID:r?function(e){return e=e.replace($,""),function(t){return t.getAttribute("id")===e}}:function(e){return e=e.replace($,""),function(t){var n=typeof t.getAttributeNode!==p&&t.getAttributeNode("id");return n&&n.value===e}},TAG:function(e){return e==="*"?function(){return!0}:(e=e.replace($,"").toLowerCase(),function(t){return t.nodeName&&t.nodeName.toLowerCase()===e})},CLASS:function(e){var t=k[d][e+" "];return t||(t=new RegExp("(^|"+O+")"+e+"("+O+"|$)"))&&k(e,function(e){return t.test(e.className||typeof e.getAttribute!==p&&e.getAttribute("class")||"")})},ATTR:function(e,t,n){return function(r,i){var s=nt.attr(r,e);return s==null?t==="!=":t?(s+="",t==="="?s===n:t==="!="?s!==n:t==="^="?n&&s.indexOf(n)===0:t==="*="?n&&s.indexOf(n)>-1:t==="$="?n&&s.substr(s.length-n.length)===n:t==="~="?(" "+s+" ").indexOf(n)>-1:t==="|="?s===n||s.substr(0,n.length+1)===n+"-":!1):!0}},CHILD:function(e,t,n,r){return e==="nth"?function(e){var t,i,s=e.parentNode;if(n===1&&r===0)return!0;if(s){i=0;for(t=s.firstChild;t;t=t.nextSibling)if(t.nodeType===1){i++;if(e===t)break}}return i-=r,i===n||i%n===0&&i/n>=0}:function(t){var n=t;switch(e){case"only":case"first":while(n=n.previousSibling)if(n.nodeType===1)return!1;if(e==="first")return!0;n=t;case"last":while(n=n.nextSibling)if(n.nodeType===1)return!1;return!0}}},PSEUDO:function(e,t){var n,r=i.pseudos[e]||i.setFilters[e.toLowerCase()]||nt.error("unsupported pseudo: "+e);return r[d]?r(t):r.length>1?(n=[e,e,"",t],i.setFilters.hasOwnProperty(e.toLowerCase())?N(function(e,n){var i,s=r(e,t),o=s.length;while(o--)i=T.call(e,s[o]),e[i]=!(n[i]=s[o])}):function(e){return r(e,0,n)}):r}},pseudos:{not:N(function(e){var t=[],n=[],r=a(e.replace(j,"$1"));return r[d]?N(function(e,t,n,i){var s,o=r(e,null,i,[]),u=e.length;while(u--)if(s=o[u])e[u]=!(t[u]=s)}):function(e,i,s){return t[0]=e,r(t,null,s,n),!n.pop()}}),has:N(function(e){return function(t){return nt(e,t).length>0}}),contains:N(function(e){return function(t){return(t.textContent||t.innerText||s(t)).indexOf(e)>-1}}),enabled:function(e){return e.disabled===!1},disabled:function(e){return e.disabled===!0},checked:function(e){var t=e.nodeName.toLowerCase();return t==="input"&&!!e.checked||t==="option"&&!!e.selected},selected:function(e){return e.parentNode&&e.parentNode.selectedIndex,e.selected===!0},parent:function(e){return!i.pseudos.empty(e)},empty:function(e){var t;e=e.firstChild;while(e){if(e.nodeName>"@"||(t=e.nodeType)===3||t===4)return!1;e=e.nextSibling}return!0},header:function(e){return X.test(e.nodeName)},text:function(e){var t,n;return e.nodeName.toLowerCase()==="input"&&(t=e.type)==="text"&&((n=e.getAttribute("type"))==null||n.toLowerCase()===t)},radio:rt("radio"),checkbox:rt("checkbox"),file:rt("file"),password:rt("password"),image:rt("image"),submit:it("submit"),reset:it("reset"),button:function(e){var t=e.nodeName.toLowerCase();return t==="input"&&e.type==="button"||t==="button"},input:function(e){return V.test(e.nodeName)},focus:function(e){var t=e.ownerDocument;return e===t.activeElement&&(!t.hasFocus||t.hasFocus())&&!!(e.type||e.href||~e.tabIndex)},active:function(e){return e===e.ownerDocument.activeElement},first:st(function(){return[0]}),last:st(function(e,t){return[t-1]}),eq:st(function(e,t,n){return[n<0?n+t:n]}),even:st(function(e,t){for(var n=0;n<t;n+=2)e.push(n);return e}),odd:st(function(e,t){for(var n=1;n<t;n+=2)e.push(n);return e}),lt:st(function(e,t,n){for(var r=n<0?n+t:n;--r>=0;)e.push(r);return e}),gt:st(function(e,t,n){for(var r=n<0?n+t:n;++r<t;)e.push(r);return e})}},f=y.compareDocumentPosition?function(e,t){return e===t?(l=!0,0):(!e.compareDocumentPosition||!t.compareDocumentPosition?e.compareDocumentPosition:e.compareDocumentPosition(t)&4)?-1:1}:function(e,t){if(e===t)return l=!0,0;if(e.sourceIndex&&t.sourceIndex)return e.sourceIndex-t.sourceIndex;var n,r,i=[],s=[],o=e.parentNode,u=t.parentNode,a=o;if(o===u)return ot(e,t);if(!o)return-1;if(!u)return 1;while(a)i.unshift(a),a=a.parentNode;a=u;while(a)s.unshift(a),a=a.parentNode;n=i.length,r=s.length;for(var f=0;f<n&&f<r;f++)if(i[f]!==s[f])return ot(i[f],s[f]);return f===n?ot(e,s[f],-1):ot(i[f],t,1)},[0,0].sort(f),h=!l,nt.uniqueSort=function(e){var t,n=[],r=1,i=0;l=h,e.sort(f);if(l){for(;t=e[r];r++)t===e[r-1]&&(i=n.push(r));while(i--)e.splice(n[i],1)}return e},nt.error=function(e){throw new Error("Syntax error, unrecognized expression: "+e)},a=nt.compile=function(e,t){var n,r=[],i=[],s=A[d][e+" "];if(!s){t||(t=ut(e)),n=t.length;while(n--)s=ht(t[n]),s[d]?r.push(s):i.push(s);s=A(e,pt(i,r))}return s},g.querySelectorAll&&function(){var e,t=vt,n=/'|\\/g,r=/\=[\x20\t\r\n\f]*([^'"\]]*)[\x20\t\r\n\f]*\]/g,i=[":focus"],s=[":active"],u=y.matchesSelector||y.mozMatchesSelector||y.webkitMatchesSelector||y.oMatchesSelector||y.msMatchesSelector;K(function(e){e.innerHTML="<select><option selected=''></option></select>",e.querySelectorAll("[selected]").length||i.push("\\["+O+"*(?:checked|disabled|ismap|multiple|readonly|selected|value)"),e.querySelectorAll(":checked").length||i.push(":checked")}),K(function(e){e.innerHTML="<p test=''></p>",e.querySelectorAll("[test^='']").length&&i.push("[*^$]="+O+"*(?:\"\"|'')"),e.innerHTML="<input type='hidden'/>",e.querySelectorAll(":enabled").length||i.push(":enabled",":disabled")}),i=new RegExp(i.join("|")),vt=function(e,r,s,o,u){if(!o&&!u&&!i.test(e)){var a,f,l=!0,c=d,h=r,p=r.nodeType===9&&e;if(r.nodeType===1&&r.nodeName.toLowerCase()!=="object"){a=ut(e),(l=r.getAttribute("id"))?c=l.replace(n,"\\$&"):r.setAttribute("id",c),c="[id='"+c+"'] ",f=a.length;while(f--)a[f]=c+a[f].join("");h=z.test(e)&&r.parentNode||r,p=a.join(",")}if(p)try{return S.apply(s,x.call(h.querySelectorAll(p),0)),s}catch(v){}finally{l||r.removeAttribute("id")}}return t(e,r,s,o,u)},u&&(K(function(t){e=u.call(t,"div");try{u.call(t,"[test!='']:sizzle"),s.push("!=",H)}catch(n){}}),s=new RegExp(s.join("|")),nt.matchesSelector=function(t,n){n=n.replace(r,"='$1']");if(!o(t)&&!s.test(n)&&!i.test(n))try{var a=u.call(t,n);if(a||e||t.document&&t.document.nodeType!==11)return a}catch(f){}return nt(n,null,null,[t]).length>0})}(),i.pseudos.nth=i.pseudos.eq,i.filters=mt.prototype=i.pseudos,i.setFilters=new mt,nt.attr=v.attr,v.find=nt,v.expr=nt.selectors,v.expr[":"]=v.expr.pseudos,v.unique=nt.uniqueSort,v.text=nt.getText,v.isXMLDoc=nt.isXML,v.contains=nt.contains}(e);var nt=/Until$/,rt=/^(?:parents|prev(?:Until|All))/,it=/^.[^:#\[\.,]*$/,st=v.expr.match.needsContext,ot={children:!0,contents:!0,next:!0,prev:!0};v.fn.extend({find:function(e){var t,n,r,i,s,o,u=this;if(typeof e!="string")return v(e).filter(function(){for(t=0,n=u.length;t<n;t++)if(v.contains(u[t],this))return!0});o=this.pushStack("","find",e);for(t=0,n=this.length;t<n;t++){r=o.length,v.find(e,this[t],o);if(t>0)for(i=r;i<o.length;i++)for(s=0;s<r;s++)if(o[s]===o[i]){o.splice(i--,1);break}}return o},has:function(e){var t,n=v(e,this),r=n.length;return this.filter(function(){for(t=0;t<r;t++)if(v.contains(this,n[t]))return!0})},not:function(e){return this.pushStack(ft(this,e,!1),"not",e)},filter:function(e){return this.pushStack(ft(this,e,!0),"filter",e)},is:function(e){return!!e&&(typeof e=="string"?st.test(e)?v(e,this.context).index(this[0])>=0:v.filter(e,this).length>0:this.filter(e).length>0)},closest:function(e,t){var n,r=0,i=this.length,s=[],o=st.test(e)||typeof e!="string"?v(e,t||this.context):0;for(;r<i;r++){n=this[r];while(n&&n.ownerDocument&&n!==t&&n.nodeType!==11){if(o?o.index(n)>-1:v.find.matchesSelector(n,e)){s.push(n);break}n=n.parentNode}}return s=s.length>1?v.unique(s):s,this.pushStack(s,"closest",e)},index:function(e){return e?typeof e=="string"?v.inArray(this[0],v(e)):v.inArray(e.jquery?e[0]:e,this):this[0]&&this[0].parentNode?this.prevAll().length:-1},add:function(e,t){var n=typeof e=="string"?v(e,t):v.makeArray(e&&e.nodeType?[e]:e),r=v.merge(this.get(),n);return this.pushStack(ut(n[0])||ut(r[0])?r:v.unique(r))},addBack:function(e){return this.add(e==null?this.prevObject:this.prevObject.filter(e))}}),v.fn.andSelf=v.fn.addBack,v.each({parent:function(e){var t=e.parentNode;return t&&t.nodeType!==11?t:null},parents:function(e){return v.dir(e,"parentNode")},parentsUntil:function(e,t,n){return v.dir(e,"parentNode",n)},next:function(e){return at(e,"nextSibling")},prev:function(e){return at(e,"previousSibling")},nextAll:function(e){return v.dir(e,"nextSibling")},prevAll:function(e){return v.dir(e,"previousSibling")},nextUntil:function(e,t,n){return v.dir(e,"nextSibling",n)},prevUntil:function(e,t,n){return v.dir(e,"previousSibling",n)},siblings:function(e){return v.sibling((e.parentNode||{}).firstChild,e)},children:function(e){return v.sibling(e.firstChild)},contents:function(e){return v.nodeName(e,"iframe")?e.contentDocument||e.contentWindow.document:v.merge([],e.childNodes)}},function(e,t){v.fn[e]=function(n,r){var i=v.map(this,t,n);return nt.test(e)||(r=n),r&&typeof r=="string"&&(i=v.filter(r,i)),i=this.length>1&&!ot[e]?v.unique(i):i,this.length>1&&rt.test(e)&&(i=i.reverse()),this.pushStack(i,e,l.call(arguments).join(","))}}),v.extend({filter:function(e,t,n){return n&&(e=":not("+e+")"),t.length===1?v.find.matchesSelector(t[0],e)?[t[0]]:[]:v.find.matches(e,t)},dir:function(e,n,r){var i=[],s=e[n];while(s&&s.nodeType!==9&&(r===t||s.nodeType!==1||!v(s).is(r)))s.nodeType===1&&i.push(s),s=s[n];return i},sibling:function(e,t){var n=[];for(;e;e=e.nextSibling)e.nodeType===1&&e!==t&&n.push(e);return n}});var ct="abbr|article|aside|audio|bdi|canvas|data|datalist|details|figcaption|figure|footer|header|hgroup|mark|meter|nav|output|progress|section|summary|time|video",ht=/ jQuery\d+="(?:null|\d+)"/g,pt=/^\s+/,dt=/<(?!area|br|col|embed|hr|img|input|link|meta|param)(([\w:]+)[^>]*)\/>/gi,vt=/<([\w:]+)/,mt=/<tbody/i,gt=/<|&#?\w+;/,yt=/<(?:script|style|link)/i,bt=/<(?:script|object|embed|option|style)/i,wt=new RegExp("<(?:"+ct+")[\\s/>]","i"),Et=/^(?:checkbox|radio)$/,St=/checked\s*(?:[^=]|=\s*.checked.)/i,xt=/\/(java|ecma)script/i,Tt=/^\s*<!(?:\[CDATA\[|\-\-)|[\]\-]{2}>\s*$/g,Nt={option:[1,"<select multiple='multiple'>","</select>"],legend:[1,"<fieldset>","</fieldset>"],thead:[1,"<table>","</table>"],tr:[2,"<table><tbody>","</tbody></table>"],td:[3,"<table><tbody><tr>","</tr></tbody></table>"],col:[2,"<table><tbody></tbody><colgroup>","</colgroup></table>"],area:[1,"<map>","</map>"],_default:[0,"",""]},Ct=lt(i),kt=Ct.appendChild(i.createElement("div"));Nt.optgroup=Nt.option,Nt.tbody=Nt.tfoot=Nt.colgroup=Nt.caption=Nt.thead,Nt.th=Nt.td,v.support.htmlSerialize||(Nt._default=[1,"X<div>","</div>"]),v.fn.extend({text:function(e){return v.access(this,function(e){return e===t?v.text(this):this.empty().append((this[0]&&this[0].ownerDocument||i).createTextNode(e))},null,e,arguments.length)},wrapAll:function(e){if(v.isFunction(e))return this.each(function(t){v(this).wrapAll(e.call(this,t))});if(this[0]){var t=v(e,this[0].ownerDocument).eq(0).clone(!0);this[0].parentNode&&t.insertBefore(this[0]),t.map(function(){var e=this;while(e.firstChild&&e.firstChild.nodeType===1)e=e.firstChild;return e}).append(this)}return this},wrapInner:function(e){return v.isFunction(e)?this.each(function(t){v(this).wrapInner(e.call(this,t))}):this.each(function(){var t=v(this),n=t.contents();n.length?n.wrapAll(e):t.append(e)})},wrap:function(e){var t=v.isFunction(e);return this.each(function(n){v(this).wrapAll(t?e.call(this,n):e)})},unwrap:function(){return this.parent().each(function(){v.nodeName(this,"body")||v(this).replaceWith(this.childNodes)}).end()},append:function(){return this.domManip(arguments,!0,function(e){(this.nodeType===1||this.nodeType===11)&&this.appendChild(e)})},prepend:function(){return this.domManip(arguments,!0,function(e){(this.nodeType===1||this.nodeType===11)&&this.insertBefore(e,this.firstChild)})},before:function(){if(!ut(this[0]))return this.domManip(arguments,!1,function(e){this.parentNode.insertBefore(e,this)});if(arguments.length){var e=v.clean(arguments);return this.pushStack(v.merge(e,this),"before",this.selector)}},after:function(){if(!ut(this[0]))return this.domManip(arguments,!1,function(e){this.parentNode.insertBefore(e,this.nextSibling)});if(arguments.length){var e=v.clean(arguments);return this.pushStack(v.merge(this,e),"after",this.selector)}},remove:function(e,t){var n,r=0;for(;(n=this[r])!=null;r++)if(!e||v.filter(e,[n]).length)!t&&n.nodeType===1&&(v.cleanData(n.getElementsByTagName("*")),v.cleanData([n])),n.parentNode&&n.parentNode.removeChild(n);return this},empty:function(){var e,t=0;for(;(e=this[t])!=null;t++){e.nodeType===1&&v.cleanData(e.getElementsByTagName("*"));while(e.firstChild)e.removeChild(e.firstChild)}return this},clone:function(e,t){return e=e==null?!1:e,t=t==null?e:t,this.map(function(){return v.clone(this,e,t)})},html:function(e){return v.access(this,function(e){var n=this[0]||{},r=0,i=this.length;if(e===t)return n.nodeType===1?n.innerHTML.replace(ht,""):t;if(typeof e=="string"&&!yt.test(e)&&(v.support.htmlSerialize||!wt.test(e))&&(v.support.leadingWhitespace||!pt.test(e))&&!Nt[(vt.exec(e)||["",""])[1].toLowerCase()]){e=e.replace(dt,"<$1></$2>");try{for(;r<i;r++)n=this[r]||{},n.nodeType===1&&(v.cleanData(n.getElementsByTagName("*")),n.innerHTML=e);n=0}catch(s){}}n&&this.empty().append(e)},null,e,arguments.length)},replaceWith:function(e){return ut(this[0])?this.length?this.pushStack(v(v.isFunction(e)?e():e),"replaceWith",e):this:v.isFunction(e)?this.each(function(t){var n=v(this),r=n.html();n.replaceWith(e.call(this,t,r))}):(typeof e!="string"&&(e=v(e).detach()),this.each(function(){var t=this.nextSibling,n=this.parentNode;v(this).remove(),t?v(t).before(e):v(n).append(e)}))},detach:function(e){return this.remove(e,!0)},domManip:function(e,n,r){e=[].concat.apply([],e);var i,s,o,u,a=0,f=e[0],l=[],c=this.length;if(!v.support.checkClone&&c>1&&typeof f=="string"&&St.test(f))return this.each(function(){v(this).domManip(e,n,r)});if(v.isFunction(f))return this.each(function(i){var s=v(this);e[0]=f.call(this,i,n?s.html():t),s.domManip(e,n,r)});if(this[0]){i=v.buildFragment(e,this,l),o=i.fragment,s=o.firstChild,o.childNodes.length===1&&(o=s);if(s){n=n&&v.nodeName(s,"tr");for(u=i.cacheable||c-1;a<c;a++)r.call(n&&v.nodeName(this[a],"table")?Lt(this[a],"tbody"):this[a],a===u?o:v.clone(o,!0,!0))}o=s=null,l.length&&v.each(l,function(e,t){t.src?v.ajax?v.ajax({url:t.src,type:"GET",dataType:"script",async:!1,global:!1,"throws":!0}):v.error("no ajax"):v.globalEval((t.text||t.textContent||t.innerHTML||"").replace(Tt,"")),t.parentNode&&t.parentNode.removeChild(t)})}return this}}),v.buildFragment=function(e,n,r){var s,o,u,a=e[0];return n=n||i,n=!n.nodeType&&n[0]||n,n=n.ownerDocument||n,e.length===1&&typeof a=="string"&&a.length<512&&n===i&&a.charAt(0)==="<"&&!bt.test(a)&&(v.support.checkClone||!St.test(a))&&(v.support.html5Clone||!wt.test(a))&&(o=!0,s=v.fragments[a],u=s!==t),s||(s=n.createDocumentFragment(),v.clean(e,n,s,r),o&&(v.fragments[a]=u&&s)),{fragment:s,cacheable:o}},v.fragments={},v.each({appendTo:"append",prependTo:"prepend",insertBefore:"before",insertAfter:"after",replaceAll:"replaceWith"},function(e,t){v.fn[e]=function(n){var r,i=0,s=[],o=v(n),u=o.length,a=this.length===1&&this[0].parentNode;if((a==null||a&&a.nodeType===11&&a.childNodes.length===1)&&u===1)return o[t](this[0]),this;for(;i<u;i++)r=(i>0?this.clone(!0):this).get(),v(o[i])[t](r),s=s.concat(r);return this.pushStack(s,e,o.selector)}}),v.extend({clone:function(e,t,n){var r,i,s,o;v.support.html5Clone||v.isXMLDoc(e)||!wt.test("<"+e.nodeName+">")?o=e.cloneNode(!0):(kt.innerHTML=e.outerHTML,kt.removeChild(o=kt.firstChild));if((!v.support.noCloneEvent||!v.support.noCloneChecked)&&(e.nodeType===1||e.nodeType===11)&&!v.isXMLDoc(e)){Ot(e,o),r=Mt(e),i=Mt(o);for(s=0;r[s];++s)i[s]&&Ot(r[s],i[s])}if(t){At(e,o);if(n){r=Mt(e),i=Mt(o);for(s=0;r[s];++s)At(r[s],i[s])}}return r=i=null,o},clean:function(e,t,n,r){var s,o,u,a,f,l,c,h,p,d,m,g,y=t===i&&Ct,b=[];if(!t||typeof t.createDocumentFragment=="undefined")t=i;for(s=0;(u=e[s])!=null;s++){typeof u=="number"&&(u+="");if(!u)continue;if(typeof u=="string")if(!gt.test(u))u=t.createTextNode(u);else{y=y||lt(t),c=t.createElement("div"),y.appendChild(c),u=u.replace(dt,"<$1></$2>"),a=(vt.exec(u)||["",""])[1].toLowerCase(),f=Nt[a]||Nt._default,l=f[0],c.innerHTML=f[1]+u+f[2];while(l--)c=c.lastChild;if(!v.support.tbody){h=mt.test(u),p=a==="table"&&!h?c.firstChild&&c.firstChild.childNodes:f[1]==="<table>"&&!h?c.childNodes:[];for(o=p.length-1;o>=0;--o)v.nodeName(p[o],"tbody")&&!p[o].childNodes.length&&p[o].parentNode.removeChild(p[o])}!v.support.leadingWhitespace&&pt.test(u)&&c.insertBefore(t.createTextNode(pt.exec(u)[0]),c.firstChild),u=c.childNodes,c.parentNode.removeChild(c)}u.nodeType?b.push(u):v.merge(b,u)}c&&(u=c=y=null);if(!v.support.appendChecked)for(s=0;(u=b[s])!=null;s++)v.nodeName(u,"input")?_t(u):typeof u.getElementsByTagName!="undefined"&&v.grep(u.getElementsByTagName("input"),_t);if(n){m=function(e){if(!e.type||xt.test(e.type))return r?r.push(e.parentNode?e.parentNode.removeChild(e):e):n.appendChild(e)};for(s=0;(u=b[s])!=null;s++)if(!v.nodeName(u,"script")||!m(u))n.appendChild(u),typeof u.getElementsByTagName!="undefined"&&(g=v.grep(v.merge([],u.getElementsByTagName("script")),m),b.splice.apply(b,[s+1,0].concat(g)),s+=g.length)}return b},cleanData:function(e,t){var n,r,i,s,o=0,u=v.expando,a=v.cache,f=v.support.deleteExpando,l=v.event.special;for(;(i=e[o])!=null;o++)if(t||v.acceptData(i)){r=i[u],n=r&&a[r];if(n){if(n.events)for(s in n.events)l[s]?v.event.remove(i,s):v.removeEvent(i,s,n.handle);a[r]&&(delete a[r],f?delete i[u]:i.removeAttribute?i.removeAttribute(u):i[u]=null,v.deletedIds.push(r))}}}}),function(){var e,t;v.uaMatch=function(e){e=e.toLowerCase();var t=/(chrome)[ \/]([\w.]+)/.exec(e)||/(webkit)[ \/]([\w.]+)/.exec(e)||/(opera)(?:.*version|)[ \/]([\w.]+)/.exec(e)||/(msie) ([\w.]+)/.exec(e)||e.indexOf("compatible")<0&&/(mozilla)(?:.*? rv:([\w.]+)|)/.exec(e)||[];return{browser:t[1]||"",version:t[2]||"0"}},e=v.uaMatch(o.userAgent),t={},e.browser&&(t[e.browser]=!0,t.version=e.version),t.chrome?t.webkit=!0:t.webkit&&(t.safari=!0),v.browser=t,v.sub=function(){function e(t,n){return new e.fn.init(t,n)}v.extend(!0,e,this),e.superclass=this,e.fn=e.prototype=this(),e.fn.constructor=e,e.sub=this.sub,e.fn.init=function(r,i){return i&&i instanceof v&&!(i instanceof e)&&(i=e(i)),v.fn.init.call(this,r,i,t)},e.fn.init.prototype=e.fn;var t=e(i);return e}}();var Dt,Pt,Ht,Bt=/alpha\([^)]*\)/i,jt=/opacity=([^)]*)/,Ft=/^(top|right|bottom|left)$/,It=/^(none|table(?!-c[ea]).+)/,qt=/^margin/,Rt=new RegExp("^("+m+")(.*)$","i"),Ut=new RegExp("^("+m+")(?!px)[a-z%]+$","i"),zt=new RegExp("^([-+])=("+m+")","i"),Wt={BODY:"block"},Xt={position:"absolute",visibility:"hidden",display:"block"},Vt={letterSpacing:0,fontWeight:400},$t=["Top","Right","Bottom","Left"],Jt=["Webkit","O","Moz","ms"],Kt=v.fn.toggle;v.fn.extend({css:function(e,n){return v.access(this,function(e,n,r){return r!==t?v.style(e,n,r):v.css(e,n)},e,n,arguments.length>1)},show:function(){return Yt(this,!0)},hide:function(){return Yt(this)},toggle:function(e,t){var n=typeof e=="boolean";return v.isFunction(e)&&v.isFunction(t)?Kt.apply(this,arguments):this.each(function(){(n?e:Gt(this))?v(this).show():v(this).hide()})}}),v.extend({cssHooks:{opacity:{get:function(e,t){if(t){var n=Dt(e,"opacity");return n===""?"1":n}}}},cssNumber:{fillOpacity:!0,fontWeight:!0,lineHeight:!0,opacity:!0,orphans:!0,widows:!0,zIndex:!0,zoom:!0},cssProps:{"float":v.support.cssFloat?"cssFloat":"styleFloat"},style:function(e,n,r,i){if(!e||e.nodeType===3||e.nodeType===8||!e.style)return;var s,o,u,a=v.camelCase(n),f=e.style;n=v.cssProps[a]||(v.cssProps[a]=Qt(f,a)),u=v.cssHooks[n]||v.cssHooks[a];if(r===t)return u&&"get"in u&&(s=u.get(e,!1,i))!==t?s:f[n];o=typeof r,o==="string"&&(s=zt.exec(r))&&(r=(s[1]+1)*s[2]+parseFloat(v.css(e,n)),o="number");if(r==null||o==="number"&&isNaN(r))return;o==="number"&&!v.cssNumber[a]&&(r+="px");if(!u||!("set"in u)||(r=u.set(e,r,i))!==t)try{f[n]=r}catch(l){}},css:function(e,n,r,i){var s,o,u,a=v.camelCase(n);return n=v.cssProps[a]||(v.cssProps[a]=Qt(e.style,a)),u=v.cssHooks[n]||v.cssHooks[a],u&&"get"in u&&(s=u.get(e,!0,i)),s===t&&(s=Dt(e,n)),s==="normal"&&n in Vt&&(s=Vt[n]),r||i!==t?(o=parseFloat(s),r||v.isNumeric(o)?o||0:s):s},swap:function(e,t,n){var r,i,s={};for(i in t)s[i]=e.style[i],e.style[i]=t[i];r=n.call(e);for(i in t)e.style[i]=s[i];return r}}),e.getComputedStyle?Dt=function(t,n){var r,i,s,o,u=e.getComputedStyle(t,null),a=t.style;return u&&(r=u.getPropertyValue(n)||u[n],r===""&&!v.contains(t.ownerDocument,t)&&(r=v.style(t,n)),Ut.test(r)&&qt.test(n)&&(i=a.width,s=a.minWidth,o=a.maxWidth,a.minWidth=a.maxWidth=a.width=r,r=u.width,a.width=i,a.minWidth=s,a.maxWidth=o)),r}:i.documentElement.currentStyle&&(Dt=function(e,t){var n,r,i=e.currentStyle&&e.currentStyle[t],s=e.style;return i==null&&s&&s[t]&&(i=s[t]),Ut.test(i)&&!Ft.test(t)&&(n=s.left,r=e.runtimeStyle&&e.runtimeStyle.left,r&&(e.runtimeStyle.left=e.currentStyle.left),s.left=t==="fontSize"?"1em":i,i=s.pixelLeft+"px",s.left=n,r&&(e.runtimeStyle.left=r)),i===""?"auto":i}),v.each(["height","width"],function(e,t){v.cssHooks[t]={get:function(e,n,r){if(n)return e.offsetWidth===0&&It.test(Dt(e,"display"))?v.swap(e,Xt,function(){return tn(e,t,r)}):tn(e,t,r)},set:function(e,n,r){return Zt(e,n,r?en(e,t,r,v.support.boxSizing&&v.css(e,"boxSizing")==="border-box"):0)}}}),v.support.opacity||(v.cssHooks.opacity={get:function(e,t){return jt.test((t&&e.currentStyle?e.currentStyle.filter:e.style.filter)||"")?.01*parseFloat(RegExp.$1)+"":t?"1":""},set:function(e,t){var n=e.style,r=e.currentStyle,i=v.isNumeric(t)?"alpha(opacity="+t*100+")":"",s=r&&r.filter||n.filter||"";n.zoom=1;if(t>=1&&v.trim(s.replace(Bt,""))===""&&n.removeAttribute){n.removeAttribute("filter");if(r&&!r.filter)return}n.filter=Bt.test(s)?s.replace(Bt,i):s+" "+i}}),v(function(){v.support.reliableMarginRight||(v.cssHooks.marginRight={get:function(e,t){return v.swap(e,{display:"inline-block"},function(){if(t)return Dt(e,"marginRight")})}}),!v.support.pixelPosition&&v.fn.position&&v.each(["top","left"],function(e,t){v.cssHooks[t]={get:function(e,n){if(n){var r=Dt(e,t);return Ut.test(r)?v(e).position()[t]+"px":r}}}})}),v.expr&&v.expr.filters&&(v.expr.filters.hidden=function(e){return e.offsetWidth===0&&e.offsetHeight===0||!v.support.reliableHiddenOffsets&&(e.style&&e.style.display||Dt(e,"display"))==="none"},v.expr.filters.visible=function(e){return!v.expr.filters.hidden(e)}),v.each({margin:"",padding:"",border:"Width"},function(e,t){v.cssHooks[e+t]={expand:function(n){var r,i=typeof n=="string"?n.split(" "):[n],s={};for(r=0;r<4;r++)s[e+$t[r]+t]=i[r]||i[r-2]||i[0];return s}},qt.test(e)||(v.cssHooks[e+t].set=Zt)});var rn=/%20/g,sn=/\[\]$/,on=/\r?\n/g,un=/^(?:color|date|datetime|datetime-local|email|hidden|month|number|password|range|search|tel|text|time|url|week)$/i,an=/^(?:select|textarea)/i;v.fn.extend({serialize:function(){return v.param(this.serializeArray())},serializeArray:function(){return this.map(function(){return this.elements?v.makeArray(this.elements):this}).filter(function(){return this.name&&!this.disabled&&(this.checked||an.test(this.nodeName)||un.test(this.type))}).map(function(e,t){var n=v(this).val();return n==null?null:v.isArray(n)?v.map(n,function(e,n){return{name:t.name,value:e.replace(on,"\r\n")}}):{name:t.name,value:n.replace(on,"\r\n")}}).get()}}),v.param=function(e,n){var r,i=[],s=function(e,t){t=v.isFunction(t)?t():t==null?"":t,i[i.length]=encodeURIComponent(e)+"="+encodeURIComponent(t)};n===t&&(n=v.ajaxSettings&&v.ajaxSettings.traditional);if(v.isArray(e)||e.jquery&&!v.isPlainObject(e))v.each(e,function(){s(this.name,this.value)});else for(r in e)fn(r,e[r],n,s);return i.join("&").replace(rn,"+")};var ln,cn,hn=/#.*$/,pn=/^(.*?):[ \t]*([^\r\n]*)\r?$/mg,dn=/^(?:about|app|app\-storage|.+\-extension|file|res|widget):$/,vn=/^(?:GET|HEAD)$/,mn=/^\/\//,gn=/\?/,yn=/<script\b[^<]*(?:(?!<\/script>)<[^<]*)*<\/script>/gi,bn=/([?&])_=[^&]*/,wn=/^([\w\+\.\-]+:)(?:\/\/([^\/?#:]*)(?::(\d+)|)|)/,En=v.fn.load,Sn={},xn={},Tn=["*/"]+["*"];try{cn=s.href}catch(Nn){cn=i.createElement("a"),cn.href="",cn=cn.href}ln=wn.exec(cn.toLowerCase())||[],v.fn.load=function(e,n,r){if(typeof e!="string"&&En)return En.apply(this,arguments);if(!this.length)return this;var i,s,o,u=this,a=e.indexOf(" ");return a>=0&&(i=e.slice(a,e.length),e=e.slice(0,a)),v.isFunction(n)?(r=n,n=t):n&&typeof n=="object"&&(s="POST"),v.ajax({url:e,type:s,dataType:"html",data:n,complete:function(e,t){r&&u.each(r,o||[e.responseText,t,e])}}).done(function(e){o=arguments,u.html(i?v("<div>").append(e.replace(yn,"")).find(i):e)}),this},v.each("ajaxStart ajaxStop ajaxComplete ajaxError ajaxSuccess ajaxSend".split(" "),function(e,t){v.fn[t]=function(e){return this.on(t,e)}}),v.each(["get","post"],function(e,n){v[n]=function(e,r,i,s){return v.isFunction(r)&&(s=s||i,i=r,r=t),v.ajax({type:n,url:e,data:r,success:i,dataType:s})}}),v.extend({getScript:function(e,n){return v.get(e,t,n,"script")},getJSON:function(e,t,n){return v.get(e,t,n,"json")},ajaxSetup:function(e,t){return t?Ln(e,v.ajaxSettings):(t=e,e=v.ajaxSettings),Ln(e,t),e},ajaxSettings:{url:cn,isLocal:dn.test(ln[1]),global:!0,type:"GET",contentType:"application/x-www-form-urlencoded; charset=UTF-8",processData:!0,async:!0,accepts:{xml:"application/xml, text/xml",html:"text/html",text:"text/plain",json:"application/json, text/javascript","*":Tn},contents:{xml:/xml/,html:/html/,json:/json/},responseFields:{xml:"responseXML",text:"responseText"},converters:{"* text":e.String,"text html":!0,"text json":v.parseJSON,"text xml":v.parseXML},flatOptions:{context:!0,url:!0}},ajaxPrefilter:Cn(Sn),ajaxTransport:Cn(xn),ajax:function(e,n){function T(e,n,s,a){var l,y,b,w,S,T=n;if(E===2)return;E=2,u&&clearTimeout(u),o=t,i=a||"",x.readyState=e>0?4:0,s&&(w=An(c,x,s));if(e>=200&&e<300||e===304)c.ifModified&&(S=x.getResponseHeader("Last-Modified"),S&&(v.lastModified[r]=S),S=x.getResponseHeader("Etag"),S&&(v.etag[r]=S)),e===304?(T="notmodified",l=!0):(l=On(c,w),T=l.state,y=l.data,b=l.error,l=!b);else{b=T;if(!T||e)T="error",e<0&&(e=0)}x.status=e,x.statusText=(n||T)+"",l?d.resolveWith(h,[y,T,x]):d.rejectWith(h,[x,T,b]),x.statusCode(g),g=t,f&&p.trigger("ajax"+(l?"Success":"Error"),[x,c,l?y:b]),m.fireWith(h,[x,T]),f&&(p.trigger("ajaxComplete",[x,c]),--v.active||v.event.trigger("ajaxStop"))}typeof e=="object"&&(n=e,e=t),n=n||{};var r,i,s,o,u,a,f,l,c=v.ajaxSetup({},n),h=c.context||c,p=h!==c&&(h.nodeType||h instanceof v)?v(h):v.event,d=v.Deferred(),m=v.Callbacks("once memory"),g=c.statusCode||{},b={},w={},E=0,S="canceled",x={readyState:0,setRequestHeader:function(e,t){if(!E){var n=e.toLowerCase();e=w[n]=w[n]||e,b[e]=t}return this},getAllResponseHeaders:function(){return E===2?i:null},getResponseHeader:function(e){var n;if(E===2){if(!s){s={};while(n=pn.exec(i))s[n[1].toLowerCase()]=n[2]}n=s[e.toLowerCase()]}return n===t?null:n},overrideMimeType:function(e){return E||(c.mimeType=e),this},abort:function(e){return e=e||S,o&&o.abort(e),T(0,e),this}};d.promise(x),x.success=x.done,x.error=x.fail,x.complete=m.add,x.statusCode=function(e){if(e){var t;if(E<2)for(t in e)g[t]=[g[t],e[t]];else t=e[x.status],x.always(t)}return this},c.url=((e||c.url)+"").replace(hn,"").replace(mn,ln[1]+"//"),c.dataTypes=v.trim(c.dataType||"*").toLowerCase().split(y),c.crossDomain==null&&(a=wn.exec(c.url.toLowerCase()),c.crossDomain=!(!a||a[1]===ln[1]&&a[2]===ln[2]&&(a[3]||(a[1]==="http:"?80:443))==(ln[3]||(ln[1]==="http:"?80:443)))),c.data&&c.processData&&typeof c.data!="string"&&(c.data=v.param(c.data,c.traditional)),kn(Sn,c,n,x);if(E===2)return x;f=c.global,c.type=c.type.toUpperCase(),c.hasContent=!vn.test(c.type),f&&v.active++===0&&v.event.trigger("ajaxStart");if(!c.hasContent){c.data&&(c.url+=(gn.test(c.url)?"&":"?")+c.data,delete c.data),r=c.url;if(c.cache===!1){var N=v.now(),C=c.url.replace(bn,"$1_="+N);c.url=C+(C===c.url?(gn.test(c.url)?"&":"?")+"_="+N:"")}}(c.data&&c.hasContent&&c.contentType!==!1||n.contentType)&&x.setRequestHeader("Content-Type",c.contentType),c.ifModified&&(r=r||c.url,v.lastModified[r]&&x.setRequestHeader("If-Modified-Since",v.lastModified[r]),v.etag[r]&&x.setRequestHeader("If-None-Match",v.etag[r])),x.setRequestHeader("Accept",c.dataTypes[0]&&c.accepts[c.dataTypes[0]]?c.accepts[c.dataTypes[0]]+(c.dataTypes[0]!=="*"?", "+Tn+"; q=0.01":""):c.accepts["*"]);for(l in c.headers)x.setRequestHeader(l,c.headers[l]);if(!c.beforeSend||c.beforeSend.call(h,x,c)!==!1&&E!==2){S="abort";for(l in{success:1,error:1,complete:1})x[l](c[l]);o=kn(xn,c,n,x);if(!o)T(-1,"No Transport");else{x.readyState=1,f&&p.trigger("ajaxSend",[x,c]),c.async&&c.timeout>0&&(u=setTimeout(function(){x.abort("timeout")},c.timeout));try{E=1,o.send(b,T)}catch(k){if(!(E<2))throw k;T(-1,k)}}return x}return x.abort()},active:0,lastModified:{},etag:{}});var Mn=[],_n=/\?/,Dn=/(=)\?(?=&|$)|\?\?/,Pn=v.now();v.ajaxSetup({jsonp:"callback",jsonpCallback:function(){var e=Mn.pop()||v.expando+"_"+Pn++;return this[e]=!0,e}}),v.ajaxPrefilter("json jsonp",function(n,r,i){var s,o,u,a=n.data,f=n.url,l=n.jsonp!==!1,c=l&&Dn.test(f),h=l&&!c&&typeof a=="string"&&!(n.contentType||"").indexOf("application/x-www-form-urlencoded")&&Dn.test(a);if(n.dataTypes[0]==="jsonp"||c||h)return s=n.jsonpCallback=v.isFunction(n.jsonpCallback)?n.jsonpCallback():n.jsonpCallback,o=e[s],c?n.url=f.replace(Dn,"$1"+s):h?n.data=a.replace(Dn,"$1"+s):l&&(n.url+=(_n.test(f)?"&":"?")+n.jsonp+"="+s),n.converters["script json"]=function(){return u||v.error(s+" was not called"),u[0]},n.dataTypes[0]="json",e[s]=function(){u=arguments},i.always(function(){e[s]=o,n[s]&&(n.jsonpCallback=r.jsonpCallback,Mn.push(s)),u&&v.isFunction(o)&&o(u[0]),u=o=t}),"script"}),v.ajaxSetup({accepts:{script:"text/javascript, application/javascript, application/ecmascript, application/x-ecmascript"},contents:{script:/javascript|ecmascript/},converters:{"text script":function(e){return v.globalEval(e),e}}}),v.ajaxPrefilter("script",function(e){e.cache===t&&(e.cache=!1),e.crossDomain&&(e.type="GET",e.global=!1)}),v.ajaxTransport("script",function(e){if(e.crossDomain){var n,r=i.head||i.getElementsByTagName("head")[0]||i.documentElement;return{send:function(s,o){n=i.createElement("script"),n.async="async",e.scriptCharset&&(n.charset=e.scriptCharset),n.src=e.url,n.onload=n.onreadystatechange=function(e,i){if(i||!n.readyState||/loaded|complete/.test(n.readyState))n.onload=n.onreadystatechange=null,r&&n.parentNode&&r.removeChild(n),n=t,i||o(200,"success")},r.insertBefore(n,r.firstChild)},abort:function(){n&&n.onload(0,1)}}}});var Hn,Bn=e.ActiveXObject?function(){for(var e in Hn)Hn[e](0,1)}:!1,jn=0;v.ajaxSettings.xhr=e.ActiveXObject?function(){return!this.isLocal&&Fn()||In()}:Fn,function(e){v.extend(v.support,{ajax:!!e,cors:!!e&&"withCredentials"in e})}(v.ajaxSettings.xhr()),v.support.ajax&&v.ajaxTransport(function(n){if(!n.crossDomain||v.support.cors){var r;return{send:function(i,s){var o,u,a=n.xhr();n.username?a.open(n.type,n.url,n.async,n.username,n.password):a.open(n.type,n.url,n.async);if(n.xhrFields)for(u in n.xhrFields)a[u]=n.xhrFields[u];n.mimeType&&a.overrideMimeType&&a.overrideMimeType(n.mimeType),!n.crossDomain&&!i["X-Requested-With"]&&(i["X-Requested-With"]="XMLHttpRequest");try{for(u in i)a.setRequestHeader(u,i[u])}catch(f){}a.send(n.hasContent&&n.data||null),r=function(e,i){var u,f,l,c,h;try{if(r&&(i||a.readyState===4)){r=t,o&&(a.onreadystatechange=v.noop,Bn&&delete Hn[o]);if(i)a.readyState!==4&&a.abort();else{u=a.status,l=a.getAllResponseHeaders(),c={},h=a.responseXML,h&&h.documentElement&&(c.xml=h);try{c.text=a.responseText}catch(p){}try{f=a.statusText}catch(p){f=""}!u&&n.isLocal&&!n.crossDomain?u=c.text?200:404:u===1223&&(u=204)}}}catch(d){i||s(-1,d)}c&&s(u,f,c,l)},n.async?a.readyState===4?setTimeout(r,0):(o=++jn,Bn&&(Hn||(Hn={},v(e).unload(Bn)),Hn[o]=r),a.onreadystatechange=r):r()},abort:function(){r&&r(0,1)}}}});var qn,Rn,Un=/^(?:toggle|show|hide)$/,zn=new RegExp("^(?:([-+])=|)("+m+")([a-z%]*)$","i"),Wn=/queueHooks$/,Xn=[Gn],Vn={"*":[function(e,t){var n,r,i=this.createTween(e,t),s=zn.exec(t),o=i.cur(),u=+o||0,a=1,f=20;if(s){n=+s[2],r=s[3]||(v.cssNumber[e]?"":"px");if(r!=="px"&&u){u=v.css(i.elem,e,!0)||n||1;do a=a||".5",u/=a,v.style(i.elem,e,u+r);while(a!==(a=i.cur()/o)&&a!==1&&--f)}i.unit=r,i.start=u,i.end=s[1]?u+(s[1]+1)*n:n}return i}]};v.Animation=v.extend(Kn,{tweener:function(e,t){v.isFunction(e)?(t=e,e=["*"]):e=e.split(" ");var n,r=0,i=e.length;for(;r<i;r++)n=e[r],Vn[n]=Vn[n]||[],Vn[n].unshift(t)},prefilter:function(e,t){t?Xn.unshift(e):Xn.push(e)}}),v.Tween=Yn,Yn.prototype={constructor:Yn,init:function(e,t,n,r,i,s){this.elem=e,this.prop=n,this.easing=i||"swing",this.options=t,this.start=this.now=this.cur(),this.end=r,this.unit=s||(v.cssNumber[n]?"":"px")},cur:function(){var e=Yn.propHooks[this.prop];return e&&e.get?e.get(this):Yn.propHooks._default.get(this)},run:function(e){var t,n=Yn.propHooks[this.prop];return this.options.duration?this.pos=t=v.easing[this.easing](e,this.options.duration*e,0,1,this.options.duration):this.pos=t=e,this.now=(this.end-this.start)*t+this.start,this.options.step&&this.options.step.call(this.elem,this.now,this),n&&n.set?n.set(this):Yn.propHooks._default.set(this),this}},Yn.prototype.init.prototype=Yn.prototype,Yn.propHooks={_default:{get:function(e){var t;return e.elem[e.prop]==null||!!e.elem.style&&e.elem.style[e.prop]!=null?(t=v.css(e.elem,e.prop,!1,""),!t||t==="auto"?0:t):e.elem[e.prop]},set:function(e){v.fx.step[e.prop]?v.fx.step[e.prop](e):e.elem.style&&(e.elem.style[v.cssProps[e.prop]]!=null||v.cssHooks[e.prop])?v.style(e.elem,e.prop,e.now+e.unit):e.elem[e.prop]=e.now}}},Yn.propHooks.scrollTop=Yn.propHooks.scrollLeft={set:function(e){e.elem.nodeType&&e.elem.parentNode&&(e.elem[e.prop]=e.now)}},v.each(["toggle","show","hide"],function(e,t){var n=v.fn[t];v.fn[t]=function(r,i,s){return r==null||typeof r=="boolean"||!e&&v.isFunction(r)&&v.isFunction(i)?n.apply(this,arguments):this.animate(Zn(t,!0),r,i,s)}}),v.fn.extend({fadeTo:function(e,t,n,r){return this.filter(Gt).css("opacity",0).show().end().animate({opacity:t},e,n,r)},animate:function(e,t,n,r){var i=v.isEmptyObject(e),s=v.speed(t,n,r),o=function(){var t=Kn(this,v.extend({},e),s);i&&t.stop(!0)};return i||s.queue===!1?this.each(o):this.queue(s.queue,o)},stop:function(e,n,r){var i=function(e){var t=e.stop;delete e.stop,t(r)};return typeof e!="string"&&(r=n,n=e,e=t),n&&e!==!1&&this.queue(e||"fx",[]),this.each(function(){var t=!0,n=e!=null&&e+"queueHooks",s=v.timers,o=v._data(this);if(n)o[n]&&o[n].stop&&i(o[n]);else for(n in o)o[n]&&o[n].stop&&Wn.test(n)&&i(o[n]);for(n=s.length;n--;)s[n].elem===this&&(e==null||s[n].queue===e)&&(s[n].anim.stop(r),t=!1,s.splice(n,1));(t||!r)&&v.dequeue(this,e)})}}),v.each({slideDown:Zn("show"),slideUp:Zn("hide"),slideToggle:Zn("toggle"),fadeIn:{opacity:"show"},fadeOut:{opacity:"hide"},fadeToggle:{opacity:"toggle"}},function(e,t){v.fn[e]=function(e,n,r){return this.animate(t,e,n,r)}}),v.speed=function(e,t,n){var r=e&&typeof e=="object"?v.extend({},e):{complete:n||!n&&t||v.isFunction(e)&&e,duration:e,easing:n&&t||t&&!v.isFunction(t)&&t};r.duration=v.fx.off?0:typeof r.duration=="number"?r.duration:r.duration in v.fx.speeds?v.fx.speeds[r.duration]:v.fx.speeds._default;if(r.queue==null||r.queue===!0)r.queue="fx";return r.old=r.complete,r.complete=function(){v.isFunction(r.old)&&r.old.call(this),r.queue&&v.dequeue(this,r.queue)},r},v.easing={linear:function(e){return e},swing:function(e){return.5-Math.cos(e*Math.PI)/2}},v.timers=[],v.fx=Yn.prototype.init,v.fx.tick=function(){var e,n=v.timers,r=0;qn=v.now();for(;r<n.length;r++)e=n[r],!e()&&n[r]===e&&n.splice(r--,1);n.length||v.fx.stop(),qn=t},v.fx.timer=function(e){e()&&v.timers.push(e)&&!Rn&&(Rn=setInterval(v.fx.tick,v.fx.interval))},v.fx.interval=13,v.fx.stop=function(){clearInterval(Rn),Rn=null},v.fx.speeds={slow:600,fast:200,_default:400},v.fx.step={},v.expr&&v.expr.filters&&(v.expr.filters.animated=function(e){return v.grep(v.timers,function(t){return e===t.elem}).length});var er=/^(?:body|html)$/i;v.fn.offset=function(e){if(arguments.length)return e===t?this:this.each(function(t){v.offset.setOffset(this,e,t)});var n,r,i,s,o,u,a,f={top:0,left:0},l=this[0],c=l&&l.ownerDocument;if(!c)return;return(r=c.body)===l?v.offset.bodyOffset(l):(n=c.documentElement,v.contains(n,l)?(typeof l.getBoundingClientRect!="undefined"&&(f=l.getBoundingClientRect()),i=tr(c),s=n.clientTop||r.clientTop||0,o=n.clientLeft||r.clientLeft||0,u=i.pageYOffset||n.scrollTop,a=i.pageXOffset||n.scrollLeft,{top:f.top+u-s,left:f.left+a-o}):f)},v.offset={bodyOffset:function(e){var t=e.offsetTop,n=e.offsetLeft;return v.support.doesNotIncludeMarginInBodyOffset&&(t+=parseFloat(v.css(e,"marginTop"))||0,n+=parseFloat(v.css(e,"marginLeft"))||0),{top:t,left:n}},setOffset:function(e,t,n){var r=v.css(e,"position");r==="static"&&(e.style.position="relative");var i=v(e),s=i.offset(),o=v.css(e,"top"),u=v.css(e,"left"),a=(r==="absolute"||r==="fixed")&&v.inArray("auto",[o,u])>-1,f={},l={},c,h;a?(l=i.position(),c=l.top,h=l.left):(c=parseFloat(o)||0,h=parseFloat(u)||0),v.isFunction(t)&&(t=t.call(e,n,s)),t.top!=null&&(f.top=t.top-s.top+c),t.left!=null&&(f.left=t.left-s.left+h),"using"in t?t.using.call(e,f):i.css(f)}},v.fn.extend({position:function(){if(!this[0])return;var e=this[0],t=this.offsetParent(),n=this.offset(),r=er.test(t[0].nodeName)?{top:0,left:0}:t.offset();return n.top-=parseFloat(v.css(e,"marginTop"))||0,n.left-=parseFloat(v.css(e,"marginLeft"))||0,r.top+=parseFloat(v.css(t[0],"borderTopWidth"))||0,r.left+=parseFloat(v.css(t[0],"borderLeftWidth"))||0,{top:n.top-r.top,left:n.left-r.left}},offsetParent:function(){return this.map(function(){var e=this.offsetParent||i.body;while(e&&!er.test(e.nodeName)&&v.css(e,"position")==="static")e=e.offsetParent;return e||i.body})}}),v.each({scrollLeft:"pageXOffset",scrollTop:"pageYOffset"},function(e,n){var r=/Y/.test(n);v.fn[e]=function(i){return v.access(this,function(e,i,s){var o=tr(e);if(s===t)return o?n in o?o[n]:o.document.documentElement[i]:e[i];o?o.scrollTo(r?v(o).scrollLeft():s,r?s:v(o).scrollTop()):e[i]=s},e,i,arguments.length,null)}}),v.each({Height:"height",Width:"width"},function(e,n){v.each({padding:"inner"+e,content:n,"":"outer"+e},function(r,i){v.fn[i]=function(i,s){var o=arguments.length&&(r||typeof i!="boolean"),u=r||(i===!0||s===!0?"margin":"border");return v.access(this,function(n,r,i){var s;return v.isWindow(n)?n.document.documentElement["client"+e]:n.nodeType===9?(s=n.documentElement,Math.max(n.body["scroll"+e],s["scroll"+e],n.body["offset"+e],s["offset"+e],s["client"+e])):i===t?v.css(n,r,i,u):v.style(n,r,i,u)},n,o?i:t,o,null)}})}),e.jQuery=e.$=v,typeof define=="function"&&define.amd&&define.amd.jQuery&&define("jquery",[],function(){return v})})(window);









/*jslint browser: true */ /*global jQuery: true */

/**
 * jQuery Cookie plugin
 *
 * Copyright (c) 2010 Klaus Hartl (stilbuero.de)
 * Dual licensed under the MIT and GPL licenses:
 * http://www.opensource.org/licenses/mit-license.php
 * http://www.gnu.org/licenses/gpl.html
 *
 */

// TODO JsDoc

/**
 * Create a cookie with the given key and value and other optional parameters.
 *
 * @example $.cookie('the_cookie', 'the_value');
 * @desc Set the value of a cookie.
 * @example $.cookie('the_cookie', 'the_value', { expires: 7, path: '/', domain: 'jquery.com', secure: true });
 * @desc Create a cookie with all available options.
 * @example $.cookie('the_cookie', 'the_value');
 * @desc Create a session cookie.
 * @example $.cookie('the_cookie', null);
 * @desc Delete a cookie by passing null as value. Keep in mind that you have to use the same path and domain
 *       used when the cookie was set.
 *
 * @param String key The key of the cookie.
 * @param String value The value of the cookie.
 * @param Object options An object literal containing key/value pairs to provide optional cookie attributes.
 * @option Number|Date expires Either an integer specifying the expiration date from now on in days or a Date object.
 *                             If a negative value is specified (e.g. a date in the past), the cookie will be deleted.
 *                             If set to null or omitted, the cookie will be a session cookie and will not be retained
 *                             when the the browser exits.
 * @option String path The value of the path atribute of the cookie (default: path of page that created the cookie).
 * @option String domain The value of the domain attribute of the cookie (default: domain of page that created the cookie).
 * @option Boolean secure If true, the secure attribute of the cookie will be set and the cookie transmission will
 *                        require a secure protocol (like HTTPS).
 * @type undefined
 *
 * @name $.cookie
 * @cat Plugins/Cookie
 * @author Klaus Hartl/klaus.hartl@stilbuero.de
 */

/**
 * Get the value of a cookie with the given key.
 *
 * @example $.cookie('the_cookie');
 * @desc Get the value of a cookie.
 *
 * @param String key The key of the cookie.
 * @return The value of the cookie.
 * @type String
 *
 * @name $.cookie
 * @cat Plugins/Cookie
 * @author Klaus Hartl/klaus.hartl@stilbuero.de
 */
jQuery.cookie = function (key, value, options) {
    
    // key and at least value given, set cookie...
    if (arguments.length > 1 && String(value) !== "[object Object]") {
        options = jQuery.extend({}, options);

        if (value === null || value === undefined) {
            options.expires = -1;
        }

        if (typeof options.expires === 'number') {
            var days = options.expires, t = options.expires = new Date();
            t.setDate(t.getDate() + days);
        }
        
        value = String(value);
        
        return (document.cookie = [
            encodeURIComponent(key), '=',
            options.raw ? value : encodeURIComponent(value),
            options.expires ? '; expires=' + options.expires.toUTCString() : '', // use expires attribute, max-age is not supported by IE
            options.path ? '; path=' + options.path : '',
            options.domain ? '; domain=' + options.domain : '',
            options.secure ? '; secure' : ''
        ].join(''));
    }

    // key and possibly options given, get cookie...
    options = value || {};
    var result, decode = options.raw ? function (s) { return s; } : decodeURIComponent;
    return (result = new RegExp('(?:^|; )' + encodeURIComponent(key) + '=([^;]*)').exec(document.cookie)) ? decode(result[1]) : null;
};

































/*!
 * jQzoom Evolution Library v2.3  - Javascript Image magnifier
 * http://www.mind-projects.it
 *
 * Copyright 2011, Engineer Marco Renzi
 * Licensed under the BSD license.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *     * Neither the name of the organization nor the
 *       names of its contributors may be used to endorse or promote products
 *       derived from this software without specific prior written permission.
 *
 * Date: 03 May 2011 22:16:00
 */
(function ($) {
    //GLOBAL VARIABLES
    var isIE6 = ($.browser.msie && $.browser.version < 7);
    var body = $(document.body);
    var window = $(window);
    var jqzoompluging_disabled = false; //disabilita globalmente il plugin
    $.fn.jqzoom = function (options) {
        return this.each(function () {
            var node = this.nodeName.toLowerCase();
            if (node == 'a') {
                new jqzoom(this, options);
            }
        });
    };
    jqzoom = function (el, options) {
        var api = null;
        api = $(el).data("jqzoom");
        if (api) return api;
        var obj = this;
        var settings = $.extend({}, $.jqzoom.defaults, options || {});
        obj.el = el;
        el.rel = $(el).attr('rel');
        //ANCHOR ELEMENT
        el.zoom_active = false;
        el.zoom_disabled = false; //to disable single zoom instance
        el.largeimageloading = false; //tell us if large image is loading
        el.largeimageloaded = false; //tell us if large image is loaded
        el.scale = {};
        el.timer = null;
        el.mousepos = {};
        el.mouseDown = false;
        $(el).css({
            'outline-style': 'none',
            'text-decoration': 'none'
        });
        //BASE IMAGE
        var img = $("img:eq(0)", el);
        el.title = $(el).attr('title');
        el.imagetitle = img.attr('title');
        var zoomtitle = ($.trim(el.title).length > 0) ? el.title : el.imagetitle;
        var smallimage = new Smallimage(img);
        var lens = new Lens();
        var stage = new Stage();
        var largeimage = new Largeimage();
        var loader = new Loader();
        //preventing default click,allowing the onclick event [exmple: lightbox]
        $(el).bind('click', function (e) {
            e.preventDefault();
            return false;
        });
        //setting the default zoomType if not in settings
        var zoomtypes = ['standard', 'drag', 'innerzoom', 'reverse'];
        if ($.inArray($.trim(settings.zoomType), zoomtypes) < 0) {
            settings.zoomType = 'standard';
        }
        $.extend(obj, {
            create: function () { //create the main objects
                //create ZoomPad
                if ($(".zoomPad", el).length == 0) {
                    el.zoomPad = $('<div/>').addClass('zoomPad');
                    img.wrap(el.zoomPad);
                }
                if(settings.zoomType == 'innerzoom'){
                    settings.zoomWidth  = smallimage.w;
                    settings.zoomHeight  =   smallimage.h;
                }
                //creating ZoomPup
                if ($(".zoomPup", el).length == 0) {
                    lens.append();
                }
                //creating zoomWindow
                if ($(".zoomWindow", el).length == 0) {
                    stage.append();
                }
                //creating Preload
                if ($(".zoomPreload", el).length == 0) {
                    loader.append();
                }
                //preloading images
                if (settings.preloadImages || settings.zoomType == 'drag' || settings.alwaysOn) {
                    obj.load();
                }
                obj.init();
            },
            init: function () {
                //drag option
                if (settings.zoomType == 'drag') {
                    $(".zoomPad", el).mousedown(function () {
                        el.mouseDown = true;
                    });
                    $(".zoomPad", el).mouseup(function () {
                        el.mouseDown = false;
                    });
                    document.body.ondragstart = function () {
                        return false;
                    };
                    $(".zoomPad", el).css({
                        cursor: 'default'
                    });
                    $(".zoomPup", el).css({
                        cursor: 'move'
                    });
                }
                if (settings.zoomType == 'innerzoom') {
                    $(".zoomWrapper", el).css({
                        cursor: 'crosshair'
                    });
                }
                $(".zoomPad", el).bind('mouseenter mouseover', function (event) {
                    img.attr('title', '');
                    $(el).attr('title', '');
                    el.zoom_active = true;
                    //if loaded then activate else load large image
                    smallimage.fetchdata();
                    if (el.largeimageloaded) {
                        obj.activate(event);
                    } else {
                        obj.load();
                    }
                });
                $(".zoomPad", el).bind('mouseleave', function (event) {
                    obj.deactivate();
                });
                $(".zoomPad", el).bind('mousemove', function (e) {

                    //prevent fast mouse mevements not to fire the mouseout event
                    if (e.pageX > smallimage.pos.r || e.pageX < smallimage.pos.l || e.pageY < smallimage.pos.t || e.pageY > smallimage.pos.b) {
                        lens.setcenter();
                        return false;
                    }
                    el.zoom_active = true;
                    if (el.largeimageloaded && !$('.zoomWindow', el).is(':visible')) {
                        obj.activate(e);
                    }
                    if (el.largeimageloaded && (settings.zoomType != 'drag' || (settings.zoomType == 'drag' && el.mouseDown))) {
                        lens.setposition(e);
                    }
                });
                var thumb_preload = new Array();
                var i = 0;
                //binding click event on thumbnails
                var thumblist = new Array();
                thumblist = $('a').filter(function () {
                    var regex = new RegExp("gallery[\\s]*:[\\s]*'" + $.trim(el.rel) + "'", "i");
                    var rel = $(this).attr('rel');
                    if (regex.test(rel)) {
                        return this;
                    }
                });
                if (thumblist.length > 0) {
                    //getting the first to the last
                    var first = thumblist.splice(0, 1);
                    thumblist.push(first);
                }
                thumblist.each(function () {
                    //preloading thumbs
                    if (settings.preloadImages) {
                        var thumb_options = $.extend({}, eval("(" + $.trim($(this).attr('rel')) + ")"));
                        thumb_preload[i] = new Image();
                        thumb_preload[i].src = thumb_options.largeimage;
                        i++;
                    }
                    $(this).click(function (e) {
                        if($(this).hasClass('zoomThumbActive')){
                          return false;
                        }
                        thumblist.each(function () {
                            $(this).removeClass('zoomThumbActive');
                        });
                        e.preventDefault();
                        obj.swapimage(this);
                        return false;
                    });
                });
            },
            load: function () {
                if (el.largeimageloaded == false && el.largeimageloading == false) {
                    var url = $(el).attr('href');
                    el.largeimageloading = true;
                    largeimage.loadimage(url);
                }
            },
            activate: function (e) {
                clearTimeout(el.timer);
                //show lens and zoomWindow
                lens.show();
                stage.show();
            },
            deactivate: function (e) {
                switch (settings.zoomType) {
                case 'drag':
                    //nothing or lens.setcenter();
                    break;
                default:
                    img.attr('title', el.imagetitle);
                    $(el).attr('title', el.title);
                    if (settings.alwaysOn) {
                        lens.setcenter();
                    } else {
                        stage.hide();
                        lens.hide();
                    }
                    break;
                }
                el.zoom_active = false;
            },
            swapimage: function (link) {
                el.largeimageloading = false;
                el.largeimageloaded = false;
                var options = new Object();
                options = $.extend({}, eval("(" + $.trim($(link).attr('rel')) + ")"));
                if (options.smallimage && options.largeimage) {
                    var smallimage = options.smallimage;
                    var largeimage = options.largeimage;
                    $(link).addClass('zoomThumbActive');
                    $(el).attr('href', largeimage);
                    img.attr('src', smallimage);
                    lens.hide();
                    stage.hide();
                    obj.load();
                } else {
                    alert('ERROR :: Missing parameter for largeimage or smallimage.');
                    throw 'ERROR :: Missing parameter for largeimage or smallimage.';
                }
                return false;
            }
        });
        //sometimes image is already loaded and onload will not fire
        if (img[0].complete) {
            //fetching data from sallimage if was previously loaded
            smallimage.fetchdata();
            if ($(".zoomPad", el).length == 0) obj.create();
        }
/*========================================================,
|   Smallimage
|---------------------------------------------------------:
|   Base image into the anchor element
`========================================================*/

        function Smallimage(image) {
            var $obj = this;
            this.node = image[0];
            this.findborder = function () {
                var bordertop = 0;
                bordertop = image.css('border-top-width');
                btop = '';
                var borderleft = 0;
                borderleft = image.css('border-left-width');
                bleft = '';
                if (bordertop) {
                    for (i = 0; i < 3; i++) {
                        var x = [];
                        x = bordertop.substr(i, 1);
                        if (isNaN(x) == false) {
                            btop = btop + '' + bordertop.substr(i, 1);
                        } else {
                            break;
                        }
                    }
                }
                if (borderleft) {
                    for (i = 0; i < 3; i++) {
                        if (!isNaN(borderleft.substr(i, 1))) {
                            bleft = bleft + borderleft.substr(i, 1)
                        } else {
                            break;
                        }
                    }
                }
                $obj.btop = (btop.length > 0) ? eval(btop) : 0;
                $obj.bleft = (bleft.length > 0) ? eval(bleft) : 0;
            };
            this.fetchdata = function () {
                $obj.findborder();
                $obj.w = image.width();
                $obj.h = image.height();
                $obj.ow = image.outerWidth();
                $obj.oh = image.outerHeight();
                $obj.pos = image.offset();
                $obj.pos.l = image.offset().left + $obj.bleft;
                $obj.pos.t = image.offset().top + $obj.btop;
                $obj.pos.r = $obj.w + $obj.pos.l;
                $obj.pos.b = $obj.h + $obj.pos.t;
                $obj.rightlimit = image.offset().left + $obj.ow;
                $obj.bottomlimit = image.offset().top + $obj.oh;
                
            };
            this.node.onerror = function () {
                alert('Problems while loading image.');
                throw 'Problems while loading image.';
            };
            this.node.onload = function () {
                $obj.fetchdata();
                if ($(".zoomPad", el).length == 0) obj.create();
            };
            return $obj;
        };
/*========================================================,
|  Loader
|---------------------------------------------------------:
|  Show that the large image is loading
`========================================================*/

        function Loader() {
            var $obj = this;
            this.append = function () {
                this.node = $('<div/>').addClass('zoomPreload').css('visibility', 'hidden').html(settings.preloadText);
                $('.zoomPad', el).append(this.node);
            };
            this.show = function () {
                this.node.top = (smallimage.oh - this.node.height()) / 2;
                this.node.left = (smallimage.ow - this.node.width()) / 2;
                //setting position
                this.node.css({
                    top: this.node.top,
                    left: this.node.left,
                    position: 'absolute',
                    visibility: 'visible'
                });
            };
            this.hide = function () {
                this.node.css('visibility', 'hidden');
            };
            return this;
        }
/*========================================================,
|   Lens
|---------------------------------------------------------:
|   Lens over the image
`========================================================*/

        function Lens() {
            var $obj = this;
            this.node = $('<div/>').addClass('zoomPup');
            //this.nodeimgwrapper = $("<div/>").addClass('zoomPupImgWrapper');
            this.append = function () {
                $('.zoomPad', el).append($(this.node).hide());
                if (settings.zoomType == 'reverse') {
                    this.image = new Image();
                    this.image.src = smallimage.node.src; // fires off async
                    $(this.node).empty().append(this.image);
                }
            };
            this.setdimensions = function () {
                this.node.w = (parseInt((settings.zoomWidth) / el.scale.x) > smallimage.w ) ? smallimage.w : (parseInt(settings.zoomWidth / el.scale.x)); 
                this.node.h = (parseInt((settings.zoomHeight) / el.scale.y) > smallimage.h ) ? smallimage.h : (parseInt(settings.zoomHeight / el.scale.y)); 
                this.node.top = (smallimage.oh - this.node.h - 2) / 2;
                this.node.left = (smallimage.ow - this.node.w - 2) / 2;
                //centering lens
                this.node.css({
                    top: 0,
                    left: 0,
                    width: this.node.w + 'px',
                    height: this.node.h + 'px',
                    position: 'absolute',
                    display: 'none',
                    borderWidth: 1 + 'px'
                });



                if (settings.zoomType == 'reverse') {
                    this.image.src = smallimage.node.src;
                    $(this.node).css({
                        'opacity': 1
                    });

                    $(this.image).css({
                        position: 'absolute',
                        display: 'block',
                        left: -(this.node.left + 1 - smallimage.bleft) + 'px',
                        top: -(this.node.top + 1 - smallimage.btop) + 'px'
                    });

                }
            };
            this.setcenter = function () {
                //calculating center position
                this.node.top = (smallimage.oh - this.node.h - 2) / 2;
                this.node.left = (smallimage.ow - this.node.w - 2) / 2;
                //centering lens
                this.node.css({
                    top: this.node.top,
                    left: this.node.left
                });
                if (settings.zoomType == 'reverse') {
                    $(this.image).css({
                        position: 'absolute',
                        display: 'block',
                        left: -(this.node.left + 1 - smallimage.bleft) + 'px',
                        top: -(this.node.top + 1 - smallimage.btop) + 'px'
                    });

                }
                //centering large image
                largeimage.setposition();
            };
            this.setposition = function (e) {
                el.mousepos.x = e.pageX;
                el.mousepos.y = e.pageY;
                var lensleft = 0;
                var lenstop = 0;

                function overleft(lens) {
                    return el.mousepos.x - (lens.w) / 2 < smallimage.pos.l; 
                }

                function overright(lens) {
                    return el.mousepos.x + (lens.w) / 2 > smallimage.pos.r; 
                   
                }

                function overtop(lens) {
                    return el.mousepos.y - (lens.h) / 2 < smallimage.pos.t; 
                }

                function overbottom(lens) {
                    return el.mousepos.y + (lens.h) / 2 > smallimage.pos.b; 
                }
                
                lensleft = el.mousepos.x + smallimage.bleft - smallimage.pos.l - (this.node.w + 2) / 2;
                lenstop = el.mousepos.y + smallimage.btop - smallimage.pos.t - (this.node.h + 2) / 2;
                if (overleft(this.node)) {
                    lensleft = smallimage.bleft - 1;
                } else if (overright(this.node)) {
                    lensleft = smallimage.w + smallimage.bleft - this.node.w - 1;
                }
                if (overtop(this.node)) {
                    lenstop = smallimage.btop - 1;
                } else if (overbottom(this.node)) {
                    lenstop = smallimage.h + smallimage.btop - this.node.h - 1;
                }
                
                this.node.left = lensleft;
                this.node.top = lenstop;
                this.node.css({
                    'left': lensleft + 'px',
                    'top': lenstop + 'px'
                });
                if (settings.zoomType == 'reverse') {
                    if ($.browser.msie && $.browser.version > 7) {
                        $(this.node).empty().append(this.image);
                    }

                    $(this.image).css({
                        position: 'absolute',
                        display: 'block',
                        left: -(this.node.left + 1 - smallimage.bleft) + 'px',
                        top: -(this.node.top + 1 - smallimage.btop) + 'px'
                    });
                }
               
                largeimage.setposition();
            };
            this.hide = function () {
                img.css({
                    'opacity': 1
                });
                this.node.hide();
            };
            this.show = function () {  
                
                if (settings.zoomType != 'innerzoom' && (settings.lens || settings.zoomType == 'drag')) {
                    this.node.show();
                }       

                if (settings.zoomType == 'reverse') {
                    img.css({
                        'opacity': settings.imageOpacity
                    });
                }
            };
            this.getoffset = function () {
                var o = {};
                o.left = $obj.node.left;
                o.top = $obj.node.top;
                return o;
            };
            return this;
        };
/*========================================================,
|   Stage
|---------------------------------------------------------:
|   Window area that contains the large image
`========================================================*/

        function Stage() {
            var $obj = this;
            this.node = $("<div class='zoomWindow'><div class='zoomWrapper'><div class='zoomWrapperTitle'></div><div class='zoomWrapperImage'></div></div></div>");
            this.ieframe = $('<iframe class="zoomIframe" src="javascript:\'\';" marginwidth="0" marginheight="0" align="bottom" scrolling="no" frameborder="0" ></iframe>');
            this.setposition = function () {
                this.node.leftpos = 0;
                this.node.toppos = 0;
                if (settings.zoomType != 'innerzoom') {
                    //positioning
                    switch (settings.position) {
                    case "left":
                        this.node.leftpos = (smallimage.pos.l - smallimage.bleft - Math.abs(settings.xOffset) - settings.zoomWidth > 0) ? (0 - settings.zoomWidth - Math.abs(settings.xOffset)) : (smallimage.ow + Math.abs(settings.xOffset));
                        this.node.toppos = Math.abs(settings.yOffset);
                        break;
                    case "top":
                        this.node.leftpos = Math.abs(settings.xOffset);
                        this.node.toppos = (smallimage.pos.t - smallimage.btop - Math.abs(settings.yOffset) - settings.zoomHeight > 0) ? (0 - settings.zoomHeight - Math.abs(settings.yOffset)) : (smallimage.oh + Math.abs(settings.yOffset));
                        break;
                    case "bottom":
                        this.node.leftpos = Math.abs(settings.xOffset);
                        this.node.toppos = (smallimage.pos.t - smallimage.btop + smallimage.oh + Math.abs(settings.yOffset) + settings.zoomHeight < screen.height) ? (smallimage.oh + Math.abs(settings.yOffset)) : (0 - settings.zoomHeight - Math.abs(settings.yOffset));
                        break;
                    default:
                        this.node.leftpos = (smallimage.rightlimit + Math.abs(settings.xOffset) + settings.zoomWidth < screen.width) ? (smallimage.ow + Math.abs(settings.xOffset)) : (0 - settings.zoomWidth - Math.abs(settings.xOffset));
                        this.node.toppos = Math.abs(settings.yOffset);
                        break;
                    }
                }
                this.node.css({
                    'left': this.node.leftpos + 'px',
                    'top': this.node.toppos + 'px'
                });
                return this;
            };
            this.append = function () {
                $('.zoomPad', el).append(this.node);
                this.node.css({
                    position: 'absolute',
                    display: 'none',
                    zIndex: 5001
                });
                if (settings.zoomType == 'innerzoom') {
                    this.node.css({
                        cursor: 'default'
                    });
                    var thickness = (smallimage.bleft == 0) ? 1 : smallimage.bleft;
                    $('.zoomWrapper', this.node).css({
                        borderWidth: thickness + 'px'
                    });    
                }
                
                  $('.zoomWrapper', this.node).css({
                      width: Math.round(settings.zoomWidth) + 'px' ,
                      borderWidth: thickness + 'px'
                  });

                  $('.zoomWrapperImage', this.node).css({
                      width: '100%',
                      height: Math.round(settings.zoomHeight) + 'px'
                  });
                  //zoom title
                 $('.zoomWrapperTitle', this.node).css({
                        width: '100%',
                        position: 'absolute'
                  });  
              
                $('.zoomWrapperTitle', this.node).hide();
                if (settings.title && zoomtitle.length > 0) {
                    $('.zoomWrapperTitle', this.node).html(zoomtitle).show();
                }
                $obj.setposition();
            };
            this.hide = function () {
                switch (settings.hideEffect) {
                case 'fadeout':
                    this.node.fadeOut(settings.fadeoutSpeed, function () {});
                    break;
                default:
                    this.node.hide();
                    break;
                }
                this.ieframe.hide();
            };
            this.show = function () {
                switch (settings.showEffect) {
                case 'fadein':
                    this.node.fadeIn();
                    this.node.fadeIn(settings.fadeinSpeed, function () {});
                    break;
                default:
                    this.node.show();
                    break;
                }
                if (isIE6 && settings.zoomType != 'innerzoom') {
                    this.ieframe.width = this.node.width();
                    this.ieframe.height = this.node.height();
                    this.ieframe.left = this.node.leftpos;
                    this.ieframe.top = this.node.toppos;
                    this.ieframe.css({
                        display: 'block',
                        position: "absolute",
                        left: this.ieframe.left,
                        top: this.ieframe.top,
                        zIndex: 99,
                        width: this.ieframe.width + 'px',
                        height: this.ieframe.height + 'px'
                    });
                    $('.zoomPad', el).append(this.ieframe);
                    this.ieframe.show();
                };
            };
        };
/*========================================================,
|   LargeImage
|---------------------------------------------------------:
|   The large detailed image
`========================================================*/

        function Largeimage() {
            var $obj = this;
            this.node = new Image();
            this.loadimage = function (url) {
                //showing preload
                loader.show();
                this.url = url;
                this.node.style.position = 'absolute';
                this.node.style.border = '0px';
                this.node.style.display = 'none';
                this.node.style.left = '-5000px';
                this.node.style.top = '0px';
                document.body.appendChild(this.node);
                this.node.src = url; // fires off async
            };
            this.fetchdata = function () {
                var image = $(this.node);
                var scale = {};
                this.node.style.display = 'block';
                $obj.w = image.width();
                $obj.h = image.height();
                $obj.pos = image.offset();
                $obj.pos.l = image.offset().left;
                $obj.pos.t = image.offset().top;
                $obj.pos.r = $obj.w + $obj.pos.l;
                $obj.pos.b = $obj.h + $obj.pos.t;
                scale.x = ($obj.w / smallimage.w);
                scale.y = ($obj.h / smallimage.h);
                el.scale = scale;
                document.body.removeChild(this.node);
                $('.zoomWrapperImage', el).empty().append(this.node);
                //setting lens dimensions;
                lens.setdimensions();
            };
            this.node.onerror = function () {
                alert('Problems while loading the big image.');
                throw 'Problems while loading the big image.';
            };
            this.node.onload = function () {
                //fetching data
                $obj.fetchdata();
                loader.hide();
                el.largeimageloading = false;
                el.largeimageloaded = true;
                if (settings.zoomType == 'drag' || settings.alwaysOn) {
                    lens.show();
                    stage.show();
                    lens.setcenter();
                }
            };
            this.setposition = function () {
                var left = -el.scale.x * (lens.getoffset().left - smallimage.bleft + 1);
                var top = -el.scale.y * (lens.getoffset().top - smallimage.btop + 1);
                $(this.node).css({
                    'left': left + 'px',
                    'top': top + 'px'
                });
            };
            return this;
        };
        $(el).data("jqzoom", obj);
    };
    //es. $.jqzoom.disable('#jqzoom1');
    $.jqzoom = {
        defaults: {
            zoomType: 'standard',
            //innerzoom/standard/reverse/drag
            zoomWidth: 300,
            //zoomWindow  default width
            zoomHeight: 300,
            //zoomWindow  default height
            xOffset: 5,
            //zoomWindow x offset, can be negative(more on the left) or positive(more on the right)
            yOffset: 0,
            //zoomWindow y offset, can be negative(more on the left) or positive(more on the right)
            position: "right",
            //zoomWindow default position
            preloadImages: true,
            //image preload
            preloadText: 'Loading zoom',
            title: true,
            lens: true,
            imageOpacity: 0.4,
            alwaysOn: false,
            showEffect: 'show',
            //show/fadein
            hideEffect: 'hide',
            //hide/fadeout
            fadeinSpeed: 'slow',
            //fast/slow/number
            fadeoutSpeed: '2000' //fast/slow/number
        },
        disable: function (el) {
            var api = $(el).data('jqzoom');
            api.disable();
            return false;
        },
        enable: function (el) {
            var api = $(el).data('jqzoom');
            api.enable();
            return false;
        },
        disableAll: function (el) {
            jqzoompluging_disabled = true;
        },
        enableAll: function (el) {
            jqzoompluging_disabled = false;
        }
    };
})(jQuery);















































			


$(document).ready(function(){
	$(".tabContents").hide(); 
	$(".tabContents:first").show(); 
	
	$("#tabContaier ul li a").click(function(){ 
		
		var activeTab = $(this).attr("title"); 
		$("#tabContaier ul li a").removeClass("active"); 
		$("#tabContaier ul li a").addClass("backgroundtab"); 
		$(this).removeClass("backgroundtab"); 
		$(this).addClass("active"); 
		$(".tabContents").hide(); 
		$(activeTab).fadeIn(); 
	});
	
	
	
	
		$('.jqzoom').jqzoom({
			zoomWidth: 300,  
			zoomHeight:350,  
			zoomType: 'standard',
			lens:false,
			preloadImages: false,
           // position:'bottom',
			alwaysOn:false
        });

	
	
	
	
});







/* http://keith-wood.name/countdown.html
   Countdown for jQuery v1.6.1.
   Written by Keith Wood (kbwood{at}iinet.com.au) January 2008.
   Available under the MIT (https://github.com/jquery/jquery/blob/master/MIT-LICENSE.txt) license. 
   Please attribute the author if you use it. */

/* Display a countdown timer.
   Attach it with options like:
   $('div selector').countdown(
       {until: new Date(2009, 1 - 1, 1, 0, 0, 0), onExpiry: happyNewYear}); */

(function($) { // Hide scope, no $ conflict

/* Countdown manager. */
function Countdown() {
	this.regional = []; // Available regional settings, indexed by language code
	this.regional[''] = { // Default regional settings
		// The display texts for the counters
		labels: ['Years', 'Months', 'Weeks', 'Days', 'Hours', 'Minutes', 'Seconds'],
		// The display texts for the counters if only one
		labels1: ['Year', 'Month', 'Week', 'Day', 'Hour', 'Minute', 'Second'],
		compactLabels: ['y', 'm', 'w', 'd'], // The compact texts for the counters
		whichLabels: null, // Function to determine which labels to use
		digits: ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'], // The digits to display
		timeSeparator: ':', // Separator for time periods
		isRTL: false // True for right-to-left languages, false for left-to-right
	};
	this._defaults = {
		until: null, // new Date(year, mth - 1, day, hr, min, sec) - date/time to count down to
			// or numeric for seconds offset, or string for unit offset(s):
			// 'Y' years, 'O' months, 'W' weeks, 'D' days, 'H' hours, 'M' minutes, 'S' seconds
		since: null, // new Date(year, mth - 1, day, hr, min, sec) - date/time to count up from
			// or numeric for seconds offset, or string for unit offset(s):
			// 'Y' years, 'O' months, 'W' weeks, 'D' days, 'H' hours, 'M' minutes, 'S' seconds
		timezone: null, // The timezone (hours or minutes from GMT) for the target times,
			// or null for client local
		serverSync: null, // A function to retrieve the current server time for synchronisation
		format: 'dHMS', // Format for display - upper case for always, lower case only if non-zero,
			// 'Y' years, 'O' months, 'W' weeks, 'D' days, 'H' hours, 'M' minutes, 'S' seconds
		layout: '', // Build your own layout for the countdown
		compact: false, // True to display in a compact format, false for an expanded one
		significant: 0, // The number of periods with values to show, zero for all
		description: '', // The description displayed for the countdown
		expiryUrl: '', // A URL to load upon expiry, replacing the current page
		expiryText: '', // Text to display upon expiry, replacing the countdown
		alwaysExpire: false, // True to trigger onExpiry even if never counted down
		onExpiry: null, // Callback when the countdown expires -
			// receives no parameters and 'this' is the containing division
		onTick: null, // Callback when the countdown is updated -
			// receives int[7] being the breakdown by period (based on format)
			// and 'this' is the containing division
		tickInterval: 1 // Interval (seconds) between onTick callbacks
	};
	$.extend(this._defaults, this.regional['']);
	this._serverSyncs = [];
	// Shared timer for all countdowns
	function timerCallBack(timestamp) {
		var drawStart = (timestamp < 1e12 ? // New HTML5 high resolution timer
			(drawStart = performance.now ?
			(performance.now() + performance.timing.navigationStart) : Date.now()) :
			// Integer milliseconds since unix epoch
			timestamp || new Date().getTime());
		if (drawStart - animationStartTime >= 1000) {
			plugin._updateTargets();
			animationStartTime = drawStart;
		}
		requestAnimationFrame(timerCallBack);
	}
	var requestAnimationFrame = window.requestAnimationFrame ||
		window.webkitRequestAnimationFrame || window.mozRequestAnimationFrame ||
		window.oRequestAnimationFrame || window.msRequestAnimationFrame || null;
		// This is when we expect a fall-back to setInterval as it's much more fluid
	var animationStartTime = 0;
	if (!requestAnimationFrame || $.noRequestAnimationFrame) {
		$.noRequestAnimationFrame = null;
		setInterval(function() { plugin._updateTargets(); }, 980); // Fall back to good old setInterval
	}
	else {
		animationStartTime = window.animationStartTime ||
			window.webkitAnimationStartTime || window.mozAnimationStartTime ||
			window.oAnimationStartTime || window.msAnimationStartTime || new Date().getTime();
		requestAnimationFrame(timerCallBack);
	}
}

var Y = 0; // Years
var O = 1; // Months
var W = 2; // Weeks
var D = 3; // Days
var H = 4; // Hours
var M = 5; // Minutes
var S = 6; // Seconds

$.extend(Countdown.prototype, {
	/* Class name added to elements to indicate already configured with countdown. */
	markerClassName: 'hasCountdown',
	/* Name of the data property for instance settings. */
	propertyName: 'countdown',

	/* Class name for the right-to-left marker. */
	_rtlClass: 'countdown_rtl',
	/* Class name for the countdown section marker. */
	_sectionClass: 'countdown_section',
	/* Class name for the period amount marker. */
	_amountClass: 'countdown_amount',
	/* Class name for the countdown row marker. */
	_rowClass: 'countdown_row',
	/* Class name for the holding countdown marker. */
	_holdingClass: 'countdown_holding',
	/* Class name for the showing countdown marker. */
	_showClass: 'countdown_show',
	/* Class name for the description marker. */
	_descrClass: 'countdown_descr',

	/* List of currently active countdown targets. */
	_timerTargets: [],
	
	/* Override the default settings for all instances of the countdown widget.
	   @param  options  (object) the new settings to use as defaults */
	setDefaults: function(options) {
		this._resetExtraLabels(this._defaults, options);
		$.extend(this._defaults, options || {});
	},

	/* Convert a date/time to UTC.
	   @param  tz     (number) the hour or minute offset from GMT, e.g. +9, -360
	   @param  year   (Date) the date/time in that timezone or
	                  (number) the year in that timezone
	   @param  month  (number, optional) the month (0 - 11) (omit if year is a Date)
	   @param  day    (number, optional) the day (omit if year is a Date)
	   @param  hours  (number, optional) the hour (omit if year is a Date)
	   @param  mins   (number, optional) the minute (omit if year is a Date)
	   @param  secs   (number, optional) the second (omit if year is a Date)
	   @param  ms     (number, optional) the millisecond (omit if year is a Date)
	   @return  (Date) the equivalent UTC date/time */
	UTCDate: function(tz, year, month, day, hours, mins, secs, ms) {
		if (typeof year == 'object' && year.constructor == Date) {
			ms = year.getMilliseconds();
			secs = year.getSeconds();
			mins = year.getMinutes();
			hours = year.getHours();
			day = year.getDate();
			month = year.getMonth();
			year = year.getFullYear();
		}
		var d = new Date();
		d.setUTCFullYear(year);
		d.setUTCDate(1);
		d.setUTCMonth(month || 0);
		d.setUTCDate(day || 1);
		d.setUTCHours(hours || 0);
		d.setUTCMinutes((mins || 0) - (Math.abs(tz) < 30 ? tz * 60 : tz));
		d.setUTCSeconds(secs || 0);
		d.setUTCMilliseconds(ms || 0);
		return d;
	},

	/* Convert a set of periods into seconds.
	   Averaged for months and years.
	   @param  periods  (number[7]) the periods per year/month/week/day/hour/minute/second
	   @return  (number) the corresponding number of seconds */
	periodsToSeconds: function(periods) {
		return periods[0] * 31557600 + periods[1] * 2629800 + periods[2] * 604800 +
			periods[3] * 86400 + periods[4] * 3600 + periods[5] * 60 + periods[6];
	},

	/* Attach the countdown widget to a div.
	   @param  target   (element) the containing division
	   @param  options  (object) the initial settings for the countdown */
	_attachPlugin: function(target, options) {
		target = $(target);
		if (target.hasClass(this.markerClassName)) {
			return;
		}
		var inst = {options: $.extend({}, this._defaults), _periods: [0, 0, 0, 0, 0, 0, 0]};
		target.addClass(this.markerClassName).data(this.propertyName, inst);
		this._optionPlugin(target, options);
	},

	/* Add a target to the list of active ones.
	   @param  target  (element) the countdown target */
	_addTarget: function(target) {
		if (!this._hasTarget(target)) {
			this._timerTargets.push(target);
		}
	},

	/* See if a target is in the list of active ones.
	   @param  target  (element) the countdown target
	   @return  (boolean) true if present, false if not */
	_hasTarget: function(target) {
		return ($.inArray(target, this._timerTargets) > -1);
	},

	/* Remove a target from the list of active ones.
	   @param  target  (element) the countdown target */
	_removeTarget: function(target) {
		this._timerTargets = $.map(this._timerTargets,
			function(value) { return (value == target ? null : value); }); // delete entry
	},

	/* Update each active timer target. */
	_updateTargets: function() {
		for (var i = this._timerTargets.length - 1; i >= 0; i--) {
			this._updateCountdown(this._timerTargets[i]);
		}
	},

	/* Reconfigure the settings for a countdown div.
	   @param  target   (element) the control to affect
	   @param  options  (object) the new options for this instance or
	                    (string) an individual property name
	   @param  value    (any) the individual property value (omit if options
	                    is an object or to retrieve the value of a setting)
	   @return  (any) if retrieving a value */
	_optionPlugin: function(target, options, value) {
		target = $(target);
		var inst = target.data(this.propertyName);
		if (!options || (typeof options == 'string' && value == null)) { // Get option
			var name = options;
			options = (inst || {}).options;
			return (options && name ? options[name] : options);
		}

		if (!target.hasClass(this.markerClassName)) {
			return;
		}
		options = options || {};
		if (typeof options == 'string') {
			var name = options;
			options = {};
			options[name] = value;
		}
		this._resetExtraLabels(inst.options, options);
		$.extend(inst.options, options);
		this._adjustSettings(target, inst);
		var now = new Date();
		if ((inst._since && inst._since < now) || (inst._until && inst._until > now)) {
			this._addTarget(target[0]);
		}
		this._updateCountdown(target, inst);
	},

	/* Redisplay the countdown with an updated display.
	   @param  target  (jQuery) the containing division
	   @param  inst    (object) the current settings for this instance */
	_updateCountdown: function(target, inst) {
		var $target = $(target);
		inst = inst || $target.data(this.propertyName);
		if (!inst) {
			return;
		}
		$target.html(this._generateHTML(inst)).toggleClass(this._rtlClass, inst.options.isRTL);
		if ($.isFunction(inst.options.onTick)) {
			var periods = inst._hold != 'lap' ? inst._periods :
				this._calculatePeriods(inst, inst._show, inst.options.significant, new Date());
			if (inst.options.tickInterval == 1 ||
					this.periodsToSeconds(periods) % inst.options.tickInterval == 0) {
				inst.options.onTick.apply(target, [periods]);
			}
		}
		var expired = inst._hold != 'pause' &&
			(inst._since ? inst._now.getTime() < inst._since.getTime() :
			inst._now.getTime() >= inst._until.getTime());
		if (expired && !inst._expiring) {
			inst._expiring = true;
			if (this._hasTarget(target) || inst.options.alwaysExpire) {
				this._removeTarget(target);
				if ($.isFunction(inst.options.onExpiry)) {
					inst.options.onExpiry.apply(target, []);
				}
				if (inst.options.expiryText) {
					var layout = inst.options.layout;
					inst.options.layout = inst.options.expiryText;
					this._updateCountdown(target, inst);
					inst.options.layout = layout;
				}
				if (inst.options.expiryUrl) {
					window.location = inst.options.expiryUrl;
				}
			}
			inst._expiring = false;
		}
		else if (inst._hold == 'pause') {
			this._removeTarget(target);
		}
		$target.data(this.propertyName, inst);
	},

	/* Reset any extra labelsn and compactLabelsn entries if changing labels.
	   @param  base     (object) the options to be updated
	   @param  options  (object) the new option values */
	_resetExtraLabels: function(base, options) {
		var changingLabels = false;
		for (var n in options) {
			if (n != 'whichLabels' && n.match(/[Ll]abels/)) {
				changingLabels = true;
				break;
			}
		}
		if (changingLabels) {
			for (var n in base) { // Remove custom numbered labels
				if (n.match(/[Ll]abels[02-9]/)) {
					base[n] = null;
				}
			}
		}
	},
	
	/* Calculate interal settings for an instance.
	   @param  target  (element) the containing division
	   @param  inst    (object) the current settings for this instance */
	_adjustSettings: function(target, inst) {
		var now;
		var serverOffset = 0;
		var serverEntry = null;
		for (var i = 0; i < this._serverSyncs.length; i++) {
			if (this._serverSyncs[i][0] == inst.options.serverSync) {
				serverEntry = this._serverSyncs[i][1];
				break;
			}
		}
		if (serverEntry != null) {
			serverOffset = (inst.options.serverSync ? serverEntry : 0);
			now = new Date();
		}
		else {
			var serverResult = ($.isFunction(inst.options.serverSync) ?
				inst.options.serverSync.apply(target, []) : null);
			now = new Date();
			serverOffset = (serverResult ? now.getTime() - serverResult.getTime() : 0);
			this._serverSyncs.push([inst.options.serverSync, serverOffset]);
		}
		var timezone = inst.options.timezone;
		timezone = (timezone == null ? -now.getTimezoneOffset() : timezone);
		inst._since = inst.options.since;
		if (inst._since != null) {
			inst._since = this.UTCDate(timezone, this._determineTime(inst._since, null));
			if (inst._since && serverOffset) {
				inst._since.setMilliseconds(inst._since.getMilliseconds() + serverOffset);
			}
		}
		inst._until = this.UTCDate(timezone, this._determineTime(inst.options.until, now));
		if (serverOffset) {
			inst._until.setMilliseconds(inst._until.getMilliseconds() + serverOffset);
		}
		inst._show = this._determineShow(inst);
	},

	/* Remove the countdown widget from a div.
	   @param  target  (element) the containing division */
	_destroyPlugin: function(target) {
		target = $(target);
		if (!target.hasClass(this.markerClassName)) {
			return;
		}
		this._removeTarget(target[0]);
		target.removeClass(this.markerClassName).empty().removeData(this.propertyName);
	},

	/* Pause a countdown widget at the current time.
	   Stop it running but remember and display the current time.
	   @param  target  (element) the containing division */
	_pausePlugin: function(target) {
		this._hold(target, 'pause');
	},

	/* Pause a countdown widget at the current time.
	   Stop the display but keep the countdown running.
	   @param  target  (element) the containing division */
	_lapPlugin: function(target) {
		this._hold(target, 'lap');
	},

	/* Resume a paused countdown widget.
	   @param  target  (element) the containing division */
	_resumePlugin: function(target) {
		this._hold(target, null);
	},

	/* Pause or resume a countdown widget.
	   @param  target  (element) the containing division
	   @param  hold    (string) the new hold setting */
	_hold: function(target, hold) {
		var inst = $.data(target, this.propertyName);
		if (inst) {
			if (inst._hold == 'pause' && !hold) {
				inst._periods = inst._savePeriods;
				var sign = (inst._since ? '-' : '+');
				inst[inst._since ? '_since' : '_until'] =
					this._determineTime(sign + inst._periods[0] + 'y' +
						sign + inst._periods[1] + 'o' + sign + inst._periods[2] + 'w' +
						sign + inst._periods[3] + 'd' + sign + inst._periods[4] + 'h' + 
						sign + inst._periods[5] + 'm' + sign + inst._periods[6] + 's');
				this._addTarget(target);
			}
			inst._hold = hold;
			inst._savePeriods = (hold == 'pause' ? inst._periods : null);
			$.data(target, this.propertyName, inst);
			this._updateCountdown(target, inst);
		}
	},

	/* Return the current time periods.
	   @param  target  (element) the containing division
	   @return  (number[7]) the current periods for the countdown */
	_getTimesPlugin: function(target) {
		var inst = $.data(target, this.propertyName);
		return (!inst ? null : (!inst._hold ? inst._periods :
			this._calculatePeriods(inst, inst._show, inst.options.significant, new Date())));
	},

	/* A time may be specified as an exact value or a relative one.
	   @param  setting      (string or number or Date) - the date/time value
	                        as a relative or absolute value
	   @param  defaultTime  (Date) the date/time to use if no other is supplied
	   @return  (Date) the corresponding date/time */
	_determineTime: function(setting, defaultTime) {
		var offsetNumeric = function(offset) { // e.g. +300, -2
			var time = new Date();
			time.setTime(time.getTime() + offset * 1000);
			return time;
		};
		var offsetString = function(offset) { // e.g. '+2d', '-4w', '+3h +30m'
			offset = offset.toLowerCase();
			var time = new Date();
			var year = time.getFullYear();
			var month = time.getMonth();
			var day = time.getDate();
			var hour = time.getHours();
			var minute = time.getMinutes();
			var second = time.getSeconds();
			var pattern = /([+-]?[0-9]+)\s*(s|m|h|d|w|o|y)?/g;
			var matches = pattern.exec(offset);
			while (matches) {
				switch (matches[2] || 's') {
					case 's': second += parseInt(matches[1], 10); break;
					case 'm': minute += parseInt(matches[1], 10); break;
					case 'h': hour += parseInt(matches[1], 10); break;
					case 'd': day += parseInt(matches[1], 10); break;
					case 'w': day += parseInt(matches[1], 10) * 7; break;
					case 'o':
						month += parseInt(matches[1], 10); 
						day = Math.min(day, plugin._getDaysInMonth(year, month));
						break;
					case 'y':
						year += parseInt(matches[1], 10);
						day = Math.min(day, plugin._getDaysInMonth(year, month));
						break;
				}
				matches = pattern.exec(offset);
			}
			return new Date(year, month, day, hour, minute, second, 0);
		};
		var time = (setting == null ? defaultTime :
			(typeof setting == 'string' ? offsetString(setting) :
			(typeof setting == 'number' ? offsetNumeric(setting) : setting)));
		if (time) time.setMilliseconds(0);
		return time;
	},

	/* Determine the number of days in a month.
	   @param  year   (number) the year
	   @param  month  (number) the month
	   @return  (number) the days in that month */
	_getDaysInMonth: function(year, month) {
		return 32 - new Date(year, month, 32).getDate();
	},

	/* Determine which set of labels should be used for an amount.
	   @param  num  (number) the amount to be displayed
	   @return  (number) the set of labels to be used for this amount */
	_normalLabels: function(num) {
		return num;
	},

	/* Generate the HTML to display the countdown widget.
	   @param  inst  (object) the current settings for this instance
	   @return  (string) the new HTML for the countdown display */
	_generateHTML: function(inst) {
		var self = this;
		// Determine what to show
		inst._periods = (inst._hold ? inst._periods :
			this._calculatePeriods(inst, inst._show, inst.options.significant, new Date()));
		// Show all 'asNeeded' after first non-zero value
		var shownNonZero = false;
		var showCount = 0;
		var sigCount = inst.options.significant;
		var show = $.extend({}, inst._show);
		for (var period = Y; period <= S; period++) {
			shownNonZero |= (inst._show[period] == '?' && inst._periods[period] > 0);
			show[period] = (inst._show[period] == '?' && !shownNonZero ? null : inst._show[period]);
			showCount += (show[period] ? 1 : 0);
			sigCount -= (inst._periods[period] > 0 ? 1 : 0);
		}
		var showSignificant = [false, false, false, false, false, false, false];
		for (var period = S; period >= Y; period--) { // Determine significant periods
			if (inst._show[period]) {
				if (inst._periods[period]) {
					showSignificant[period] = true;
				}
				else {
					showSignificant[period] = sigCount > 0;
					sigCount--;
				}
			}
		}
		var labels = (inst.options.compact ? inst.options.compactLabels : inst.options.labels);
		var whichLabels = inst.options.whichLabels || this._normalLabels;
		var showCompact = function(period) {
			var labelsNum = inst.options['compactLabels' + whichLabels(inst._periods[period])];
			return (show[period] ? self._translateDigits(inst, inst._periods[period]) +
				(labelsNum ? labelsNum[period] : labels[period]) + ' ' : '');
		};
		var showFull = function(period) {
			var labelsNum = inst.options['labels' + whichLabels(inst._periods[period])];
			return ((!inst.options.significant && show[period]) ||
				(inst.options.significant && showSignificant[period]) ?
				'<span class="' + plugin._sectionClass + '">' +
				'<span class="' + plugin._amountClass + '">' +
				self._translateDigits(inst, inst._periods[period]) + '</span><br/>' +
				(labelsNum ? labelsNum[period] : labels[period]) + '</span>' : '');
		};
		return (inst.options.layout ? this._buildLayout(inst, show, inst.options.layout,
			inst.options.compact, inst.options.significant, showSignificant) :
			((inst.options.compact ? // Compact version
			'<span class="' + this._rowClass + ' ' + this._amountClass +
			(inst._hold ? ' ' + this._holdingClass : '') + '">' + 
			showCompact(Y) + showCompact(O) + showCompact(W) + showCompact(D) + 
			(show[H] ? this._minDigits(inst, inst._periods[H], 2) : '') +
			(show[M] ? (show[H] ? inst.options.timeSeparator : '') +
			this._minDigits(inst, inst._periods[M], 2) : '') +
			(show[S] ? (show[H] || show[M] ? inst.options.timeSeparator : '') +
			this._minDigits(inst, inst._periods[S], 2) : '') :
			// Full version
			'<span class="' + this._rowClass + ' ' + this._showClass + (inst.options.significant || showCount) +
			(inst._hold ? ' ' + this._holdingClass : '') + '">' +
			showFull(Y) + showFull(O) + showFull(W) + showFull(D) +
			showFull(H) + showFull(M) + showFull(S)) + '</span>' +
			(inst.options.description ? '<span class="' + this._rowClass + ' ' + this._descrClass + '">' +
			inst.options.description + '</span>' : '')));
	},

	/* Construct a custom layout.
	   @param  inst             (object) the current settings for this instance
	   @param  show             (string[7]) flags indicating which periods are requested
	   @param  layout           (string) the customised layout
	   @param  compact          (boolean) true if using compact labels
	   @param  significant      (number) the number of periods with values to show, zero for all
	   @param  showSignificant  (boolean[7]) other periods to show for significance
	   @return  (string) the custom HTML */
	_buildLayout: function(inst, show, layout, compact, significant, showSignificant) {
		var labels = inst.options[compact ? 'compactLabels' : 'labels'];
		var whichLabels = inst.options.whichLabels || this._normalLabels;
		var labelFor = function(index) {
			return (inst.options[(compact ? 'compactLabels' : 'labels') +
				whichLabels(inst._periods[index])] || labels)[index];
		};
		var digit = function(value, position) {
			return inst.options.digits[Math.floor(value / position) % 10];
		};
		var subs = {desc: inst.options.description, sep: inst.options.timeSeparator,
			yl: labelFor(Y), yn: this._minDigits(inst, inst._periods[Y], 1),
			ynn: this._minDigits(inst, inst._periods[Y], 2),
			ynnn: this._minDigits(inst, inst._periods[Y], 3), y1: digit(inst._periods[Y], 1),
			y10: digit(inst._periods[Y], 10), y100: digit(inst._periods[Y], 100),
			y1000: digit(inst._periods[Y], 1000),
			ol: labelFor(O), on: this._minDigits(inst, inst._periods[O], 1),
			onn: this._minDigits(inst, inst._periods[O], 2),
			onnn: this._minDigits(inst, inst._periods[O], 3), o1: digit(inst._periods[O], 1),
			o10: digit(inst._periods[O], 10), o100: digit(inst._periods[O], 100),
			o1000: digit(inst._periods[O], 1000),
			wl: labelFor(W), wn: this._minDigits(inst, inst._periods[W], 1),
			wnn: this._minDigits(inst, inst._periods[W], 2),
			wnnn: this._minDigits(inst, inst._periods[W], 3), w1: digit(inst._periods[W], 1),
			w10: digit(inst._periods[W], 10), w100: digit(inst._periods[W], 100),
			w1000: digit(inst._periods[W], 1000),
			dl: labelFor(D), dn: this._minDigits(inst, inst._periods[D], 1),
			dnn: this._minDigits(inst, inst._periods[D], 2),
			dnnn: this._minDigits(inst, inst._periods[D], 3), d1: digit(inst._periods[D], 1),
			d10: digit(inst._periods[D], 10), d100: digit(inst._periods[D], 100),
			d1000: digit(inst._periods[D], 1000),
			hl: labelFor(H), hn: this._minDigits(inst, inst._periods[H], 1),
			hnn: this._minDigits(inst, inst._periods[H], 2),
			hnnn: this._minDigits(inst, inst._periods[H], 3), h1: digit(inst._periods[H], 1),
			h10: digit(inst._periods[H], 10), h100: digit(inst._periods[H], 100),
			h1000: digit(inst._periods[H], 1000),
			ml: labelFor(M), mn: this._minDigits(inst, inst._periods[M], 1),
			mnn: this._minDigits(inst, inst._periods[M], 2),
			mnnn: this._minDigits(inst, inst._periods[M], 3), m1: digit(inst._periods[M], 1),
			m10: digit(inst._periods[M], 10), m100: digit(inst._periods[M], 100),
			m1000: digit(inst._periods[M], 1000),
			sl: labelFor(S), sn: this._minDigits(inst, inst._periods[S], 1),
			snn: this._minDigits(inst, inst._periods[S], 2),
			snnn: this._minDigits(inst, inst._periods[S], 3), s1: digit(inst._periods[S], 1),
			s10: digit(inst._periods[S], 10), s100: digit(inst._periods[S], 100),
			s1000: digit(inst._periods[S], 1000)};
		var html = layout;
		// Replace period containers: {p<}...{p>}
		for (var i = Y; i <= S; i++) {
			var period = 'yowdhms'.charAt(i);
			var re = new RegExp('\\{' + period + '<\\}(.*)\\{' + period + '>\\}', 'g');
			html = html.replace(re, ((!significant && show[i]) ||
				(significant && showSignificant[i]) ? '$1' : ''));
		}
		// Replace period values: {pn}
		$.each(subs, function(n, v) {
			var re = new RegExp('\\{' + n + '\\}', 'g');
			html = html.replace(re, v);
		});
		return html;
	},

	/* Ensure a numeric value has at least n digits for display.
	   @param  inst   (object) the current settings for this instance
	   @param  value  (number) the value to display
	   @param  len    (number) the minimum length
	   @return  (string) the display text */
	_minDigits: function(inst, value, len) {
		value = '' + value;
		if (value.length >= len) {
			return this._translateDigits(inst, value);
		}
		value = '0000000000' + value;
		return this._translateDigits(inst, value.substr(value.length - len));
	},

	/* Translate digits into other representations.
	   @param  inst   (object) the current settings for this instance
	   @param  value  (string) the text to translate
	   @return  (string) the translated text */
	_translateDigits: function(inst, value) {
		return ('' + value).replace(/[0-9]/g, function(digit) {
				return inst.options.digits[digit];
			});
	},

	/* Translate the format into flags for each period.
	   @param  inst  (object) the current settings for this instance
	   @return  (string[7]) flags indicating which periods are requested (?) or
	            required (!) by year, month, week, day, hour, minute, second */
	_determineShow: function(inst) {
		var format = inst.options.format;
		var show = [];
		show[Y] = (format.match('y') ? '?' : (format.match('Y') ? '!' : null));
		show[O] = (format.match('o') ? '?' : (format.match('O') ? '!' : null));
		show[W] = (format.match('w') ? '?' : (format.match('W') ? '!' : null));
		show[D] = (format.match('d') ? '?' : (format.match('D') ? '!' : null));
		show[H] = (format.match('h') ? '?' : (format.match('H') ? '!' : null));
		show[M] = (format.match('m') ? '?' : (format.match('M') ? '!' : null));
		show[S] = (format.match('s') ? '?' : (format.match('S') ? '!' : null));
		return show;
	},
	
	/* Calculate the requested periods between now and the target time.
	   @param  inst         (object) the current settings for this instance
	   @param  show         (string[7]) flags indicating which periods are requested/required
	   @param  significant  (number) the number of periods with values to show, zero for all
	   @param  now          (Date) the current date and time
	   @return  (number[7]) the current time periods (always positive)
	            by year, month, week, day, hour, minute, second */
	_calculatePeriods: function(inst, show, significant, now) {
		// Find endpoints
		inst._now = now;
		inst._now.setMilliseconds(0);
		var until = new Date(inst._now.getTime());
		if (inst._since) {
			if (now.getTime() < inst._since.getTime()) {
				inst._now = now = until;
			}
			else {
				now = inst._since;
			}
		}
		else {
			until.setTime(inst._until.getTime());
			if (now.getTime() > inst._until.getTime()) {
				inst._now = now = until;
			}
		}
		// Calculate differences by period
		var periods = [0, 0, 0, 0, 0, 0, 0];
		if (show[Y] || show[O]) {
			// Treat end of months as the same
			var lastNow = plugin._getDaysInMonth(now.getFullYear(), now.getMonth());
			var lastUntil = plugin._getDaysInMonth(until.getFullYear(), until.getMonth());
			var sameDay = (until.getDate() == now.getDate() ||
				(until.getDate() >= Math.min(lastNow, lastUntil) &&
				now.getDate() >= Math.min(lastNow, lastUntil)));
			var getSecs = function(date) {
				return (date.getHours() * 60 + date.getMinutes()) * 60 + date.getSeconds();
			};
			var months = Math.max(0,
				(until.getFullYear() - now.getFullYear()) * 12 + until.getMonth() - now.getMonth() +
				((until.getDate() < now.getDate() && !sameDay) ||
				(sameDay && getSecs(until) < getSecs(now)) ? -1 : 0));
			periods[Y] = (show[Y] ? Math.floor(months / 12) : 0);
			periods[O] = (show[O] ? months - periods[Y] * 12 : 0);
			// Adjust for months difference and end of month if necessary
			now = new Date(now.getTime());
			var wasLastDay = (now.getDate() == lastNow);
			var lastDay = plugin._getDaysInMonth(now.getFullYear() + periods[Y],
				now.getMonth() + periods[O]);
			if (now.getDate() > lastDay) {
				now.setDate(lastDay);
			}
			now.setFullYear(now.getFullYear() + periods[Y]);
			now.setMonth(now.getMonth() + periods[O]);
			if (wasLastDay) {
				now.setDate(lastDay);
			}
		}
		var diff = Math.floor((until.getTime() - now.getTime()) / 1000);
		var extractPeriod = function(period, numSecs) {
			periods[period] = (show[period] ? Math.floor(diff / numSecs) : 0);
			diff -= periods[period] * numSecs;
		};
		extractPeriod(W, 604800);
		extractPeriod(D, 86400);
		extractPeriod(H, 3600);
		extractPeriod(M, 60);
		extractPeriod(S, 1);
		if (diff > 0 && !inst._since) { // Round up if left overs
			var multiplier = [1, 12, 4.3482, 7, 24, 60, 60];
			var lastShown = S;
			var max = 1;
			for (var period = S; period >= Y; period--) {
				if (show[period]) {
					if (periods[lastShown] >= max) {
						periods[lastShown] = 0;
						diff = 1;
					}
					if (diff > 0) {
						periods[period]++;
						diff = 0;
						lastShown = period;
						max = 1;
					}
				}
				max *= multiplier[period];
			}
		}
		if (significant) { // Zero out insignificant periods
			for (var period = Y; period <= S; period++) {
				if (significant && periods[period]) {
					significant--;
				}
				else if (!significant) {
					periods[period] = 0;
				}
			}
		}
		return periods;
	}
});

// The list of commands that return values and don't permit chaining
var getters = ['getTimes'];

/* Determine whether a command is a getter and doesn't permit chaining.
   @param  command    (string, optional) the command to run
   @param  otherArgs  ([], optional) any other arguments for the command
   @return  true if the command is a getter, false if not */
function isNotChained(command, otherArgs) {
	if (command == 'option' && (otherArgs.length == 0 ||
			(otherArgs.length == 1 && typeof otherArgs[0] == 'string'))) {
		return true;
	}
	return $.inArray(command, getters) > -1;
}

/* Process the countdown functionality for a jQuery selection.
   @param  options  (object) the new settings to use for these instances (optional) or
                    (string) the command to run (optional)
   @return  (jQuery) for chaining further calls or
            (any) getter value */
$.fn.countdown = function(options) {
	var otherArgs = Array.prototype.slice.call(arguments, 1);
	if (isNotChained(options, otherArgs)) {
		return plugin['_' + options + 'Plugin'].
			apply(plugin, [this[0]].concat(otherArgs));
	}
	return this.each(function() {
		if (typeof options == 'string') {
			if (!plugin['_' + options + 'Plugin']) {
				throw 'Unknown command: ' + options;
			}
			plugin['_' + options + 'Plugin'].
				apply(plugin, [this].concat(otherArgs));
		}
		else {
			plugin._attachPlugin(this, options || {});
		}
	});
};

/* Initialise the countdown functionality. */
var plugin = $.countdown = new Countdown(); // Singleton instance

})(jQuery);









/*
 * jQuery Nivo Slider v3.2
 * http://nivo.dev7studios.com
 *
 * Copyright 2012, Dev7studios
 * Free to use and abuse under the MIT license.
 * http://www.opensource.org/licenses/mit-license.php
 */

(function(e){var t=function(t,n){var r=e.extend({},e.fn.nivoSlider.defaults,n);var i={currentSlide:0,currentImage:"",totalSlides:0,running:false,paused:false,stop:false,controlNavEl:false};var s=e(t);s.data("nivo:vars",i).addClass("nivoSlider");var o=s.children();o.each(function(){var t=e(this);var n="";if(!t.is("img")){if(t.is("a")){t.addClass("nivo-imageLink");n=t}t=t.find("img:first")}var r=r===0?t.attr("width"):t.width(),s=s===0?t.attr("height"):t.height();if(n!==""){n.css("display","none")}t.css("display","none");i.totalSlides++});if(r.randomStart){r.startSlide=Math.floor(Math.random()*i.totalSlides)}if(r.startSlide>0){if(r.startSlide>=i.totalSlides){r.startSlide=i.totalSlides-1}i.currentSlide=r.startSlide}if(e(o[i.currentSlide]).is("img")){i.currentImage=e(o[i.currentSlide])}else{i.currentImage=e(o[i.currentSlide]).find("img:first")}if(e(o[i.currentSlide]).is("a")){e(o[i.currentSlide]).css("display","block")}var u=e("<img/>").addClass("nivo-main-image");u.attr("src",i.currentImage.attr("src")).show();s.append(u);e(window).resize(function(){s.children("img").width(s.width());u.attr("src",i.currentImage.attr("src"));u.stop().height("auto");e(".nivo-slice").remove();e(".nivo-box").remove()});s.append(e('<div class="nivo-caption"></div>'));var a=function(t){var n=e(".nivo-caption",s);if(i.currentImage.attr("title")!=""&&i.currentImage.attr("title")!=undefined){var r=i.currentImage.attr("title");if(r.substr(0,1)=="#")r=e(r).html();if(n.css("display")=="block"){setTimeout(function(){n.html(r)},t.animSpeed)}else{n.html(r);n.stop().fadeIn(t.animSpeed)}}else{n.stop().fadeOut(t.animSpeed)}};a(r);var f=0;if(!r.manualAdvance&&o.length>1){f=setInterval(function(){d(s,o,r,false)},r.pauseTime)}if(r.directionNav){s.append('<div class="nivo-directionNav"><a class="nivo-prevNav">'+r.prevText+'</a><a class="nivo-nextNav">'+r.nextText+"</a></div>");e(s).on("click","a.nivo-prevNav",function(){if(i.running){return false}clearInterval(f);f="";i.currentSlide-=2;d(s,o,r,"prev")});e(s).on("click","a.nivo-nextNav",function(){if(i.running){return false}clearInterval(f);f="";d(s,o,r,"next")})}if(r.controlNav){i.controlNavEl=e('<div class="nivo-controlNav"></div>');s.after(i.controlNavEl);for(var l=0;l<o.length;l++){if(r.controlNavThumbs){i.controlNavEl.addClass("nivo-thumbs-enabled");var c=o.eq(l);if(!c.is("img")){c=c.find("img:first")}if(c.attr("data-thumb"))i.controlNavEl.append('<a class="nivo-control" rel="'+l+'"><img src="'+c.attr("data-thumb")+'" alt="" /></a>')}else{i.controlNavEl.append('<a class="nivo-control" rel="'+l+'">'+(l+1)+"</a>")}}e("a:eq("+i.currentSlide+")",i.controlNavEl).addClass("active");e("a",i.controlNavEl).bind("click",function(){if(i.running)return false;if(e(this).hasClass("active"))return false;clearInterval(f);f="";u.attr("src",i.currentImage.attr("src"));i.currentSlide=e(this).attr("rel")-1;d(s,o,r,"control")})}if(r.pauseOnHover){s.hover(function(){i.paused=true;clearInterval(f);f=""},function(){i.paused=false;if(f===""&&!r.manualAdvance){f=setInterval(function(){d(s,o,r,false)},r.pauseTime)}})}s.bind("nivo:animFinished",function(){u.attr("src",i.currentImage.attr("src"));i.running=false;e(o).each(function(){if(e(this).is("a")){e(this).css("display","none")}});if(e(o[i.currentSlide]).is("a")){e(o[i.currentSlide]).css("display","block")}if(f===""&&!i.paused&&!r.manualAdvance){f=setInterval(function(){d(s,o,r,false)},r.pauseTime)}r.afterChange.call(this)});var h=function(t,n,r){if(e(r.currentImage).parent().is("a"))e(r.currentImage).parent().css("display","block");e('img[src="'+r.currentImage.attr("src")+'"]',t).not(".nivo-main-image,.nivo-control img").width(t.width()).css("visibility","hidden").show();var i=e('img[src="'+r.currentImage.attr("src")+'"]',t).not(".nivo-main-image,.nivo-control img").parent().is("a")?e('img[src="'+r.currentImage.attr("src")+'"]',t).not(".nivo-main-image,.nivo-control img").parent().height():e('img[src="'+r.currentImage.attr("src")+'"]',t).not(".nivo-main-image,.nivo-control img").height();for(var s=0;s<n.slices;s++){var o=Math.round(t.width()/n.slices);if(s===n.slices-1){t.append(e('<div class="nivo-slice" name="'+s+'"><img src="'+r.currentImage.attr("src")+'" style="position:absolute; width:'+t.width()+"px; height:auto; display:block !important; top:0; left:-"+(o+s*o-o)+'px;" /></div>').css({left:o*s+"px",width:t.width()-o*s+"px",height:i+"px",opacity:"0",overflow:"hidden"}))}else{t.append(e('<div class="nivo-slice" name="'+s+'"><img src="'+r.currentImage.attr("src")+'" style="position:absolute; width:'+t.width()+"px; height:auto; display:block !important; top:0; left:-"+(o+s*o-o)+'px;" /></div>').css({left:o*s+"px",width:o+"px",height:i+"px",opacity:"0",overflow:"hidden"}))}}e(".nivo-slice",t).height(i);u.stop().animate({height:e(r.currentImage).height()},n.animSpeed)};var p=function(t,n,r){if(e(r.currentImage).parent().is("a"))e(r.currentImage).parent().css("display","block");e('img[src="'+r.currentImage.attr("src")+'"]',t).not(".nivo-main-image,.nivo-control img").width(t.width()).css("visibility","hidden").show();var i=Math.round(t.width()/n.boxCols),s=Math.round(e('img[src="'+r.currentImage.attr("src")+'"]',t).not(".nivo-main-image,.nivo-control img").height()/n.boxRows);for(var o=0;o<n.boxRows;o++){for(var a=0;a<n.boxCols;a++){if(a===n.boxCols-1){t.append(e('<div class="nivo-box" name="'+a+'" rel="'+o+'"><img src="'+r.currentImage.attr("src")+'" style="position:absolute; width:'+t.width()+"px; height:auto; display:block; top:-"+s*o+"px; left:-"+i*a+'px;" /></div>').css({opacity:0,left:i*a+"px",top:s*o+"px",width:t.width()-i*a+"px"}));e('.nivo-box[name="'+a+'"]',t).height(e('.nivo-box[name="'+a+'"] img',t).height()+"px")}else{t.append(e('<div class="nivo-box" name="'+a+'" rel="'+o+'"><img src="'+r.currentImage.attr("src")+'" style="position:absolute; width:'+t.width()+"px; height:auto; display:block; top:-"+s*o+"px; left:-"+i*a+'px;" /></div>').css({opacity:0,left:i*a+"px",top:s*o+"px",width:i+"px"}));e('.nivo-box[name="'+a+'"]',t).height(e('.nivo-box[name="'+a+'"] img',t).height()+"px")}}}u.stop().animate({height:e(r.currentImage).height()},n.animSpeed)};var d=function(t,n,r,i){var s=t.data("nivo:vars");if(s&&s.currentSlide===s.totalSlides-1){r.lastSlide.call(this)}if((!s||s.stop)&&!i){return false}r.beforeChange.call(this);if(!i){u.attr("src",s.currentImage.attr("src"))}else{if(i==="prev"){u.attr("src",s.currentImage.attr("src"))}if(i==="next"){u.attr("src",s.currentImage.attr("src"))}}s.currentSlide++;if(s.currentSlide===s.totalSlides){s.currentSlide=0;r.slideshowEnd.call(this)}if(s.currentSlide<0){s.currentSlide=s.totalSlides-1}if(e(n[s.currentSlide]).is("img")){s.currentImage=e(n[s.currentSlide])}else{s.currentImage=e(n[s.currentSlide]).find("img:first")}if(r.controlNav){e("a",s.controlNavEl).removeClass("active");e("a:eq("+s.currentSlide+")",s.controlNavEl).addClass("active")}a(r);e(".nivo-slice",t).remove();e(".nivo-box",t).remove();var o=r.effect,f="";if(r.effect==="random"){f=new Array("sliceDownRight","sliceDownLeft","sliceUpRight","sliceUpLeft","sliceUpDown","sliceUpDownLeft","fold","fade","boxRandom","boxRain","boxRainReverse","boxRainGrow","boxRainGrowReverse");o=f[Math.floor(Math.random()*(f.length+1))];if(o===undefined){o="fade"}}if(r.effect.indexOf(",")!==-1){f=r.effect.split(",");o=f[Math.floor(Math.random()*f.length)];if(o===undefined){o="fade"}}if(s.currentImage.attr("data-transition")){o=s.currentImage.attr("data-transition")}s.running=true;var l=0,c=0,d="",m="",g="",y="";if(o==="sliceDown"||o==="sliceDownRight"||o==="sliceDownLeft"){h(t,r,s);l=0;c=0;d=e(".nivo-slice",t);if(o==="sliceDownLeft"){d=e(".nivo-slice",t)._reverse()}d.each(function(){var n=e(this);n.css({top:"0px"});if(c===r.slices-1){setTimeout(function(){n.animate({opacity:"1.0"},r.animSpeed,"",function(){t.trigger("nivo:animFinished")})},100+l)}else{setTimeout(function(){n.animate({opacity:"1.0"},r.animSpeed)},100+l)}l+=50;c++})}else if(o==="sliceUp"||o==="sliceUpRight"||o==="sliceUpLeft"){h(t,r,s);l=0;c=0;d=e(".nivo-slice",t);if(o==="sliceUpLeft"){d=e(".nivo-slice",t)._reverse()}d.each(function(){var n=e(this);n.css({bottom:"0px"});if(c===r.slices-1){setTimeout(function(){n.animate({opacity:"1.0"},r.animSpeed,"",function(){t.trigger("nivo:animFinished")})},100+l)}else{setTimeout(function(){n.animate({opacity:"1.0"},r.animSpeed)},100+l)}l+=50;c++})}else if(o==="sliceUpDown"||o==="sliceUpDownRight"||o==="sliceUpDownLeft"){h(t,r,s);l=0;c=0;var b=0;d=e(".nivo-slice",t);if(o==="sliceUpDownLeft"){d=e(".nivo-slice",t)._reverse()}d.each(function(){var n=e(this);if(c===0){n.css("top","0px");c++}else{n.css("bottom","0px");c=0}if(b===r.slices-1){setTimeout(function(){n.animate({opacity:"1.0"},r.animSpeed,"",function(){t.trigger("nivo:animFinished")})},100+l)}else{setTimeout(function(){n.animate({opacity:"1.0"},r.animSpeed)},100+l)}l+=50;b++})}else if(o==="fold"){h(t,r,s);l=0;c=0;e(".nivo-slice",t).each(function(){var n=e(this);var i=n.width();n.css({top:"0px",width:"0px"});if(c===r.slices-1){setTimeout(function(){n.animate({width:i,opacity:"1.0"},r.animSpeed,"",function(){t.trigger("nivo:animFinished")})},100+l)}else{setTimeout(function(){n.animate({width:i,opacity:"1.0"},r.animSpeed)},100+l)}l+=50;c++})}else if(o==="fade"){h(t,r,s);m=e(".nivo-slice:first",t);m.css({width:t.width()+"px"});m.animate({opacity:"1.0"},r.animSpeed*2,"",function(){t.trigger("nivo:animFinished")})}else if(o==="slideInRight"){h(t,r,s);m=e(".nivo-slice:first",t);m.css({width:"0px",opacity:"1"});m.animate({width:t.width()+"px"},r.animSpeed*2,"",function(){t.trigger("nivo:animFinished")})}else if(o==="slideInLeft"){h(t,r,s);m=e(".nivo-slice:first",t);m.css({width:"0px",opacity:"1",left:"",right:"0px"});m.animate({width:t.width()+"px"},r.animSpeed*2,"",function(){m.css({left:"0px",right:""});t.trigger("nivo:animFinished")})}else if(o==="boxRandom"){p(t,r,s);g=r.boxCols*r.boxRows;c=0;l=0;y=v(e(".nivo-box",t));y.each(function(){var n=e(this);if(c===g-1){setTimeout(function(){n.animate({opacity:"1"},r.animSpeed,"",function(){t.trigger("nivo:animFinished")})},100+l)}else{setTimeout(function(){n.animate({opacity:"1"},r.animSpeed)},100+l)}l+=20;c++})}else if(o==="boxRain"||o==="boxRainReverse"||o==="boxRainGrow"||o==="boxRainGrowReverse"){p(t,r,s);g=r.boxCols*r.boxRows;c=0;l=0;var w=0;var E=0;var S=[];S[w]=[];y=e(".nivo-box",t);if(o==="boxRainReverse"||o==="boxRainGrowReverse"){y=e(".nivo-box",t)._reverse()}y.each(function(){S[w][E]=e(this);E++;if(E===r.boxCols){w++;E=0;S[w]=[]}});for(var x=0;x<r.boxCols*2;x++){var T=x;for(var N=0;N<r.boxRows;N++){if(T>=0&&T<r.boxCols){(function(n,i,s,u,a){var f=e(S[n][i]);var l=f.width();var c=f.height();if(o==="boxRainGrow"||o==="boxRainGrowReverse"){f.width(0).height(0)}if(u===a-1){setTimeout(function(){f.animate({opacity:"1",width:l,height:c},r.animSpeed/1.3,"",function(){t.trigger("nivo:animFinished")})},100+s)}else{setTimeout(function(){f.animate({opacity:"1",width:l,height:c},r.animSpeed/1.3)},100+s)}})(N,T,l,c,g);c++}T--}l+=100}}};var v=function(e){for(var t,n,r=e.length;r;t=parseInt(Math.random()*r,10),n=e[--r],e[r]=e[t],e[t]=n);return e};var m=function(e){if(this.console&&typeof console.log!=="undefined"){console.log(e)}};this.stop=function(){if(!e(t).data("nivo:vars").stop){e(t).data("nivo:vars").stop=true;m("Stop Slider")}};this.start=function(){if(e(t).data("nivo:vars").stop){e(t).data("nivo:vars").stop=false;m("Start Slider")}};r.afterLoad.call(this);return this};e.fn.nivoSlider=function(n){return this.each(function(r,i){var s=e(this);if(s.data("nivoslider")){return s.data("nivoslider")}var o=new t(this,n);s.data("nivoslider",o)})};e.fn.nivoSlider.defaults={effect:"random",slices:15,boxCols:8,boxRows:4,animSpeed:500,pauseTime:3e3,startSlide:0,directionNav:true,controlNav:true,controlNavThumbs:false,pauseOnHover:true,manualAdvance:false,prevText:"Prev",nextText:"Next",randomStart:false,beforeChange:function(){},afterChange:function(){},slideshowEnd:function(){},lastSlide:function(){},afterLoad:function(){}};e.fn._reverse=[].reverse})(jQuery)





