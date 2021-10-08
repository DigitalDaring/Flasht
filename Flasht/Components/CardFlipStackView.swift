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
        let scale = 1.0 - offset * 0.011
        return self.offset(CGSize(width: 0, height: offset * -15)).scaleEffect(scale)
    }
}

struct CardFlipStackView: View {
    
    @State var cards: Array<CardModel> = []
    
    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    ForEach(0..<cards.count, id: \.self) { index in
                        CardView(card: self.cards[index]).stacked(at: index, in: cards.count)
                    }
                }
            }
        }
    }
    
}
