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

struct CardStackModel: Codable, Identifiable {
    var id = UUID()
    var stackTitle = ""
    var cards: Array<CardModel> = []
}

struct FullDeckModel: Codable {
    var cardStacks: Array<CardStackModel> = []
}
