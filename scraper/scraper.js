
// NodeJS HTTP content scraper.
  var Client = require('./client');

  var client = new Client('catalog.data.gov');

  client.getRequest(
    '/dataset/nist-its-90-thermocouple-database-srd-60',
    function onSuccess(data) {
      console.log('success');
      console.log(data);
    },
    function onError(error) {
      console.log('error')
      console.log(error);
    }
  );

