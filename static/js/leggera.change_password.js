$(document).ready(function(){
    $('#change-password-form #change-submit').click(function(){
       if (validate_change_form()) {
          $('#loading-modal').modal('show')
          var code = window.location.pathname.split('/')[window.location.pathname.split('/').length-2]
          $.post( '/ajax/login/change/', {
              password: $('#change-password-1').val(),
              reset_code: code
            },
            function(response) {
              if(response.status) {
                $('#alert-success').removeClass('hide')
                setTimeout(function(){
                  window.location.replace('/login/')
                }, 20000)
              }
              else {
                $('#alert-error').removeClass('hide')
                setTimeout(function(){
                  $('#alert-error').addClass('hide')
                }, 5000)
              }
            }
          )
            $('#loading-modal').modal('hide')
        }
    });
    $('#change-password-form #change-password').click(function(){

    });
})

function validate_change_form() {
    var valid = true;

    regexp_arr = {
        password: /^([a-zA-Z0-9@*#_-]{6,20})$/
    }
    $('#change-password-form input').each(function(){
        name = $(this).attr('name').split('-')[2];
        this_valid = regexp_arr[name].test($(this).val())
        if (!this_valid) {
            $(this).parent().addClass('has-error')
        }
        else {
            $(this).parent().removeClass('has-error')
        }
        valid = valid && this_valid;
    });
    if ($('#change-password-1').val() != $('#change-password-2').val()) {
      valid = false;
      $('#change-password-1').parent().addClass('has-error')
      $('#change-password-2').parent().addClass('has-error')
      $('#alert-match').removeClass('hide')
      setTimeout(function(){
        $('#alert-match').addClass('hide')
      }, 10000)
    }
    return valid;
}
