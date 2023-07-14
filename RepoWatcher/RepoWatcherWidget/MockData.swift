//
//  MockData.swift
//  RepoWatcherWidgetExtension
//
//  Created by Jered McFerron on 7/14/23.
//

import Foundation

struct MockData {
    static let repoOne = Repository(name: "Repository 1",
                                        owner: Owner(avatarUrl: ""),
                                        hasIssues: true,
                                        forks: 1,
                                        watchers: 403,
                                        openIssues: 2,
                                        pushedAt: "2023-07-14T18:05:59Z",
                                        avatarData: Data())
    
    static let repoTwo = Repository(name: "Repository 2",
                                        owner: Owner(avatarUrl: ""),
                                        hasIssues: false,
                                        forks: 134,
                                        watchers: 976,
                                        openIssues: 122,
                                        pushedAt: "2021-07-14T18:05:59Z",
                                        avatarData: Data())
}
