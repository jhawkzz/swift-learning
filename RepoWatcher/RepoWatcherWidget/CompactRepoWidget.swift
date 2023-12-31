//
//  RepoWatcherWidget.swift
//  RepoWatcherWidget
//
//  Created by Jered McFerron on 7/14/23.
//

import WidgetKit
import SwiftUI

struct CompactRepoProvider: TimelineProvider {
    func placeholder(in context: Context) -> CompactRepoEntry {
        CompactRepoEntry(date: Date(), repo: MockData.repoOne, bottomRepo: MockData.repoTwo)
    }

    func getSnapshot(in context: Context, completion: @escaping (CompactRepoEntry) -> ()) {
        let entry = CompactRepoEntry(date: Date(), repo: MockData.repoOne, bottomRepo: MockData.repoTwo)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        Task {
            let nextUpdate = Date().addingTimeInterval(43200) //12 hours in seconds
            
            do {
                
                // Get Top Repo
                var repo = try await NetworkManager.shared.getRepo(atUrl: RepoURL.fbAlphaShock)
                let avatarImageData = await NetworkManager.shared.downloadImageData(from: repo.owner.avatarUrl)
                repo.avatarData = avatarImageData ?? Data();
                
                // Get Bottom Repo if in large widget
                var bottomRepo: Repository?
                
                if context.family == .systemLarge {
                    bottomRepo = try await NetworkManager.shared.getRepo(atUrl: RepoURL.swiftNews)
                    let avatarImageData = await NetworkManager.shared.downloadImageData(from: bottomRepo!.owner.avatarUrl)
                    bottomRepo!.avatarData = avatarImageData ?? Data();
                }

                // Create Entry & Timeline
                let entry = CompactRepoEntry(date: .now, repo: repo, bottomRepo: bottomRepo)
                let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
                completion(timeline)
            } catch {
                print("❌ Error - \(error)")
            }
        }
    }
}

struct CompactRepoEntry: TimelineEntry {
    let date: Date
    let repo: Repository
    let bottomRepo: Repository?
}

struct CompactRepoEntryView : View {
    @Environment(\.widgetFamily) var family
    
    var entry: CompactRepoEntry
    
    var body: some View {
        
        switch family {
        case .systemMedium:
            RepoMediumView(repo: entry.repo)
        case .systemLarge:
            VStack(spacing: 36) {
                RepoMediumView(repo: entry.repo)
                
                if let bottomRepo = entry.bottomRepo {
                    RepoMediumView(repo: bottomRepo)
                }
            }
        case .systemSmall, .systemExtraLarge, .accessoryCircular, .accessoryRectangular, .accessoryInline:
            EmptyView()
        @unknown default:
            EmptyView()
        }
    }
}

struct CompactRepoWidget: Widget {
    let kind: String = "CompactRepoWidget" // this is bound to the installed instance. you have to delete / re-add from devices if this changes.

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: CompactRepoProvider()) { entry in
            CompactRepoEntryView(entry: entry)
        }
        .configurationDisplayName("Repo Watcher")
        .description("Keep tabs on your favorite repos.")
        .supportedFamilies([.systemMedium, .systemLarge])
    }
}

struct CompactRepoWidget_Previews: PreviewProvider {
    static var previews: some View {
        CompactRepoEntryView(entry: CompactRepoEntry(date: Date(), repo: MockData.repoOne, bottomRepo: MockData.repoTwo))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
