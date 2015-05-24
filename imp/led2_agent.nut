function handler(req, resp) {
    if ("i" in req.query) {
        device.send("vis", req.query.i.tofloat());
    }
    resp.send(200, "Hello World");
}

http.onrequest(handler);
