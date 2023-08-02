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
        ContributorEntry( date: .now, repo: MockData.repoOne )
    }
    
    func getSnapshot(in context: Context, completion: @escaping (ContributorEntry) -> ()) {
        let entry = ContributorEntry( date: .now, repo: MockData.repoOne)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<ContributorEntry>)-> ()) {
        
        Task {
            let nextUpdate = Date().addingTimeInterval(43200) //12 hours in seconds
            
            do {
                // Get Repo
                var repo = try await NetworkManager.shared.getRepo(atUrl: RepoURL.fbAlphaShock)
                
                // Get contributors
                let contributors = try await NetworkManager.shared.getContributors(atUrl: repo.contributorsUrl )
                
                // Filter to just the top 4
                var topFour = Array(contributors.prefix(4))
                
                // Download top four avatars
                for i in topFour.indices {
                    let avatarData = await NetworkManager.shared.downloadImageData(from: topFour[i].avatarUrl )
                    
                    topFour[i].avatarData = avatarData ?? Data()
                }
                
                repo.contributors = topFour
                
                // create entry & timeline
                let entry = ContributorEntry( date: .now, repo: repo )
                let timeline = Timeline( entries: [entry], policy: .after(nextUpdate))
                completion(timeline)
            }
            catch {
                print("❌ Error - \(error)")
            }
            
        }
    }
}

struct ContributorEntry: TimelineEntry {
    let date: Date
    let repo: Repository
}

struct ContributorEntryView : View {
    var entry: ContributorEntry
    
    var body: some View {
        VStack {
            RepoMediumView(repo: entry.repo)
            ContributorMediumView(repo:entry.repo)
        }
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
        ContributorEntryView(entry: ContributorEntry(date: .now, repo: MockData.repoOne))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
