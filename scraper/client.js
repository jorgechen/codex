var request = require('request');

var Client = {};
/**
 * @param url
 * @param sucessCallback When sucessful, it will callback(rawData)
 */
Client.request = function(url, sucessCallback) {
  request(
    url,
    function (error, response, body) {
      if (!error && response.statusCode == 200) {
        sucessCallback(body);
      }
      else {
        console.log('Failed ' + url + '\nError: ' + error + '\nResponse: ' + JSON.stringify(response.status));
      }
    }
  );
}

module.exports = Client;
