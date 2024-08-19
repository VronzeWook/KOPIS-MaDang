//
//  DetailTouristInfoView.swift
//  MaDang
//
//  Created by LDW on 8/16/24.
//
import SwiftUI

struct DetailTouristInfoView: View {
    
    @State private var infoList: [TouristInfo] = TouristInfo.infoList
    @State private var selection: Int = 0
    
    var body: some View {
        let filteredInfoList = infoList.filter { info in
            if selection == 0 { return true }
            switch info.type {
            case .cafe :
                if selection == 1 {return true}
            case .restaurant :
                if selection == 2 {return true}
            case .touristSpot :
                if selection == 3 {return true}
            }
            return false
        }
        
        VStack {
            HStack {
                Text("Tourist Information")
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                
                Spacer()
            }
            
            touristInfoSegmentedView(selection: $selection)
            
            TabView {
                // 리스트를 4개로 쪼개서 전달
                let split = Array(filteredInfoList.prefix(4))
                
                ForEach(0..<3) { index in
                    TouristInfoGridView(infos: split)
                        .offset(y: -20)
                }

            }
            .frame(height: 530)
            //.border(.blue)
            .tabViewStyle(PageTabViewStyle())
        }
        .background(.nineBlack)
    }
}

extension DetailTouristInfoView {
    private struct touristInfoSegmentedView: View {
        
        @Binding var selection: Int
        
        var body: some View {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    Button(action: {
                        selection = 0
                    }, label: {
                        Text("All")
                            .font(.system(size: 16))
                            .foregroundStyle(selection == 0 ? .nineBlack : .white)
                            .padding(.horizontal, 32)
                            .padding(.vertical, 8)
                            .background(selection == 0 ? .nineYellow : .nineDarkGray)
                            .cornerRadius(55)
                    })
                    
                    Button(action: {
                        selection = 1
                    }, label: {
                        HStack {
                            Image(systemName: "camera.fill")
                                .font(.system(size: 16))
                                .foregroundStyle(selection == 1 ? .nineBlack : .white)
                            
                            Text("The sights")
                                .font(.system(size: 16))
                                .foregroundStyle(selection == 1 ? .nineBlack : .white)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(selection == 1 ? .nineYellow : .nineDarkGray)
                        .cornerRadius(55)
                    })
                    
                    Button(action: {
                        selection = 2
                    }, label: {
                        HStack {
                            Image(systemName: "fork.knife.circle.fill")
                                .font(.system(size: 16))
                                .foregroundStyle(selection == 2 ? .nineBlack : .white)
                            
                            Text("Restaurants")
                                .font(.system(size: 16))
                                .foregroundStyle(selection == 2 ? .nineBlack : .white)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(selection == 2 ? .nineYellow : .nineDarkGray)
                        .cornerRadius(55)
                    })
                    
                    Button(action: {
                        selection = 3
                    }, label: {
                        HStack {
                            Image(systemName: "cup.and.saucer.fill")
                                .font(.system(size: 16))
                                .foregroundStyle(selection == 3 ? .nineBlack : .white)
                            
                            Text("Cafes")
                                .font(.system(size: 16))
                                .foregroundStyle(selection == 3 ? .nineBlack : .white)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(selection == 3 ? .nineYellow : .nineDarkGray)
                        .cornerRadius(55)
                    })
                }
            }

            .padding(.vertical, 16)
        }
    }
}


#Preview {
    DetailTouristInfoView()
}
