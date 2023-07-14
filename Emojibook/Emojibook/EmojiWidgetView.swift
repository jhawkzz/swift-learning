//
//  EmojiWidgetView.swift
//  Emojibook WidgetExtension
//
//  Created by Jered McFerron on 7/11/23.
//

import SwiftUI

struct SmallEmojiWidgetView: View {
    
    let emojiDetails: EmojiDetails
    
    var body: some View {
        ZStack {
            Color(UIColor.systemIndigo)
            VStack {
                Text(emojiDetails.emoji)
                    .font(.system(size: 56))
                Text(emojiDetails.name)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding(.top, 5)
                    .padding([.leading, .trailing])
                    .foregroundColor(.white)
            }
        }
        .widgetURL(emojiDetails.url)
    }
}

struct InlineEmojiWidgetView: View {
    
    let emojiDetails: EmojiDetails
    
    var body: some View {
        HStack {
            Text(emojiDetails.name)
                .font(.system(size:16))
            Text(emojiDetails.emoji)
                .font(.headline)
        }
        .widgetURL(emojiDetails.url)
    }
}

struct CircularEmojiWidgetView: View {
    
    let emojiDetails: EmojiDetails
    
    var body: some View {
        Text(emojiDetails.emoji)
            .font(.headline)
            .widgetURL(emojiDetails.url)
    }
}

struct MediumEmojiWidgetView: View {
    
    let emojiDetails: EmojiDetails
    
    var body: some View {
        ZStack {
            Color(UIColor.systemIndigo)
            HStack {
                Text(emojiDetails.emoji)
                    .font(.system(size: 56))
                    .padding()
                
                VStack(alignment: .leading) {
                    Text(emojiDetails.name)
                        .font(.headline)
                    Text(emojiDetails.description)
                }
                .foregroundColor(.white)
                .padding([.top, .bottom, .trailing])
            }
        }
        .widgetURL(emojiDetails.url)
    }
}

struct LargeEmojiWidgetView: View {
    
    let emojiDetails: EmojiDetails
    
    var body: some View {
        ZStack {
            Color(UIColor.systemIndigo)
            
            VStack {
                Text(emojiDetails.name)
                    .bold()
                    .font(.title)
                
                Text(emojiDetails.emoji)
                    .font(.system(size: 60))
                    .padding()
                
                Text(emojiDetails.description)
                    .font(.title3)
            }
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .padding()
        }
        .widgetURL(emojiDetails.url)
    }
}

struct EmojiWidgetView: View {
 
    @Environment(\.widgetFamily) var family
    
    let emojiDetails: EmojiDetails
    
    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall:
            SmallEmojiWidgetView(emojiDetails: emojiDetails)
        
        case .systemMedium:
            MediumEmojiWidgetView(emojiDetails: emojiDetails)
            
        case .systemLarge:
            LargeEmojiWidgetView(emojiDetails: emojiDetails)
            
        case .accessoryInline:
            InlineEmojiWidgetView(emojiDetails: emojiDetails)
            
        case .accessoryRectangular:
            InlineEmojiWidgetView(emojiDetails: emojiDetails)
            
        case .accessoryCircular:
            CircularEmojiWidgetView(emojiDetails: emojiDetails)
            
        default:
            EmptyView()
        }
    }
}

struct EmojiWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiWidgetView( emojiDetails:EmojiProvider.all()[0])
    }
}
