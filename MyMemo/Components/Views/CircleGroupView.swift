//
//  CircleGroupView.swift
//  Assistant
//
//  Created by Vince Carlo Santos on 5/24/23.
//

import SwiftUI

struct CircleGroupView: View {
    //MARK - PROPERTY
    
    @State var shapeColor: Color
    @State var shapeOpacity: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(shapeColor.opacity(shapeOpacity), lineWidth: 40)
                .padding()
            Circle()
                .stroke(shapeColor.opacity(shapeOpacity), lineWidth: 80)
                .padding()
        }
        .padding()
    }
}

struct CircleGroupView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.accentColor
                .ignoresSafeArea()
            CircleGroupView(shapeColor: .white, shapeOpacity: 0.2)
        }
    }
}
