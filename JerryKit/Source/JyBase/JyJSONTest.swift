//
//  JyJSONTest.swift
//  JerryKit
//
//  Created by Jayyi on 2020/10/3.
//  Copyright © 2020 Jerry987123. All rights reserved.
//

class JyJSONTest {
    func test(){
        makeToJSONTest()
        makeStringToObjectTest()
    }
    func makeToJSONTest(){
        let obj = JSONTestStruct(name: "abc", number: 123, address: "world")
        let jsonString = JyJSON().makeToJSON(obj)
        let check = "{\"name\":\"abc\",\"number\":123,\"address\":\"world\"}"
        if check == jsonString {
            dprint("makeToJSONTest測試成功")
        } else {
            dprint("makeToJSONTest測試失敗")
        }
    }
    func makeStringToObjectTest(){
        let jsonString = "{\"name\":\"abc\",\"number\":123,\"address\":\"world\"}"
        let obj = JyJSON().makeStringToObject(jsonString, type: JSONTestStruct.self)
        if let obj = obj, obj.name == "abc" && obj.number == 123 && obj.address == "world" {
            dprint("makeStringToObjectTest測試成功")
        } else {
            dprint("makeStringToObjectTest測試失敗")
        }
    }
}
struct JSONTestStruct: Codable {
    var name = ""
    var number = 0
    var address = ""
}
