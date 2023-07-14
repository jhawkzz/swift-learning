//
//  EmojiDetails.swift
//  Emojibook
//
//  Created by Jered McFerron on 7/11/23.
//

import Foundation

struct EmojiDetails : Identifiable, Hashable {
    public let emoji: String
    public let name: String
    public let description: String
    public let url: URL?
    
    public var id: String {
        emoji
    }
    
    init( emoji: String, name: String, description: String ) {
        self.emoji = emoji
        self.name = name
        self.description = description
        self.url = URL(string: "emoji://\(name.filter { !$0.isWhitespace })")
    }
}
