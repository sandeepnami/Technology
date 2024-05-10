from flask import Flask, send_from_directory, render_template, request, redirect, url_for, g, flash
from flask_wtf import FlaskForm
from flask_wtf.file import FileAllowed, FileRequired
from wtforms import FileField, StringField, TextAreaField, SubmitField, SelectField, DecimalField
from wtforms.validators import InputRequired, DataRequired, Length
from werkzeug.utils import secure_filename
import pdb
import sqlite3
import os
import datetime
from secrets import token_hex

basedir = os.path.abspath(os.path.dirname(__file__))

app = Flask(__name__)
app.config["SECRET_KEY"] = "secretkey"
app.config["ALLOWED_IMAGE_EXTENSIONS"] = ["jpeg", "jpg", "png"]
app.config["MAX_CONTENT_LENGTH"] = 16 * 1024 * 1024
app.config["IMAGE_UPLOADS"] = os.path.join(basedir, "uploads")

class ItemForm(FlaskForm):
    title       = StringField("Title", validators=[InputRequired("Input is required!"), DataRequired("Data is required!"), Length(min=5, max=20, message="Input must be between 5 and 20 characters long")])
    price       = DecimalField("Price")
    description = TextAreaField("Description", validators=[InputRequired("Input is required!"), DataRequired("Data is required!"), Length(min=5, max=40, message="Input must be between 5 and 40 characters long")])
    image       = FileField("Image", validators=[FileRequired(), FileAllowed(app.config["ALLOWED_IMAGE_EXTENSIONS"], "Images only!")])

class NewItemForm(ItemForm):
    category    = SelectField("Category", coerce=int)
    subcategory = SelectField("Subcategory", coerce=int)
    submit      = SubmitField("Submit")

class EditItemForm(ItemForm):
    submit      = SubmitField("Update item")

class DeleteItemForm(FlaskForm):
    submit      = SubmitField("Delete item")

class FilterForm(FlaskForm):
    title       = StringField("Title", validators=[Length(max=20)])
    price       = SelectField("Price", coerce=int, choices=[(0, "---"), (1, "Max to Min"), (2, "Min to Max")])
    category    = SelectField("Category", coerce=int)
    subcategory = SelectField("Subcategory", coerce=int)
    submit      = SubmitField("Filter")

@app.route("/item/<int:item_id>/edit", methods=["GET", "POST"])
def edit_item(item_id):
    conn = get_db()
    c = conn.cursor()
    item_from_db = c.execute("SELECT * FROM items WHERE id = ?", (item_id,))
    row = c.fetchone()
    try:
        item = {
            "id": row[0],
            "title": row[1],
            "description": row[2],
            "price": row[3],
            "image": row[4]
        }
    except:
        item = {}

    if item:
        form = EditItemForm()
        if form.validate_on_submit():
            c.execute("""UPDATE items SET
            title = ?, description = ?, price = ?
            WHERE id = ?""",
                (
                    form.title.data,
                    form.description.data,
                    float(form.price.data),
                    item_id
                )
            )
            conn.commit()

            flash("Item {} has been successfully updated".format(form.title.data), "success")
            return redirect(url_for("item", item_id=item_id))

        form.title.data       = item["title"]
        form.description.data = item["description"]
        form.price.data       = item["price"]

        if form.errors:
            flash("{}".format(form.errors), "danger")
        return render_template("edit_item.html", item=item, form=form)

    return redirect(url_for("home"))

@app.route("/item/<int:item_id>/delete", methods=["POST"])
def delete_item(item_id):
    conn = get_db()
    c = conn.cursor()

    item_from_db = c.execute("SELECT * FROM items WHERE id = ?", (item_id,))
    row = c.fetchone()
    try:
        item = {
            "id": row[0],
            "title": row[1]
        }
    except:
        item = {}

    if item:
        c.execute("DELETE FROM items WHERE id = ?", (item_id,))
        conn.commit()

        flash("Item {} has been successfully deleted.".format(item["title"]), "success")
    else:
        flash("This item does not exist.", "danger")

    return redirect(url_for("home"))

@app.route("/item/<int:item_id>")
def item(item_id):
    c = get_db().cursor()
    item_from_db = c.execute("""SELECT
                   i.id, i.title, i.description, i.price, i.image, c.name, s.name
                   FROM
                   items AS i
                   INNER JOIN categories AS c ON i.category_id = c.id
                   INNER JOIN subcategories AS s ON i.subcategory_id = s.id
                   WHERE i.id = ?""",
                   (item_id,)
    )
    row = c.fetchone()

    try:
        item = {
            "id": row[0],
            "title": row[1],
            "description": row[2],
            "price": row[3],
            "image": row[4],
            "category": row[5],
            "subcategory": row[6]
        }
    except:
        item = {}

    if item:
        deleteItemForm = DeleteItemForm()

        return render_template("item.html", item=item, deleteItemForm=deleteItemForm)
    return redirect(url_for("home"))

@app.route("/")
def home():
    conn = get_db()
    c = conn.cursor()

    form = FilterForm(request.args, meta={"csrf": False})

    c.execute("SELECT id, name FROM categories")
    categories = c.fetchall()
    categories.insert(0, (0, "---"))
    form.category.choices = categories

    c.execute("SELECT id, name FROM subcategories WHERE category_id = ?", (1,))
    subcategories = c.fetchall()
    subcategories.insert(0, (0, "---"))
    form.subcategory.choices = subcategories

    query = """SELECT
                    i.id, i.title, i.description, i.price, i.image, c.name, s.name
                    FROM
                    items AS i
                    INNER JOIN categories AS c ON i.category_id = c.id
                    INNER JOIN subcategories AS s ON i.subcategory_id = s.id
    """

    if form.validate():

        filter_queries = []
        parameters = []

        if form.title.data.strip():
            filter_queries.append("i.title LIKE ?")
            parameters.append("%" + form.title.data + "%")

        if form.category.data:
            filter_queries.append("i.category_id = ?")
            parameters.append(form.category.data)

        if form.subcategory.data:
            filter_queries.append("i.subcategory_id = ?")
            parameters.append(form.subcategory.data)

        if filter_queries:
            query += " WHERE "
            query += " AND ".join(filter_queries)

        if form.price.data:
            if form.price.data == 1:
                query += " ORDER BY i.price DESC"
            else:
                query += " ORDER BY i.price"
        else:
            query += " ORDER BY i.id DESC"

        items_from_db = c.execute(query, tuple(parameters))
    else:
        items_from_db = c.execute(query + "ORDER BY i.id DESC")

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

    return render_template("home.html", items=items, form=form)

@app.route("/uploads/<filename>")
def uploads(filename):
    return send_from_directory(app.config["IMAGE_UPLOADS"], filename)

@app.route("/item/new", methods=["GET", "POST"])
def new_item():
    conn = get_db()
    c = conn.cursor()
    form = NewItemForm()

    c.execute("SELECT id, name FROM categories")
    categories = c.fetchall()
    # [(1, 'Food'), (2, 'Technology'), (3, 'Books')]
    form.category.choices = categories

    c.execute("""SELECT id, name FROM subcategories
                    WHERE category_id = ?""",
                    (1,)
    )
    subcategories = c.fetchall()
    form.subcategory.choices = subcategories

    if form.validate_on_submit():

        format = "%Y%m%dT%H%M%S"
        now = datetime.datetime.utcnow().strftime(format)
        random_string = token_hex(2)
        filename = random_string + "_" + now + "_" + form.image.data.filename
        filename = secure_filename(filename)
        form.image.data.save(os.path.join(app.config["IMAGE_UPLOADS"], filename))


        # Process the form data
        c.execute("""INSERT INTO items
                    (title, description, price, image, category_id, subcategory_id)
                    VALUES(?,?,?,?,?,?)""",
                    (
                        form.title.data,
                        form.description.data,
                        float(form.price.data),
                        filename,
                        form.category.data,
                        form.subcategory.data
                    )
        )
        conn.commit()
        # Redirect to some page
        flash("Item {} has been successfully submitted".format(request.form.get("title")), "success")
        return redirect(url_for("home"))

    if form.errors:
        flash("{}".format(form.errors), "danger")
    return render_template("new_item.html", form=form)

def get_db():
    db = getattr(g, "_database", None)
    if db is None:
        db = g._database = sqlite3.connect("db/globomantics.db")
    return db

@app.teardown_appcontext
def close_connection(exception):
    db = getattr(g, "_database", None)
    if db is not None:
        db.close()
