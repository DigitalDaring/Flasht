//
//  SeeDeckDetailsView.swift
//  Flasht
//
//  Created by Edmund Bates on 10/8/21.
//

import Foundation
import SwiftUI

struct SeeDeckDetailsView: View {
    @State var deckCollection: DeckCollectionModel
    @State var deck: DeckModel
    @State var isEditStackLinkActive = false
    
    private func succeedAtCard(index: Int) -> Void {
        
    }
    
    private func failAtCard(index: Int) -> Void {
        
    }
    
    func appendCard(card: CardModel) -> Void {
        deck.cards.append(card)
    }
    
    func moveCardToBack(at index: Int) {
        let movedCard = deck.cards[index]
        deck.cards.remove(at: index)
        delaySlideCardIntoBack(movedCard: movedCard)
    }
    
    private func delaySlideCardIntoBack(movedCard: CardModel) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            deck.cards.insert(movedCard, at: 0)
        }
    }
    
    var body: some View {
        VStack {
            Text("\(deck.cards.count) Cards").padding(.bottom, 75)
            ZStack {
                VStack {
                    ZStack {
                        ForEach(0..<deck.cards.count, id: \.self) { index in
                            CardView(card: self.deck.cards[index],
                                successRemoval: {
                                    withAnimation {
                                        self.moveCardToBack(at: index)
                                    }
                                },
                                failureRemoval:  {
                                    withAnimation {
                                        self.moveCardToBack(at: index)
                                }
                            }).stacked(at: index, in: deck.cards.count)
                        }
                    }
                }
            }
            NavigationLink(destination: EditDeckDetailsView(deckCollection: deckCollection, deck: deck, onAddCard: {self.appendCard(card: $0)}), isActive: $isEditStackLinkActive) {
                Button(action: {self.isEditStackLinkActive = true}) {
                    Label("Add/Edit Cards", systemImage: "compose")
                }
            }
        }.navigationTitle($deck.wrappedValue.deckTitle)
    }
}
