//
//  Emojibook_WidgetBundle.swift
//  Emojibook Widget
//
//  Created by Jered McFerron on 7/11/23.
//

import WidgetKit
import SwiftUI

@main
struct Emojibook_WidgetBundle: WidgetBundle {
    var body: some Widget {
        Emojibook_Widget()
        Emojibook_WidgetLiveActivity()
    }
}
