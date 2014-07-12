#coding: utf-8

import bottle
import os.path
from cork import Cork
from cork.backends import SQLiteBackend
from beaker.middleware import SessionMiddleware
import logging

logging.basicConfig(format='localhost - - [%(asctime)s] %(message)s', level=logging.DEBUG)
log = logging.getLogger(__name__)
bottle.debug(True)

db = SQLiteBackend('./leggeradb.db')

auth = Cork(backend=db, email_sender='artkon92@gmail.com', smtp_url=smtpurl)


def log_in_user(email, password):
    res = auth.login(email, password, success_redirect='/ajax/login/success/', fail_redirect='/ajax/login/error/')


def management_users_view():
    roles_arr = ['admin', 'editor']
    return bottle.template('./templates/admin_users', roles=roles_arr)


def create_user_by_admin(username, password, role):
    try:
        auth.create_user(username, role, password)
        return dict(ok=True, msg='')
    except Exception, e:
        return dict(ok=False, msg=e.message)
