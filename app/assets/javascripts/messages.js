reloadFunc = function() {
	$.getJSON('/messages/update.json', {}, function(data) {
		if(data.collection != null) {
		  var html = "";
		  _(data.collection).each(function(msg) {
		  	html += "<dd>" + msg.text + "</dd>";
		  	html += "<dt>" + mst.user_name + "</dd>";
		  });

		  $("#list").prepend(html);
		}

   	window.setTimeout(reloadFunc, 4000);
	});
};
