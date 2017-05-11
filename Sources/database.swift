//
// Created by Erik Little on 5/11/17.
//

import Foundation
import MySQL
import PerfectLib

enum DatabaseError : Error {
    case alterTableError(String)
    case connectionError
    case tableCreationError(String)
}

func createTables() throws {
    Log.info(message: "Creating the tables")

    try withDb {db in
        Log.info(message: "Creating user table")

        let success = db.query(statement: "create table if not exists users(" +
                                          "id int not null AUTO_INCREMENT PRIMARY KEY," +
                                          "firstname VARCHAR(255) not null," +
                                          "lastname VARCHAR(255) not null)")

        guard success else {
            Log.error(message: "User Errors: \(db.errorMessage())")

            throw DatabaseError.tableCreationError("users")
        }
    }
}

func updateTables() throws {
    Log.info(message: "Updating the tables")

    try withDb {db in
        Log.info(message: "Altering user table: Adding email")

        let success = db.query(statement: "alter table users add column email VARCHAR(100) unique not null")

        if !success {
            Log.error(message: "User Errors: \(db.errorMessage())")
        }
    }
}

func withDb(execute: (MySQL) throws -> ()) throws {
    let mysql = MySQL()

    guard mysql.connect(host: dbHost, user: dbUser, password: dbPassword, db: db, port: UInt32(dbPort)) else {
        throw DatabaseError.connectionError
    }

    defer { mysql.close() }

    try execute(mysql)
}
