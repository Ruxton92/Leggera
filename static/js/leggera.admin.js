function show_message(message, time) {
    $('#quick-info-modal .modal-header h4').html(message);
    $('#quick-info-modal').modal('show')
    if (time && parseInt(time)) {
        setTimeout(function(){
            $('#quick-info-modal').modal('hide')
        }, time)
    }
}
