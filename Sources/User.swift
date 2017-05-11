//
// Created by Erik Little on 5/11/17.
//

import Foundation
import MySQLStORM
import StORM

class User : MySQLStORM {
    var id: Int = 0
    var firstname: String = ""
    var lastname: String = ""
    var email: String = ""

    // Unfortunately necessary due to Swift's introspection limitations
    func rows() -> [User] {
        var rows = [User]()

        for i in 0..<self.results.rows.count {
            let row = User()
            row.to(self.results.rows[i])
            rows.append(row)
        }

        return rows
    }

    override open func table() -> String {
        return "users"
    }

    override func to(_ this: StORMRow) {
        id = this.data["id"] as? Int ?? 0
        firstname = this.data["firstname"] as? String ?? ""
        lastname = this.data["lastname"] as? String	?? ""
        email = this.data["email"] as? String ?? ""
    }
}
