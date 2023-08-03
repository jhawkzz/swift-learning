//
//  CompactPersonWidget.swift
//  KidsTest
//
//  Created by Jered McFerron on 8/2/23.
//

import SwiftUI
import WidgetKit

struct CompactPersonView: View {
    let person: Person
    
    var body: some View {
        ZStack {
            ContainerRelativeShape()
                .fill( Color.white.gradient )
            
            VStack {
                VStack {
                    Image(uiImage: UIImage(data: person.imageData) ?? UIImage(named: "avatar")!)
                        .resizable()
                        .frame(width: 75, height: 75)
                        .clipShape(Circle())
                        .shadow(radius: 2)
                    
                    Text(person.name)
                        .font(.title2)
                        .minimumScaleFactor(0.6)
                        .lineLimit(1)
                        .fontWeight(.bold)
                }
                
                Spacer()
                
                VStack {
                    Text("\(person.timesUntilNextReward)")
                    
                    Text( "visits to next reward")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    
                }
            }
            .padding()
        }
        
    }
}

struct CompactPersonWidget_Previews: PreviewProvider {
    static var previews: some View {
        CompactPersonView(person: MockData.personOne)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
