#!/usr/bin/env node

import http from "unit-http";

http.createServer(async function (request, response) {
    response.writeHead(200, { "Content-Type": "text/html" });
    const {x} = await import('./modules/dynamic.js');
    response.end("Hello, Node.js on Unit!" + x)
}).listen();
