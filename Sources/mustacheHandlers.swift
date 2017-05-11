//
// Created by Erik Little on 5/11/17.
//

import Foundation
import PerfectMustache

class HelloPageRenderer : MustachePageHandler {
    func extendValuesForResponse(context contxt: MustacheWebEvaluationContext,
                                 collector: MustacheEvaluationOutputCollector) {
        var values = MustacheEvaluationContext.MapType()

        values["name"] = contxt.webRequest.urlVariables["name"] ?? ""
        contxt.extendValues(with: values)

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

