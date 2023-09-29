//
//  OnboardingViewModel.swift
//  Assistant
//
//  Created by Vince Carlo Santos on 5/24/23.
//

import Foundation
import SwiftUI

extension OnboardingView {
    @MainActor
    final class OnboardingViewModel: ObservableObject {
        @AppStorage("baseViewState") var baseViewState: Int = 0
    }
}

