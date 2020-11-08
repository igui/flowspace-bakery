// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$(() => {
  if(!window.ovenCookieId) {
    return;
  }

  window.App.cable.subscriptions.create({ 
    channel: "CookieChannel", cookie_id: window.ovenCookieId },
    { 
      received: (data) => { 
        // Show the cookie when ready
        console.log(`Recevied data ${JSON.stringify(data)}`);
        if(data && data.ready) {
          $('#cookie_status, #retrieve_cookie').show();
        }
      }
    });
});