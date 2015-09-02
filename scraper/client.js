/* Module dependencies
 */
var http       = require("http");
// TODO var https      = require("https");

"use strict";

var Logger     = {
  trace: function (message) {
    console.log(message);
  }
};

process.env.NODE_TLS_REJECT_UNAUTHORIZED = "0";

/**
 * @brief Client interface to make RIS server requests.
 * @param initialDomain
 * @param initialPort
 * @constructor
 */
function Client( initialDomain, initialPort ) {

   var self = this;

   // Default timeout in milliseconds
   var DEFAULT_TIMEOUT = 8000;

   /**
    * @brief Customizable hostname of RIS server target
    * @type {string} hostname string
    */
   var domain = initialDomain;

   /**
    * @brief getter
    */
   this.getHostname = function () {
      return domain;
   };

   /**
    * @brief setter
    */
   this.setHostname = function( newHostname ) {
      domain = newHostname;
   };


   /**
    * @brief Customizable port number
    * @type {number} port number
    */
   var port = 'number' === typeof initialPort ? initialPort : 80;

   /**
    * @brief getter
    */
   this.getPort = function () {
      return port;
   };



   /**
    * @brief Send a GET request.
    * @param path
    * @param responseCallback callback to use if request succeeds
    * @param errorCallback callback to use if request fails
    */
   this.getRequest = function (path, responseCallback, errorCallback) {
      request("GET", path, responseCallback, errorCallback);
   };

   /**
    * @brief Send a PATCH request.
    * @param path
    * @param parameters
    * @param responseCallback callback to use if request succeeds
    * @param errorCallback callback to use if request fails
    */
   this.patchRequest = function (path, parameters, responseCallback, errorCallback) {
      requestWithData(path, parameters, responseCallback, errorCallback, "PATCH");
   };

   /**
    * @brief Send a POST request.
    * @param path
    * @param parameters
    * @param responseCallback callback to use if request succeeds
    * @param errorCallback callback to use if request fails
    */
   this.postRequest = function (path, parameters, responseCallback, errorCallback, timeout) {
      requestWithData(path, parameters, responseCallback, errorCallback, "POST", timeout);
   };

   /**
    * @brief Send a DELETE request.
    * @param path
    * @param responseCallback callback to use if request succeeds
    * @param errorCallback callback to use if request fails
    */
   this.deleteRequest = function (path, responseCallback, errorCallback) {
      request("DELETE", path, responseCallback, errorCallback);
   };

   /**
    * @brief Response callback
    */
   function processResponse( response, successCallback, failureCallback ) {
      var json = null;
      var body = "";

      // 200 - status ok
      // 201 - resource created

      if ( 2 === Math.floor( response.statusCode/100 ) ) {
         response.setEncoding("utf8");

         // Process each chunk of data received
         response.on(
            "data",
            function onResponseIncomingData( data ) {
               body += data;
            }
         );

         response.on(
            "end",
            function onResponseEnd() {
              successCallback(body);
            }
         );
      }
      else {
         failureCallback(
            http.STATUS_CODES[response.statusCode] +
            "\nStatus code: " + response.statusCode );
      }
   }

   /**
    * @brief Sends a request with data.
    * @param path
    * @param parameters
    * @param responseCallback callback to use if request succeeds
    * @param errorCallback callback to use if request fails
    * @param methodName - POST or PATCH
    */
   function requestWithData (path, parameters, responseCallback, errorCallback, methodName, timeout) {

      var post_data = JSON.stringify(parameters);

      var options = {
         hostname: domain,
         port: port,
         path: path,
         method: methodName,
         headers: {
            "Content-Type": "application/json",
            "Content-Length": post_data.length
         }
      };

      Logger.trace( "New request " + JSON.stringify(options) );

      // Request and callback
      var request = http.request(
         options,
         function onResponse( response ) {
            processResponse( response, responseCallback, errorCallback );
         }
      );

      // Set timeout
      if ( typeof timeout === "undefined" ) {
         timeout = DEFAULT_TIMEOUT; // default
      }
      else {
         Logger.trace("Post request custom timeout: " + timeout + " msecs.");
      }
      request.on(
         "socket",
         function ( socket ) {
            socket.setTimeout(timeout);
            socket.on(
               "timeout",
               function() {
                  request.end();
               }
            );
         }
      );

      // Response error callback
      request.on("error", errorCallback);

      // Write data
      request.write(post_data);

      request.end();
   };


   /**
    * @brief Generic method to handle requests
    * @param method
    * @param path
    * @param responseCallback
    * @param errorCallback
    */
   function request (method, path, responseCallback, errorCallback) {
      var options = {
         hostname: domain,
         port: port,
         path: path,
         method: method
      };

      Logger.trace( "New request " + JSON.stringify(options) );

      // Request and callback
      var newRequest = http.request(
         options,
         function onResponse( response ) {
            processResponse( response, responseCallback, errorCallback );
         }
      );

      // Set timeout
      newRequest.on(
         "socket",
         function ( socket ) {
            socket.setTimeout( DEFAULT_TIMEOUT );
            socket.on(
               "timeout",
               function() {
                  newRequest.abort();
               }
            );
         }
      );

      // Response error callback
      newRequest.on(
         "error",
         function onError( error ) {
            errorCallback( JSON.stringify(error) );
         }
      );

      newRequest.end();
   };
};


/* Exports
 */
module.exports = Client;
