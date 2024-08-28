//
//  MyActivityList.swift
//  MaDang
//
//  Created by 추서연 on 8/20/24.
//

import SwiftUI

struct MyActivityList: View {
    @EnvironmentObject var userManager: UserManager
    @Binding var performs: [Performance]
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("My activity")
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    Spacer()
                }
                
                VStack{
                    NavigationLink(destination: LikesView(performs: $performs)) {
                        HStack{
                            Image(systemName: "heart")
                                .font(.system(size: 18))
                                .fontWeight(.medium)
                                .foregroundStyle(.white)
                            Text("Likes")
                                .font(.system(size: 18))
                                .fontWeight(.medium)
                                .foregroundStyle(.white)
                            
                            Spacer()
                            
                            Image(systemName:"chevron.right")
                                .font(.system(size: 18))
                                .fontWeight(.medium)
                                .foregroundStyle(.white)
                        }
                    }
                    
                    Divider()
                        .background(Color.gray)
                        .padding(.vertical,4)
                    
                    NavigationLink(destination: MyReviewView()) {
                        HStack{
                            Image(systemName: "text.bubble")
                                .font(.system(size: 18))
                                .fontWeight(.medium)
                                .foregroundStyle(.white)
                            Text("Reviews")
                                .font(.system(size: 18))
                                .fontWeight(.medium)
                                .foregroundStyle(.white)
                            
                            Spacer()
                            
                            Image(systemName:"chevron.right")
                                .font(.system(size: 18))
                                .fontWeight(.medium)
                                .foregroundStyle(.white)
                        }
                        .padding(.vertical,4)
                    }
                    
                    Divider()
                        .background(Color.gray)
                        .padding(.vertical,4)
                    
                    
                    NavigationLink {
                        AlertSettingView()
                    } label: {
                        HStack{
                            Image(systemName: "alarm")
                                .font(.system(size: 18))
                                .fontWeight(.medium)
                                .foregroundStyle(.white)
                            Text("Alarm")
                                .font(.system(size: 18))
                                .fontWeight(.medium)
                                .foregroundStyle(.white)
                            
                            Spacer()
                            
                            Image(systemName:"chevron.right")
                                .font(.system(size: 18))
                                .fontWeight(.medium)
                                .foregroundStyle(.white)
                        }
                        
                    }
   
                }
                .padding(20)
                .background(.nineDarkGray)
                .cornerRadius(15)
                
            }
            .background(.nineBlack)
            .padding(.horizontal, 16)
        }
    }
    
    
}

#Preview {
    MyActivityList(performs: .constant([]))
}
