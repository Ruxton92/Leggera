$(document).ready(function(){
    $('.block-remove').on('click', function(){
        delete_block_click($(this).attr('data-id'), $(this).attr('data-title'))
        return false;
    });

    $('#block-delete-sure').on('click', function(){
        delete_block_sure()
    });

    $('#blocks-list .move-block-up').on('click', function(){ move_block('up', $(this)) });
    $('#blocks-list .move-block-down').on('click', function(){ move_block('down', $(this)) });


})

function move_block(dir, $obj) {
    $wr = $obj.closest('.block-block')
    var need_to_save = true
    if (dir=='up') {
        $prev = $wr.prev()
        if ($prev.hasClass('block-block')) {
            $prev.before($wr)
        }
        else {need_to_save = false}
    } else if (dir=='down') {
        $next = $wr.next()
        if ($next.hasClass('block-block')) {
            $next.after($wr)
        }
        else {need_to_save = false}
    }
    if (need_to_save) save_blocks_weight()
}

function save_blocks_weight() {
    var weights = [];
    $.each($('.block-block'), function (i,v) {
            var d = {}
            d[key = $(v).find('.block-item').data('id')] = parseInt(i) + 1
            weights.push(d);
        }
    );
    var $alert = $('<div class="alert alert-success" role="alert"><span class="glyphicon glyphicon-ok"></span> <span class="text">Saving the order of the blocks...</span></div>')
    $('#messages-container').append($alert)
    $.post('/ajax/content/save_weights/', {'weights': JSON.stringify(weights)},
        function(response){
            $alert.find('.text').text('Saved');
            setTimeout(function(){$alert.fadeOut()}, 1000);
    });
}

function delete_block_click(id, title) {
    $('#deleting-block').text(title).attr('data-id', id);
    $('#delete-block-modal').modal('show')
}

function delete_block_sure() {
    var cid = $('#deleting-block').attr('data-id');
    var title = $('#deleting-block').attr('data-title');
    $('#delete-block-modal').modal('hide')
    $.post( '/ajax/content/delte_block/', {
            id: cid,
        },
        function(response){
            if (response.status == true) {
                var $btn = $('.block-remove[data-id="' + cid + '"]')
                $btn.closest('li').remove()
                show_message('Block <b>' + title + '</b> was successfully deleted', 4000)
            }
            else if (response.status == false) {
                show_message('Something goes wrong, please, try again later', 5000)
            }
            else if (response.status.reload) {
                show_message('Block <b>' + title + '</b> was successfully deleted', 2000)
                setTimeout(function(){window.location.reload()}, 2000);
            }
        }
    )

}
