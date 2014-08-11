<div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
  <div class="container">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="/management/">Leggera</a>
    </div>
    <div class="collapse navbar-collapse">
      <ul class="nav navbar-nav">
        %if pathname == '/management/':
          <li class="active"><a href="#">Dashboard</a></li>
        %else:
          <li><a href="/management/">Dashboard</a></li>
        %end
        %if pathname.startswith('/management/content/'):
          <li class="active"><a href="">Content</a></li>
        %else:
          <li><a href="/management/content/">Content</a></li>
        %end
        %if pathname == '/management/users/':
          <li class="active"><a href="#">Users</a></li>
        %else:
          <li><a href="/management/users/">Users</a></li>
        %end
        %if pathname == '/management/files/':
          <li class="active"><a href="#">Files</a></li>
        %else:
          <li><a href="/management/files/">Files</a></li>
        %end
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown">{{ username }} <span class="caret"></span></a>
          <ul class="dropdown-menu" role="menu">
            <li><a href="/login/">Change account</a></li>
            <li><a href="/logout/">Log out</a></li>
          </ul>
        </li>
      </ul>
    </div>
  </div>
</div>
