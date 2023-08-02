//
//  Repository.swift
//  RepoWatcher
//
//  Created by Jered McFerron on 7/14/23.
//

import Foundation

struct Repository {
    let name: String
    let owner: Owner
    let hasIssues: Bool
    let forks: Int
    let watchers: Int
    let openIssues: Int
    let pushedAt: String
    let contributorsUrl: String
    var avatarData: Data
    var contributors: [Contributor] = []
}

extension Repository {
    struct CodingData: Decodable {
        let name: String
        let owner: Owner
        let hasIssues: Bool
        let forks: Int
        let watchers: Int
        let openIssues: Int
        let pushedAt: String
        let contributorsUrl: String
        
        var repo: Repository {
            Repository(name: name,
                       owner: owner,
                       hasIssues: hasIssues,
                       forks: forks,
                       watchers: watchers,
                       openIssues: openIssues,
                       pushedAt: pushedAt,
                       contributorsUrl: contributorsUrl,
                       avatarData: Data())
        }
    }
}

struct Owner: Decodable {
    let avatarUrl: String
}