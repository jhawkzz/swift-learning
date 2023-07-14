//
//  MonthView.swift
//  MonthlyWidgetExtension
//
//  Created by Jered McFerron on 7/13/23.
//

import WidgetKit
import SwiftUI

struct MonthViewManager {
    
    static func getMonthView( entry: DayEntry ) -> some View {
        
        let monthInt = Calendar.current.component(.month, from: entry.date)
        
        switch monthInt {
            case 1: return AnyView(JanMonthView( entry: entry ))
            case 2: return AnyView(FebMonthView( entry: entry ))
            default: return  AnyView(UnknownMonthView( entry: entry ))
        }
    }
}

struct JanMonthView: View {
    
    var entry: DayEntry
    var monthConfig = MonthConfig.determineConfig(from: 1)
    
    init( entry: DayEntry ) {
        self.entry = entry
    }
    
    var body: some View {
        ZStack {
            ContainerRelativeShape()
                .fill(monthConfig.backgroundColor.gradient.blendMode(.difference))
            
            ZStack {
                Text("JAN")
                    .font(.system(size: 80, weight: .heavy))
                    .fontWeight(.bold)
                    .opacity(0.3)
                
                VStack {
                    Text(monthConfig.emojiText)
                        .font(.largeTitle)
                    
                    Text(entry.date.weekdayDisplayFormat)
                        .font(.title3)
                        .fontWeight(.bold)
                        .minimumScaleFactor(0.6)
                        .foregroundColor(monthConfig.weekdayTextColor)
                    
                    Text(entry.date.dayDisplayFormat)
                        .font(.title3)
                        .fontWeight(.bold)
                        .minimumScaleFactor(0.6)
                        .foregroundColor(monthConfig.weekdayTextColor)
                }
            }
            
        }
    }
}

struct FebMonthView: View {
    
    var entry: DayEntry
    var monthConfig = MonthConfig.determineConfig(from: 2)
    
    init( entry: DayEntry ) {
        self.entry = entry
    }
    
    var body: some View {
        ZStack {
            ContainerRelativeShape()
                .fill(monthConfig.backgroundColor.gradient)
            
            VStack {
                HStack(spacing: 4) {
                    Text(monthConfig.emojiText)
                        .font(.title)
                    Text(entry.date.weekdayDisplayFormat)
                        .font(.title3)
                        .fontWeight(.bold)
                        .minimumScaleFactor(0.6)
                        .foregroundColor(monthConfig.weekdayTextColor)
                    Spacer()
                }
                
                Text(entry.date.dayDisplayFormat)
                    .font(.system(size:80, weight: .heavy))
                    .foregroundColor(monthConfig.dayTextColor)
            }
            .padding()
        }
    }
}

struct UnknownMonthView: View {
    
    var entry: DayEntry
    
    init( entry: DayEntry ) {
        self.entry = entry
    }
        var body: some View {
        ZStack {
            ContainerRelativeShape()
                .fill(.brown.gradient)
            
            ZStack {
                Text("?")
                    .font(.system(size: 80, weight: .heavy))
                    .fontWeight(.bold)
                    .opacity(0.3)
                
                VStack {
                    Text("😈")
                        .font(.largeTitle)
                    
                    Text("?")
                        .font(.title3)
                        .fontWeight(.bold)
                        .minimumScaleFactor(0.6)
                        .foregroundColor(.black)
                    
                    Text("?")
                        .font(.title3)
                        .fontWeight(.bold)
                        .minimumScaleFactor(0.6)
                        .foregroundColor(.white)
                }
            }
            
        }
    }
}
