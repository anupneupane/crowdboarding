$(document).ready(function() {
	mouseOverHelmet();
	clickHelmet();
	showNotifyBar();
	hoverNotifications();
	clickNotifications();
});

mouseOverHelmet = function(){
	$("div#helmet").mouseover(function() {
		$(this).css('background-position', '0 -123px');
	}).mouseout(function() { 
		$(this).css('background-position', '0 0');
	});
}

showNotifyBar = function(){
	notifier = $('div#wrapper_noticebar');
	if(notifier.length) {
		notifier.slideDown().delay(3000).slideUp();
	}
}

clickHelmet = function(){
	$('div#helmet').click(function(){
		window.location = "/helmet"
	});
}

hoverNotifications = function(){
	$('li#notifications a, li.highlighted_plus a').hover(function(){
		$(this).toggleClass("hover");
	});
}

clickNotifications = function(){
	$('li#notifications a').click(function(){
		$('div#notifications_window').show();
		var opts = {
		  lines: 12, // The number of lines to draw
		  length: 6, // The length of each line
		  width: 5, // The line thickness
		  radius: 10, // The radius of the inner circle
		  color: '#B10109', // #rbg or #rrggbb
		  speed: 1, // Rounds per second
		  trail: 100, // Afterglow percentage
		  shadow: false // Whether to render a shadow
		};
		var target = document.getElementById('notifications_body');
		var spinner = new Spinner(opts).spin(target);
	});
}