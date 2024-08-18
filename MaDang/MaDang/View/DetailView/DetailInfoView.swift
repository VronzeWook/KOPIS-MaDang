//
//  DetailInfoView.swift
//  MaDang
//
//  Created by LDW on 8/16/24.
//

import SwiftUI

struct DetailInfoView: View {
    @Binding var perform: Performance
    
    var body: some View {
            VStack(alignment: .leading) {
                
                let url = perform.posterUrlList.isEmpty ? "" : perform.posterUrlList[0]
                
                AsyncImage(url: URL(string: url)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                } placeholder: {
                    Color.gray
                }
                
                
                Text("\(perform.title)")
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
                
                Text("\(perform.area)")
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
                
                Text("\(perform.startDate) ~ \(perform.endDate)")
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
                
                Text("\(perform.showtime)")
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
                
                Text("\(perform.ageLimit)")
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
                
                Text("삭제 예정")
                    .font(.system(size: 14))
                    .foregroundStyle(.white)
                    .padding(.leading, 10)
            }
            .padding(.horizontal, 6)
            .background(.black)
        }
}



#Preview {
    DetailInfoView(perform: .constant(Performance.performList[0]))
}
