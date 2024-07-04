//
//  TimeCalculator.swift
//  Sleep_Keeper_SwiftData
//
//  Created by user on 7/5/24.
//

import Foundation


func timeDifference(from start: Date, to end: Date) -> Int {
        let interval = end.timeIntervalSince(start) // 이런식으로 차이구하는듯
        
        let hours = Int(interval) / 3600
        let minutes = (Int(interval) % 3600) / 60
        let seconds = Int(interval) % 60
        
    
    return Int(interval)/60 // 분단위로 남은 시간 반환
    }
//
//
//public func whatTimeLeft( wakeUpTime: Date) -> Int {
//        
//    
//        return
//    }
//
//public func whatPercentLeft(RemainTime:Date)-> Int{
//    
//    
//}


// 이거 Date() 로 생성하면 한국 시간 아니라서 그거 고려해서 계산해줘야함!! 여기서 시간을 한국시간으로 바꿔서 계산을 하든가
