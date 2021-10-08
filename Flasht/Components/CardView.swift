//
//  CardView.swift
//  Flasht
//
//  Created by Edmund Bates on 10/8/21.
//

import Foundation
import SwiftUI

struct CardView: View {
    
    var card: CardModel
    @State private var isShowingAnswer = false
    
    static var example: CardView {
        CardView(card: CardModel(callText: "Ich bin ein Berliner", answerText: "I am a donut"))
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous).fill(Color.white).shadow(radius: 10)
            VStack {
                Text(card.callText)
                    .font(.largeTitle)
                    .foregroundColor(.black)
                if(isShowingAnswer) {
                    Text(card.answerText)
                        .font(.title)
                        .foregroundColor(.gray)
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 320, height: 500)
        .onTapGesture {
            self.isShowingAnswer.toggle()
        }
    }
}
