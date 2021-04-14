//
//  JyJSON.swift
//  JerryKit
//
//  Created by Jayyi on 2020/10/3.
//  Copyright © 2020 Jerry987123. All rights reserved.
//

public class JyJSON {
    public init(){
    }
    // JSON轉物件
    func makeStringToObject<T>(_ jsonString:String, type:T.Type) -> T? where T : Codable {
        let data = jsonString.data(using: .utf8)
        let jsonDecoder = JSONDecoder()
        do {
            let model = try jsonDecoder.decode(type.self, from: data!)
            return model
        } catch let error {
            dprint("error: \(error)")
            return nil
        }
    }

    // 轉換物件成JSON
    func makeToJSON<T>(_ data:T) -> String where T : Codable {
        let jsonEncoder = JSONEncoder()
        if let backToJson = try? jsonEncoder.encode(data) {
            if let jsonString = String(data: backToJson, encoding: .utf8) {
                return jsonString
            }
        }
        return ""
    }
}
