#!/usr/bin/env python
#coding: utf-8

import bottle
from cork import Cork
from cork.backends import SQLiteBackend
from beaker.middleware import SessionMiddleware

import app.urls

app = bottle.app()
session_opts = {
    'session.cookie_expires': True,
    'session.encrypt_key': 'leggerasecretkey',
    'session.httponly': True,
    'session.timeout': 3600 * 24 * 7, # 1 week
    'session.type': 'cookie',
    'session.validate_key': True,
}
app = SessionMiddleware(app, session_opts)


def main():
    # Start the Bottle webapp, it's open for local network
    bottle.run(app=app, quiet=False, reloader=False, host="0.0.0.0", port="8080", debu=True)


if __name__ == "__main__":
    main()
