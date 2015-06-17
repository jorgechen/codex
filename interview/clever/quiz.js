var https = require('https');

var options = {
  method: 'GET',
  hostname: 'api.clever.com',
  path: '/v1.1/sections?count=true',
  headers: {
    Authorization: 'Bearer DEMO_TOKEN'
  }
};

var request = https.request(
  options, 
  function(response) { 
    response.setEncoding('utf8');
    response.on('data',
      function (chunk) {
        console.log(chunk);
      }
    )
  }
);

request.end();
