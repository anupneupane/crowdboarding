$(document).ready(function() {
	hideNotificationWindow();
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
	$('li#notifications a').click(function(event){
		var notification_body = $('div#notifications_body');
		var notifications_window = $('div#notifications_window');
		notifications_window.show();
		if(!notification_body.find('div.notification').length){
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
			var target = document.getElementById('notifications_window');
			var spinner = new Spinner(opts).spin(target);
		}
	});
}

hideNotificationWindow = function(){
	var mouse_is_inside = false;
	var notifications_window = $('div#notifications_window')
	notifications_window.hover(
		function(){ mouse_is_inside=true; }, 
		function(){ mouse_is_inside=false; }
	);

	$("body").mouseup(function(){ 
		if(!mouse_is_inside) {
			notifications_window.hide();
		}
	});

}

