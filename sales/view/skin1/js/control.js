// JavaScript Document
function Control()
{
	this.loading = "image/loading.gif";
	this.getUrl = function()
	{
		url = document.location;
		arr = (""+url).split('#');
		if(arr[1] == undefined)
			return "";
		return arr[1];
	}
	
	this.getUrlFromLink =function(mlink)
	{
		url = mlink;
		arr = (""+url).split('#');
		if(arr[1] == undefined)
			return "";
		return arr[1];
	}
	
	this.getParam = function(field,url)
	{
		var strurl = url;
		arr = (""+strurl).split('&');
		for(i in arr)
		{
			//alert(arr[i])
			ar = arr[i].split('=');
			if(ar[0]==field)
			{
				return ar[1];
			}
		}
	}
	
	this.fload = function(eid,url)
	{
		
		/*$.ajax({
		  url: url,
		  cache: false,
		  success: function(html){
			$(eid).html(html);
		  }
		});*/
		$(eid).load(url,function(){
			
			$(eid).hide().fadeIn("slow")					 
		});
		
	}
	this.loadContent = function(url)
	{
		$("#ben-content").html("<div style='text-align: center;'><img src='"+this.loading+"'></div> ");
		url =url.replace('#','?');
		
		this.fload("#ben-content",url);
		menuid=this.getParam("sitemapid",url);
		this.setCurentMenu(menuid);
		
	}
	
	this.setCurentMenu = function(menuid)
	{
		
		$(".menu ").removeClass("current-tab");
		$("#menu_"+menuid).addClass("current-tab");
	}
	
}


var control = new Control();
var strurl = control.getUrl();


