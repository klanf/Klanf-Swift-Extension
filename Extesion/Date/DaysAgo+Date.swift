//
//  DaysAgo+Date.swift
//
//  Created by klanf on 2020/6/11.
//  Copyright © 2020 com.klanf.ios. All rights reserved.
//2020-06-10 16:29:19

extension Date {
    
    // MARK: 获取当前时间
    // 这里的 type 是指日期的格式 “yyyy-MM-dd HH:mm” 或者 “yyyy-MM-dd” 这样子
    static func nowTime(_ type: String?) -> String {
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = type ?? "yyyy-MM-dd HH:mm:ss"
        let time = formatter.string(from: currentDate)
        return time
    }
    
    // MARK: 获取当前开始时间
    static func dayStartTime() -> String {
        
        return Date.nowTime(day:nil, hour: 08, minute: 00)
    }
    
    // MARK: 获取当前结束时间
    static func dayEndTime() -> String {
        
        return Date.nowTime(day:nil, hour: 17, minute: 30)
    }
    
    // MARK: 获取当前时间
    static func nowTime(day: Int?, hour: Int, minute: Int) -> String {
        let calendar = Calendar.current
        var dayComp = calendar.dateComponents([.year, .month, .day], from: Date.init())
        if let day = day {
            dayComp.day = day
        }
        dayComp.hour = hour
        dayComp.minute = minute
        dayComp.second = 0
        let last = calendar.date(from: dayComp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let day = dateFormatter.string(from: last!)
        return day
    }
    
    // MARK: 获取当前周开始时间
    static func sevenDaysAgo() -> String {
        
        let daysago = Date.init().addingTimeInterval(-7*24*60*60)
        let dayComp = Calendar.current.dateComponents([.year, .month, .day], from: daysago)
        return Date.nowTime(day:dayComp.day, hour: 08, minute: 00)
        
    }
    
    // MARK: 获取当前周开始时间
    static func weekStartTime() -> String {
        
        let calendar = Calendar.current
        let comp = calendar.dateComponents([.year, .month, .day, .weekday], from: Date.init())
        
        // 获取今天是周几
        let weekDay = comp.weekday
        // 获取几天是几号
        let day = comp.day
        
        // 计算当前日期和本周的星期一和星期天相差天数
        let firstDiff: Int = weekDay == 1 ? -6: calendar.firstWeekday - weekDay! + 1
        
        return Date.nowTime(day:day! + firstDiff, hour: 08, minute: 00)
    }
    
    // MARK: 获取某一天所在的周一和周日
    static func getWeekTime(_ dateStr: String) -> Array<String> {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let nowDate = dateFormatter.date(from: dateStr)
        let calendar = Calendar.current
        let comp = calendar.dateComponents([.year, .month, .day, .weekday], from: nowDate!)
        
        // 获取今天是周几
        let weekDay = comp.weekday
        // 获取几天是几号
        let day = comp.day
        
        // 计算当前日期和本周的星期一和星期天相差天数
        var firstDiff: Int
        var lastDiff: Int
        // weekDay = 1;
        if (weekDay == 1) {
            firstDiff = -6;
            lastDiff = 0;
        } else {
            firstDiff = calendar.firstWeekday - weekDay! + 1
            lastDiff = 8 - weekDay!
        }
        
        // 在当前日期(去掉时分秒)基础上加上差的天数
        var firstDayComp = calendar.dateComponents([.year, .month, .day], from: nowDate!)
        firstDayComp.day = day! + firstDiff
        firstDayComp.hour = 8
        firstDayComp.minute = 0
        let firstDayOfWeek = calendar.date(from: firstDayComp)
        var lastDayComp = calendar.dateComponents([.year, .month, .day], from: nowDate!)
        lastDayComp.day = day! + lastDiff
        lastDayComp.hour = 17
        lastDayComp.minute = 30
        let lastDayOfWeek = calendar.date(from: lastDayComp)
        
        let firstDay = dateFormatter.string(from: firstDayOfWeek!)
        let lastDay = dateFormatter.string(from: lastDayOfWeek!)
        let weekArr = [firstDay, lastDay]
        
        return weekArr;
    }
    
    // MARK: 当月开始日期
    // nowDay 为传入需要计算的日期
    static func startOfCurrentMonth() -> String {
                
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: Date.init())
        components.day = 1
        components.hour = 8
        components.minute = 0
        components.second = 0
        let startOfMonth = calendar.date(from: components)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let day = dateFormatter.string(from: startOfMonth!)
        return day
    }
    
    //MARK: 时间字符串转date
    static func timeStringToDate(_ dateStr:String,_ dateFormat: String = "yyyy-MM-dd  HH:mm:ss") ->Date {
        let dateFormatter = DateFormatter()
        //        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = dateFormat
        let date
            = dateFormatter.date(from: dateStr)
        return date!
    }
    
    //MARK: 将时间显示为（几分钟前，几小时前，几天前）
    static func compareCurrentTime(str:String) -> String {
        
        let timeDate = self.timeStringToDate(str)
        
        let currentDate = NSDate()
        
        let timeInterval = currentDate.timeIntervalSince(timeDate)
        
        var temp:Double = 0
        
        var result:String = ""
        
        if timeInterval/60 < 1 {
            
            result = NSLocalizedString("刚刚", comment: "")
            
        }else if (timeInterval/60) < 60{
            
            temp = timeInterval/60
            
            result = "\(Int(temp))" + NSLocalizedString("分钟前", comment: "")
            
        }else if timeInterval/60/60 < 24 {
            
            temp = timeInterval/60/60
            
            result = "\(Int(temp))" + NSLocalizedString("小时前", comment: "")
            
        }else if timeInterval/(24 * 60 * 60) < 30 {
            
            temp = timeInterval / (24 * 60 * 60)
            
            result = "\(Int(temp))" + NSLocalizedString("天前", comment: "")
            
        }else if timeInterval/(30 * 24 * 60 * 60)  < 12 {
            
            temp = timeInterval/(30 * 24 * 60 * 60)
            
            result = "\(Int(temp))" + NSLocalizedString("个月前", comment: "")
            
        }else{
            
            temp = timeInterval/(12 * 30 * 24 * 60 * 60)
            
            result = "\(Int(temp))" + NSLocalizedString("年前", comment: "")
            
        }
        
        return result
        
    }
}
