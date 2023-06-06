//
//  HomeViewModel.swift
//  Assistant
//
//  Created by Vince Carlo Santos on 5/29/23.
//

import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var showReminderOptions = false
    @Published var sheetState: HomeViewState?
}

enum HomeViewState: Identifiable {
    var id: Int {
        hashValue
    }
    case audioRecording
    case text
}
