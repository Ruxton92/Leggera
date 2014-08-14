% rebase('templates/layout.tpl')
% title='Leggera - Index page'
% include('templates/navbar')

% if header:
    <header id="leggera-main-header" class="container-fluid">
        <div class="container">
            {{ !header.content }}
        </div>
    </header>
% end

<div class="container">
    % if blocks:
        % for b in blocks:
            <div class="row">
                <div id="{{ b.anchor() }}" class="col-xs-12 col-md-12">
                    <h2>{{ b.title }}</h2>
                    {{ !b.content }}
                </div>
            </div>
        %end
    % end
</div>

% if footer:
<footer id="leggera-main-footer" class="container-fluid">
    <div class="container">
        {{ !footer.content }}
    </div>
</footer>
% end

% extra_js = '''
    <script type="text/javascript" src="/static/js/leggera.index.js"></script>
'''
