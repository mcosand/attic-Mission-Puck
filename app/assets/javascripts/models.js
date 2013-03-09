var MissionModel = function(apiModel)
{
  var self = this;
  this.id = apiModel.id
  this.started = ko.observable(apiModel.started ? new XDate(apiModel.started, true) : undefined)
  this.title = ko.observable(apiModel.title)
  this.number = ko.observable(apiModel.number)

  this.started.formatted = ko.computed({
    read: function() { return this.started() ? this.started().toString("yyyy-MM-dd HH:mm") : ""; },
    write: function(value) { this.started(new XDate(value)); },
                owner: this
  });

  this.started.formattedDate = ko.computed({
    read: function() { return this.started() ? this.started().toString("yyyy-MM-dd") : ""; },
    write: function(value) {
      old = this.started();
      newDate = new XDate(value).setHours(old ? old.getHours() : 0).setMinutes(old ? old.getMinutes(): 0);
      this.started(newDate);
    },
    owner: this
  });

  this.started.formattedTime = ko.computed({
    read: function() { return this.started() ? this.started().toString("HH:mm") : ""; },
    write: function(value) {
      old = this.started();
      if (!old) old = new XDate();
      this.started(new XDate(old.toString("yyyy-MM-dd ") + value));
    },
    owner: this
  });

  // Initializes this instance to the browser time, rounded to the previous half hour.
  this.started.initRounded = function() {
    self.started(new XDate().setMinutes(Math.round((new XDate().getMinutes() - 15) / 30) * 30))
  }
}

