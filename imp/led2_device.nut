#require "ws2812.class.nut:1.0"

hardware.spi257.configure(MSB_FIRST, 7500);
pixels <- WS2812(hardware.spi257, 5);

function get(i, val) {
	if (val) {
		return [ 40, 40, 40 ];
	} else {
		return [ 0, 0, 0 ];
	}
}

function vis(val) {
	for (local i = 0 ; i < 5 ; ++i) {
		pixels.writePixel(i, val & (1 << i));
	}
	pixels.writeFrame();
}

agent.on("val", vis);
