// NodeJS HTTP content scraper.
var client = require('./client');
var path = require('path');
var fs = require('fs');


var SAVE_DIR = 'saves/';

var saveToFile = function (filePath, data) {
  fs.writeFile(
    filePath,
    JSON.stringify(data, null, 2),
    function(error) {
      if (error) {
        console.error(error);
      }
      else {
        console.log('Saved ' + filePath);
      }
    }
  );
}


var saveFromHttp = function (url) {
  console.log('Getting ' + url);

  // Get the file name from the URL
  var info = path.parse(url);
  var fileName = info.base;

  if (fileName) {
    client.request(
      url,
      function saveJsonData(data) {
        saveToFile(path.resolve(SAVE_DIR, fileName), data);
      }
    );
  }
}

var urlRegex = /\b(https?|ftp|file):\/\/[\-A-Za-z0-9+&@#\/%?=~_|!:,.;]*[\-A-Za-z0-9+&@#\/%=~_|‌​]/ig
var jsonRegex = /.*\.json/i;

var succeed = function (data) {
  if ('string' === typeof data) {

    console.log('response length = ' + data.length);

    var matches = data.match(urlRegex);
    for (var i = 0; i < matches.length; i++) {
      var m = matches[i];

      if (m.match(jsonRegex)) {
        saveFromHttp(m);
      }
    }
  }
}

// Scrape a page for .json URLs
client.request(
  'http://catalog.data.gov/dataset/nist-its-90-thermocouple-database-srd-60',
  function (data) {
    succeed(data);
  }
);

