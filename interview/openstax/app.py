from flask import Flask, render_template, request
from flask.ext.sqlalchemy import SQLAlchemy
import os


app = Flask(__name__)
# app.config.from_object(os.environ['APP_SETTINGS'])
# db = SQLAlchemy(app)

# from models import Result


@app.route('/')
def index():
  return render_template('index.html')


@app.route('/<name>')
def hello_name(name):
  return "Hello {}!".format(name)


def allowed_file(filename):
  return '.' in filename and \
    filename.rsplit('.', 1)[1] in ['.csv']


@app.route('/upload', methods=['POST'])
def upload():
  if request.method == 'POST':
    f = request.files['file']
    if f


  result = 'File upload was processed. '

  file = request.args.get('file')
  session_id = request.args.get('session_id')
  print(file)
  print(session_id)
  print(request.args.get('a'))

  from pprint import pprint
  print("args:")
  pprint(request.args)
  print("files:")
  pprint(request.files)
  print("form:")
  pprint(request.form)
  print("data:")
  pprint(request.data)

    # file = request.files['file']
    # print(file)
  #   if file and allowed_file(file.filename):
  #     filename = secure_filename(file.filename)
  #     print("filename: " + filename)

  #     # Save to database

  # else:
  #   result = 'Not a POST request. '



  return result

if __name__ == '__main__':
  app.secret_key = 'OpenStax homework for George Chen'
  app.run(host='0.0.0.0', debug=True)

