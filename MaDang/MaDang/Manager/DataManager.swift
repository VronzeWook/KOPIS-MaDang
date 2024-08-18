//
//  DataManager.swift
//  MaDang
//
//  Created by LDW on 8/18/24.
//

import Foundation


// 없는게 편할 거 같기도 ? ? 보류
final class DataManager: ObservableObject {
    
    static let shared = DataManager()
    private init() {}
    
    // 필터링을 통해서
    // - 최신 공연 4개 이미지
    // - 장르별 공연 9개 이미지 추출 후 보여주기
    @Published var performs: [Performance] = []
    
    // 뇌피셜, 인기 순위 이미지는 파이어베이스에서 정렬되서 나오니, 아에 분리하는게 나을수도 있겠다..?
    @Published var popularPerforms: [Performance] = []
    
    
    // 번역 메서드
    func translationInfo() {}
    

    
}
