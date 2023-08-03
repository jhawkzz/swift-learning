//
//  Person.swift
//  KidsTest
//
//  Created by Jered McFerron on 8/2/23.
//

import Foundation

struct Person {
    let name: String
    let age: Int
    let imageUrl: String
    let lastCheckinDate: Date
    let timesUntilNextReward: Int
    var imageData: Data
}

extension Person {
    struct CodingData: Decodable {
        let name: String
        let age: Int
        let imageUrl: String
        let lastCheckinDate: Date
        let timesUntilNextReward: Int
        
        var person: Person {
            Person( name: name,
                    age: age,
                    imageUrl: imageUrl,
                    lastCheckinDate: lastCheckinDate,
                    timesUntilNextReward: timesUntilNextReward,
                    imageData: Data() )
        }
    }
}
