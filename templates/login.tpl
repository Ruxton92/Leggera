<!DOCTYPE html>
<html>
    <head>
        <title>Leggera login page</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
        <link rel="stylesheet" href="/static/vendor/css/bootstrap.min.css">
        <link rel="stylesheet" href="/static/vendor/css/bootstrap-theme.min.css">
        <link rel="stylesheet" href="/static/css/leggera.css">
        <link rel="stylesheet" href="/static/css/leggera.admin.css">
        <script type="text/javascript" src="/static/vendor/js/jquery-1.11.1.min.js"></script>
        <script type="text/javascript" src="/static/vendor/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="/static/js/leggera.login.js"></script>
    </head>
    <body class="login-page">
        <div class="container">
          <div id="login-form" class="form-signin">
            <h2 class="form-signin-heading text-center">Please sign in</h2>
            <input id="login-email" type="email" class="form-control" placeholder="Login" required autofocus>
            <input id="login-pass" type="password" class="form-control" placeholder="Password" required>
            <!-- <div class="checkbox">
              <label>
                <input type="checkbox" value="remember-me"> Remember me
              </label>
            </div> -->
            <button id="login-submit" class="btn btn-lg btn-success btn-block" type="submit">Sign in</button>
          </div>
        </div>
        <div class="container">
            <div id="alert-container" class="col-xs-12 col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3">
                <div id="alert-wrong-email" class="alert alert-danger hide" role="alert">
                    <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <span class="glyphicon glyphicon-ban-circle"></span> Wrong username and password combination.
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
