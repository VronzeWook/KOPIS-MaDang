//
//  AboutUsView.swift
//  MaDang
//
//  Created by LDW on 8/26/24.
//

import SwiftUI

struct AboutUsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("SaejakSaejak")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.nineYellow)
                
                Spacer()
            }
            .padding(.top, 24)
            .padding(.horizontal, 24)

            Divider()
                .background(Color.nineDarkGray)
                .padding(.horizontal, 24)
            
            Text("We are Team 'SaejakSaejak'. We are developing a service to enhance performing arts in Korea.")
                .font(.body)
                .foregroundStyle(.white)
                .padding(.horizontal, 24)

            Divider()
                .background(Color.nineDarkGray)
                .padding(.horizontal, 24)

            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Circle()
                        .fill(Color.nineYellow)
                        .frame(width: 12, height: 12)
                    Text("Andrew - iOS Developer")
                        .font(.callout)
                        .foregroundStyle(.white)
                }
                
                HStack {
                    Circle()
                        .fill(Color.nineYellow)
                        .frame(width: 12, height: 12)
                    Text("Sadie - iOS Developer")
                        .font(.callout)
                        .foregroundStyle(.white)
                }

                HStack {
                    Circle()
                        .fill(Color.nineYellow)
                        .frame(width: 12, height: 12)
                    Text("Nine - Designer")
                        .font(.callout)
                        .foregroundStyle(.white)
                }
            }
            .padding(.horizontal, 24)

            Spacer()
        }
        .background(Color.nineBlack.edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    AboutUsView()
}

#Preview {
    AboutUsView()
}
