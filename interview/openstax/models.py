from server import db

class CsvItem(db.Model):
  id = db.Column(db.Integer, primary_key=True)
  contents = db.Column(db.String)
  name = db.Column(db.String)

  def __init__(self, contents, name):
    self.contents = contents
    self.name = name
  def __repr__(self):
    return '<id={}, name={}>'.format(self.id, self.name)
