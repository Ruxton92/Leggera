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
            <h2>List of all users</h2>
        </div>
        <div class="col-xs-12 col-md-4">
            <h2>Create new user</h2>
            <div class="row">
                <div class="col-xs-8 col-sm-6 col-md-4">
                    <form id="create-user-form" role="form">
                        <div class="form-group ">
                            <label class="control-label" for="create-user-username">Username can contain letters, numbers, symbols "_" and "-"</label>
                            <input id="create-user-username" name="create-user-username" type="text" class="form-control" placeholder="Username">
                        </div>
                        <!-- <div class="form-group ">
                            <label class="control-label" for="create-user-password">Use real existing email address</label>
                            <input id="create-user-email" name="create-user-email" type="email" class="form-control" placeholder="Email">
                        </div> -->
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
% extra_js = '''
    <script type="text/javascript" src="/static/js/leggera.users.js"></script>
'''
