import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

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
