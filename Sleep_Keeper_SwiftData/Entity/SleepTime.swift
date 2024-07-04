//
//  SleepTime.swift
//  Sleep_Keeper_SwiftData
//
//  Created by user on 7/5/24.
//

import Foundation
import SwiftData
@Model
final class SleepStartTime{
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
