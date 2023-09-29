//
//  BaseView.swift
//  Assistant
//
//  Created by Vince Carlo Santos on 5/24/23.
//

import SwiftUI

struct BaseView: View {
    @ObservedObject var memoryStorage: MemoryStorage
    @StateObject var viewModel = BaseViewModel()
    
    init(memoryStorage: MemoryStorage) {
        self.memoryStorage = memoryStorage
    }
    
    var body: some View {
        ZStack {
            if viewModel.baseViewState == BaseViewState.onboarding.rawValue {
                OnboardingView()
            } else if viewModel.baseViewState == BaseViewState.home.rawValue {
                HomeView(memoryStorage: memoryStorage)  
            }
        }
    }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView(memoryStorage: MemoryStorage())
    }
}
