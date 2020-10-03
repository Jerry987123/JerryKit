//
//  JyDateTest.swift
//  JerryKit
//
//  Created by Jayyi on 2020/10/3.
//  Copyright © 2020 Jerry987123. All rights reserved.
//

class JyDateTest {
    let inter = JyDate()
    
    func test(){
        getNowTest()
        isSecLateTest()
        dateIsBigThanNowTest()
        dateIsBigThanNow2Test()
        addMinturesTest()
        convertDateTimeFormatterTest()
    }
    func getNowTest(){
        var msg = inter.getNowYYYYMMdd()
        dprint(msg)
        msg = inter.getNowYYYYMMddHHmm()
        dprint(msg)
        msg = inter.getNowYYYYMMddHHmmss()
        dprint(msg)
        msg = inter.getNowYYYYMMddHHmmDash()
        dprint(msg)
    }
    func isSecLateTest(){
        let dateTime = "2020-10-03 12:25:00"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 8 * 60 * 60)
        guard let date = dateFormatter.date(from: dateTime) else {
            return dprint("datetime failed")
        }
        let dateTimeNow = "2020-10-03 12:25:10"
        guard let dateNow = dateFormatter.date(from: dateTimeNow) else {
            return dprint("datetime failed")
        }
        if inter.isSecLate(date, limit: 1, now: dateNow){
            dprint("isSecLateTest 已過限制時間成功")
        } else {
            dprint("isSecLateTest 已過限制時間失敗")
        }
        if inter.isSecLate(date, limit: 11, now: dateNow){
            dprint("isSecLateTest 未過限制時間失敗")
        } else {
            dprint("isSecLateTest 未過限制時間成功")
        }
    }
    func dateIsBigThanNowTest(){
        let dateTimeNow = "2020-10-03 12:25:10"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 8 * 60 * 60)
        guard let dateNow = dateFormatter.date(from: dateTimeNow) else {
            return dprint("datetime failed")
        }
        let time1 = "2020-10-03 12:25:09"
        if inter.dateIsBigThanNow(dateTime: time1, now: dateNow){
            dprint("dateIsBigThanNowTest測試比現在早失敗")
        } else {
            dprint("dateIsBigThanNowTest測試比現在早成功")
        }
        let time2 = "2020-10-03 12:25:11"
        if inter.dateIsBigThanNow(dateTime: time2, now: dateNow){
            dprint("dateIsBigThanNowTest測試比現在晚成功")
        } else {
            dprint("dateIsBigThanNowTest測試比現在晚失敗")
        }
    }
    func dateIsBigThanNow2Test(){
        let dateTimeNow = "2020-10-03 12:25"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 8 * 60 * 60)
        guard let dateNow = dateFormatter.date(from: dateTimeNow) else {
            return dprint("datetime failed")
        }
        let time1 = "2020-10-03 12:24"
        if inter.dateIsBigThanNow2(YYYYMMddHHmm: time1, now: dateNow){
            dprint("dateIsBigThanNow2Test測試比現在早失敗")
        } else {
            dprint("dateIsBigThanNow2Test測試比現在早成功")
        }
        let time2 = "2020-10-03 12:26"
        if inter.dateIsBigThanNow2(YYYYMMddHHmm: time2, now: dateNow){
            dprint("dateIsBigThanNow2Test測試比現在晚成功")
        } else {
            dprint("dateIsBigThanNow2Test測試比現在晚失敗")
        }
    }
    func addMinturesTest(){
        let time1 = "2020-10-03 00:00"
        let time2 = inter.addMintures(YYYYMMddHHmm: time1, addMin: 10)
        if time2 == "2020-10-03 00:10" {
            dprint("addMinturesTest成功")
        } else {
            dprint("addMinturesTest失敗")
        }
    }
    func convertDateTimeFormatterTest(){
        let time1 = "2020-10-03 12:24:00"
        let time2 = inter.convertDateTimeFormatter(time1)
        let check = "下午 12:24:00"
        if check == time2 {
            dprint("convertDateTimeFormatterTest 測試成功")
        } else {
            dprint("convertDateTimeFormatterTest 測試失敗")
        }
    }
}
