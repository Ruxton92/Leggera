<!DOCTYPE html>
<html>
    <head>
        <title>{{title or 'Leggera default title'}}</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
        {{ !get('extra_meta', '')}}
        <link href='http://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,400,700,300&subset=latin,cyrillic' rel='stylesheet' type='text/css'>
        <link rel="stylesheet" href="/static/vendor/css/bootstrap.min.css">
        <link rel="stylesheet" href="/static/vendor/css/bootstrap-theme.min.css">
        <link rel="stylesheet" href="/static/css/leggera.css">
        {{ !get('extra_css', '')}}
        <script type="text/javascript" src="/static/vendor/js/jquery-1.11.1.min.js"></script>
        <script type="text/javascript" src="/static/vendor/js/bootstrap.min.js"></script>
        {{ !get('extra_js', '')}}
    </head>
    <body>
        % include('templates/navbar')
        {{!base}}
    </body>
</html>
