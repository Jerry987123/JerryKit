//
//  JyBaseFuns.swift
//  JerryKit
//
//  Created by Jayyi on 2020/10/3.
//  Copyright © 2020 Jerry987123. All rights reserved.
//

// 須先設定
// Swift Compiler - Custom Flags
// Other Swift Flags
// Debug 欄位的值設定 -D DEBUG
public func dprint(_ item: @autoclosure () -> Any) {
    #if DEBUG
        print("------>",item())
    #endif
}
public func dprint(_ item: @autoclosure () -> Any, _ item2: @autoclosure () -> Any) {
    #if DEBUG
        print("------>","\(item())\(item2())")
    #endif
}
