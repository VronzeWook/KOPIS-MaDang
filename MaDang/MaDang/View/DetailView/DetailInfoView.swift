//
//  DetailInfoView.swift
//  MaDang
//
//  Created by LDW on 8/16/24.
//

import SwiftUI

struct DetailInfoView: View {
    var body: some View {
            VStack(alignment: .leading) {
                Image("kopisTestImage")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: .infinity) // 화면 너비에 맞추기
                                    .background(.nineBlack)
                
                Text("A Store Selling Time")
                    .fontWeight(.bold)
                    .font(.system(size: 28))
                    .foregroundStyle(.white)
                    .padding(.leading, 4)
                
                Text("Location")
                    .font(.system(size: 14))
                    .foregroundColor(.nineYellow)
                    .padding(.vertical, 2)
                    .padding(.horizontal, 10)
                    .background(Color.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 18.5)
                            .stroke(.nineYellow, lineWidth: 2)
                    )
                
                Text("Bupyeong Arts Center Dalnuri Theater")
                    .font(.system(size: 14))
                    .foregroundStyle(.white)
                    .padding(.leading, 10)
                
                Rectangle()
                    .foregroundStyle(.gray)
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 5)
                    .padding(.bottom, 8)

                Text("Period")
                    .font(.system(size: 14))
                    .foregroundColor(.nineYellow)
                    .padding(.vertical, 2)
                    .padding(.horizontal, 10)
                    .background(Color.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 18.5)
                            .stroke(.nineYellow, lineWidth: 2)
                    )
                
                Text("Oct. 4, 2024(Fri.) ~ Oct. 19, 2024(Sat.)")
                    .font(.system(size: 14))
                    .foregroundStyle(.white)
                    .padding(.leading, 10)
                
                Rectangle()
                    .foregroundStyle(.gray)
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 5)
                    .padding(.bottom, 8)
                
                Text("Time")
                    .font(.system(size: 14))
                    .foregroundColor(.nineYellow)
                    .padding(.vertical, 2)
                    .padding(.horizontal, 10)
                    .background(Color.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 18.5)
                            .stroke(.nineYellow, lineWidth: 2)
                    )
                
                Text("Fri. 19:30 / Sat. 18:00")
                    .font(.system(size: 14))
                    .foregroundStyle(.white)
                    .padding(.leading, 10)
                
                Rectangle()
                    .foregroundStyle(.gray)
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 5)
                    .padding(.bottom, 8)
                
                Text("Age")
                    .font(.system(size: 14))
                    .foregroundColor(.nineYellow)
                    .padding(.vertical, 2)
                    .padding(.horizontal, 10)
                    .background(Color.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 18.5)
                            .stroke(.nineYellow, lineWidth: 2)
                    )
                
                Text("Suitable for ages 7 and older")
                    .font(.system(size: 14))
                    .foregroundStyle(.white)
                    .padding(.leading, 10)
                
                Rectangle()
                    .foregroundStyle(.gray)
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 5)
                    .padding(.bottom, 8)
                
                Text("Price")
                    .font(.system(size: 14))
                    .foregroundColor(.nineYellow)
                    .padding(.vertical, 2)
                    .padding(.horizontal, 10)
                    .background(Color.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 18.5)
                            .stroke(.nineYellow, lineWidth: 2)
                    )
                
                Text("All seats ₩30,000 / $21.99")
                    .font(.system(size: 14))
                    .foregroundStyle(.white)
                    .padding(.leading, 10)
            }
            .padding(.horizontal, 6)
            .background(.black)
        }
}



#Preview {
    DetailInfoView()
}
