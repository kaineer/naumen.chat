reloadFunc = function() {
	$.getJSON('/messages.json', {}, function(data) {
		if(data.collection != null) {
		  var html = "";
		  _(data.collection).each(function(msg) {
		  	html += "<dt>" + msg.user_name + "</dd>";
		  	html += "<dd>" + msg.text + "</dd>";
		  });

		  $("#list").prepend(html);
		}

   	window.setTimeout(reloadFunc, 4000);
	});
};
