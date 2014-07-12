#coding: utf-8

import bottle
from bottle import response
from json import dumps
from views import *

@bottle.route('/static/<filepath:path>')
def static_files(filepath):
    print filepath
    return bottle.static_file(filepath, root='./static/')


@bottle.route('/')
def index():
    return bottle.template('./templates/index')


@bottle.route('/login/')
def login_page():
    return bottle.template('./templates/login')


@bottle.route('/logout/')
def log_out():
    auth.logout(success_redirect='/login/')


@bottle.route('/management/')
def management_page():
    auth.require(role='admin', fail_redirect='/')
    return bottle.template('./templates/admin_dasboard')


@bottle.route('/management/users/')
def management_users_page():
    auth.require(role='admin', fail_redirect='/')
    return management_users_view()


# AJAX requests
@bottle.post('/ajax/login/login/')
def log_in():
    email = bottle.request.forms.get('email')
    password = bottle.request.forms.get('pass')
    log_in_user(email, password)


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
    response.content_type = 'application/json'
    # email = bottle.request.forms.get('email')
    password = bottle.request.forms.get('password')
    username = bottle.request.forms.get('username')
    role = bottle.request.forms.get('role')
    ret = create_user_by_admin(username, password, role)
    response.content_type = 'application/json'
    return dumps({"status": ret.get('ok')})


@bottle.route('/ajax/create_user/error/')
def create_user_error_redirect():
    response.content_type = 'application/json'
    return dumps({"status": "error"})


@bottle.route('/ajax/create_user/success/')
def create_user_success_redirect():
    response.content_type = 'application/json'
    return dumps({"status": "success"})
