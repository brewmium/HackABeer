var Relayr = require('relayr');
var express = require('express');
var https = require('https');
var fs = require('fs');

var app = express()

var app_id = "a0eb4abd-6eb8-444c-ae23-d497bfd10025";
var token = "I3hsyjxeq4D_yhDghdcAIBGTYqPGr4jB";

var leds = 0;

var relayr = new Relayr(app_id);

relayr.connect(token, "322f4dbc-2d95-49f0-bdb3-6ed351758598");
relayr.connect(token, "ba92052a-d355-4652-a5c0-d8250df525c8");
relayr.connect(token, "56327c0a-3c96-4490-9266-5523a5b724eb");

var bouncePale = { state: false, since: Date.now() };
var bounceIPA = { state: false, since: Date.now() };

var state = require("./beer");
state.pullPale = false;
state.pullIPA = false;
if (!state.lastPale) {
	state.lastPale = Date.now();
}
if (!state.lastIPA) {
	state.lastIPA = Date.now();
}

function readTemp() {
	var options, body;

	options = {
		host: 'agent.electricimp.com',
		port: 443,
		path: '/NoIVacpIHfnG/data',
		method: 'GET',
	};

	body = "";

	var req = https.request(options, function(res) {
		res.on('data', function(d) {
			body += d;
		});

		res.on('end', function() {
			var	data = JSON.parse(body);

			state.tempPale = data.temperature;
		});
	});
	req.end();

	req.on('error', function(e) {
		console.error(e);
	});
}

setInterval(readTemp, 3000);

function setBounce(bounce, p) {
	return p;
}

function setPull(bounce, pull, count, time) {
	var	cur = state[pull];

	if (bounce && !cur) {
		++state[count];
		state[time] = Date.now();

		save();
	}

	state[pull] = bounce;
}

function save() {
	var	beer;

	beer = "module.exports = " + JSON.stringify(state) + ";"

	fs.writeFile("./beer.js", beer, function(err) {
		if(err) {
			return console.log(err);
		}
	});
}

relayr.on('data', function (topic, msg) {
		var i, l;

		for (i = 0 ; i < msg.readings.length ; ++i) {
				var m = msg.readings[i];

				if (m.meaning == "proximity") {
					setPull(setBounce(bouncePale, m.value < 1000), "pullPale", "countPale", "lastPale");
				} else if (m.meaning == "acceleration") {
					console.log("r=" + Math.atan2(m.value.y, m.value.x));
					setPull(setBounce(bounceIPA, Math.atan2(m.value.y, m.value.x) < -0.1), "pullIPA", "countIPA", "lastIPA");
				} else if (m.meaning == "temperature") {
					state.tempIPA = m.value;
				}
		}

	l = 0;
	if (state.pullPale)
		l += 1;
	if (state.pullIPA)
		l += 2;
	if (l != leds) {
		var options;

		leds = l;

		options = {
			host: 'agent.electricimp.com',
			port: 443,
			path: '/kL90EDF3atru?i=' + l,
			method: 'GET',
		};

		var req = https.request(options, function(res) {
			res.on('data', function(d) {
			});
		});
		req.end();

		req.on('error', function(e) {
			console.error(e);
		});
	}
});

app.get('/', function (req, res) {
	state.sincePale = Math.floor((Date.now() - state.lastPale) / 1000);
	state.sinceIPA = Math.floor((Date.now() - state.lastIPA) / 1000);

	res.send(JSON.stringify(state));
})

app.listen(80);
