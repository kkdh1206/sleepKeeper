//
//  Item.swift
//  Sleep_Keeper_SwiftData
//
//  Created by user on 7/4/24.
//

import Foundation
import SwiftData

@Model
final class WakeUpTime {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}

