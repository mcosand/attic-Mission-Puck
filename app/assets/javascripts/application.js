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
//
//= require jquery-1.9.1.js
//= require jquery-ui-1.10.1.custom.min.js
//= require knockout-2.2.1.js
//= require xdate.js

ko.bindingHandlers.ctrlEnter = {
	init: function (element, valueAccessor, allBindingsAccessor, viewModel) {
		var allBindings = allBindingsAccessor();
		$(element).keypress(function (event) {
			var keyCode = (event.which ? event.which : event.keyCode);
			if (keyCode == 10 && event.ctrlKey)
			{
				$(this).blur();
				allBindings.ctrlEnter.call(viewModel);
				return false;
			}
			return true;
		});
	}
};

function needSetServerTime() {
  var timeBox = $('#setTimeValue').val(new XDate().toString('yyyy-MM-dd HH:mm'));
  var tips = $('#setTimeTips')
  $('#setTimeDialog').dialog({
      autoOpen: true,
      height: 250,
      width: 400,
      modal: true,
      closeOnEscape: false,
      buttons: {
        "Set Server Time": function() {
          timeBox.removeClass("ui-state-error")
          tips.text('');
          var time = new XDate(timeBox.val());
          if (time.valid())
          {
            var dlg = this;
            $.ajax({ type: 'POST', url: siteRoot+'home/setSystemTime/' + (time.getTime()/1000)})
              .done(function(result) {
                window.location.href=window.location.href
              });
          }
          else
          {
            timeBox.addClass('ui-state-error');
            tips.text('Invalid date');
          }
        }
      },
      close: function() {
        timeBox.val( "" ).removeClass( "ui-state-error" );
      }
    });
}
