//
//  JyDate.swift
//  JerryKit
//
//  Created by Jayyi on 2020/10/3.
//  Copyright © 2020 Jerry987123. All rights reserved.
//

public class JyDate {
    public init(){
    }
    // MARK: - 取回YYYY/MM/dd HH:mm特定格式的日期
    func getNowYYYYMMddHHmm() -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "YYYY/MM/dd HH:mm"
        dateformatter.timeZone = TimeZone(secondsFromGMT: 8 * 60 * 60)
        let currentdate = Date()
        let dateString = dateformatter.string(from: currentdate)
        return dateString
    }
    // MARK: - 取回YYYY/MM/dd HH:mm:ss特定格式的日期
    func getNowYYYYMMddHHmmss() -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "YYYY/MM/dd HH:mm:ss"
        dateformatter.timeZone = TimeZone(secondsFromGMT: 8 * 60 * 60)
        let currentdate = Date()
        let dateString = dateformatter.string(from: currentdate)
        return dateString
    }
    // MARK: - 取回YYYY-MM-dd HH:mm特定格式的日期
    func getNowYYYYMMddHHmmDash() -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "YYYY-MM-dd HH:mm"
        dateformatter.timeZone = TimeZone(secondsFromGMT: 8 * 60 * 60)
        let currentdate = Date()
        let dateString = dateformatter.string(from: currentdate)
        return dateString
    }
    // MARK: - 取回YYYYMMdd特定格式的日期
    func getNowYYYYMMdd() -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "YYYYMMdd"
        dateformatter.timeZone = TimeZone(secondsFromGMT: 8 * 60 * 60)
        let currentdate = Date()
        let dateString = dateformatter.string(from: currentdate)
        return dateString
    }
    // MARK: - 傳入Date(),已過冷卻時間limit秒鐘後則true
    func isSecLate(_ date:Date, limit:Double, now:Date = Date()) -> Bool {
        // 測試時間 + 限制時間
        let targetLateDate:Date = date.addingTimeInterval(limit)
        // 測試的時間 + 限制時間 比 now
        let compareResult = targetLateDate.compare(now)
//        dprint(compareResult.rawValue)
        // 測試的時間 + 限制時間 比 now 小 表示已過冷卻時間
//        dprint("\(targetLateDate):\(Date())")
        // A.compare(B):A比B大則回1,表示未過冷卻時間
        if compareResult.rawValue == 1 {
            return false
        } else {
            return true
        }
    }
    // 字串日期時間比現在早(false)或晚(true)
    func dateIsBigThanNow(dateTime: String, now:Date = Date()) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 8 * 60 * 60)
        guard let date = dateFormatter.date(from: dateTime) else {
            dprint("get date failed")
            return true
        }
        let compareResult = date.compare(now)
        // A.compare(B):A比B大則回1
        if compareResult.rawValue == 1 {
            return true
        } else {
            return false
        }
    }
    // 字串日期時間比現在早(false)或晚(true)
    func dateIsBigThanNow2(YYYYMMddHHmm: String, now:Date = Date()) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 8 * 60 * 60)
        guard let date = dateFormatter.date(from: YYYYMMddHHmm) else {
            dprint("get date failed")
            return true
        }
        let compareResult = date.compare(now)
        // A.compare(B):A比B大則回1
        if compareResult.rawValue == 1 {
            return true
        } else {
            return false
        }
    }
    // 傳入YYYY-MM-dd HH:mm，加上x分鐘後，傳出YYYY-MM-dd HH:mm
    func addMintures(YYYYMMddHHmm:String, addMin:Int) -> String {
        var result = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 8 * 60 * 60)
        guard let date = dateFormatter.date(from: YYYYMMddHHmm) else { return result }
        guard let newDate = Calendar.current.date(byAdding: .minute, value: addMin, to: date) else { return result }
        result = dateFormatter.string(from: newDate)
        return result
    }
}
