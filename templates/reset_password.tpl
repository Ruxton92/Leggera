<!DOCTYPE html>
<html>
    <head>
        <title>Leggera resetting password</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
        <link rel="stylesheet" href="/static/vendor/css/bootstrap.min.css">
        <link rel="stylesheet" href="/static/vendor/css/bootstrap-theme.min.css">
        <link rel="stylesheet" href="/static/css/leggera.css">
        <link rel="stylesheet" href="/static/css/leggera.admin.css">
        <script type="text/javascript" src="/static/vendor/js/jquery-1.11.1.min.js"></script>
        <script type="text/javascript" src="/static/vendor/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="/static/js/leggera.reset_password.js"></script>
    </head>
    <body class="login-page">
        <div class="container">
          <div id="reset-password-form" class="form-signin">
            <h2 class="form-signin-heading text-center">Resetting password</h2>
            <input id="reset-email" name="rest-form-email" type="email" class="form-control" placeholder="Your email" required autofocus>
            <input id="reset-login" name="rest-form-username" type="text" class="form-control" placeholder="Your username" required>
            <button id="reset-submit" class="btn btn-lg btn-success btn-block" type="submit">Reset your password</button>
          </div>
        </div>
        <div class="container">
            <div id="alert-container" class="col-xs-12 col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3">
                <div id="alert-error" class="alert alert-danger hide" role="alert">
                    <!-- <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button> -->
                    <span class="glyphicon glyphicon-ban-circle"></span> Wrong username and email combination.
                </div>
                <div id="alert-success" class="alert alert-success hide" role="alert">
                    <!-- <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button> -->
                    <span class="glyphicon glyphicon-ok"></span> Success! Check your inbox.
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
