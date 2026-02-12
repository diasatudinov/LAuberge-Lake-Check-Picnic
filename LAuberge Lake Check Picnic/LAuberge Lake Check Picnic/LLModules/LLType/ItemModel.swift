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
    let id: UUID
    var name: String
    var quantity: String
    var typesOfRecreation: [TypeModel]
    var check: Bool

    // 1) если картинка из ImagePicker
    var imageData: Data?

    // 2) если картинка из Assets
    var assetImageName: String?

    init(
        id: UUID = UUID(),
        name: String,
        quantity: String,
        typesOfRecreation: [TypeModel],
        check: Bool,
        imageData: Data? = nil,
        assetImageName: String? = nil
    ) {
        self.id = id
        self.name = name
        self.quantity = quantity
        self.typesOfRecreation = typesOfRecreation
        self.check = check
        self.imageData = imageData
        self.assetImageName = assetImageName
    }

    /// Единый источник картинки для UI
    var uiImage: UIImage? {
        if let data = imageData, let img = UIImage(data: data) {
            return img
        }
        if let name = assetImageName, let img = UIImage(named: name) {
            return img
        }
        return nil
    }

    mutating func setPickedImage(_ image: UIImage?) {
        imageData = image?.jpegData(compressionQuality: 0.8)
        assetImageName = nil // если выбрали свою — считаем её приоритетной
    }

    mutating func setAssetImage(name: String?) {
        assetImageName = name
        if name != nil { imageData = nil } // если выбрали ассет — чистим пикер
    }
}

struct Activity: Codable, Hashable, Identifiable {
    let id = UUID()
    var name: String
    var participants: String
    var duration: String
    var typesOfRecreation: [TypeModel]
    
}
