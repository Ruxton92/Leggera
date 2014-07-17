$(document).ready(function(){
    $('#login-form #login-submit').click(function(){
       if (validate()) {
           $('#loading-modal').modal('show')
           $.post( '/ajax/login/login/', {
                    email: $('#login-email').val(),
                    pass: $('#login-pass').val()
                },
                function(response) {
                    if (response.status == 'error') {
                        $('#alert-wrong-email').removeClass('hide');
                    }
                    else if (response.status == 'success') {
                        window.location.replace('/management/')
                    }
                }
            )
            $('#loading-modal').modal('hide')
        }
    });
    $('#reset-password-form #reset-password').click(function(){
       $.post( '/ajax/login/reset/', {
                email: $('#reset-email').val(),
                username: $('#reset-username').val()
            },
            function(response) {
                console.debug(response)
            }
        )
    });
})

function validate() {
    var valid = true;
    if (!$('#login-email').val()) {
        valid = false;
        $('#login-email').parent().addClass('has-error')
    }
    else { $('#login-email').parent().removeClass('has-error') }
    if (!$('#login-pass').val()) {
        valid = false;
        $('#login-pass').parent().addClass('has-error')
    }
    else { $('#login-pass').parent().removeClass('has-error') }
    return valid;
}
