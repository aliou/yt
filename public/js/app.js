$(document).ready(function() {
  $(".remove-chan").click(function(evt) {
    evt.preventDefault();

    var $this = $(this);
    var channelId = $this.parents("li").data("id");

    if (channelId > 0) {
      $.ajax({url: "/channels/" + channelId, type: "DELETE"})
	.success(function() {
	  $this.parents("li").fadeOut(500, function () {
	    $(this).remove();
	  });
	}).fail(function() { alert("something broke!");
      });
    }
  });
});
