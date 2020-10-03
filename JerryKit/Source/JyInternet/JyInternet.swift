//
//  JyInternet.swift
//  JerryKit
//
//  Created by Jayyi on 2020/10/3.
//  Copyright © 2020 Jerry987123. All rights reserved.
//

import UIKit

public class JyInternet {
    public init(){
    }
    
    // 須先於.Header設定載入Reachability.h
    // MARK: - 檢查裝置的網路狀態
    public func checkInternetFunction() -> Bool {
        let reachability = Reachability(hostName: "https://www.apple.com/")
        if reachability?.currentReachabilityStatus().rawValue == 0 {
            dprint("no internet connected.")
            return false
        } else {
            dprint("internet connected successfully.")
            return true
        }
    }
    // MARK: - 以safari開啟網址
    public func showWeb(_ url: String) {
        if let url = URL(string: "\(url)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}
