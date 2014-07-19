$(document).ready(function(){
    $('#create-user-form').on('submit', function(e){
        e.preventDefault();
        var valid = validate_create_form()
        if (valid) {
            $('#loading-modal').modal('show')
            $.post( '/ajax/users/create/', {
                    username: $('#create-user-username').val(),
                    email: $('#create-user-email').val(),
                    password: $('#create-user-password').val(),
                    role: $('#create-user-role').val()
                },
                function(response) {
                    if (response.status) {
                        $('#alert-user-exists').addClass('hide');
                        $('#alert-user-created').removeClass('hide');
                        $('#create-user-form input').val('')
                        $('#create-user-role').val('')
                    }
                    else {
                        $('#alert-user-created').addClass('hide');
                        $('#alert-user-exists').removeClass('hide');
                    }
                }
            )
            $('#loading-modal').modal('hide')
        }
    });

    $('.user-block .delete-user').click(function(){
        var username = $(this).closest('.user-block').find('.username-title').data('username')
        delete_user_click(username)
    });
    $('.user-block .open-settings').click(function(){
        var username = $(this).closest('.user-block').find('.username-title').data('username')
        user_settings_click(username)
    });
    $('.open-settings').click(function(){$('#user-settings-modal *').removeClass('has-error')})
    $('#user-delete-sure').click(delete_user_sure);
    $('#user-settings-cancel').click(function(){
        $('#user-settings-modal').modal('hide')
        $('#user-settings-email, #user-settings-role').val('');
        $('#user-settings-username').text('')
    });
    $('#user-settings-save').click(edit_user_save);
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

function delete_user_click(username) {
    $('#deleting-user-username').text(username);
    $('#delete-user-modal').modal('show')
}

function user_settings_click(username) {
    $('#user-settings-username').text(username);
    var ub = $('.username-title[data-username=' + username + ']').closest('.user-block')
    $('#user-settings-email').val($(ub).find('.user-email').text());
    $('#user-settings-role').val($(ub).find('.user-role').text());
    $('#user-settings-modal').modal('show')
}

function delete_user_sure() {
    var username = $('#deleting-user-username').text();
    $('#delete-user-modal').modal('hide')
    $.post( '/ajax/users/delete/', {
            user: username,
        },
        function(response){
            if (response.status) {
                show_message('User <b>' + username + '</b> was successfully deleted', 4000)
            }
            else {
                show_message('Something goes wrong, please, try again later', 5000)
            }
        }
    )

}

function edit_user_save() {
    if (validate_edit_form()) {
        $.post( '/ajax/users/edit/', {
                email: $('#user-settings-email').val(),
                role: $('#user-settings-role').val(),
                username: $('#user-settings-username').text(),
            }, function(response) {
                if (response.status) {
                    var username = $('#user-settings-username').text()
                    var ub = $('.username-title[data-username=' + username + ']').closest('.user-block')
                    $(ub).find('.user-email').text($('#user-settings-email').val());
                    $(ub).find('.user-role').text($('#user-settings-role').val());
                    $('#user-settings-modal').modal('hide')
                    $('#user-settings-email, #user-settings-role').val('');
                    $('#user-settings-username').text('')
                    show_message('User data was successfully changed', 3000)
                }
                else {
                    $('#user-settings-modal').modal('hide')
                    $('#user-settings-email, #user-settings-role').val('');
                    $('#user-settings-username').text('')
                    show_message('Something goes wrong, please, try again later', 5000)
                }
            }
        )
    }
    else {

    }
}

function validate_edit_form() {
    var valid = true;
    var email_regex = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    if (email_regex.test($('#user-settings-email').val())) {
        $('#user-settings-email').parent().removeClass('has-error');
    }
    else {
        $('#user-settings-email').parent().addClass('has-error');
        valid = false;
    }
    if ($('#user-settings-role').val()) {
        $('#user-settings-role').parent().removeClass('has-error');
    }
    else {
        $('#user-settings-role').parent().addClass('has-error');
        valid = false;
    }
    return valid;
}
