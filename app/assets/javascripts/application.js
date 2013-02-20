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

function formatDateTime(format, date, settings) {
    if (!date) { return "" }
		if (isNaN(date.getTime())) { return date.toString() }

    // var dayNamesShort = (settings ? settings.dayNamesShort : null) || this._defaults.dayNamesShort;
    // var dayNames = (settings ? settings.dayNames : null) || this._defaults.dayNames;
    // var monthNamesShort = (settings ? settings.monthNamesShort : null) || this._defaults.monthNamesShort;
    // var monthNames = (settings ? settings.monthNames : null) || this._defaults.monthNames;
    var lookAhead = function (match) {
        var matches = (iFormat + 1 < format.length && format.charAt(iFormat + 1) == match);
        if (matches) { iFormat++ } return matches
    };
    var formatNumber = function (match, value, len) {
        var num = "" + value;
        if (lookAhead(match)) {
            while (num.length < len) {
                num = "0" + num
            }
        }
        return num
    };
    var formatName = function (match, value, shortNames, longNames) {
        return (lookAhead(match) ? longNames[value] : shortNames[value])
    };
    var output = "";
    var literal = false;
    if (date) {
        for (var iFormat = 0; iFormat < format.length; iFormat++) {
            if (literal) {
                if (format.charAt(iFormat) == "'" && !lookAhead("'")) {
                    literal = false
                } else {
                    output += format.charAt(iFormat)
                }
            } else {
                switch (format.charAt(iFormat)) {
                    case "d": output += formatNumber("d", date.getDate(), 2); break;
                    case "D": output += formatName("D", date.getDay(), ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"], ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]); break;
                    //    case "o": var doy = date.getDate(); for (var m = date.getMonth() - 1; m >= 0; m--) { doy += this._getDaysInMonth(date.getFullYear(), m) } output += formatNumber("o", doy, 3); break; 
                    case "m": output += formatNumber("m", date.getMonth() + 1, 2); break;
                    //    case "M": output += formatName("M", date.getMonth(), monthNamesShort, monthNames); break; 
                    case "y": output += (lookAhead("y") ? date.getFullYear() : (date.getYear() % 100 < 10 ? "0" : "") + date.getYear() % 100); break;
                    case "@": output += date.getTime(); break;
                    case "'": if (lookAhead("'")) { output += "'" } else { literal = true } break;
                    case 'H': output += formatNumber("H", date.getHours(), 2); break;
                    case 'i': output += formatNumber('i', date.getMinutes(), 2); break;
										case 's': output += formatNumber('s', date.getSeconds(), 2); break;
                    default: output += format.charAt(iFormat)
                }
            }
        }
    }
    return output
};
