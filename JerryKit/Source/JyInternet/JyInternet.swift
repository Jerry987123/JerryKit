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
    
    // 須先於.Header設定載入 #import "Reachability.h"
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
    // MARK: 偵測是否開啟wifi，即使沒有連線
    func isWifiEnabled() -> Bool {
        var addresses = [String]()
        
        var ifaddr : UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else { return false }
        guard let firstAddr = ifaddr else { return false }
        
        for ptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            addresses.append(String(cString: ptr.pointee.ifa_name))
        }
        
        var counts:[String:Int] = [:]
        
        for item in addresses {
            counts[item] = (counts[item] ?? 0) + 1
        }
        
        freeifaddrs(ifaddr)
        guard let count = counts["awdl0"] else { return false }
        return count > 1
    }
}
