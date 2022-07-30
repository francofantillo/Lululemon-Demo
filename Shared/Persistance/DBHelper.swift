//
//  DBHelper.swift
//  Lululemon Demo
//
//  Created by Franco Fantillo on 2022-07-29.
//

import Foundation
import UIKit
import SQLite3
import SwiftUI


class DBHelper {
    
    let TABLE_NAME = "Garments"
    let DATE_VAR = "date"
    let NAME_VAR = "name"
   
    var db: OpaquePointer?
    
    private func openConnection(){
        
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("Inventory.sqlite")
        
        let openCode = sqlite3_open(fileURL.path, &db)
        if openCode == SQLITE_OK {
            print("Successfully opened connection to database at \(fileURL)")
        } else {
            print("Unable to open database.")
        }
    }
    
    private func createTable(){
        
        let createTableString = """
            CREATE TABLE IF NOT EXISTS \(TABLE_NAME) (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            \(NAME_VAR) VARCHAR,
            \(DATE_VAR) VARCHAR)
        """
    
        var createTableStatement: OpaquePointer?
        
        let createCode = sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil)
        if createCode == SQLITE_OK {

          if sqlite3_step(createTableStatement) == SQLITE_DONE {
            print("\nItems table created.")
          } else {
            print("\nItems table is not created.")
          }
        } else {
          print("\nCREATE TABLE statement is not prepared.")
        }

        sqlite3_finalize(createTableStatement)
    }
    
    private func readTable() -> [Garment]{
        
        var storedGarments = [Garment]()
        
        let queryStatementString = "SELECT * FROM \(TABLE_NAME);"
        
        var queryStatement: OpaquePointer?
        let readCode = sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil)
        if readCode == SQLITE_OK {
              print("\n")
              while (sqlite3_step(queryStatement) == SQLITE_ROW) {
                  let id = sqlite3_column_int(queryStatement, 0)
                  guard let queryResultCol1 = sqlite3_column_text(queryStatement, 1) else {
                      print("Query result is nil.")
                      continue
                  }
                  guard let queryResultCol2 = sqlite3_column_text(queryStatement, 2) else {
                      print("Query result is nil.")
                      continue
                  }
                  let name = String(cString: queryResultCol1)
                  let dateString = String(cString: queryResultCol2)
                  let date = DateFunctions.convertStringToDate(dateString: dateString)
                  print("Query Result:")
                  print("\(id) | \(name)")
                  let garment = Garment(creationDate: date, name: name)
                  storedGarments.append(garment)
              }
        } else {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("\nQuery is not prepared \(errorMessage)")
        }
        sqlite3_finalize(queryStatement)
        return storedGarments
    }
    
    private func insertData(garments: [Garment]){
        
        let insertStatementString = "INSERT INTO \(TABLE_NAME) (\(NAME_VAR), \(DATE_VAR)) VALUES (?, ?);"
        
        var insertStatement: OpaquePointer?

        let prepareCode = sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil)
        
        if prepareCode == SQLITE_OK {

            for item in garments {

                let name = item.name as NSString
                let date = DateFunctions.convertDateToString(date: item.creationDate) as NSString

                sqlite3_bind_text(insertStatement, 1, name.utf8String , -1, nil)

                sqlite3_bind_text(insertStatement, 2, date.utf8String, -1, nil)

                let insertCode = sqlite3_step(insertStatement)
                print(insertCode)

                if insertCode == SQLITE_DONE {
                    print("\nSuccessfully inserted row.")
                } else {
                    print("\nCould not insert row.")
                }

                sqlite3_reset(insertStatement)
            }
            sqlite3_finalize(insertStatement)

        } else {
          print("\nINSERT statement is not prepared.")
        }
    }
    
    private func deleteData(){
        
        var deleteStatement: OpaquePointer?
        
        let deleteStatementString = "DELETE FROM \(TABLE_NAME)"
        
        if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) ==
              SQLITE_OK {
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
              print("\nSuccessfully deleted row.")
            } else {
              print("\nCould not delete row.")
            }
          } else {
            print("\nDELETE statement could not be prepared")
          }
          
          sqlite3_finalize(deleteStatement)
    }
    
    func readDatabase(garments: inout[Garment]) {
        
        garments.removeAll()
        openConnection()
        garments = readTable()
        sqlite3_close(db)
        print(garments)
    }
    
    func writeDatabase(garments: inout [Garment]) {

        openConnection()
        createTable()
        deleteData()
        insertData(garments: garments)
        sqlite3_close(db)
    }
}
