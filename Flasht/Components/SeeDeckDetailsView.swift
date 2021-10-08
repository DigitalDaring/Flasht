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
    
    var body: some View {
        VStack {
            Text("\(deck.cards.count) Cards").padding(.bottom, 75)
            CardFlipStackView(cards: deck.cards)
            NavigationLink(destination: EditDeckDetailsView(deckCollection: deckCollection, deck: deck), isActive: $isEditStackLinkActive) {
                Button(action: {self.isEditStackLinkActive = true}) {
                    Label("Add/Edit Cards", systemImage: "compose")
                }
            }
        }.navigationTitle($deck.wrappedValue.deckTitle)
    }
}
