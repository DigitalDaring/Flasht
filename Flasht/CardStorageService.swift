//
//  CardStorageService.swift
//  Flasht
//
//  Created by Edmund Bates on 10/1/21.
//

import Foundation

class CardStorageService {
    let ourCardStacksFile = "CardStacksFile"
    
    enum CardStorageServiceErrors: Error {
        case weirdEncodingError
    }
    
    private func documentDirectory() -> String {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        return documentDirectory[0]
    }

    private func append(toPath path: String, withPathComponent pathComponent: String) -> String? {
        if var pathUrl = URL(string: path) {
            pathUrl.appendPathComponent(pathComponent)
            return pathUrl.absoluteString
        }
        return nil
    }

    private func read(fromDocumentsWithFileName fileName: String) -> String? {
        guard let filePath = self.append(toPath: self.documentDirectory(), withPathComponent: fileName) else {
            return nil
        }
        
        do {
            let savedString = try String(contentsOfFile: filePath)
            return savedString
        } catch {
            print("Error occurred while loading file");
            return nil
        }
    }
    
    private func save(text: String, toDirectory directory: String, withFileName fileName: String) {
        guard let filePath = self.append(toPath: directory, withPathComponent: fileName) else {
            return
        }
        
        do {
            try text.write(toFile: filePath, atomically: true, encoding: .utf8)
        } catch {
            print("Error occured while saving the file", error)
            return
        }
        
        print("File successfully saved")
    }
    
    public func loadFullDeckFromStorage() -> FullDeckModel {
        let defaultDeck = FullDeckModel(cardStacks: [])
        
        guard let jsonString = self.read(fromDocumentsWithFileName: ourCardStacksFile) else {
            return defaultDeck
        }
        
        if let dataFromString = jsonString.data(using: .utf8) {
            do {
                let modelFromData = try JSONDecoder().decode(FullDeckModel.self, from: dataFromString)
                return modelFromData
            } catch {
                print("Error occured while decoding JSON in file", error)
                return defaultDeck
            }
        }
        
        return defaultDeck
    }
    
    
    public func saveFullDeckToStorage(fullDeck: FullDeckModel) {
        do {
            let encodedDeck = try JSONEncoder().encode(fullDeck)
            guard let jsonString = String(data: encodedDeck, encoding: .utf8) else { throw CardStorageServiceErrors.weirdEncodingError }
            self.save(text: jsonString, toDirectory: self.documentDirectory(), withFileName: ourCardStacksFile)
        } catch {
            print("Error occurred while encoding JSON", error)
        }
        
    }
}
