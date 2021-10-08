//
//  DeckView.swift
//  Flasht
//
//  Created by Edmund Bates on 10/8/21.
//

import Foundation
import SwiftUI

struct DeckView: View {
    @State var deckCollection: DeckCollectionModel
    @State var deck: DeckModel
    @State private var isSeeDetailsLinkActive = false
    var body: some View {
        NavigationLink(destination: SeeDeckDetailsView(deckCollection: deckCollection, deck: deck)) {
            Button(action: {self.isSeeDetailsLinkActive = true}) {
                HStack {
                    Image(systemName: "book")
                        .frame(width: 50, height: 50)
                        .foregroundColor(.purple)
                    Text(deck.deckTitle)
                        .font(.title3)
                        .fontWeight(.thin)
                }
            }
        }
        
    }
}
