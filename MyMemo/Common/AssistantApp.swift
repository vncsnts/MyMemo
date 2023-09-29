//
//  AssistantApp.swift
//  Assistant
//
//  Created by Vince Carlo Santos on 5/24/23.
//

import SwiftUI

@main
struct AssistantApp: App {
    @StateObject private var memoryStorage = MemoryStorage()
    
    
    var body: some Scene {
        WindowGroup {
            BaseView(memoryStorage: memoryStorage)
        }
    }
}
