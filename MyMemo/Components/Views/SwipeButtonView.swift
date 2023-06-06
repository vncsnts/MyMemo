//
//  SwipeButtonView.swift
//  Assistant
//
//  Created by Vince Carlo Santos on 5/24/23.
//

import SwiftUI

struct SwipeButtonView: View {
    @State var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State var buttonOffset: CGFloat = 0
    var doneAction: () -> Void
    var resetAction: (() -> Void)?
    var percentage: ((Int) -> Void)?
    
    var body: some View {
        ZStack {
            Capsule()
                .fill(Color.white.opacity(0.2))
            Capsule()
                .fill(Color.white.opacity(0.2))
                .padding()
            
            HStack {
                Capsule()
                    .fill(Color.red.gradient)
                    .frame(width: 80)
                Spacer()
            }
            
            Text("Get Started")
                .font(.system(.title3, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .offset(x: 20)
            
            HStack {
                Capsule()
                    .fill(Color.red.gradient)
                    .frame(width: buttonOffset + 80)
                Spacer()
            }
            
            HStack {
                ZStack {
                    Circle()
                        .fill(Color.red.gradient)
                    Circle()
                        .fill(Color.black.opacity(0.1))
                        .padding()
                    Image(systemName: "chevron.right.2")
                        .font(.system(size: 24))
                }
                .foregroundColor(.white)
                .frame(width: 80, height: 80, alignment: .center)
                .offset(x: buttonOffset)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            if gesture.translation.width > 0 && buttonOffset <= buttonWidth - 80 {
                                buttonOffset = gesture.translation.width
                                calculatePercentage()
                            }
                        }
                        .onEnded { _ in
                            if buttonOffset > buttonWidth / 2 {
                                doneAction()
                            } else {
                                buttonOffset = 0
                                resetAction?()
                            }
                        }
                )
                Spacer()
            }
        }
        .frame(width: buttonWidth, height: 80, alignment: .center)
        .padding()
    }
    
    func calculatePercentage() {
        let totalWidth = buttonWidth - 80
        let progress = buttonOffset / totalWidth
        let percentValue = Int(progress * 100)
        
        percentage?(percentValue)
    }
}

struct SwipeButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeButtonView {
            
        }
    }
}
