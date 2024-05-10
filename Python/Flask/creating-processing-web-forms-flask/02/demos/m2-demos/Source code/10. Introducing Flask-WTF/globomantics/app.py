from flask import Flask, render_template, request, redirect, url_for, g, flash
from flask_wtf import FlaskForm
from wtforms import StringField, TextAreaField, SubmitField
import pdb
import sqlite3

app = Flask(__name__)
app.config["SECRET_KEY"] = "secretkey"

class NewItemForm(FlaskForm):
    title       = StringField("Title")
    price       = StringField("Price")
    description = TextAreaField("Description")
    submit      = SubmitField("Submit")

@app.route("/")
def home():
    conn = get_db()
    c = conn.cursor()

    items_from_db = c.execute("""SELECT
                    i.id, i.title, i.description, i.price, i.image, c.name, s.name
                    FROM
                    items AS i
                    INNER JOIN categories     AS c ON i.category_id     = c.id
                    INNER JOIN subcategories  AS s ON i.subcategory_id  = s.id
                    ORDER BY i.id DESC
    """)

    items = []
    for row in items_from_db:
        item = {
            "id": row[0],
            "title": row[1],
            "description": row[2],
            "price": row[3],
            "image": row[4],
            "category": row[5],
            "subcategory": row[6]
        }
        items.append(item)

    return render_template("home.html", items=items)

@app.route("/item/new", methods=["GET", "POST"])
def new_item():
    conn = get_db()
    c = conn.cursor()
    form = NewItemForm()

    if request.method == "POST":
        # Process the form data
        c.execute("""INSERT INTO items
                    (title, description, price, image, category_id, subcategory_id)
                        VALUES (?,?,?,?,?,?)""",
                        (
                            form.title.data,
                            form.description.data,
                            float(form.price.data),
                            "",
                            1,
                            1
                        )
        )
        conn.commit()
        # Redirect to some page
        flash("Item {} has been successfully submitted".format(request.form.get("title")), "success")
        return redirect(url_for("home"))

    return render_template("new_item.html", form=form)

def get_db():
    db = getattr(g, '_database', None)
    if db is None:
        db = g._database = sqlite3.connect('db/globomantics.db')
    return db

@app.teardown_appcontext
def close_connection(exception):
    db = getattr(g, '_database', None)
    if db is not None:
        db.close()
