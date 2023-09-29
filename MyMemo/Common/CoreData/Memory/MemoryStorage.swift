//
//  DataController.swift
//  MyMemo
//
//  Created by Vince Carlo Santos on 8/24/23.
//

import Foundation
import CoreData

final class MemoryStorage: ObservableObject {
    let container = NSPersistentContainer(name: "MemoryModel")
    @Published var memories: [Memory] = []
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load data with error: \(error.localizedDescription)")
            } else {
                print("Successful load of Core Data")
            }
        }
        fetch()
    }
    
    func fetch() {
        let request = NSFetchRequest<Memory>(entityName: "Memory")
        
        do {
            let allMemories = try container.viewContext.fetch(request)
            memories = allMemories
        } catch {
            print("\(error.localizedDescription)")
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            fetch()
            print("Saved data to MemoryModel.")
        } catch {
            print("Failed to save data with error: \(error.localizedDescription)")
        }
    }
    
    func addMemory(data: Data, name: String, type: MemoryStorageType) {
        let memory = Memory(context: container.viewContext)
        memory.id = UUID()
        memory.date = Date()
        memory.name = name
        memory.data = data
        memory.type = type.rawValue
        
        save(context: container.viewContext)
    }
    
    func updateMemory(memory: Memory, name: String) {
        memory.name = name
        
        save(context: container.viewContext)
    }
}

enum MemoryStorageType: String {
    case text = "text"
    case audio = "audio"
}
