$(document).ready(function(){
    $('#block-save').on('click', function(e){
        save_block(e)
    });

    $('#block-content').summernote({
        height: 300,
        focus: true,
        toolbar: [
            ['style', ['bold', 'italic', 'underline', 'strikethrough', 'clear']],
            ['color', ['color']],
            ['fontsize', ['fontsize']],
            ['para', ['ul', 'ol', 'paragraph']],
            ['insert', ['picture']],
            ['misc', ['undo', 'redo', 'codeview']]
        ],
        onImageUpload: function(files, editor, editable) {
            $('.note-image-input').upload('/ajax/files/upload/', function(result) {
                var filename_arr = $('.note-image-input').val().split('\\')
                var filename = filename_arr[filename_arr.length - 1]
                url = '/uploads/' + filename
                debugger
                editor.insertImage(editable, url);
            }, 'json');
        }
    });
})

function save_block(e) {
    e.preventDefault();
    form = $('#block-form').serializeArray();
    form.push({'name': 'content', 'value': $('#block-content').code()})
    $.post('/ajax/content/save_block/', {'form': JSON.stringify(form)},
        function(response){
            if (response.status == true) {
                show_message('Block cuccessfully saved', 2000);
            }
            else if (response.status.new_id) {
                window.location.replace('/management/content/edit/' + response.status.new_id + '/')
            }
            else {
                show_message('Something goes wrong...', 2000);
            }
    })
    return false;
}
