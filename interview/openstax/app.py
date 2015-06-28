from flask import Flask, render_template, request, url_for, redirect, make_response, session
from flask.ext.sqlalchemy import SQLAlchemy
from werkzeug import secure_filename

import os


app = Flask(__name__)
# app.config.from_object(os.environ['APP_SETTINGS'])
# db = SQLAlchemy(app)

# from models import Result


@app.route('/')
def index():
  contents = request.args.get('contents')
  error = request.args.get('error')
  return render_template('index.html', contents=contents, error=error)


@app.route('/update', methods=['POST'])
def update():
  text = request.args.get('text')
  #TODO Save an edit to database

  return text


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
      resp = make_response(contents)
      resp.mimetype = 'text/csv'

      # TODO Save to database

      return redirect(url_for('index', contents=contents))
    else:
      error = 'File is invalid. '

  return redirect(url_for('index', error=error))

if __name__ == '__main__':
  app.secret_key = 'OpenStax homework for George Chen'
  app.run(host='0.0.0.0', debug=True)

