//
//  DetailReviewView.swift
//  MaDang
//
//  Created by LDW on 8/16/24.
//

import SwiftUI

struct DetailReviewView: View {
    @Binding var perform: Performance
    
    var body: some View {
        VStack{
            HStack {
                Text("Reviews")
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    
                Spacer()
                
                NavigationLink {
                    ReviewEditorView()
                } label: {
                    HStack {
                        Image(systemName: "text.bubble.fill")
                            .foregroundStyle(.nineYellow)
                        Text("Write")
                            .font(.system(size: 14))
                            .foregroundStyle(.nineYellow)
                    }
                }
                
            }
            
            SegmentedCountryView()
            
            ReviewPostView()
            ReviewPostView()
            ReviewPostView()
            
            Rectangle()
                .foregroundStyle(.gray)
                .frame(height: 1)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 5)
                .padding(.top, 40)
        }
        .background(.black)
        
        
    }
    
    private struct ReviewPostView: View {
        
        let rating = 3.5
        let text = "It was truly an amazing experience. I was amazed at the thoughtfulness they showed towards the audience, and I was able to have a great time with my family."
        @State private var likeCount = 16
        @State private var isLike = false
        
        
        var body: some View {
            VStack {
                HStack {
                    Image(systemName: "person.crop.circle.fill")
                        .foregroundStyle(.white)
                        
                    Text("Ashley 🇺🇸")
                        .foregroundStyle(.white)
                        .font(.system(size: 14))
                        .fontWeight(.bold)
                        
                    
                    Spacer()
                }
                .padding(.bottom, 8)
                
                HStack{
                    StarRatingView(rating: rating)
                    Spacer()
                    Text("2024-10-18")
                        .font(.system(size: 12))
                        .foregroundStyle(.gray)
                }
                .padding(.bottom, 8)
                
                ExpandableTextView(text: text)
                .padding(.bottom, 16)
                
                HStack {
                    Button(action: {
                        if isLike {
                            likeCount -= 1
                        } else {
                            likeCount += 1
                        }
                        
                        isLike.toggle()
                    }, label: {
                        HStack(spacing: 2) {
                            Image(systemName: isLike ? "hand.thumbsup.fill" : "hand.thumbsup")
                                .foregroundStyle(.nineYellow)
                            Text("\(likeCount)")
                                .foregroundStyle(.nineYellow)
                                .font(.system(size: 14))
                        }
                    })

                    Spacer()
                    
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "ellipsis")
                            .foregroundStyle(.gray)
                    })
                }
                
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16) // 둥근 사각형 배경 추가
                    .fill(.nineDarkGray) // 배경 색상 설정
            )
            
        }
        
    }
    
    
    private struct StarRatingView: View {
        var rating: Double
        
        var body: some View {
            HStack(spacing: 1) {
                ForEach(0..<5) { index in
                    self.starType(for: index)
                        .foregroundColor(.nineYellow)
                }
                
                Text(String(format: "%.1f", rating))
                    .font(.system(size: 14))
                    .foregroundStyle(.nineYellow)
            }
        }
        
        func starType(for index: Int) -> Image {
            let starValue = Double(index) + 1
            
            if rating >= starValue {
                return Image(systemName: "star.fill")
            } else if rating >= starValue - 0.5 {
                return Image(systemName: "star.leadinghalf.filled")
            } else {
                return Image(systemName: "star")
            }
        }
    }
    
    
    private struct ExpandableTextView: View {
        let text: String
        @State private var isExpanded: Bool = false
        
        var body: some View {
            VStack(alignment: .leading) {
                Text(text)
                    .font(.body)
                    .lineLimit(isExpanded ? nil : 2)
                    .foregroundColor(.white)
                    .onTapGesture {
                        withAnimation {
                            isExpanded.toggle()
                        }
                    }
            }
        }
    }

    private struct SegmentedCountryView: View {
        
        @State private var selection = 0
        
        var body: some View {
            
            ScrollView(.horizontal) {
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
                        Text("🇺🇸 USA")
                            .font(.system(size: 16))
                            .foregroundStyle(selection == 1 ? .nineBlack : .white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(selection == 1 ? .nineYellow : .nineDarkGray)
                            .cornerRadius(55)
                    })
                    
                    Button(action: {
                        selection = 2
                    }, label: {
                        Text("🇨🇳 CHN")
                            .font(.system(size: 16))
                            .foregroundStyle(selection == 2 ? .nineBlack : .white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(selection == 2 ? .nineYellow : .nineDarkGray)
                            .cornerRadius(55)
                    })
                    
                    Button(action: {
                        selection = 3
                    }, label: {
                        Text("🇯🇵 JAN")
                            .font(.system(size: 16))
                            .foregroundStyle(selection == 3 ? .nineBlack : .white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(selection == 3 ? .nineYellow : .nineDarkGray)
                            .cornerRadius(55)                    })
                    
                }
            }
            .padding(.vertical, 16)
        }
        
    }
}

#Preview {
    DetailReviewView(perform: .constant(Performance.performList[0]))
}
