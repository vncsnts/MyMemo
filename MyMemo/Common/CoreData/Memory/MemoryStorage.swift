//
//  DataController.swift
//  MyMemo
//
//  Created by Vince Carlo Santos on 8/24/23.
//

import Foundation
import CoreData

actor MemoryStorage: ObservableObject {
    let container = NSPersistentContainer(name: "MemoryModel")
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load data with error: \(error.localizedDescription)")
            } else {
                print("Successful load of Core Data")
            }
        }
    }
    
    func fetch() async -> [Memory] {
        let request = NSFetchRequest<Memory>(entityName: "Memory")
        
        do {
            let allMemories = try container.viewContext.fetch(request)
            return allMemories
        } catch {
            print("\(error.localizedDescription)")
            return [Memory]()
        }
    }
    
    func save(context: NSManagedObjectContext) async {
        do {
            try context.save()
            print("Saved data to MemoryModel.")
        } catch {
            print("Failed to save data with error: \(error.localizedDescription)")
        }
    }
    
    func addMemory(data: Data, name: String, type: MemoryStorageType) async {
        let memory = Memory(context: container.viewContext)
        memory.id = UUID()
        memory.date = Date()
        memory.name = name
        memory.data = data
        memory.type = type.rawValue
        
        await save(context: container.viewContext)
    }
    
    func updateMemory(memory: Memory, name: String) async {
        memory.name = name
        
        await save(context: container.viewContext)
    }
}

enum MemoryStorageType: String {
    case text = "text"
    case audio = "audio"
}
