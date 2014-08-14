#coding: utf-8

import sqlite3
import bottle
import os.path
from os.path import isfile, join, splitext
from os import listdir

class ContentBlock:
    cid = 0
    title = ''
    weight = 0
    category = 'block'
    content = ''


    @classmethod
    def __init__(self):
        self.cid = 0


    def __str__(self):
        return "{}, {}".format(self.cid, self.title)


    def anchor(self):
        return '-'.join(self.title.lower().split(' '))


    def save(self):
        sql = SQLbackend()
        curs = sql.get_cursor()
        result = False
        if self.cid == 0:
            curs.execute("INSERT INTO content_blocks (title, content, category, weight) VALUES (?, ?, ?, ?)", (
                self.title,
                self.content,
                self.category,
                self.weight,
            ))
            new_id = curs.lastrowid
            result = {'new_id': new_id}
        else:
            curs.execute("UPDATE content_blocks SET title = ?, content = ?, category = ?, weight = ? WHERE id = ?", (
                self.title,
                self.content,
                self.category,
                self.weight,
                self.cid
            ))

            result = True
        sql.commit_and_close()
        return result

    def delete(self):
        sql = SQLbackend()
        curs = sql.get_cursor()
        print "self.cid={}".format(self.cid)
        curs.execute("DELETE FROM content_blocks WHERE id = ?", (self.cid, ))
        sql.commit_and_close()
        return True


    @staticmethod
    def get_by_id(id):
        sql = SQLbackend()
        curs = sql.get_cursor()
        curs.execute("SELECT * FROM content_blocks WHERE id=?", (str(id),))
        block = curs.fetchall()[0]
        sql.close_connection()
        cb = ContentBlock()
        cb.cid = block[0]
        cb.title = block[1]
        cb.content = block[2]
        cb.category = block[3]
        cb.weight = block[4]
        return cb


    @staticmethod
    def get_block_by_category(category):
        sql = SQLbackend()
        curs = sql.get_cursor()
        curs.execute("SELECT * FROM content_blocks WHERE category=? ORDER BY weight ASC", (category,))
        blocks = curs.fetchall()
        sql.close_connection()
        if category in ['header', 'footer']:
            if len(blocks):
                cb = ContentBlock()
                cb.cid = blocks[0][0]
                cb.title = blocks[0][1]
                cb.content = blocks[0][2]
                cb.category = blocks[0][3]
                cb.weight = blocks[0][4]
                result = cb
            else:
                result = False
        else:
            result = list()
            for b in blocks:
                cb = ContentBlock()
                cb.cid = b[0]
                cb.title = b[1]
                cb.content = b[2]
                cb.category = b[3]
                cb.weight = b[4]
                result.append(cb)
        return result


    @staticmethod
    def get_header():
        return ContentBlock.get_block_by_category('header')


    @staticmethod
    def get_footer():
        return ContentBlock.get_block_by_category('footer')


    @staticmethod
    def get_blocks():
        return ContentBlock.get_block_by_category('block')


class Singleton(object):
    _instance = None
    def __new__(cls, *args, **kwargs):
        if not cls._instance:
            cls._instance = super(Singleton, cls).__new__(cls, *args, **kwargs)
        return cls._instance


class SQLbackend(Singleton):
    db = ''
    cursor = ''
    connect = ''

    @classmethod
    def __init__(self):
        self.db = './leggeradb.db'
        self.connect = sqlite3.connect(self.db)
        self.cursor = self.connect.cursor()

    def get_cursor(self):
        return self.cursor

    def commit(self):
        self.connect.commit()

    def close_connection(self):
        self.connect.close()

    def commit_and_close(self):
        self.connect.commit()
        self.connect.close()
