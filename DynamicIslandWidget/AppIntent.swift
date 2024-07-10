//
//  AppIntent.swift
//  DynamicIslandWidget
//
//  Created by user on 7/8/24.
//

import WidgetKit
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Configuration"
    static var description = IntentDescription("This is an example widget.")

    func perform() async throws -> some IntentResult {
            // 앱을 열거나 특정 동작을 수행하도록 설정
            return .result()
        }
//    // An example configurable parameter.
//    @Parameter(title: "Favorite Emoji", default: "😃")
//    var favoriteEmoji: String
}
