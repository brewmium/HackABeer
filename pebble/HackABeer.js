/**
 * Welcome to Pebble.js!
 *
 * This is where you write your app.
 */

var UI = require('ui'),
    type = '',
    cards = {
      main: new UI.Card({
        title: 'Hack a Beer',
        subtitle: 'We\'re promise I fine.'
      }),
      pale: new UI.Card({
        title: 'Pale'
      }),
      ipa: new UI.Card({
        title: 'IPA'
      }),
      team: new UI.Card({
        title: 'Team'
      })
    };

initNewCard(cards.main);

function onUpClick () {
  type = 'pale';
  initNewCard(cards.pale);
}

function onDownClick () {
  type = 'ipa';
  initNewCard(cards.ipa);
}

function onMiddleClick () {
  type = '';
  initNewCard(cards.main);
}

function initNewCard(card) {
  card.subtitle(cards.position);
  getAPIData(card);
  card.show();
  card.on('click', 'up', onUpClick);
  card.on('click', 'select', onMiddleClick);
  card.on('click', 'down', onDownClick);
}

function getAPIData (card) {
  var req = new XMLHttpRequest(),
      url = "http://54.237.120.219/",
      response;

  req.open('GET', url, true);
  req.onload = function(e) {
    if (req.readyState == 4 && req.status == 200) {
      if(req.status == 200) {
        response = JSON.parse(req.responseText);

        if (type === 'pale') {
          card.body(
            response.countPale + ' beers served' + '\n' +
            Math.round(response.tempPale * 1.8 + 32*100)/100 + '°' + '\n' +
            parseInt(response.sincePale / 60) + ':' + response.sincePale % 60 + ' idle tap'
          );
        } else if (type === 'ipa') {
          card.body(
            response.countIPA + ' beers served' + '\n' +
            Math.round(response.tempIPA * 1.8 + 32*100)/100 + '°' + '\n' +
            parseInt(response.sinceIPA / 60) + ':' + response.sinceIPA % 60 + ' idle tap'
          );
        }
      } else {
        console.log('Error');
      }
    }
  };
  req.send(null);
}
