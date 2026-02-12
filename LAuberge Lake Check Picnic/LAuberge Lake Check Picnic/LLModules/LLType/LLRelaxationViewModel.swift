//
//  LLRelaxationViewModel.swift
//  LAuberge Lake Check Picnic
//
//

import SwiftUI

class LLRelaxationViewModel: ObservableObject {
    // MARK: – Published variables
    
    @Published var types: [TypeModel] = [
        TypeModel(name: "Picnic by the Lake", mood: "typeImageLL1", items: [], activities: []),
        TypeModel(name: "River Barbecue", mood: "typeImageLL2", items: [], activities: []),
        TypeModel(name: "Day with Kids", mood: "typeImageLL3", items: [], activities: []),
        TypeModel(name: "Kayaking & SUP", mood: "typeImageLL4", items: [], activities: []),
        TypeModel(name: "Fishing", mood: "typeImageLL5", items: [], activities: []),
        TypeModel(name: "Overnight by the Water", mood: "typeImageLL6", items: [], activities: []),
        TypeModel(name: "Yoga on the Shore", mood: "typeImageLL7", items: [], activities: []),
        TypeModel(name: "Romantic Dinner", mood: "typeImageLL8", items: [], activities: []),
        TypeModel(name: "Cold Water Swim", mood: "typeImageLL9", items: [], activities: []),
        TypeModel(name: "Birthday by the Water", mood: "typeImageLL10", items: [], activities: []),
    ] {
        didSet { saveTypes() }
    }
    
    @Published var items: [Item] = [
        Item(name: "Towel", quantity: "", typesOfRecreation: [], check: false, assetImageName: "itemImgLL1"),
        Item(name: "Picnic blanket", quantity: "", typesOfRecreation: [], check: false, assetImageName: "itemImgLL2"),
        Item(name: "Thermos", quantity: "", typesOfRecreation: [], check: false, assetImageName: "itemImgLL3"),
        Item(name: "Drinking water", quantity: "", typesOfRecreation: [], check: false, assetImageName: "itemImgLL4"),
        Item(name: "Napkins", quantity: "", typesOfRecreation: [], check: false, assetImageName: "itemImgLL5"),
        Item(name: "Trash bag", quantity: "", typesOfRecreation: [], check: false, assetImageName: "itemImgLL6"),
        Item(name: "Sunscreen", quantity: "", typesOfRecreation: [], check: false, assetImageName: "itemImgLL7"),
        Item(name: "Umbrella", quantity: "", typesOfRecreation: [], check: false, assetImageName: "itemImgLL8"),
        Item(name: "Ball", quantity: "", typesOfRecreation: [], check: false, assetImageName: "itemImgLL9"),
        Item(name: "Portable speaker", quantity: "", typesOfRecreation: [], check: false, assetImageName: "itemImgLL10"),
        Item(name: "Knife", quantity: "", typesOfRecreation: [], check: false, assetImageName: "itemImgLL11"),
        Item(name: "Cutting board", quantity: "", typesOfRecreation: [], check: false, assetImageName: "itemImgLL12"),
        Item(name: "Disposable tableware", quantity: "", typesOfRecreation: [], check: false, assetImageName: "itemImgLL13"),
        Item(name: "Grill", quantity: "", typesOfRecreation: [], check: false, assetImageName: "itemImgLL14"),
        Item(name: "Charcoal", quantity: "", typesOfRecreation: [], check: false, assetImageName: "itemImgLL15"),
        Item(name: "Insect repellent", quantity: "", typesOfRecreation: [], check: false, assetImageName: "itemImgLL16"),
        Item(name: "First aid kit", quantity: "", typesOfRecreation: [], check: false, assetImageName: "itemImgLL17"),
        Item(name: "Flashlight", quantity: "", typesOfRecreation: [], check: false, assetImageName: "itemImgLL18"),
        Item(name: "Float", quantity: "", typesOfRecreation: [], check: false, assetImageName: "itemImgLL19"),
        Item(name: "Life jacket", quantity: "", typesOfRecreation: [], check: false, assetImageName: "itemImgLL20"),
        Item(name: "Test", quantity: "", typesOfRecreation: [], check: false),

        
    ] {
        didSet { saveItems() }
    }
    
    @Published var activities: [Activity] = [
        Activity(name: "Volleyball", participants: "4", duration: "30", typesOfRecreation: []),
        Activity(name: "Kayaking", participants: "2", duration: "45", typesOfRecreation: []),
        Activity(name: "SUP", participants: "1", duration: "40", typesOfRecreation: []),
        Activity(name: "Fishing", participants: "1", duration: "60", typesOfRecreation: []),
        Activity(name: "Treasure Hunt", participants: "4", duration: "45", typesOfRecreation: []),
        Activity(name: "Photo Session", participants: "2", duration: "20", typesOfRecreation: []),
        Activity(name: "Yoga on the Shore", participants: "2", duration: "30", typesOfRecreation: []),
        Activity(name: "Kite Flying", participants: "2", duration: "25", typesOfRecreation: []),
        Activity(name: "Water Polo", participants: "6", duration: "40", typesOfRecreation: []),
        Activity(name: "Raft Building", participants: "4", duration: "60", typesOfRecreation: []),
        
        Activity(name: "Reading Books", participants: "1", duration: "30", typesOfRecreation: []),
        Activity(name: "Karaoke", participants: "5", duration: "40", typesOfRecreation: []),
        Activity(name: "Board Games", participants: "4", duration: "35", typesOfRecreation: []),
        Activity(name: "Bathing", participants: "2", duration: "20", typesOfRecreation: []),
        Activity(name: "Shell Collecting", participants: "2", duration: "30", typesOfRecreation: []),
        Activity(name: "Campfire Singing", participants: "4", duration: "30", typesOfRecreation: []),
        Activity(name: "Drawing", participants: "1", duration: "25", typesOfRecreation: []),
        Activity(name: "Bird Watching", participants: "1", duration: "30", typesOfRecreation: []),
        Activity(name: "Meditation", participants: "1", duration: "20", typesOfRecreation: []),
        Activity(name: "Swimming", participants: "2", duration: "30", typesOfRecreation: []),
    ] {
        didSet { saveActivities() }
    }
    
    
    // MARK: – UserDefaults keys
    private var fileURL: URL {
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return dir.appendingPathComponent("items.json")
    }
    
    private var activityFileURL: URL {
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return dir.appendingPathComponent("activities.json")
    }
    
    private var typesFileURL: URL {
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return dir.appendingPathComponent("types.json")
    }
    
    // MARK: – Init
    init() {
        loadItems()
        loadActivities()
        loadTypes()
    }
    
    // MARK: – Save / Load Backgrounds
    
    private func saveItems() {
        let url = fileURL
        do {
            let data = try JSONEncoder().encode(items)
            try data.write(to: url, options: [.atomic])
        } catch {
            print("Failed to save myDives:", error)
        }
    }
    
    private func loadItems() {
        let url = fileURL
        guard FileManager.default.fileExists(atPath: url.path) else {
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let itemsData = try JSONDecoder().decode([Item].self, from: data)
            items = itemsData
        } catch {
            print("Failed to load myDives:", error)
        }
    }
    
    private func saveActivities() {
        let url = activityFileURL
        do {
            let data = try JSONEncoder().encode(activities)
            try data.write(to: url, options: [.atomic])
        } catch {
            print("Failed to save myDives:", error)
        }
    }
    
    private func loadActivities() {
        let url = activityFileURL
        guard FileManager.default.fileExists(atPath: url.path) else {
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let activitiesData = try JSONDecoder().decode([Activity].self, from: data)
            activities = activitiesData
        } catch {
            print("Failed to load myDives:", error)
        }
    }
    
    private func saveTypes() {
        let url = typesFileURL
        do {
            let data = try JSONEncoder().encode(types)
            try data.write(to: url, options: [.atomic])
        } catch {
            print("Failed to save myDives:", error)
        }
    }
    
    private func loadTypes() {
        let url = typesFileURL
        guard FileManager.default.fileExists(atPath: url.path) else {
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let typesData = try JSONDecoder().decode([TypeModel].self, from: data)
            types = typesData
        } catch {
            print("Failed to load myDives:", error)
        }
    }
    
    // MARK: – Example buy action
    
    func add(type: TypeModel) {
        guard !types.contains(type) else { return }
        types.append(type)
        
    }
    
    func delete(type: TypeModel) {
        guard let index = types.firstIndex(of: type) else { return }
        types.remove(at: index)
    }
    
    func add(item: Item) {
        guard !items.contains(item) else { return }
        items.append(item)
        
    }
    
    func delete(item: Item) {
        guard let index = items.firstIndex(of: item) else { return }
        items.remove(at: index)
    }
    
    func add(activity: Activity) {
        guard !activities.contains(activity) else { return }
        activities.append(activity)
        
    }
    
    func delete(activity: Activity) {
        guard let index = activities.firstIndex(of: activity) else { return }
        activities.remove(at: index)
    }
    
    func deleteActivityType(type: TypeModel, activity: Activity) {
        guard let typeIndex = types.firstIndex(of: type) else { return }
        guard let activityIndex = types[typeIndex].activities.firstIndex(of: activity) else { return }
        
        types[typeIndex].activities.remove(at: activityIndex)
    }
    
    func checkItemToggle(type: TypeModel, item: Item) {
        guard let typeIndex = types.firstIndex(of: type) else { return }
        guard let itemIndex = types[typeIndex].items.firstIndex(of: item) else { return }
        types[typeIndex].items[itemIndex].check.toggle()
    }
    
    func deleteItemType(type: TypeModel, item: Item) {
        guard let typeIndex = types.firstIndex(of: type) else { return }
        guard let itemIndex = types[typeIndex].items.firstIndex(of: item) else { return }
        
        types[typeIndex].items.remove(at: itemIndex)
    }
    
    func addItemType(type: TypeModel, item: Item) {
        guard let typeIndex = types.firstIndex(of: type) else { return }
        types[typeIndex].items.append(item)
    }
    
    func addActivityType(type: TypeModel, activity: Activity) {
        guard let typeIndex = types.firstIndex(of: type) else { return }
        types[typeIndex].activities.append(activity)
    }
    
    private func getFiveRandomItems() -> [Item] {
        Array(items.shuffled().prefix(5)).map { item in
            var updated = item
            updated.quantity = String(Int.random(in: 1...4))
            return updated
        }
    }
    
    func generateChecklistOfItems(type: TypeModel) {
        guard let typeIndex = types.firstIndex(of: type) else { return }
        types[typeIndex].items = getFiveRandomItems()
    }
    
    private func getFiveRandomActivities() -> [Activity] {
        Array(activities.shuffled().prefix(5)).map { item in
            var updated = item
            return updated
        }
    }
    
    func generateChecklistOfActivities(type: TypeModel) {
        guard let typeIndex = types.firstIndex(of: type) else { return }
        types[typeIndex].activities = getFiveRandomActivities()
    }
    
    func addItemToSelectedTypes(
        selectedTypeIDs: Set<UUID>,
        item: Item
    ) {
        for index in types.indices {
            if selectedTypeIDs.contains(types[index].id) {
                types[index].items.append(item)
            }
        }
    }
    
    func addActivityToSelectedTypes(
        selectedTypeIDs: Set<UUID>,
        activity: Activity
    ) {
        for index in types.indices {
            if selectedTypeIDs.contains(types[index].id) {
                types[index].activities.append(activity)
            }
        }
    }
}
