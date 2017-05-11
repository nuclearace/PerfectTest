import PerfectLib
import PerfectHTTP
import PerfectHTTPServer
import MySQLStORM

MySQLConnector.host = dbHost
MySQLConnector.username = dbUser
MySQLConnector.password = dbPassword
MySQLConnector.database = db
MySQLConnector.port = dbPort

try createTables()
try updateTables()

let server = HTTPServer()
var routes = Routes()

addWebRoutes(&routes)
addJavaScriptRoutes(&routes)
addApiRoutes(&routes)

server.serverPort = 8181
server.addRoutes(routes)

do {
    try server.start()
} catch let PerfectError.networkError(err, message) {
    print(message)
}
