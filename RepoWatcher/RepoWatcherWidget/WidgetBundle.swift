//
//  WidgetBundle.swift
//  RepoWatcherWidgetExtension
//
//  Created by Jered McFerron on 7/14/23.
//

import SwiftUI
import WidgetKit

@main
struct RepoWatcherWidgets: WidgetBundle {
    var body: some Widget {
        CompactRepoWidget()
        ContributorWidget()
    }
}
