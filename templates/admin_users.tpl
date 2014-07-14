% rebase('templates/layout_admin.tpl')
% title='Leggera - Users management'
<div class="container-fluid">

  <div class="row">
        <div class="col-xs-12">
            <h1>Users management</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12 col-md-8">
            <h2>All users</h2>
            <div class="row">
                <div class="col-xs-12 col-sm-8 col-md-8">
                    <ul class="list-group">
                        % for user in users:
                            <li class="user-block list-group-item">
                                <div class="row">
                                    <div class="col-xs-9 col-sm-10 col-md-10">
                                        <h3 class="username-title" data-username="{{ user[0] }}">
                                            {{ user[0] }}
                                            % if user[0] == username:
                                                <span>(me)</span>
                                            % end
                                        </h3>
                                        <br class="visible-xs-block visible-sm-block">
                                        <small class="user-additional-info">
                                            % if user[1]:
                                                <span class="user-email">{{ user[1] }}</span>,
                                            % end
                                            <span class="user-role">{{ user[2] }}</span>
                                        </small>
                                    </div>
                                    <div class="col-xs-3 col-sm-2 col-md-2 text-right user-controls">
                                        <a class="open-settings"><big class="glyphicon glyphicon-cog"></big></a>
                                        % if user[0] != username:
                                            <a class="delete-user"><span class="glyphicon glyphicon-trash"></span></a>
                                        % end
                                    </div>
                                </div>
                            </li>
                        % end
                    </ul>
                </div>
            </div>
        </div>
        <div class="col-xs-12 col-md-4">
            <h2>Create new user</h2>
            <div class="row">
                <div class="col-xs-8 col-sm-6 col-md-6">
                    <form id="create-user-form" role="form">
                        <div class="form-group ">
                            <label class="control-label" for="create-user-username">Username can contain letters, numbers, symbols "_" and "-"</label>
                            <input id="create-user-username" name="create-user-username" type="text" class="form-control" placeholder="Username">
                        </div>
                        <div class="form-group ">
                            <label class="control-label" for="create-user-password">Use real existing email address</label>
                            <input id="create-user-email" name="create-user-email" type="email" class="form-control" placeholder="Email">
                        </div>
                        <div class="form-group ">
                            <label class="control-label" for="create-user-email">Password can contain letters, numbers, symbols "@", "*", "#", "_", "-" (from 6 to 20 characters)</label>
                            <input id="create-user-password" name="create-user-password" type="password" class="form-control" placeholder="Password">
                        </div>
                        <div class="form-group ">
                            <label class="control-label" for="create-user-role">Select one of the roles</label>
                            <select id="create-user-role" name="create-user-role" class="form-control">
                                <option value="" disabled="disabled" selected="selected">Role</option>
                                % for item in roles:
                                    <option value="{{item }}">{{item.title()}}</option>
                                % end
                            </select>
                        </div>
                        <div class="form-group ">
                            <button type="submit" class="btn btn-success">Create user</button>
                        </div>
                    </form>
                    <div id="alert-user-exists" class="alert alert-danger hide" role="alert">
                        <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                        <span class="glyphicon glyphicon-ban-circle"></span> This username or email is already in use
                    </div>
                    <div id="alert-user-created" class="alert alert-success hide" role="alert">
                        <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                        <span class="glyphicon glyphicon-ok"></span> User successfully created
                    </div>
                </div>
            </div>

        </div>
    </div>

</div>
<div id="loading-modal" class="modal fade" data-backdrop="static" data-keyboard="false">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header" style="border:none">
        <div class="progress" style="margin:0">
          <div class="progress-bar progress-bar-striped active"  role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width: 100%">
            Loading...
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<div id="delete-user-modal" class="modal fade">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title">Are you sure you want to delete <b id="deleting-user-username"></b>?</h4>
      </div>
      <div class="modal-footer text-center">
        <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
        <button id="user-delete-sure" type="button" class="btn btn-danger">Yes, delete</button>
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
                <fieldset>
                    <div class="form-group">
                        <label for="user-settings-email">Email address</label>
                        <input type="email" class="form-control" id="user-settings-email">
                    </div>
                    <div class="form-group">
                        <label for="user-settings-role">Role</label>
                        <select id="user-settings-role" class="form-control">
                            % for item in roles:
                                <option value="{{item}}">{{item.title()}}</option>
                            % end
                        </select>
                    </div>
                </fieldset>
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


% extra_js = '''
    <script type="text/javascript" src="/static/js/leggera.users.js"></script>
'''
