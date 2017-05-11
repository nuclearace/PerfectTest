//
// Created by Erik Little on 5/11/17.
//
import Foundation
import PerfectHTTP
import PerfectMustache

func addJavaScriptRoutes(_ routes: inout Routes) {
    routes.add(method: .get, uri: "/js/**", handler: {request, response in
        let handler = StaticFileHandler(documentRoot: "./web/js/")

        request.path = request.urlVariables[routeTrailingWildcardKey] ?? ""

        handler.handleRequest(request: request, response: response)
    })
}

func addApiRoutes(_ routes: inout Routes) {
    routes.add(method: .get, uri: "/api/name/echo/", handler: handleNameEcho)
}

func addWebRoutes(_ routes: inout Routes) {
    routes.add(method: .get, uri: "/", handler: handleWebDir)
    routes.add(method: .get, uri: "/index.html", handler: handleWebDir)
    routes.add(method: .get, uri: "/{name}/hello.html", handler: handleHello)
}

func handleWebDir(request: HTTPRequest, response: HTTPResponse) {
    let handler = StaticFileHandler(documentRoot: "./web/")

    handler.handleRequest(request: request, response: response)
}

func handleHello(request: HTTPRequest, response: HTTPResponse) {
    mustacheRequest(request: request, response: response, handler: HelloPageRenderer(),
                    templatePath: "./web/index.html")
}
