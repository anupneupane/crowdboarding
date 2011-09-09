$(document).ready ->
  hideNotificationWindow()
  mouseOverHelmet()
  clickHelmet()
  showNotifyBar()
  hoverNotifications()
  clickNotifications()

mouseOverHelmet = ->
  $("div#helmet").mouseover(->
    $(this).css "background-position", "0 -123px"
  ).mouseout ->
    $(this).css "background-position", "0 0"

showNotifyBar = ->
	notifier = $("div#wrapper_noticebar")
	if notifier.length
		notifier.slideDown()# .delay(3000).slideUp()  
		notifier.find("a").click  ->
			notifier.slideUp()
			false

clickHelmet = ->
  $("div#helmet").click ->
    window.location = "/helmet"

hoverNotifications = ->
  $("li#notifications a, li.highlighted_plus a").hover ->
    $(this).toggleClass "hover"

clickNotifications = ->
  $("li#notifications a").click (event) ->
    notification_body = $("div#notifications_body")
    notifications_window = $("div#notifications_window")
    notifications_window.show()
    unless notification_body.find("div.notification").length
      opts = 
        lines: 12
        length: 6
        width: 5
        radius: 10
        color: "#B10109"
        speed: 1
        trail: 100
        shadow: false

      target = document.getElementById("notifications_window")
      spinner = new Spinner(opts).spin(target)

hideNotificationWindow = ->
  mouse_is_inside = false
  notifications_window = $("div#notifications_window")
  notifications_window.hover (->
    mouse_is_inside = true
  ), ->
    mouse_is_inside = false

  $("body").mouseup ->
    notifications_window.hide()  unless mouse_is_inside