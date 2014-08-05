#coding: utf-8

import sqlite3
import bottle
import os.path
from os.path import isfile, join, splitext
from os import listdir
from cork import Cork
from cork.backends import SQLiteBackend
from beaker.middleware import SessionMiddleware
import logging
import json
from models import ContentBlock
from urlparse import urlparse

logging.basicConfig(format='localhost - - [%(asctime)s] %(message)s', level=logging.DEBUG)
log = logging.getLogger(__name__)
bottle.debug(True)

db = SQLiteBackend('./leggeradb.db')
# smtpurl = "starttls://<gmailusername>:<gmailapppass>@smtp.gmail.com:587"
auth = Cork(backend=db, email_sender='artkon92@gmail.com', smtp_url=smtpurl)

conn = sqlite3.connect('./leggeradb.db')
curs = conn.cursor()

def log_in_user(email, password):
    res = auth.login(email, password, success_redirect='/ajax/login/success/', fail_redirect='/ajax/login/error/')


def management_users_view():
    roles_arr = ['admin', 'editor']
    curr_user = auth.current_user.username
    curs = conn.cursor()
    curs.execute("SELECT u.username, u.email_addr, r.role FROM users u NATURAL JOIN roles r WHERE u.username = ? OR r.level < (SELECT r.level FROM users u NATURAL JOIN roles r WHERE u.username = ? ) ORDER BY u.username ASC", (curr_user, curr_user))
    users_arr = curs.fetchall()
    return bottle.template('./templates/admin_users',
        roles=roles_arr,
        username=curr_user,
        users=users_arr
    )


def management_content_view():
    curr_user = auth.current_user.username
    curs.execute("SELECT id FROM content_blocks WHERE category = 'header'")
    header_id = curs.fetchall()
    curs.execute("SELECT id FROM content_blocks WHERE category = 'footer'")
    footer_id = curs.fetchall()
    return bottle.template('./templates/admin_content',
        username=curr_user,
        blocks = get_content_blocks(),
        header_id = header_id,
        footer_id = footer_id,
    )


def management_files_view():
    curr_user = auth.current_user.username
    return bottle.template('./templates/admin_files',
       username=curr_user,
       files=get_list_of_uploads()
    )


def edit_user_data(username, email, role):
    response = {'status': True}
    curs = conn.cursor()
    curs.execute("UPDATE users SET email_addr = ?, role = ? WHERE username = ?", (email, role, username))
    conn.commit()
    return response


def create_user_by_admin(username, password, role, email):
    try:
        auth.create_user(username, role, password, email)
        auth._store.connection.commit()
        return dict(ok=True, msg='')
    except Exception, e:
        return dict(ok=False, msg=e.message)


def get_list_of_uploads():
    root_path = os.path.dirname(os.path.abspath(__file__))
    uploads_path = os.path.abspath(os.path.join(root_path, '..', 'uploads'))
    only_files = [ f for f in listdir(uploads_path) if isfile(join(uploads_path,f)) ]
    only_files.sort()
    files_arr = []
    for f in only_files:
        files_arr.append({
                    'extension': splitext(f)[1],
                    'name': f
                }
            )
    return files_arr


def delete_upload_file(filename):
    if filename:
        root_path = os.path.dirname(os.path.abspath(__file__))
        uploads_path = os.path.abspath(os.path.join(root_path, '..', 'uploads'))
        print uploads_path
        os.remove("{}/{}".format(uploads_path, filename))
        return True
    else:
        return False


def save_upload_file(upload):
    root_path = os.path.dirname(os.path.abspath(__file__))
    uploads_path = os.path.abspath(os.path.join(root_path, '..', 'uploads'))
    with open(os.path.join(uploads_path, upload.filename), 'wb') as tmp_file:
        tmp_file.write(upload.file.read())
    return True


def get_content_blocks():
    curs = conn.cursor()
    curs.execute("SELECT id, title FROM content_blocks WHERE category = 'block' ORDER BY weight ASC")
    blocks_arr = curs.fetchall()
    return blocks_arr


def save_blocks_weights(weights):
    wj = json.loads(weights)
    for w in wj:
        id = w.keys()[0]
        weight = w[w.keys()[0]]
        curs.execute("UPDATE content_blocks SET weight = ? WHERE id = ?", (id, weight))
        conn.commit()

def management_section_edit(section_id, args):
    curr_user = auth.current_user.username
    print 'section_id={}'.format(section_id)
    if int(section_id) > 0:
        print 's1'
        cb = ContentBlock.get_by_id(section_id)
    else:
        print 's2'
        cb = ContentBlock()
        cb.cid = 0
        cb.title = 'New block'
        cb.content = ''
        cb.category = args if args else 'block'
        cb.weight = 1
    return bottle.template('./templates/admin_content_detail',
        username=curr_user,
        block = cb
    )

def save_content_block(form):
    print form
    cb = ContentBlock()
    for b in json.loads(form):
        if b.get('name') == 'cid':
            cb.cid = b.get('value')
        elif b.get('name') == 'title':
            cb.title = b.get('value')
        elif b.get('name') == 'weight':
            cb.weight = b.get('value')
        elif b.get('name') == 'category':
            cb.category = b.get('value')
        elif b.get('name') == 'content':
            cb.content = b.get('value')
    print cb
    return True

