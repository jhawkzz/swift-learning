//
//  Emojibook_Widget.swift
//  Emojibook Widget
//
//  Created by Jered McFerron on 7/11/23.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), emojiDetails: EmojiProvider.random())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), emojiDetails: EmojiProvider.random())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, emojiDetails: EmojiProvider.random())
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let emojiDetails: EmojiDetails
}

struct Emojibook_WidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        EmojiWidgetView(emojiDetails: entry.emojiDetails)
    }
}

struct Emojibook_Widget: Widget {
    let kind: String = "Emojibook_Widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            Emojibook_WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Random Emoji")
        .description("Displays a widget with an emoji that's updated randomly.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge,.accessoryRectangular, .accessoryInline, .accessoryCircular])
    }
}

struct Emojibook_Widget_Previews: PreviewProvider {
    static var previews: some View {
        Emojibook_WidgetEntryView(entry: SimpleEntry(date: Date(), emojiDetails: EmojiProvider.random()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
