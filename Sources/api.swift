//
// Created by Erik Little on 5/11/17.
//

import Foundation
import PerfectLib
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

func handleUserCreate(request: HTTPRequest, response: HTTPResponse) {
    guard let firstname = request.param(name: "firstname"),
          let lastname = request.param(name: "lastname"),
          let email = request.param(name: "email") else {
        response.completed(status: .badRequest)

        return
    }

    let trimmedEmail = email.trimmingCharacters(in: .whitespaces)

    guard trimmedEmail != "" else {
        response.completed(status: .badRequest)

        return
    }

    let user = User()

    user.firstname = firstname
    user.lastname = lastname
    user.email = trimmedEmail

    do {
        try user.save()

        response.setBody(string: "Created!")
        response.completed()
    } catch {
        Log.error(message: "Could not create user \(request.params())")

        response.completed(status: .internalServerError)
    }
}
