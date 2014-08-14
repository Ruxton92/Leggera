$(document).ready(function(){
    $('#reset-password-form #reset-submit').click(function(){
       if (validate_reset_form()) {
           $('#loading-modal').modal('show')
           $.post( '/ajax/login/reset/', {
              email: $('#reset-email').val(),
              username: $('#reset-login').val()
            },
            function(response) {
              if(response.status) {
                $('#alert-success').removeClass('hide')
                setTimeout(function(){
                  $('#alert-success').addClass('hide')
                }, 3000)
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
    $('#reset-password-form #reset-password').click(function(){

    });
})

function validate_reset_form() {
    var valid = true;

    regexp_arr = {
        email: /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/,
        username: /^[a-zA-Z0-9_-]+$/,
    }
    $('#reset-password-form input').each(function(){
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
    return valid;
}
