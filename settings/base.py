#coding: utf-8
import os

db_name = './leggeradb.db'

smtpurl = "starttls://gmailusername:gmailapppass@smtp.gmail.com:587"
smtpsender = 'account@gmail.com'

root_path = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..'))
