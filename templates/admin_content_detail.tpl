% rebase('templates/layout_admin.tpl')
% title='Leggera - Editing content block'
<div class="container-fluid">

    <div class="row">
        <div class="col-xs-12">
            <h1>Editing content</h1>
        </div>
    </div>
    <form role="form" id="block-form">
        <div class="row form-group">
            <div class="col-xs-12 col-sm-5 col-md-3">
                <input id="block-title" name="title" class="form-control" type="text" value="{{ block.title }}" placeholder="Block title">
            </div>
        </div>
        <div class="row form-group">
            <div class="col-xs-12 col-sm-12 col-md-12">
                <!--textarea name="content" id="block-content" class="form-control" cols="30" rows="10">{{ block.content }}</textarea> -->
                <div id="block-content">{{ !block.content }}</div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-3 col-sm-3 col-md-2">
                <a id="block-save" href="#" class="btn btn-success">
                    <span class="glyphicon glyphicon-save"></span> Save
                </a>
            </div>
        </div>
        <div class="row hide">
            <div class="col-xs-1 col-sm-1 col-md-1">
                <input id="block-cid" name="cid" value="{{ block.cid }}" type="hidden">
                <input id="block-weight" name="weight" value="{{ block.weight }}" type="hidden">
                <input id="block-category" name="category" value="{{ block.category }}" type="hidden">
            </div>
        </div>
    </form>










</div>

% extra_js = '''
    <script type="text/javascript" src="/static/vendor/js/jqueryupload.js"></script>
    <script type="text/javascript" src="/static/vendor/js/summernote.min.js"></script>
    <script type="text/javascript" src="/static/js/leggera.content_detail.js"></script>
'''

% extra_css = '''
    <link rel="stylesheet" href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.min.css">
    <link rel="stylesheet" href="/static/vendor/css/summernote.css">
    <link rel="stylesheet" href="/static/vendor/css/summernote-bs3.css">
'''
