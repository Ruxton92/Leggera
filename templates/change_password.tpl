<!DOCTYPE html>
<html>
    <head>
        <title>Leggera changing password</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
        <link rel="stylesheet" href="/static/vendor/css/bootstrap.min.css">
        <link rel="stylesheet" href="/static/vendor/css/bootstrap-theme.min.css">
        <link rel="stylesheet" href="/static/css/leggera.css">
        <link rel="stylesheet" href="/static/css/leggera.admin.css">
        <script type="text/javascript" src="/static/vendor/js/jquery-1.11.1.min.js"></script>
        <script type="text/javascript" src="/static/vendor/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="/static/js/leggera.change_password.js"></script>
    </head>
    <body class="login-page">
        <div class="container">
          <div id="change-password-form" class="form-signin">
            <h2 class="form-signin-heading text-center">Enter new password</h2>
            <input id="change-password-1" name="rest-form-password-1" type="password" class="form-control" placeholder="New password" required autofocus>
            <input id="change-password-2" name="rest-form-password-2" type="password" class="form-control" placeholder="Please, enter it again" required>
            <button id="change-submit" class="btn btn-lg btn-success btn-block" type="submit">Change password</button>
          </div>
        </div>
        <div class="container">
            <div id="alert-container" class="col-xs-12 col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3">
                <div id="alert-match" class="alert alert-danger hide" role="alert">
                    <!-- <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button> -->
                    <span class="glyphicon glyphicon-exclamation-sign"></span> Passwords doesn't match.
                </div>
                <div id="alert-error" class="alert alert-danger hide" role="alert">
                    <!-- <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button> -->
                    <span class="glyphicon glyphicon-ban-circle"></span> Something went wrong. Try again later.
                </div>
                <div id="alert-success" class="alert alert-success hide" role="alert">
                    <!-- <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button> -->
                    <span class="glyphicon glyphicon-ok"></span> Password successfully changed. Go to <a href="/login/">login</a>.
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
    </body>
</html>
