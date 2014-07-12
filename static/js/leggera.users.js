$(document).ready(function(){
    $('#create-user-form').on('submit', function(e){
        e.preventDefault();
        var valid = validate_create_form()
        if (valid) {
            $('#loading-modal').modal('show')
            $.post( '/ajax/users/create/', {
                    username: $('#create-user-username').val(),
                    // email: $('#create-user-email').val(),
                    password: $('#create-user-password').val(),
                    role: $('#create-user-role').val()
                },
                function(response) {
                    if (response.status) {

                    }
                    else {
                        $('#alert-user-exists').removeClass('hide')
                    }
                }
            )
            $('#loading-modal').modal('hide')
        }
    });
})

function validate_create_form() {
    var valid = true;

    regexp_arr = {
        email: /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/,
        username: /^[a-zA-Z0-9_-]+$/,
        password: /^([a-zA-Z0-9@*#_-]{6,20})$/
    }
    $('#create-user-form input').each(function(){
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
    if (!$('#create-user-role').val()) {
        valid = false;
        $('#create-user-role').parent().addClass('has-error')
    } else {
        $('#create-user-role').parent().removeClass('has-error')
    }
    return valid;
}
