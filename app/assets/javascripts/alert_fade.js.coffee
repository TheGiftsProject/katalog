setTimeout ->
  $(".alert").fadeTo(250, 0).slideUp(500, -> $(this.remove()))
, 3000