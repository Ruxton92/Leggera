#coding: utf-8

import sqlite3
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
# smtpurl = "smtp://smtp.magnet.ie"
smtpurl = "starttls://<gmailusername>:<gmailapppass>@smtp.gmail.com:587"
auth = Cork(backend=db, email_sender='artkon92@gmail.com', smtp_url=smtpurl)

conn = sqlite3.connect('./leggeradb.db')
curs = conn.cursor()

def log_in_user(email, password):
    res = auth.login(email, password, success_redirect='/ajax/login/success/', fail_redirect='/ajax/login/error/')


def management_users_view():
    roles_arr = ['admin', 'editor']
    curr_user = auth.current_user.username
    curs = conn.cursor()
    curs.execute("SELECT u.username, u.email_addr, r.role FROM users u NATURAL JOIN roles r WHERE u.username = ? OR r.level < (SELECT r.level FROM users u NATURAL JOIN roles r WHERE u.username = ? )", (curr_user, curr_user))
    users_arr = curs.fetchall()
    print users_arr
    return bottle.template('./templates/admin_users',
        roles=roles_arr,
        username=curr_user,
        users=users_arr
    )


def create_user_by_admin(username, password, role, email):
    try:
        auth.create_user(username, role, password, email)
        auth._store.connection.commit()
        return dict(ok=True, msg='')
    except Exception, e:
        return dict(ok=False, msg=e.message)
