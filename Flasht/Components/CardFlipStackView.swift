//
//  CardFlipStackView.swift
//  Flasht
//
//  Created by Edmund Bates on 10/8/21.
//

import Foundation
import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = CGFloat(total - position)
        let scale = 1.0 - offset * 0.012
        return self.offset(CGSize(width: 0, height: offset * -12)).scaleEffect(scale).opacity(scale)
    }
}

struct CardFlipStackView: View {
    
    @State var cards: Array<CardModel> = []
    func moveCardToBack(at index: Int) {
        let movedCard = cards[index]
        cards.remove(at: index)
        delaySlideCardIntoBack(movedCard: movedCard)
    }
    
    private func delaySlideCardIntoBack(movedCard: CardModel) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            cards.insert(movedCard, at: 0)
        }
    }
    
    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    ForEach(0..<cards.count, id: \.self) { index in
                        CardView(card: self.cards[index],
                            successRemoval: {
                                withAnimation {
                                    self.moveCardToBack(at: index)
                                }
                            },
                            failureRemoval:  {
                                withAnimation {
                                    self.moveCardToBack(at: index)
                            }
                        }).stacked(at: index, in: cards.count)
                    }
                }
            }
        }
    }
    
}
