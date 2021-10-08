//
//  HomeView.swift
//  Flasht
//
//  Created by Edmund Bates on 10/8/21.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @State var deckCollection: DeckCollectionModel
    @State private var isCreateLinkActive = false
    
    var body: some View {
        List {
            ForEach(deckCollection.decks){ deck in
                DeckView(deckCollection: deckCollection, deck: deck)
            }
            NavigationLink(destination: CreateDeckView(deckCollection: deckCollection), isActive: $isCreateLinkActive) {
                Button(action: {self.isCreateLinkActive = true}) {
                    Label("Create New Card Deck", systemImage: "folder.badge.plus")
                }
            }
            
        }.onAppear(perform: {
            deckCollection = CardStorageService().loadDeckCollectionFromStorage()
        }).navigationTitle("Let's learn some stuff!")
    }
}
