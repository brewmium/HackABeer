#require "rocky.class.nut:1.1.1"

local app = Rocky();
local data = { temp=null, humidity=null };

device.on("data", function(deviceData) {
	data = deviceData;
});

app.get("/", function(context) {
	context.send(200, { message = "off" });
});
app.get("/data", function(context) {
	context.send(200, data);
});
