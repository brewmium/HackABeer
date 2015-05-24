#require "Si702x.class.nut:1.0.0"

hardware.i2c89.configure(CLOCK_SPEED_400_KHZ)
local sensor = Si702x(hardware.i2c89)
 
function poll() {
    sensor.read(function(reading) {
        agent.send("data", reading)
        imp.wakeup(1, poll);
    });
}

poll();
