#require "ws2812.class.nut:1.0"

hardware.spi257.configure(MSB_FIRST, 7500);
pixels <- WS2812(hardware.spi257, 5);

function get(i, val) {
	if (i < 2 && (val & 2)) {
		return [ 0, 40, 0 ];
	} else if (i > 2 && (val & 1)) {
		return [ 40, 0, 0 ];
	} else {
		return [ 0, 0, 0 ];
	}
}

function vis(val) {
	for (local i = 0 ; i < 5 ; ++i) {
		pixels.writePixel(i, get(i, val));
	}
	pixels.writeFrame();
}

agent.on("vis", vis);
