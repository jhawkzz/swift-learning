//
//  ContributorWidget.swift
//  RepoWatcherWidgetExtension
//
//  Created by Jered McFerron on 7/14/23.
//

import SwiftUI
import WidgetKit

struct ContributorProvider: TimelineProvider {
    
    func placeholder(in context: Context) -> ContributorEntry {
        ContributorEntry( date: .now )
    }
    
    func getSnapshot(in context: Context, completion: @escaping (ContributorEntry) -> ()) {
        let entry = ContributorEntry( date: .now)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<ContributorEntry>)-> ()) {
        let nextUpdate = Date().addingTimeInterval(43200) //12 hours in seconds
        let entry = ContributorEntry( date: .now )
        let timeline = Timeline( entries: [entry], policy: .after(nextUpdate))
        completion(timeline)
    }
}

struct ContributorEntry: TimelineEntry {
    let date: Date
}

struct ContributorEntryView : View {
    var entry: ContributorEntry
    
    var body: some View {
        Text("Hello World")
    }
}

struct ContributorWidget: Widget {
    let kind: String = "ContributorWidget" // this is bound to the installed instance. you have to delete / re-add from devices if this changes.

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: ContributorProvider()) { entry in
            ContributorEntryView(entry: entry)
        }
        .configurationDisplayName("Contributors")
        .description("Keep track of a repos top contributors.")
        .supportedFamilies([.systemLarge])
    }
}

struct ContributorEntryWidget_Previews: PreviewProvider {
    static var previews: some View {
        ContributorEntryView(entry: ContributorEntry(date: .now))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
