//
//  CardModels.swift
//  Flasht
//
//  Created by Edmund Bates on 10/1/21.
//

import Foundation

struct CardModel: Codable, Identifiable {
    var id = UUID()
    var callText = ""
    var answerText = ""
    var lastSeen = Date.distantPast
    var learningProgress = 0
}

struct DeckModel: Codable, Identifiable {
    var id = UUID()
    var deckTitle = ""
    var cards: Array<CardModel> = []
}

struct DeckCollectionModel: Codable {
    var decks: Array<DeckModel> = []
}
