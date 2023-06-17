//
//  CustomSheetView.swift
//  QTodo-v3.0
//
//  Created by Mehmet Kubilay Akdemir on 17.06.2023.
//

import SwiftUI


struct CustomSheetView: View {
    
    @EnvironmentObject var csm: CustomSheetManager
    
    var body: some View {
        ZStack {
            
            csm.csType == .error ?
                Color.pink.opacity(0.8)
                    .ignoresSafeArea() :
                Color.green.opacity(0.8)
                    .ignoresSafeArea()
            
            VStack(spacing: 10) {
                Image(systemName: csm.csType == .error ? "x.circle" : "checkmark.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.white)
                Group{
                    Text(csm.csMessage)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                    Text(csm.csEmojis)
                }
                .fontWeight(.semibold)
                .font(.title2)
                
            }
            .padding(.horizontal, 20)
        }

    }
}

struct CustomSheetView_Previews: PreviewProvider {
    static var previews: some View {
        CustomSheetView()
            .environmentObject(CustomSheetManager())
    }
}
