$(document).ready(function() {
	mouseOverHelmet();
	clickHelmet();
	showNotifyBar();
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