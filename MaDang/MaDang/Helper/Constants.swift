//
//  Constants.swift
//  MaDang
//
//  Created by LDW on 8/18/24.
//

import Foundation

public struct PerformList {
    static let requestUrl = "https://www.kopis.or.kr/openApi/restful/pblprfr"
    static let service = "?service"
    
    static let stdate = "stdate" // 공연 시작일자, 20160101
    static let eddate = "eddate" // 공연 종료일자, 20160630
    static let cpage = "cpage" // 현재 페이지, 1
    static let rows = "rows" // 페이지 당 목록 수, 10
    
    static let shcate = "shcate" // 장르 코드, AAAA
    static let signgucode = "signgucode" // 지역 코드(시도), 서울 11
    static let signgucodesub = "signgucodesub" // 지역(구군), 강남 1111
    static let shprfnm = "shprfnm" // 공연명, 사랑(URLEncoding)
    static let shprfnmfct = "shprfnmfct" // 공연시설명, 예술의 전당(URLEncoding)
    
    static let prfstate = "prfstate" // 공연 상태 코드, 상영 중 02 ??
    static let kidstate = "kidstate" // 아동 공연 여부, Y/N
    static let openrun = "openrun" // 오픈런, Y/N
    static let newsql = "newsql" // 최신 공연 순, Y/N
    
    
    private init(){}
}
