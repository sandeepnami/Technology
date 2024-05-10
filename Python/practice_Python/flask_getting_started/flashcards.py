from datetime import datetime

from flask import Flask, render_template

from model import db

app = Flask(__name__)


@app.route('/')
def welcome():
    return render_template(
        "welcome.html",
        message="Here's a message from view"
        )

@app.route('/card')
def card_view():
    card = db[0]
    return render_template(
        "card.html",
        card=card
        )

@app.route('/date')
def date():
    return "This page is served at: " + str(datetime.now())

count = 0
@app.route('/count')
def count_views():
    global count
    count += 1   
    return "This page is served " + str(count) + " times"
