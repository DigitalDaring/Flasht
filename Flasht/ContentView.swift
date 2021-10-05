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
            HomeView(fullDeck: FullDeckModel())
        }
    }
    
}

struct SeeCardStackDetailsView: View {
    @State var fullDeck: FullDeckModel
    @State var cardStack: CardStackModel
    @State var isEditStackLinkActive = false
    
    var body: some View {
        VStack {
            NavigationLink(destination: EditCardStackDetailsView(fullDeck: fullDeck, cardStack: cardStack), isActive: $isEditStackLinkActive) {
                Button(action: {self.isEditStackLinkActive = true}) {
                    Label("Edit Cards", systemImage: "compose")
                }
            }
        }.navigationTitle("Details for: " + $cardStack.wrappedValue.stackTitle)
    }
}

struct EditCardStackDetailsView: View {
    @State var fullDeck: FullDeckModel
    @State var cardStack: CardStackModel
    @State var isAddNewLinkActive = false
    
    var body: some View {
        List {
            NavigationLink(destination: AddNewCardView(fullDeck: fullDeck, cardStack: cardStack), isActive: $isAddNewLinkActive) {
                Button(action: {self.isAddNewLinkActive = true}) {
                    Label("Add New Card", systemImage: "folder.badge.plus")
                }
            }
            ForEach(cardStack.cards){ card in
                CardView(card: card)
            }
        }.navigationTitle("Managing your " + cardStack.stackTitle + " cards")
    }
}

struct CardView: View {
    
    var card: CardModel
    
    var body: some View {
        Text(card.callText)
    }
}

struct AddNewCardView: View {
    @State var fullDeck: FullDeckModel
    @State var cardStack: CardStackModel
    
    @State private var callText = ""
    @State private var answerText = ""
    
    @Environment(\.presentationMode) var presentation
    
    func saveCard() {
        if let cardStackIndex = fullDeck.cardStacks.firstIndex(where: {$0.stackTitle == cardStack.stackTitle}) {
            cardStack.cards.append(
                CardModel(callText: callText, answerText: answerText)
            )
            
            fullDeck.cardStacks[cardStackIndex] = cardStack
            CardStorageService().saveFullDeckToStorage(fullDeck: fullDeck)
            self.presentation.wrappedValue.dismiss()
        }
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
        }.navigationTitle("Adding a card to " + cardStack.stackTitle)
    }
}


struct CreateCardStackView : View {
    @State var fullDeck: FullDeckModel
    @State private var title: String = ""
    
    @Environment(\.presentationMode) var presentation
    
    func saveCardStack() {
        fullDeck.cardStacks.append(
            CardStackModel(stackTitle: $title.wrappedValue, cards: [])
        )
        CardStorageService().saveFullDeckToStorage(fullDeck: fullDeck)
        self.presentation.wrappedValue.dismiss()
    }
    
    var body: some View {
        VStack {
            Text("What should we call this card stack?")
            TextField("Name your deck", text: $title)
            Button(action: {self.saveCardStack()}) {
                Text("Save")
            }
        }.navigationTitle("Create A New Card Stack")
    }
}

struct HomeView: View {
    @State var fullDeck: FullDeckModel
    @State private var isCreateLinkActive = false
    
    var body: some View {
        List {
            ForEach(fullDeck.cardStacks){ stack in
                CardStackView(fullDeck: fullDeck, cardStack: stack)
            }
            NavigationLink(destination: CreateCardStackView(fullDeck: fullDeck), isActive: $isCreateLinkActive) {
                Button(action: {self.isCreateLinkActive = true}) {
                    Label("Create New Card Stack", systemImage: "folder.badge.plus")
                }
            }
            
        }.onAppear(perform: {
            fullDeck = CardStorageService().loadFullDeckFromStorage()
        }).navigationTitle("Let's learn some stuff!")
    }
}

struct CardStackView: View {
    var fullDeck: FullDeckModel
    var cardStack: CardStackModel
    @State private var isSeeDetailsLinkActive = false
    var body: some View {
        NavigationLink(destination: SeeCardStackDetailsView(fullDeck: fullDeck, cardStack: cardStack)) {
            Button(action: {self.isSeeDetailsLinkActive = true}) {
                HStack {
                    Image(systemName: "book")
                        .frame(width: 50, height: 50)
                        .foregroundColor(.purple)
                    Text(cardStack.stackTitle)
                        .font(.title3)
                        .fontWeight(.thin)
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
