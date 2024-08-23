//
//  WhatIsNewView.swift
//  MaDang
//
//  Created by LDW on 8/17/24.
//

import SwiftUI

struct WhatIsNewView: View {
    @State private var currentIndex: Int = 0
    @Binding var performs: [Performance]
    
    var body: some View {
        let recentPerforms = Array(performs.sorted { $0.startDate > $1.startDate }.prefix(4))
    
        VStack{
            HStack{
                Text("What's new")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                
                Spacer()
            }
            
            CarouselView(currentIndex: $currentIndex, performs: $performs, pageCount: recentPerforms.count)
                .frame(height: UIScreen.main.bounds.height * 3/5)
                .padding(.bottom, 10)
            
            
            PageIndicator(currentIndex: $currentIndex, pageCount: 4)
        }

        .background(.nineBlack)
        .border(.yellow)
    }
}

fileprivate struct CarouselView: View {

    @GestureState var dragOffset: CGFloat = 0
    @Binding var currentIndex: Int
    @Binding var performs: [Performance]
    @State private var isDetailViewPresented: Bool = false
    @State private var selectedPerform: Performance = Performance.performList[0]

    /// pageCount는 1 이상입니다.
    let pageCount: Int
    let spacing: CGFloat = 0
    let visibleEdgeSpace: CGFloat = 20

    var body: some View {
        let filtered = Array(performs.prefix(4))

        GeometryReader { proxy in

            /// 첫번째 요소의 왼쪽 여백입니다.
            let baseOffset: CGFloat = spacing + visibleEdgeSpace

            /// 티켓 하나 width를 나타냅니다.
            let pageWidth: CGFloat = proxy.size.width - (visibleEdgeSpace + spacing) * 2

            /// HStack에서 보여질 곳을 정합니다.
            let offsetX: CGFloat = baseOffset + CGFloat(currentIndex) * -pageWidth + CGFloat(currentIndex) * -spacing + dragOffset

            HStack(spacing: spacing) {
                ForEach(0..<pageCount, id: \.self) { index in
                    let url = performs[index].posterUrlList.isEmpty ? "" : performs[index].posterUrlList[0]
                    // 이미지 추출 및 번역 프로세스
                    //                    //  URL로부터  UIImage 생성하기
                    //                    if let imageUrl = URL(string: url), let imageData = try? Data(contentsOf: imageUrl), let image = UIImage(data: imageData) {
                    //                        ImageWithOverlayView(image: image)
                    //                            .frame(width: pageWidth)
                    //                            .scaleEffect(scaleFor(index: index, pageWidth: pageWidth))
                    //                            .onTapGesture {
                    //                                selectedPerform = performs[index]
                    //                                isDetailViewPresented = true
                    //                            }
                    //                    } else {
                    //                        // place holder
                    //                        Text("No image")
                    //                            .frame(width: pageWidth)
                    //                    }
                    
                    
                    VStack {
                        AsyncImage(url: URL(string: url)) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: pageWidth)
                        .scaleEffect(scaleFor(index: index, pageWidth: pageWidth))
                        .onTapGesture {
                            selectedPerform = performs[index]
                            isDetailViewPresented = true
                        }
                    }
                    .frame(width: pageWidth)
                }
                .contentShape(RoundedRectangle(cornerRadius: 20))
            }
            .border(Color.red, width: 2)
            /// offset을 통해 보이는 곳을 옮깁니다.
            .offset(x: offsetX)
            .gesture(
                DragGesture()
                    .updating($dragOffset) { value, out, _ in
                        out = value.translation.width
                    }
                    .onEnded { value in
                        let offsetX = value.translation.width
                        let progress = -offsetX / pageWidth
                        let increment = Int(progress.rounded())

                        currentIndex = max(min(currentIndex + increment, pageCount - 1), 0)
                    }
            )
            /// dragOffset이 0이 되면 다음 페이지로 넘어갑니다.
            .animation(.easeInOut, value: dragOffset == 0)
        }
        .border(Color.blue)
        .sheet(isPresented: $isDetailViewPresented) {
                DetailView(perform: $selectedPerform)
//                DetailView(perform: Binding(get: { selectedPerform }, set: { _ in }))
            
        }
    }

    private func scaleFor(index: Int, pageWidth: CGFloat) -> CGFloat {
        let offset = CGFloat(index - currentIndex) * pageWidth + dragOffset
        let distanceFromCenter = abs(offset) / pageWidth
        return max(0.8, 1 - distanceFromCenter * 0.1)
    }
}

struct PageIndicator: View {
    @Binding var currentIndex: Int
    let pageCount: Int
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<pageCount, id: \.self) { index in
                Circle()
                    .fill(index == currentIndex ? Color.nineYellow : Color.nineDarkGray)
                    .frame(width: 8, height: 8)
            }
        }
    }
}

#Preview {
    WhatIsNewView(performs: .constant(Performance.performList))
}

