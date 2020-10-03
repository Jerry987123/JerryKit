//
//  JyError.swift
//  JerryKit
//
//  Created by Jayyi on 2020/10/3.
//  Copyright © 2020 Jerry987123. All rights reserved.
//

struct CustomError:Error {
    var desc = ""
    var localizedDescription: String {
        return desc
    }
    init(_ desc:String) {
        self.desc = desc
    }
}
