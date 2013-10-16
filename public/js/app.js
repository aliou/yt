$(document).ready(function() {
  $("#signup-button").click(function() {
    $("form#create-account").submit();
  });

  $("#signin-button").click(function() {
    $("form#signin").submit();
  });

  $("#add-feed-button").click(function() {
    $("form#add-feed").submit();
  });

  $('.icon.close').click(function() {
    $(this).parents("div.message").fadeOut(500, function() {
      $(this).remove();
    });
  });

  $(".remove-chan").click(function(evt) {
    evt.preventDefault();

    var $this = $(this);
    var channelId = $this.parents("div").data("id");

    if (channelId > 0) {
      $.ajax({
        url: "/channels/" + channelId,
        type: "DELETE"
      }).success(function() {
        $this.parents("div.item").fadeOut(500, function() {
          $(this).remove();
        });
      }).fail(function() {
        alert("something broke!");
      });
    }
  });
});

$('.demo.menu .item').tab();
