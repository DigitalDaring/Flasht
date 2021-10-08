//
//  CreateDeckView.swift
//  Flasht
//
//  Created by Edmund Bates on 10/8/21.
//

import Foundation
import SwiftUI

struct CreateDeckView : View {
    @State var deckCollection: DeckCollectionModel
    @State private var title: String = ""
    
    @Environment(\.presentationMode) var presentation
    
    func saveDeck() {
        deckCollection.decks.append(
            DeckModel(deckTitle: $title.wrappedValue, cards: [])
        )
        CardStorageService().saveDeckCollectionToStorage(deckCollection: deckCollection)
        self.presentation.wrappedValue.dismiss()
    }
    
    var body: some View {
        VStack {
            Text("What should we call this deck of cards?")
            TextField("Name your deck", text: $title)
            Button(action: {self.saveDeck()}) {
                Text("Save")
            }
        }.navigationTitle("Create A New Card Deck")
    }
}
