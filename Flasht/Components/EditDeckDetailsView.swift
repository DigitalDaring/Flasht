//
//  EditDeckDetailsView.swift
//  Flasht
//
//  Created by Edmund Bates on 10/8/21.
//

import Foundation
import SwiftUI

struct EditDeckDetailsView: View {
    @State var deckCollection: DeckCollectionModel
    @State var deck: DeckModel
    @State var isAddNewLinkActive = false

    func saveCard(callText: String, answerText: String) {
        if let deckIndex = deckCollection.decks.firstIndex(where: {$0.deckTitle == deck.deckTitle}) {
            let newCard = CardModel(callText: callText, answerText: answerText)
            deck.cards.append(
                newCard
            )
            
            deckCollection.decks[deckIndex] = deck
            CardStorageService().saveDeckCollectionToStorage(deckCollection: deckCollection)
        }
    }
    
    var body: some View {
        List {
            NavigationLink(destination: AddNewCardView(deckCollection: deckCollection, deck: deck, onAddCard: {self.saveCard(callText: $0, answerText: $1)}), isActive: $isAddNewLinkActive) {
                Button(action: {self.isAddNewLinkActive = true}) {
                    Label("Add New Card", systemImage: "folder.badge.plus")
                }
            }
            ForEach(deck.cards){ card in
                Text(card.callText)
            }
        }.navigationTitle("Managing your " + deck.deckTitle + " cards")
    }
}
