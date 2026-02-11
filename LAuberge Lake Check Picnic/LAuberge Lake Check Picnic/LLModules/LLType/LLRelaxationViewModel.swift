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
        
    ] {
        didSet { saveItems() }
    }
    
    @Published var activities: [Activity] = [
        
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
    
}
