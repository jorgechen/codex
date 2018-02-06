// NodeJS HTTP content scraper.
const path = require('path');
const fs = require('fs');
const url = require('url')
const _ = require('lodash')
const axios = require('axios');
const program = require('commander');

////////////////////////////////////////
// arguments
////////////////////////////////////////

const defaults = {
  saveDirectory: 'saves/',
  url: 'https://game.capcom.com/cfn/sfv/character',
  // url: 'http://ki.infil.net/images/',
  // url: 'http://catalog.data.gov/dataset/nist-its-90-thermocouple-database-srd-60',
  extensions: 'json',
  cookie: 'scirid=OFIyX2NUX29089tV9PkIF6r-X7hY9p82PH21ivgdqM4IAFhuo0VXG8IC359AaafvuyLFxw_HxVUx1LARUYx3BXA4c3E3bENtbnUxSlFQRWVOVjhNaDc2WnMtYS1lSzh0Rk84QTcxaXdvM2M; language=en',
}

program
  .version('0.0.1')
  .option('-d, --dir [directory]', `Local directory to save to [${defaults.saveDirectory}]`, defaults.saveDirectory)
  .option('-e, --ext [extensions]', 'File extensions to filter for, separated by , or |', defaults.extensions)
  .option('-u, --url [url]', `The root URL to request ${defaults.url}`, defaults.url)
  .option('-c, --cookie [cookie]', `The CFN cookie`, defaults.cookie)
  .parse(process.argv)

const extensions = _.split(program.ext, /[,\|]/).join('|')

console.log('Arguments:')
console.log('-directory %s ', program.dir)
console.log('-extensions %s ', extensions)
console.log('-url %s ', program.url)

console.log(extensions)

const site = program.url
const directory = program.dir
const filterRegex = new RegExp(`.*\\.(${extensions})`, 'i')
const cookieHeader = [program.cookie]

const responseType = extensions.match(/png|jpg|gif/) ? 'stream' : 'text'

////////////////////////////////////////
////////////////////////////////////////
var saveFromHttp = (url) => {
  console.log(`Getting ${url}`);

  // Get the file name from the URL
  var info = path.parse(url);
  var fileName = _.chain(info.base).split('?').first().value();

  if (fileName) {
    axios({
      method: 'get',
      url,
      responseType,
    }).then(response => {
      if (response.status === 200) {
        const location = path.resolve(directory, fileName)
        console.log('Saving' + location);
        return response.data.pipe(fs.createWriteStream(location))
      }
      return Promise.reject(new Error(`${response.status} ${response.statusText}`))
    }).catch((err) => {
      console.error(err);
    })
  }
}

var succeed = function (data, home) {
  if ('string' === typeof data) {
    console.log('response char length = ' + data.length);
    const links = []

    // Try to find all the complete URLs
    var urlMatches = data.match(/\b(https?|ftp|file):\/\/[\-A-Za-z0-9+&@#\/%?=~_|!:,.;]*[\-A-Za-z0-9+&@#\/%=~_|‌​]/ig);
    if (urlMatches) {
      for (var i = 0; i < urlMatches.length; i++) {
        var m = urlMatches[i];

        links.push(m)
      }
    }

    // Try to find all the hrefs
    const hrefMatches = data.match(/<a [^<>]*href=["'][^<>]+['"]/g)
    if (hrefMatches) {
      _.each(hrefMatches, href => {
        const possibleLink = href.match(/href=["']([^<>]+)['"]/)[1]
        if (!_.includes(links, possibleLink)) {
          const l = url.resolve(home, possibleLink)
          links.push(l)
        }
      })
    }

    // Finally we got all the links!
    _.each(_.uniq(links), link => {
      const m = link.match(filterRegex)
      if (m) {
        saveFromHttp(link);
      }
    })
  }
}

axios.get(site, {
  headers: {
    Cookie: cookieHeader,
  },
}).then(response => {
  if (response.status === 200) {
    return succeed(response.data, site)
  }
  return Promise.reject(new Error(`Error from the request GET ${site}`))
}).catch((err) => {
  console.error(err);
})
