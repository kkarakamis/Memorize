//
//  ContentView.swift
//  Memorize
//
//  Created by Kutay Karakamış on 1.12.2021.
//

import SwiftUI

struct ContentView: View {
    @State var emojiCount = 4
    var emojis = ["🫀", "🫁", "🦷", "🧠", "👅", "👁"]
    var gridItemWidth = UIScreen.main.bounds.size.width/5
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemWidth))]) {
                    ForEach(emojis[0..<emojiCount], id: \.self){ emoji in
                        CardView(contentEmoji: emoji).aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            Spacer()
            buttonField.padding(.horizontal).font(.largeTitle)
        }
        .padding(.horizontal)
    }
    
    
    var buttonField: some View {
        HStack {
            Button(action: {
                changeEmojiCount(by: -1)
            }, label: {
                Image(systemName: "minus.square")
            })
        Spacer()
            Button(action: {
                changeEmojiCount(by: 1)
            }, label: {
                Image(systemName: "plus.square")
            })
        }
    }
    func changeEmojiCount(by value: Int) {
        if (emojiCount + value) > 0 && (emojiCount + value) <= emojis.count {
            emojiCount += value
        }
    }
}

/*
struct ButtonField: View {
    var emojiCount: Int
    
    var body: some View {
        HStack {
            removeButton
            Spacer()
            addButton
        }
        .padding(.horizontal)
        .font(.largeTitle)
    }
    
    let addButton = Button(action: {
        
    }, label: {
        Image(systemName: "plus.square")
    })
    let removeButton = Button(action: {
        
    }, label: {
        Image(systemName: "minus.square")
    })

}
*/



struct CardView: View {
    @State var isFaceUp: Bool = true
    var contentEmoji: String
    
    var body: some View {
        ZStack {
            let rectangleShape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                rectangleShape.fill().foregroundColor(.white)
                rectangleShape.strokeBorder(lineWidth: 3)
                Text(contentEmoji).font(.largeTitle)
            } else {
                rectangleShape.fill()
            }
        }
        .foregroundColor(.orange)
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}

















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
