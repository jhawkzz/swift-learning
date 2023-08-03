//
//  KidsTestWidget.swift
//  KidsTestWidget
//
//  Created by Jered McFerron on 8/2/23.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> PersonEntry {
        PersonEntry(date: Date(), person: MockData.personOne)
    }

    func getSnapshot(in context: Context, completion: @escaping (PersonEntry) -> ()) {
        let entry = PersonEntry(date: Date(), person: MockData.personOne)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let nextUpdate = Date().addingTimeInterval(43200) //12 hours in seconds
        
        Task {
            do {
                
                //todo: get an actual person
                var person = MockData.personOne
                
                let entry = PersonEntry(date: .now, person: person)
                let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
                completion(timeline)
            }
            catch {
                print("❌ Error - \(error)")
            }
        }
    }
}

struct PersonEntry: TimelineEntry {
    let date: Date
    let person: Person
}

struct KidsTestWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        
        CompactPersonView(person: entry.person)
        
    }
}

struct KidsTestWidget: Widget {
    let kind: String = "KidsTestWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            KidsTestWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("CCV Kids Milestone Watcher")
        .description("Keep track of your child's next milestone reward.")
    }
}

struct KidsTestWidget_Previews: PreviewProvider {
    static var previews: some View {
        KidsTestWidgetEntryView(entry: PersonEntry(date: Date(), person: MockData.personOne))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
