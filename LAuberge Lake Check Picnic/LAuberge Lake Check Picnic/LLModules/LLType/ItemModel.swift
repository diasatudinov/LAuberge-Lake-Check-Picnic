//
//  ItemModel.swift
//  LAuberge Lake Check Picnic
//
//

import SwiftUI

struct TypeModel: Codable, Hashable, Identifiable {
    let id = UUID()
    var name: String
    var mood: String
    var items: [Item]
    var activities: [Activity]
}

struct Item: Codable, Hashable, Identifiable {
    let id = UUID()
    var name: String
    var quantity: String
    var typesOfRecreation: [TypeModel]
    
    var imageData: Data?
    var image: UIImage? {
        get {
            guard let imageData else { return nil }
            return UIImage(data: imageData)
        }
        set {
            imageData = newValue?.jpegData(compressionQuality: 0.8)
        }
    }
    
}

struct Activity: Codable, Hashable, Identifiable {
    let id = UUID()
    var name: String
    var participants: String
    var duration: String
    var typesOfRecreation: [TypeModel]
    
}
