//
//  JySqliteTest.swift
//  JerryKit
//
//  Created by Jayyi on 2020/10/3.
//  Copyright © 2020 Jerry987123. All rights reserved.
//

class JySqliteTest {
    
    let tableName = "ATable"
    func test(){
//        dprint(NSHomeDirectory())
//        createTable()
//        let obj1 = SqliteTestData(string: "abc", number: 1, double: 1.1)
//        let obj2 = SqliteTestData(string: "def", number: 2, double: 2.2)
//        insert(data: [obj1, obj2])
//        let query = read(cond: "string = 'abc'", order: nil)
//        dprint("query=", query)
//        update(string: "abc", number: 3, double: 3.3)
//        undateMulti(keys: ["string"], column: "number", datas: ["('abc',4)","('def',5)"])
//        deleteTable(cond: nil)
    }
    func createTable(){
        let db = JySqlite()
        _ = db.createTable(tableName: tableName,
                        columns: [
                            "string TEXT PRIMARY KEY NOT NULL",
                            "number Integer NULL",
                            "double Real NULL"])
        db.closeDb()
    }
    func insert(data:[SqliteTestData]){
        let db = JySqlite()
        var sqls:[[String:String]] = []
        for d in data {
            var sql:[String:String] = [:]
            sql["string"] = "'\(d.string)'"
            sql["number"] = "\(d.number)"
            sql["double"] = "\(d.double)"
            sqls.append(sql)
        }
        let result = db.insertOrReplace(tableName: tableName, rows: sqls)
        dprint("insert \(tableName) is \(result)")
        db.closeDb()
    }
    func read(cond:String?, order:String?)->[SqliteTestData]{
        var ary:[SqliteTestData] = []
        let db = JySqlite()
        let statement = db.fetch(tableName: tableName, cond: cond, order: order)
        while sqlite3_step(statement) == SQLITE_ROW {
            var result = SqliteTestData()
            result.string = String(cString: sqlite3_column_text(statement, 0))
            result.number = Int(sqlite3_column_int(statement, 1))
            result.double = Double(sqlite3_column_double(statement, 2))
            ary.append(result)
        }
        sqlite3_finalize(statement)
        db.closeDb()
        return ary
    }
    func update(string:String, number:Int, double:Double){
        let db = JySqlite()
        let table = tableName
        var cond = ""
        var rows:[String:String]  = [:]
        cond = "string = '\(string)'"
        rows = ["number":"\(number)", "double":"\(double)"]
        let state = db.update(tableName: table, cond: cond, rows: rows)
        dprint("update \(tableName) is \(state)")
        db.closeDb()
    }
    func undateMulti(keys:[String], column:String, datas:[String]) {
        let db = JySqlite()
        let table = tableName
        var tmp = "("
        for k in keys {
            tmp += "\(k),"
        }
        tmp += "\(column))"
        var columns:[String] = []
        columns.append(column)
        var values:[String] = []
        for d in datas {
            values.append(d)
        }
        let state = db.updateMulti(table: table, tmp: tmp, keys: keys, columns: columns, values: values)
        dprint("undateMulti \(tableName) is \(state)")
        db.closeDb()
    }
    func deleteTable(cond:String?){
        let db = JySqlite()
        _ = db.delete(tableName: tableName, cond: cond)
        db.closeDb()
    }
}
struct SqliteTestData {
    var string = ""
    var number = 0
    var double = 0.0
}
