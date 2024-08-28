//
//  CommunityList.swift
//  MaDang
//
//  Created by 추서연 on 8/20/24.
//

import SwiftUI

struct CommunityList: View {
    
    var body: some View {
        NavigationStack{
            VStack {
                
                
                HStack {
                    Text("Community")
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    Spacer()
                }
                VStack{
                    
                    NavigationLink {
                        FAQView()
                    } label: {
                        
                        HStack{
                            Image(systemName: "questionmark.square")
                                .font(.system(size: 18))
                                .fontWeight(.medium)
                                .foregroundStyle(.white)
                            Text("FAQ")
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
                    
                                    HStack{
                                        Image(systemName: "doc.text")
                                            .font(.system(size: 18))
                                            .fontWeight(.medium)
                                            .foregroundStyle(.white)
                                        Text("Report record")
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
                    //
                    Divider()
                        .background(Color.gray)
                        .padding(.vertical,4)
                    
                    NavigationLink {
                        AboutUsView()
                    } label: {
                        HStack{
                            Image(systemName: "face.smiling")
                                .font(.system(size: 18))
                                .fontWeight(.medium)
                                .foregroundStyle(.white)
                            Text("About us")
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
    CommunityList()
}
