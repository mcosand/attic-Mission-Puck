// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.

//= require jquery-1.9.1.js
//= require jquery.mobile-1.3.0.js
//= require knockout-2.2.1.js
//= require xdate.js
//= require common.js

// To help mobile dev on the desktop
$(window).resize(function() {
  if (console.log) console.log("Window: " + $(window).width() + ' x ' + $(window).height());
});

// Refreshes a JQuery Mobile listview when the underlying observableArray changes
// <ul data-role="listview" data-bind="foreach: app.logs, listViewRefresh: app.logs">
ko.bindingHandlers.listViewRefresh = {
  update: function(element, valueAccessor, allBindingsAccessor) {
    el = $(element);
    if (valueAccessor()().length > 0 && el.hasClass('ui-listview'))
      el.listview('refresh');
  }
}

// Toggles the enabled/disabled state of a JQuery Mobile button
// If the button is a member of a listview, the listview will be refreshed after
//  the state is changed
//  <ul data-role="listview" data-inset="true">
//    <li><a href="#briefingPage" data-bind="jqmButtonEnabled: app.hasBriefing">Briefing</a></li>
//  </ul>
ko.bindingHandlers.jqmButtonEnabled = {
  update: function(element, valueAccessor, allBindingsAccessor) {
    val = valueAccessor();
    $(element).toggleClass('ui-disabled', !ko.utils.unwrapObservable(val));
    list = $(element).closest('.ui-listview');
    if (list.length > 0 && $(list[0]).data("listview")) $(list[0]).listview('refresh');
  }
}


// Pop a toast message at the top of the screen
// $.mobile.showToast('message');
;(function( $, window, undefined ) {
$.extend($.mobile, {
  showToast: function(msg){
	$("<div class='ui-loader ui-overlay-shadow ui-body-e ui-corner-all'>"+msg+"</div>")
	.css({ display: "block", 
		opacity: 0.90, 
		position: "fixed",
		padding: "7px",
		"text-align": "center",
		width: "270px",
		left: ($(window).width() - 284)/2,
		top: '10px' })
	.appendTo( $.mobile.pageContainer ).delay( 1500 )
	.fadeOut( 400, function(){
		$(this).remove();
	});
  }
});
})( jQuery, this );
