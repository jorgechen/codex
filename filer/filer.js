var fs = require('fs');
var path = require('path');
var nodefs = require('node-fs');
var _ = require('underscore');

Filer = {};


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

Filer.getAbsoluteFilePaths = function (fullPath, options) {
  var self = this;
  var isRecursive = options && options.recursive;
  var extensionFilter = options && options.extension;

  // DFS
  var files = [];

  var list = [fullPath];

  do {
    var head = list.pop();

    if (self.isFile(head)) {
      // This is a file
      files.push(head);
    }
    else if (head) {
      var children = this.getDirectoryChildren(head);

      // Prepend the full path of parent directory
      children = children.map(function (child) {
        return path.join(head, child);
      });

      // This is a directory, so continue thru its children
      list.push.apply(list, children);
    }
  } while (0 < list.length && isRecursive);


  // Accept an extension
  if (extensionFilter) {
    files = files.filter(function (f) {
      var extension = path.extname(f);
      return extensionFilter === extension;
    });
  }

  return files;
}

Filer.readFile = function (path, callback) {
  var contents = '';
  try {
    contents = fs.readFileSync(path);
  }
  catch (exception) {}
  return contents;
};


Filer.saveFile = function (filePath, data) {
  fs.writeFile(
    filePath,
    data,
    function(error) {
      if (error) {
        console.error(error);
      }
      else {
        console.log('Saved ' + filePath);
      }
    }
  );
};


Filer.filterFileContent = function (fullPath, filterCallback, options) {
  var self = this;

  var outputDirectory = path.join(process.cwd(), 'output');
  console.log(outputDirectory);

  var filePaths = self.getAbsoluteFilePaths(fullPath, options);
  console.log(filePaths);

  _.each(filePaths, function (p) {
    console.log('Reading ' + p);

    var relativePath = path.relative(fullPath, p);
    var outputPath = path.join(outputDirectory, relativePath);

    // Create folder if it doesn't exist yet
    var relativeOutputDirectory = path.join(outputDirectory, path.dirname(relativePath));
    nodefs.mkdirSync(relativeOutputDirectory, '0777', true);

    // Now filter the content if needed and write it there
    var content = Filer.readFile(p);
    if (content) {
      var filteredContent = filterCallback(content, fullPath, outputPath);
      self.saveFile(outputPath, filteredContent);
    }
  });
}

module.exports = Filer;
