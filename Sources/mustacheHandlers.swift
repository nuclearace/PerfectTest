//
// Created by Erik Little on 5/11/17.
//

import Foundation
import PerfectMustache

class HelloPageRenderer : MustachePageHandler {
    func extendValuesForResponse(context contxt: MustacheWebEvaluationContext,
                                 collector: MustacheEvaluationOutputCollector) {
        contxt.extendValues(with: ["name": contxt.webRequest.urlVariables["name"] ?? ""])

        do {
            try contxt.requestCompleted(withCollector: collector)
        } catch {
            let response = contxt.webResponse
            response.status = .internalServerError
            response.appendBody(string: "\(error)")
            response.completed()
        }
    }
}

