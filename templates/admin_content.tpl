% rebase('templates/layout_admin.tpl')
% title='Leggera - Content'
<div class="container-fluid">
    <div class="row">
        <div class="col-xs-12">
            <h1>Content management</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12 col-sm-4 col-md-3">
            <h2>Header</h2>
            % if header_id:
                <a href="/management/content/edit/{{ header_id[0][0] }}/" class="btn btn-primary">
                    <span class="glyphicon glyphicon-pencil"></span> Edit header
                </a>
                <a href="#" data-id="{{header_id[0][0]}}" data-title="{{header_id[0][1]}}" class="block-remove btn btn-danger">
                    <span class="glyphicon glyphicon-trash"></span> Delete header
                </a>
            % else:
                <a href="/management/content/edit/0/?header" class="btn btn-success">
                    <span class="glyphicon glyphicon-plus"></span> Add header
                </a>
            % end
            <hr>
        </div>
        <div class="col-xs-12 col-sm-4 col-md-3">
            <h2>Footer</h2>
            % if footer_id:
                <a href="/management/content/edit/{{ footer_id[0][0] }}/" class="btn btn-primary">
                    <span class="glyphicon glyphicon-pencil"></span> Edit footer
                </a>
                <a href="#" data-id="{{footer_id[0][0]}}" data-title="{{footer_id[0][1]}}" class="block-remove btn btn-danger">
                    <span class="glyphicon glyphicon-trash"></span> Delete header
                </a>
            % else:
                <a href="/management/content/edit/0/?footer" class="btn btn-success">
                    <span class="glyphicon glyphicon-plus"></span> Add footer
                </a>
            % end
            <hr>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12 col-sm-8 col-md-6">
            <h2>Content blocks</h2>
            <div id="files-actions-block">
                <a href="/management/content/edit/0/" class="btn btn-success">
                    <span class="glyphicon glyphicon-plus"></span> Add new block
                </a>
            </div>
            <hr>
            <div id="blocks-wrapper">
                <ul id="blocks-list" class="list-group">
                    % for block in blocks:
                        <li class="block-block list-group-item">
                            <div class="row">
                                <div class="col-xs-2 col-sm-2 col-md-2">
                                    <a href="#" class="move-block-up btn btn-default btn-xs">
                                        <span class="glyphicon glyphicon-arrow-up"></span>
                                    </a>
                                    <a href="#" class="move-block-down btn btn-default btn-xs">
                                        <span class="glyphicon glyphicon-arrow-down"></span>
                                    </a>
                                </div>
                                <div class="col-xs-7 col-sm-8 col-md-9">
                                    <span class="block-item" data-id="{{block[0]}}">{{block[1]}}</span>
                                </div>
                                <div class="col-xs-3 col-sm-2 col-md-1 text-right">
                                    <a class="block-edit-link" href="/management/content/edit/{{block[0]}}/">
                                        <span class="glyphicon glyphicon-pencil"></span>
                                    </a>
                                    <a class="block-remove" data-id="{{block[0]}}" data-title="{{block[1]}}" href="#">
                                        <span class="glyphicon glyphicon-trash"></span>
                                    </a>
                                </div>
                            </div>
                        </li>
                    % end
                </ul>
            </div>
            <div id="messages-container">

            </div>
        </div>
    </div>
</div>

<div id="delete-block-modal" class="modal fade">
  <div class="modal-dialog modal-md">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title">Are you sure you want to delete <b id="deleting-block" data-id=""></b>?</h4>
      </div>
      <div class="modal-footer text-center">
        <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
        <button id="block-delete-sure" type="button" class="btn btn-danger">Yes, delete</button>
      </div>
    </div>
  </div>
</div>

% extra_js = '''
    <script type="text/javascript" src="/static/js/leggera.content.js"></script>
'''
