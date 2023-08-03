//
//  MockData.swift
//  KidsTestWidgetExtension
//
//  Created by Jered McFerron on 8/2/23.
//

import Foundation
import SwiftUI
import WidgetKit

struct MockData {
    static let personOne = Person(name: "Hawk McFerron",
                                  age: 5,
                                  imageUrl: "",
                                  lastCheckinDate: Date(),
                                  timesUntilNextReward: 8,
                                  imageData: UIImage(named: "hawk")!.pngData()! )
}
