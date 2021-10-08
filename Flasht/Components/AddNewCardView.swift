//
//  AddNewCardView.swift
//  Flasht
//
//  Created by Edmund Bates on 10/8/21.
//

import Foundation
import SwiftUI

struct AddNewCardView: View {
    @State var deckCollection: DeckCollectionModel
    @State var deck: DeckModel
    @State var onAddCard: (_ callText: String, _ answerText: String) -> Void
    
    @State private var callText = ""
    @State private var answerText = ""
    
    @Environment(\.presentationMode) var presentation
    
    func saveCard() {
        onAddCard(callText, answerText)
        self.presentation.wrappedValue.dismiss()
    }

    var body: some View {
        VStack {
            Text("What should the front of this card say?")
            TextField("", text: $callText)
            Text("What should the back of this card say?")
            TextField("", text: $answerText)
            Button(action: {self.saveCard()}) {
                Text("Save")
            }
        }.navigationTitle("Adding a card to " + deck.deckTitle)
    }
}
