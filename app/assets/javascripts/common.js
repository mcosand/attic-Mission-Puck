function log(msg) { if (window['console'] !== undefined && console.log) console.log(msg); }

function convertToDate(model, fields)
{
  for (var i = 0; i<fields.length; i++)
  {
    model[fields[i]] = new XDate(model[fields[i]]);
  }
  return model;
}

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
