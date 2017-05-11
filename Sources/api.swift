//
// Created by Erik Little on 5/11/17.
//

import Foundation
import PerfectHTTP

func handleNameEcho(request: HTTPRequest, response: HTTPResponse) {
    guard let name = request.param(name: "name") else {
        response.completed(status: .badRequest)

        return
    }

    do {
        try response.setBody(json: ["name": name])

        response.completed()
    } catch {
        response.completed(status: .internalServerError)

        return
    }
}
