% rebase('templates/layout_admin.tpl')
% title='Leggera - Files management'
<div class="container-fluid">
  <div class="row">
        <div class="col-xs-12">
            <h1>Files management</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12 col-sm-6 col-md-6">
            <h2>All files</h2>
            <div id="files-actions-block">
                <a id="files-refresh" href="#" class="btn btn-success">
                    <span class="glyphicon glyphicon-refresh"></span> Refresh
                </a>
                <a id="files-upload" href="#" class="btn btn-primary">
                    <span class="glyphicon glyphicon-upload"></span>
                    Upload
                    <input type="file" name="upload" accept="image/*">
                </a>
            </div>
            <div id="all-files-wrapper">
                <ul id="all-files-list" class="list-group">
                    % for file in files:
                        <li class="file-block list-group-item">
                            <div class="row">
                                <div class="col-xs-9 col-sm-10 col-md-10">
                                    <a class="file-item" data-extension="{{ file['extension'] }}" data-path="/uploads/{{ file['name'] }}">
                                        <span>{{ file['name'] }}</span>
                                    </a>
                                </div>
                                <div class="col-xs-3 col-sm-2 col-md-2 text-right">
                                    <a target="_blank" class="file-direct-link" href="/uploads/{{ file['name'] }}">
                                        <span class="glyphicon glyphicon-link"></span>
                                    </a>
                                    <a class="file-remove" href="#">
                                        <span class="glyphicon glyphicon-trash"></span>
                                    </a>
                                </div>
                            </div>
                        </li>
                    % end
                </ul>
            </div>
        </div>
        <div class="col-xs-12 col-sm-6 col-md-6">
            <h2>Preview</h2>
            <hr>
            <img id="preview-picture" class="hide" src="" alt="Preview of picture">
        </div>
    </div>
</div>

<div id="delete-file-modal" class="modal fade">
  <div class="modal-dialog modal-md">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title">Are you sure you want to delete <b id="deleting-filename"></b>?</h4>
      </div>
      <div class="modal-footer text-center">
        <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
        <button id="file-delete-sure" type="button" class="btn btn-danger">Yes, delete</button>
      </div>
    </div>
  </div>
</div>

<div id="user-settings-modal" class="modal fade">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title"><b id="user-settings-username"></b> - settings</h4>
      </div>
      <div class="modal-body">
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12">

            </div>
        </div>
      </div>
      <div class="modal-footer text-center">
        <button id="user-settings-cancel" class="btn btn-default" type="button">Cancel</button>
        <button id="user-settings-save" type="button" class="btn btn-success">Save</button>
      </div>
    </div>
  </div>
</div>

<div id="delete-file-modal" class="modal fade">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title">Are you sure you want to delete <b id="deleting-filename"></b>?</h4>
      </div>
      <div class="modal-footer text-center">
        <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
        <button id="file-delete-sure" type="button" class="btn btn-danger">Yes, delete</button>
      </div>
    </div>
  </div>
</div>

<div id="file-template" class="hide">
    <li class="file-block list-group-item">
        <div class="row">
            <div class="col-xs-9 col-sm-10 col-md-10">
                <a class="file-item" data-extension="" data-path="">
                    <span></span>
                </a>
            </div>
            <div class="col-xs-3 col-sm-2 col-md-2 text-right">
                <a target="_blank" class="file-direct-link" href="">
                    <span class="glyphicon glyphicon-link"></span>
                </a>
                <a class="file-remove" href="#">
                    <span class="glyphicon glyphicon-trash"></span>
                </a>
            </div>
        </div>
    </li>
</div>

% extra_js = '''
    <script type="text/javascript" src="/static/js/leggera.files.js"></script>
    <script type="text/javascript" src="/static/vendor/js/jqueryupload.js"></script>
'''
