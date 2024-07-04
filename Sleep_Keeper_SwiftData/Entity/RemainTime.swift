//
//  RemainTime.swift
//  Sleep_Keeper_SwiftData
//
//  Created by user on 7/5/24.
//

import Foundation
import SwiftData

@Model
final class RemainTime {
    var leftMin: Int
    
    init(leftMin: Int) {
        self.leftMin = leftMin
    }
}
