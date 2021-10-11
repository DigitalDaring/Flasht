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
    var successRemoval: (() -> Void)? = nil
    var failureRemoval: (() -> Void)? = nil
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    
    static var example: CardView {
        CardView(card: CardModel(callText: "Ich bin ein Berliner", answerText: "I am a donut"))
    }
    
    func getFadeOut(offsetWidth: CGFloat) -> Double {
        return 2 - Double(abs(offsetWidth / 50))
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
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width * 5, y: 0)
        .opacity(getFadeOut(offsetWidth: offset.width))
        .gesture(
            DragGesture()
                .onChanged {gesture in self.offset = gesture.translation}
                .onEnded { _ in
                    if abs(self.offset.width) > 100 {
                        isShowingAnswer = false
                        if(self.offset.width > 0) {
                            self.successRemoval?()
                        } else {
                            self.failureRemoval?()
                        }
                        self.offset = .zero
                    } else {
                        self.offset = .zero
                    }
                }
        )
        .onTapGesture {
            self.isShowingAnswer.toggle()
        }
    }
}
