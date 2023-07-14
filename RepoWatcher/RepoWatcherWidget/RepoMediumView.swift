//
//  RepoMediumView.swift
//  RepoWatcherWidgetExtension
//
//  Created by Jered McFerron on 7/14/23.
//

import SwiftUI
import WidgetKit

struct RepoMediumView: View {
    let repo: Repository
    let formatter = ISO8601DateFormatter()
    var daysSinceLastActivity: Int {
        calcDaysSinceLastActivity(from: repo.pushedAt)
    }
    
    var body: some View {
        HStack {
            VStack( alignment: .leading ) {
                HStack {
                    Image(uiImage: UIImage(data: repo.avatarData) ?? UIImage(named: "avatar")!)
                        .resizable()
                        .frame(width: 50, height:50)
                        .clipShape(Circle())
                    Text(repo.name)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .minimumScaleFactor(0.6)
                        .lineLimit(1)
                }
                .padding(.bottom, 6)
                
                HStack {
                    StateLabel(value: repo.watchers, systemImageName: "star.fill")
                    StateLabel(value: repo.forks, systemImageName: "tuningfork")
                    if repo.hasIssues {
                        StateLabel(value: repo.openIssues, systemImageName: "exclamationmark.triangle.fill")
                    }
                }
            }
            
            Spacer()
            
            VStack {
                Text("\(daysSinceLastActivity)")
                    .font(.system(size: 70))
                    .bold()
                    .frame(width: 90)
                    .minimumScaleFactor(0.6)
                    .lineLimit(1)
                    .foregroundColor(daysSinceLastActivity > 30 ? .pink : .green)
                
                Text( "days ago")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
    }
    
    func calcDaysSinceLastActivity( from dateString: String ) -> Int {
        let lastActivityDate = self.formatter.date(from: dateString) ?? .now
        let daysSinceLastActivity = Calendar.current.dateComponents([.day], from: lastActivityDate, to: .now).day ?? 0
        
        return daysSinceLastActivity
    }
}

struct RepoMediumView_Previews: PreviewProvider {
    static var previews: some View {
        RepoMediumView(repo: MockData.repoOne)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}

fileprivate struct StateLabel: View {
    
    let value: Int
    let systemImageName: String
    
    var body: some View {
        Label {
            Text("\(self.value)")
                .font(.footnote)
                
        } icon: {
            Image(systemName: self.systemImageName)
                .foregroundColor(.green)
        }
        .fontWeight(.medium)
    }
}
