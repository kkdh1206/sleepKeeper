//
//  DynamicIslandWidget.swift
//  DynamicIslandWidget
//
//  Created by user on 7/8/24.
//

import WidgetKit
import SwiftUI
import SwiftData

@Query var remain:[RemainTime]

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

struct DynamicIslandWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            if let left = remain.first?.leftMin{
                let hour = left/60
                let min = left%60
                Text("수면가능 시간").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/.bold()).foregroundColor(.white)
                Spacer().frame(height: 10)
                Text("\(hour)시간 \(min)분").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).foregroundColor(.white)
                Spacer().frame(height: 30)
                if(left>480){
                    Image(systemName: "battery.100percent").resizable()
                        .foregroundColor(.white)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 100)
                    Spacer().frame(height: 10)
                    Text("꿀잠 가능!!!").font(.title).foregroundColor(.white)
                    
                }
                else if(left>360){
                    Image(systemName: "battery.50percent").resizable()
                        .foregroundColor(.white)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 100)
                    Text("피곤하다 자자~").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).foregroundColor(.yellow)
                }
                else if(left>240){
                    Image(systemName: "battery.25percent").resizable()
                        .foregroundColor(.white)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 100)
                    Spacer().frame(height: 20)
                    Text("내일아침 감당 가능..?").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).foregroundColor(.red)
                }
                else {
                    Image(systemName: "battery.0percent").resizable()
                        .foregroundColor(.white)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 100)
                    Text("ㅈ됐다 밤새자 ㅎㅎ").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).foregroundColor(.white)
                }
                
                
                //            Spacer().frame(height: 140)
            }
        }
    }
}

struct DynamicIslandWidget: Widget {
    let kind: String = "DynamicIslandWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            DynamicIslandWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemSmall) {
    DynamicIslandWidget()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley)
    SimpleEntry(date: .now, configuration: .starEyes)
}
