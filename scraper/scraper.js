// NodeJS HTTP content scraper.
var path = require('path');
var fs = require('fs');
const url = require('url')
const _ = require('lodash')
const axios = require('axios');

////////////////////////////////////////
// variables
////////////////////////////////////////
const SAVE_DIR = 'sfv/';
const site = 'http://ki.infil.net/images/'
// const target = 'http://catalog.data.gov/dataset/nist-its-90-thermocouple-database-srd-60',
// const filterRegex = /.*\.json/i;
const filterRegex = /.*\.(gif|png|jpg)/i;


////////////////////////////////////////
////////////////////////////////////////
var saveFromHttp = function (url) {
  console.log('Getting ' + url);

  // Get the file name from the URL
  var info = path.parse(url);
  var fileName = info.base;

  if (fileName) {
    axios({
      method: 'get',
      url,
      responseType: 'stream',
    }).then(response => {
      if (response.status === 200) {
        const location = path.resolve(SAVE_DIR, fileName)
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

axios.get(site).then(response => {
  if (response.status === 200) {
    return succeed(response.data, site)
  }
  return Promise.reject(new Error(`Error from the request GET ${site}`))
}).catch((err) => {
  console.error(err);
})
