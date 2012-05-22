var prependData = function(data) {
	if(data.collection != null) {
	  var html = "";
	  _(data.collection).each(function(msg) {
	  	html += "<dt>" + msg.user_name + "</dd>";
	  	html += "<dd>" + msg.text + "</dd>";
	  });

	  $("#list").prepend(html);
	}
};

reloadFunc = function() {
	$.getJSON('/messages.json', {}, function(data) {
		prependData(data);

   	window.setTimeout(reloadFunc, 4000);
	});
};

$(function() {
	$(".index-page form").submit(function() {
		$.ajax({
			type: "POST",
			dataType: "JSON",
			url: "/messages.json",
			data: {
				message: {
					text: $("#message_text").val()
				}
			},
			success: prependData
		});

		$("#message_text").val("");

		return false;
	});
});
