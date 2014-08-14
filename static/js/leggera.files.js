$(document).ready(function(){
    refresh_event_triggers()
    if($('#all-files-list li').length) {
        $('#all-files-list li:first .file-item').trigger('click')
    }

    $('#file-delete-sure').on('click', function(){
        delete_user_sure()
    });

    $('#files-refresh').on('click', function(e){
        e.preventDefault();
        if(!$(this).hasClass('active')){
            $(this).addClass('active')
            $.post( '/ajax/files/refresh/', {},
                function(response) {
                    if (response.files) {
                        $('#all-files-list').slideUp('fast', function(){
                            $('#all-files-list li').remove()
                            $.each(response.files, function(i,v) {
                                var $tpl = $('#file-template li').clone()
                                $tpl.find('.file-item').data('extension', v['extension']).data('path', '/uploads/' + v['name']).find('span').text(v['name'])
                                $tpl.find('.file-direct-link').attr('href', '/uploads/' + v['name'])
                                $('#all-files-list').append($tpl)
                            })
                            refresh_event_triggers()
                            $('#all-files-list').slideDown('fast')
                            $('#files-refresh').removeClass('active')
                        })

                    }
                    else {
                    }
                }
            )
        }
        return false;
    });

    $('#files-upload').on('change', function(){
        $(this).upload('/ajax/files/upload/', function(result) {
            var file = $('#files-upload input');
            file.replaceWith(file.val('').clone(true));
            $('#files-refresh').trigger('click')
            show_message('File uploaded', 2000);
        }, 'json');
    });
})

function delete_user_click(username) {
    $('#deleting-user-username').text(username);
    $('#delete-user-modal').modal('show')
}

function refresh_event_triggers() {
    $('.file-item').on('click', function(){
        if($(this).data('extension') != '.pdf'){
           var href = $(this).data('path')
            $('#preview-picture').attr('src', href)
            $('#preview-pdf').addClass('hide')
            $('#preview-picture').removeClass('hide')
        }
        else {
            $('#preview-picture').addClass('hide')
            $('#preview-pdf').removeClass('hide')
        }
        return false
    });
    $('.file-block .file-remove').click(function(){
        var username = $(this).closest('.file-block').find('.file-item span').text()
        delete_user_click(username)
    });
}

function delete_user_click(filename) {
    $('#deleting-filename').text(filename);
    $('#delete-file-modal').modal('show')
}

function delete_user_sure() {
    var filename = $('#deleting-filename').text();
    $('#delete-file-modal').modal('hide')
    $.post( '/ajax/files/delete/', {
            file: filename,
        },
        function(response){
            if (response.status) {
                show_message('File <b>' + filename + '</b> was successfully deleted', 4000)
                $('#files-refresh').trigger('click')
            }
            else {
                show_message('Something goes wrong, please, try again later', 5000)
            }
        }
    )

}
