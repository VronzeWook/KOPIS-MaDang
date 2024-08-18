//
//  DetailCastingView.swift
//  MaDang
//
//  Created by LDW on 8/16/24.
//

import SwiftUI

struct DetailCastingView: View {
    // test
    let numberOfCircles: Int
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    @Binding var perform: Performance
    
    var body: some View {
        VStack {
            HStack {
                Text("Casting")
                    .fontWeight(.bold)
                    .font(.system(size: 22))
                    .foregroundStyle(.white)
                    .foregroundStyle(.white)
                Spacer()
            }
            
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(0..<numberOfCircles, id: \.self) { _ in
                    VStack{
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .foregroundStyle(.white)
                            .scaledToFit()
                            .frame(width: 80)
                     Text("Se eun Park")
                            .font(.system(size: 16))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            
            Rectangle()
                .foregroundStyle(.gray)
                .frame(height: 1)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 5)
                .padding(.top, 40)
        }
        
        .background(.nineBlack)
    }
}

#Preview {
    DetailCastingView(numberOfCircles: 7, perform: .constant(Performance.performList[0]))
}
