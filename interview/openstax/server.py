from flask import Flask, render_template, request, url_for, redirect, make_response, session
from flask.ext.sqlalchemy import SQLAlchemy
from werkzeug import secure_filename

import os, re


app = Flask(__name__)

app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///homework.db'
app.secret_key = 'OpenStax homework for George Chen'

db = SQLAlchemy(app)

from models import *

def break_down_csv(csv):
  # Turn a CSV string into [[a,b,c], [d,e,f]]
  lines = csv.split("\n")
  table = []
  for line in lines:
    table.append(re.split('[,\t]', line))
  return table


def get_contents():
  contents = ''
  if session:
    if session['name']:
      name = session['name']
      item = CsvItem.query.filter_by(name=name).first()
      if item:
        contents = item.contents
  return contents

@app.route('/')
def index():
  error = request.args.get('error')
  contents = get_contents()
  content_table = break_down_csv(contents)

  return render_template('index.html', contents=contents, content_table=content_table, error=error)


@app.route('/update', methods=['POST'])
def update():

  # Update the CSV data
  if session and session['name']:
    name = session['name']
    item = CsvItem.query.filter_by(name=name).first()
    contents = request.form['contents']
    if item and contents:
      print(item)
      print(contents)

      item.contents = contents
      db.session.add(item)
      db.session.commit()

  return redirect(url_for('index'))


@app.route('/export')
def export():
  contents = get_contents()

  # Return a CSV file
  response = make_response(contents)
  response.mimetype = 'text/csv'
  return response


ALLOWED_EXTENSIONS = set(['csv'])

def allowed_file(filename):
  return '.' in filename and \
    filename.rsplit('.', 1)[1] in ALLOWED_EXTENSIONS

@app.route('/upload', methods=['GET', 'POST'])
def upload():
  error = 'Upload failed. '

  if request.method == 'POST':
    file = request.files['file']
    if file and allowed_file(file.filename):
      filename = secure_filename(file.filename)
      print("filename: " + filename)

      contents = file.read()

      print("CONTENTS: {}".format(contents))

      # Do nothing if file already exists
      item = CsvItem.query.filter_by(name=filename).first()
      if item is None:
        item = CsvItem(contents, filename)
        db.session.add(item)
        db.session.commit()

      session['name'] = item.name

      return redirect(url_for('index', name=item.name))
    else:
      error = 'File is invalid. '

  return redirect(url_for('index', error=error))

if __name__ == '__main__':
  app.run(host='0.0.0.0', debug=True)

