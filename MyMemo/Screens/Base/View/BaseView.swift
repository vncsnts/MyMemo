//
//  BaseView.swift
//  Assistant
//
//  Created by Vince Carlo Santos on 5/24/23.
//

import SwiftUI

struct BaseView: View {
    @StateObject var viewModel = BaseViewModel()
    
    var body: some View {
        ZStack {
            if viewModel.baseViewState == BaseViewState.onboarding.rawValue {
                OnboardingView()
            } else if viewModel.baseViewState == BaseViewState.home.rawValue {
                HomeView()
            }
        }
    }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}
