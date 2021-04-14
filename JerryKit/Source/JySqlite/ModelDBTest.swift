//
//  ModelDBTest.swift
//  JerryKit
//
//  Created by Jayyi on 2020/10/27.
//  Copyright © 2020 Jerry987123. All rights reserved.
//

class ModelDBTest {

let db = ModelDB()

    func test(){
        dprint("ModelDBTest")
        createTableTest()
        insertTest()
        readTest()
        deleteTableTest()
    }
    func createTableTest(){
        let result = db.createTable()
        dprint("createTableTest測試\(result ? "成功":"失敗")")
    }
    func insertTest(){
        let respString = "[{\"id\":1,\"name\":\"A\",\"file\":null,\"code\":null},{\"id\":2,\"name\":\"B\",\"file\":null,\"code\":null}]"
        let _resp = JyJSON().makeStringToObject(respString, type: [ModelData].self)
        guard let resp = _resp else {
            return dprint("insert測試失敗:JSON failed")
        }
        let result = db.insert(data: resp)
        dprint("insert測試\(result ? "成功":"失敗")")
    }
    func readTest(){
        let datas = db.read(cond: nil, order: nil)
        let check = "[JerryKit.ModelData(id: 1, name: \"A\", file: nil, code: nil), JerryKit.ModelData(id: 2, name: \"B\", file: nil, code: nil)]"
        if check == "\(datas)" {
            dprint("readTest測試成功")
        } else {
            dprint("readTest測試失敗=\(datas)")
        }
    }
    func deleteTableTest(){
        let result = db.deleteTable(cond: nil)
        dprint("deleteTableTest測試\(result ? "成功":"失敗")")
    }
}
