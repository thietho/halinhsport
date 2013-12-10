function initMenu() {
  $('#menu ul').hide();
  $('#menu li div.collape').click(
    function() {
		if($(this).children('span').hasClass('down'))
		{
			$(this).children('span').removeClass('down');
			$(this).children('span').addClass('up');
		}
		else
		{
			$(this).children('span').removeClass('up');
			$(this).children('span').addClass('down');
		}
        $(this).next().slideToggle('normal');
		
      }
    );
  }
$(document).ready(function() {initMenu();});