reloadFunc = function() {
	jQuery.getJSON('/messages/update.json', {}, function(data) {
		if(data.collection != null) {
		  var node = $("#list");
		  for(var i = 0; i < data.collection.length; i++) {
		    msg = data.collection[i];
		    node.prepend("<dd>" + msg.text + "</dd>");
		    node.prepend("<dt>" + msg.user_name + "</dt>");
		  }
		}
    	window.setTimeout(reloadFunc, 4000);
	});
};
