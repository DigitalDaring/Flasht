//
//  ContentView.swift
//  Flasht
//
//  Created by Edmund Bates on 10/1/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        WelcomeView()
    }
}

struct WelcomeView: View {
    var body: some View {
        NavigationView {
            HomeView(deckCollection: DeckCollectionModel())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
