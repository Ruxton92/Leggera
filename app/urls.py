#coding: utf-8

import bottle
from bottle import response
from json import dumps
from views import *


@bottle.route('/static/<filepath:path>')
def static_files(filepath):
    return bottle.static_file(filepath, root='./static/')


@bottle.route('/uploads/<filepath:path>')
def upload_static_files(filepath):
    return bottle.static_file(filepath, root='./uploads/')


@bottle.route('/')
def index():
    return bottle.template('./templates/index')


@bottle.route('/login/')
def login_page():
    return bottle.template('./templates/login')


@bottle.route('/logout/')
def log_out():
    auth.logout(success_redirect='/login/')


@bottle.route('/reset-password/')
def reset_password_page():
    return bottle.template('./templates/reset_password')


@bottle.route('/change-password/<reset_code>/')
def change_password_page(reset_code):
    return bottle.template('./templates/change_password', code=reset_code)


@bottle.route('/management/')
def management_page():
    auth.require(role='editor', fail_redirect='/')
    return bottle.template('./templates/admin_dasboard', username=auth.current_user.username, pathname=bottle.request.path,)


@bottle.route('/management/users/')
def management_users_page():
    auth.require(role='admin', fail_redirect='/')
    return management_users_view()


@bottle.route('/management/content/')
def management_content_page():
    auth.require(role='editor', fail_redirect='/')
    return management_content_view()


@bottle.route('/management/content/edit/<section_id>/')
def management_content_edit(section_id):
    auth.require(role='editor', fail_redirect='/')
    return management_section_edit(section_id, bottle.request.query_string)


@bottle.route('/management/files/')
def management_files_page():
    auth.require(role='editor', fail_redirect='/')
    return management_files_view()


# AJAX requests
@bottle.post('/ajax/login/login/')
def log_in():
    email = bottle.request.forms.get('email')
    password = bottle.request.forms.get('pass')
    log_in_user(email, password)


@bottle.post('/ajax/login/reset/')
def log_in():
    em = bottle.request.forms.get('email')
    us = bottle.request.forms.get('username')
    response.content_type = 'application/json'
    try:
        auth.send_password_reset_email(
            username=us,
            email_addr=em
        )
        auth._store.connection.commit()
        return dumps({"status": True})
    except Exception, e:
        print repr(e)
        return dumps({"status": False})


@bottle.post('/ajax/login/change/')
def log_in():
    ps = bottle.request.forms.get('password')
    cd = bottle.request.forms.get('reset_code')
    response.content_type = 'application/json'
    try:
        auth.reset_password(cd, ps)
        auth._store.connection.commit()
        return dumps({"status": True})
    except Exception, e:
        print repr(e)
        return dumps({"status": False})


@bottle.route('/ajax/login/error/')
def login_error_redirect():
    response.content_type = 'application/json'
    return dumps({"status": "error"})


@bottle.route('/ajax/login/success/')
def login_success_redirect():
    response.content_type = 'application/json'
    return dumps({"status": "success"})


@bottle.post('/ajax/users/create/')
def create_user():
    email = bottle.request.forms.get('email')
    password = bottle.request.forms.get('password')
    username = bottle.request.forms.get('username')
    role = bottle.request.forms.get('role')
    ret = create_user_by_admin(username, password, role, email)
    response.content_type = 'application/json'
    return dumps({"status": ret.get('ok')})


@bottle.post('/ajax/users/delete/')
def delete_user():
    username = bottle.request.forms.get('user')
    response.content_type = 'application/json'
    try:
        auth.delete_user(username)
        auth._store.connection.commit()
        return dumps({"status": True})
    except Exception, e:
        print repr(e)
        return dumps({"status": False})


@bottle.post('/ajax/users/edit/')
def edit_user():
    username = bottle.request.forms.get('username')
    email = bottle.request.forms.get('email')
    role = bottle.request.forms.get('role')
    response.content_type = 'application/json'
    return edit_user_data(username, email, role)


@bottle.route('/ajax/users/error/')
def users_error_redirect():
    response.content_type = 'application/json'
    return dumps({"status": "error"})


@bottle.route('/ajax/users/success/')
def users_success_redirect():
    response.content_type = 'application/json'
    return dumps({"status": "success"})


@bottle.post('/ajax/files/refresh/')
def refresh_files_list():
    response.content_type = 'application/json'
    return dumps({"files": get_list_of_uploads()})


@bottle.post('/ajax/files/delete/')
def delete_upload():
    filename = bottle.request.forms.get('file')
    response.content_type = 'application/json'
    return dumps({"status": delete_upload_file(filename)})


@bottle.post('/ajax/files/upload/')
def upload_file():
    response.content_type = 'application/json'
    return dumps({"status": save_upload_file(bottle.request.files.upload)})


@bottle.post('/ajax/content/save_weights/')
def save_weights():
    save_blocks_weights(bottle.request.forms.get('weights'))
    response.content_type = 'application/json'
    return dumps({"status": True})


@bottle.post('/ajax/content/save_block/')
def save_block():
    ret = save_content_block(bottle.request.forms.get('form'))
    response.content_type = 'application/json'
    return dumps({"status": ret})


@bottle.post('/ajax/content/delte_block/')
def delete_block():
    cid = bottle.request.forms.get('id')
    ret = delete_content_block(cid)
    response.content_type = 'application/json'
    return dumps({"status": ret})
