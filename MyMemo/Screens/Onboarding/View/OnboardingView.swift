//
//  OnboardingView.swift
//  Assistant
//
//  Created by Vince Carlo Santos on 5/24/23.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject var viewModel = OnboardingViewModel()
    
    @State var isAnimating = false
    
    var body: some View {
        ZStack {
            Color.accentColor
                .ignoresSafeArea(.all, edges: .all)
            
            VStack {
                Spacer()
                
                VStack {
                    Text("My Memo.")
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                    
                    Text("""
                    Get reminded of things, with a single tap.
                    """)
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                }
                .opacity(isAnimating ? 1: 0)
                .offset(y: isAnimating ? 0 : -40)
                .animation(.easeIn(duration: 1), value: isAnimating)
                
                ZStack {
                    CircleGroupView(shapeColor: .white, shapeOpacity: 0.2)
                        .blur(radius: isAnimating ? 0 : 10)
                        .opacity(isAnimating ? 1 : 0)
                        .scaleEffect(isAnimating ? 1 : 0.5)
                        .animation(.easeOut, value: isAnimating)
                        .padding()
                    Image("character-1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .levitate()
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeIn(duration: 0.5), value: isAnimating)
                }
                .padding()
                
                Spacer()
                
                SwipeButtonView {
                    viewModel.baseViewState = BaseViewState.home.rawValue
                }
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 40)
                .animation(.easeOut(duration: 1), value: isAnimating)
            }
        }
        .onAppear {
            isAnimating = true
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
