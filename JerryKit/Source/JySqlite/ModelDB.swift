//
//  ModelDB.swift
//  JerryKit
//
//  Created by Jayyi on 2020/10/26.
//  Copyright © 2020 Jerry987123. All rights reserved.
//

struct ModelData: Codable {
    var id = 0
    var name = ""
    var file:String?
    var code:Int?
}

class ModelDB {
    let tableName = "modelTable"
        
    func createTable() -> Bool {
        let db = JySqlite()
        let primaryKeyIndex = 0 // PK
        var columns:[String] = []
        let mirror = Mirror(reflecting: ModelData()) // model
        for (index, data) in mirror.children.enumerated() {
            let valueType = type(of: data.value)
            guard let label = data.label else {
                dprint("readsql can't get label")
                continue
            }
            if valueType == String.self || valueType == Optional<String>.self {
                if index == primaryKeyIndex {
                    columns.append("\(label) Text PRIMARY KEY")
                } else {
                    columns.append("\(label) Text")
                }
            } else if valueType == Int.self || valueType == Optional<Int>.self {
                if index == primaryKeyIndex {
                    columns.append("\(label) Integer PRIMARY KEY")
                } else {
                    columns.append("\(label) Integer")
                }
            } else if valueType == Double.self || valueType == Optional<Double>.self {
                if index == primaryKeyIndex {
                    columns.append("\(label) Real PRIMARY KEY")
                } else {
                    columns.append("\(label) Real")
                }
            } else {
                dprint("other type:\(data.value)")
                dprint(valueType)
            }
        }
        let result = db.createTable(tableName: tableName,columns: columns)
        db.closeDb()
        return result
    }
    func insert(data:[ModelData]) -> Bool { // model
        let db = JySqlite()
        let sqls = insertSql(data: data)
        let result = db.insertOrReplace(tableName: tableName, rows: sqls)
        dprint("insert \(tableName) is \(result)")
        db.closeDb()
        return result
    }
    private func insertSql<T>(data:[T]) -> [[String:String]] {
        var sqls:[[String:String]] = []
        for model in data {
            var sql:[String:String] = [:]
            let mirror = Mirror(reflecting: model)
            for case let (property_name?,value) in mirror.children {
                  if let value = value as? String {
                    sql[property_name] = "'\(value)'"
                  } else if let value = value as? Int {
                    sql[property_name] = "\(value)"
                  } else if let value = value as? Double {
                    sql[property_name] = "\(value)"
                  } else {
                    sql[property_name] = "null"
                  }
            }
            sqls.append(sql)
        }
        return sqls
    }
    func read(cond:String?, order:String?)->[ModelData]{ // model
        let db = JySqlite()
        let statement = db.fetch(tableName: tableName, cond: cond, order: order)
        let valueStrings = db.readSql(statement: statement, model: ModelData())
        guard let ary = JyJSON().makeStringToObject(valueStrings, type: [ModelData].self) else { // model
            dprint("readSql valueString to Object failed")
            dprint(valueStrings)
            return []
        }
        
        sqlite3_finalize(statement)
        db.closeDb()
        return ary
    }
    func deleteTable(cond:String?) -> Bool {
        let db = JySqlite()
        let result = db.delete(tableName: tableName, cond: cond)
        db.closeDb()
        return result
    }
}
