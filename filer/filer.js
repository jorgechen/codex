var fs = require('fs');
var path = require('path');

Filer = {};

Filer.getExtension = function (fileNameOrPath) {
  var extension = '';
  var parts = fileNameOrPath.split('.');
  if (1 < parts.length) {
    extension = parts.pop();
  }
  return extension;
}

Filer.isFile = function (location) {
  var stat = fs.lstatSync(location);
  return stat && stat.isFile();
}

Filer.isDirectory = function (location) {
  var stat = fs.lstatSync(location);
  return stat && stat.isDirectory();
}

// Immediate files/folders in current location
Filer.getDirectoryChildren = function (location) {
  var fileNames = [];
  if (this.isDirectory(location)) {
    fileNames = fs.readdirSync(location);
  }
  return fileNames;
}

Filer.getFiles = function (location, options) {
  var isRecursive = options && options.recursive;
  var extensionRequirement = options && options.extension;

  // DFS
  var files = [];

  var list = [location];

  do {
    var head = list.pop();

    if (this.isFile(head)) {
      // This is a file
      files.push(head);
    }
    else {
      var children = this.getDirectoryChildren(head);

      // This is a directory, so continue thru its children
      list.push.apply(list, children.map(function (child) {
        return path.join(head, child);
      }));
    }
  } while (0 < list.length && isRecursive);

  return files;
}

