(function() {
  $(function() {
    console.log('hello');
    $('input[name="custom"]').hide();
    return $('input[type="radio"]').change(function() {
      if ($('input[name="case"]:checked').val() === 'option_2') {
        return $('input[name="custom"]').show();
      } else {
        return $('input[name="custom"]').hide();
      }
    });
  });

}).call(this);
