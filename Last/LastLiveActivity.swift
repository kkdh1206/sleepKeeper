//
//  LastLiveActivity.swift
//  Last
//
//  Created by user on 7/10/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct LastAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct LastLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LastAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension LastAttributes {
    fileprivate static var preview: LastAttributes {
        LastAttributes(name: "World")
    }
}

extension LastAttributes.ContentState {
    fileprivate static var smiley: LastAttributes.ContentState {
        LastAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: LastAttributes.ContentState {
         LastAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: LastAttributes.preview) {
   LastLiveActivity()
} contentStates: {
    LastAttributes.ContentState.smiley
    LastAttributes.ContentState.starEyes
}
