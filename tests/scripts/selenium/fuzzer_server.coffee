util = require('util')
connect = require('connect')
port = 1337
connect.createServer(
  connect.static(__dirname)
).listen(port)
util.puts("Listening on #{port}...")
