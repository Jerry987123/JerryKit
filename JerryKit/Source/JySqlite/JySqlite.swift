//
//  JySqlite.swift
//  JerryKit
//
//  Created by Jayyi on 2020/10/3.
//  Copyright © 2020 Jerry987123. All rights reserved.
//

import Foundation

// 須先於.Header設定載入 #import "sqlite3.h"
class JySqlite {
    var db:OpaquePointer?
    
    init() {
        let sqlitePath = NSHomeDirectory() + "/Library/Preferences/sqlite3.db"
        db = openDatabase(path: sqlitePath)
    }
    init(path:String) {
        let sqlitePath = NSHomeDirectory() + "/Library/Preferences/\(path).db"
        db = openDatabase(path: sqlitePath)
    }
    
    // connect database
    func openDatabase(path:String) -> OpaquePointer? {
        var connectDB:OpaquePointer?
        if sqlite3_open(path, &connectDB) == SQLITE_OK {
            return connectDB
        } else {
            dprint("Unable to open database")
            return nil
        }
    }
    
    // close database
    func closeDb(){
        sqlite3_close(db)
    }
    
    // create
    func createTable(tableName:String, columns:[String]) -> Bool {
        let sql = "create table if not exists \(tableName) "
            + "(\(columns.joined(separator: ",")))"
        if sqlite3_exec(db, (sql as NSString).utf8String, nil, nil, nil) == SQLITE_OK {
            dprint("\(sql) successfully")
            return true
        } else {
            dprint("\(sql) fail")
            return false
        }
    }
    // create double key
    func createTable(tableName:String, columns:[String], keys:[String]) -> Bool {
        var sql = "create table if not exists \(tableName) "
            + "(\(columns.joined(separator: ","))"
        sql += ",PRIMARY KEY ("
        for key in keys {
            sql += "\(key),"
        }
        sql.removeLast()
        sql += "))"
        if sqlite3_exec(db, (sql as NSString).utf8String, nil, nil, nil) == SQLITE_OK {
            dprint("\(sql) successfully")
            return true
        } else {
            dprint("\(sql) fail")
            return false
        }
    }
    // insert single line
    func insert(tableName:String, rows:[String:String]) -> Bool {
        var state = false
        let sql = "insert into \(tableName) "
            + "(\(rows.keys.joined(separator: ","))) "
            + "values "
            + "(\(rows.values.joined(separator: ",")))"
        var statement:OpaquePointer?
        sqlite3_prepare_v2(db, (sql as NSString).utf8String, -1, &statement, nil)
        if sqlite3_step(statement) == SQLITE_DONE {
//            dprint("insert successfully")
            state =  true
        } else {
            dprint("\(sql) fail")
            state = false
        }
        sqlite3_reset(statement)
        sqlite3_finalize(statement)
        return state

    }
    // insert multi line
    func insert(tableName:String, rows:[[String:String]]) -> Bool {
        var state = false
        var sql = "insert into \(tableName) "
            + "(\(rows[0].keys.joined(separator: ","))) "
            + "values "
        for row in rows {
            var ss = "("
            for s in rows[0] {
                let value = row[s.key]
                ss += value ?? ""
                ss += ","
            }
            ss.removeLast()
            ss += "),"
            sql += ss
        }
        sql.removeLast()
        sql += ";"
        var statement:OpaquePointer?
        sqlite3_prepare_v2(db, (sql as NSString).utf8String, -1, &statement, nil)
        let result = sqlite3_step(statement)
        if result == SQLITE_DONE {
//            dprint("insert successfully")
            state =  true
        } else {
            dprint("\(sql) fail: \(result)")
            state = false
        }
        sqlite3_reset(statement)
        sqlite3_finalize(statement)
        return state
        
    }
    // insert or replace multi line
    func insertOrReplace(tableName:String, rows:[[String:String]]) -> Bool {
        if rows.count == 0 {
            return false
        }
        var state = false
        var sql = "insert or replace into \(tableName) "
            + "(\(rows[0].keys.joined(separator: ","))) "
            + "values "
        for row in rows {
            var ss = "("
            for s in rows[0] {
                let value = row[s.key]
                ss += value ?? ""
                ss += ","
            }
            ss.removeLast()
            ss += "),"
            sql += ss
        }
        sql.removeLast()
        sql += ";"
        var statement:OpaquePointer?
        sqlite3_prepare_v2(db, (sql as NSString).utf8String, -1, &statement, nil)
        let result = sqlite3_step(statement)
        if result == SQLITE_DONE {
//            dprint("insert successfully")
            state =  true
        } else {
            dprint("\(sql) fail: \(result)")
            state = false
        }
        sqlite3_reset(statement)
        sqlite3_finalize(statement)
        return state
        
    }
    // insert by sql
    func insert(tableName:String, sql:String) -> Bool {
        var state = false
        var statement:OpaquePointer?
        sqlite3_prepare_v2(db, (sql as NSString).utf8String, -1, &statement, nil)
        if sqlite3_step(statement) == SQLITE_DONE {
//            dprint("insert successfully")
            state =  true
        } else {
            dprint("\(sql) fail")
            state = false
        }
        sqlite3_reset(statement)
        sqlite3_finalize(statement)
        return state
        
    }
    // read
    func fetch(tableName:String, cond:String?, order:String?) -> OpaquePointer? {
        var sql = "select * from \(tableName)"
        if let condition = cond {
            sql += " where \(condition)"
        }
        if let orderBy = order {
            sql += " order by \(orderBy)"
        }
        var statement:OpaquePointer?
        sqlite3_prepare_v2(db, (sql as NSString).utf8String, -1, &statement, nil)
        return statement
    }
    // read by sql
    func fetch(sql:String) -> OpaquePointer? {
        var statement:OpaquePointer?
        sqlite3_prepare_v2(db, (sql as NSString).utf8String, -1, &statement, nil)
        return statement
    }
    // update
    func update(tableName:String, cond:String?, rows:[String:String]) -> Bool {
        var state = false
        var sql = "update \(tableName) set "
        var info:[String] = []
        for (k,v) in rows {
            info.append("\(k) = \(v)")
        }
        sql += info.joined(separator: ",")
        
        if let condition = cond {
            sql += " where \(condition)"
        }
        var statement:OpaquePointer?
        sqlite3_prepare_v2(db, (sql as NSString).utf8String, -1, &statement, nil)
        if sqlite3_step(statement) == SQLITE_DONE {
//            dprint("update successfully")
            state = true
        } else {
            dprint("\(sql) fail")
            state = false
        }
        sqlite3_reset(statement)
        sqlite3_finalize(statement)
        return state
    }
    // update append
    // update ATable set id = id || ', abc' where uniqueid = '004'
    func updateAppend(tableName:String, cond:String?, rows:[String:String]) -> Bool {
        var state = false
        var sql = "update \(tableName) set "
        var info:[String] = []
        for (k,v) in rows {
            info.append("\(k) = \(k) || \(v)")
        }
        sql += info.joined(separator: ",")
        
        if let condition = cond {
            sql += " where \(condition)"
        }
        var statement:OpaquePointer?
        sqlite3_prepare_v2(db, (sql as NSString).utf8String, -1, &statement, nil)
        if sqlite3_step(statement) == SQLITE_DONE {
//            dprint("update successfully")
            state = true
        } else {
            dprint("\(sql) fail")
            state = false
        }
        sqlite3_reset(statement)
        sqlite3_finalize(statement)
        return state
    }
    // update multi line
    func updateMulti(table:String, tmp:String, keys:[String], columns:[String], values:[String]) -> Bool {
        var state = false
        var sql = ""
        sql += "with tmp\(tmp) as (values "
        for v in values {
            sql += "\(v),"
        }
        sql.removeLast()
        sql += ") update \(table) set"
        for c in columns {
            sql += " \(c) = ( select \(c) from tmp where 1=1"
            for k in keys {
                sql += " and \(table).\(k) = tmp.\(k)"
            }
            sql += "),"
        }
        sql.removeLast()
        sql += " where 1=1"
        for k in keys {
            sql += " and \(k) in (select \(k) from tmp)"
        }
        sql += ";"
        var statement:OpaquePointer?
        sqlite3_prepare_v2(db, (sql as NSString).utf8String, -1, &statement, nil)
        if sqlite3_step(statement) == SQLITE_DONE {
//            dprint("update successfully")
            state = true
        } else {
            dprint("\(sql) fail = \(sqlite3_step(statement))")
            state = false
        }
        sqlite3_reset(statement)
        sqlite3_finalize(statement)
        return state
    }
    // delete
    func delete(tableName:String, cond:String?) -> Bool {
        var result = false
        var sql = "delete from \(tableName)"
        if let condition = cond {
            sql += " where \(condition)"
        }
        var statement:OpaquePointer?
        sqlite3_prepare_v2(db, (sql as NSString).utf8String, -1, &statement, nil)
        if sqlite3_step(statement) == SQLITE_DONE {
//            dprint("\(sql) successfully")
            result = true
        } else {
            dprint("\(sql) fail")
            result = false
        }
        sqlite3_reset(statement)
        sqlite3_finalize(statement)
        return result
    }
}
