//
//  KopisNetworkingManager.swift
//  MaDang
//
//  Created by LDW on 8/18/24.
//

import Foundation

//MARK: - 네트워크에서 발생할 수 있는 에러
enum NetworkError: Error {
    case networkingError
    case dataError
    case parseError
}

//MARK: - Networking, 서버와 통신하는 클래스 모델
final class KopisNetworkingManager {
    
    static let shared = KopisNetworkingManager()
    
    private var currentElement: String?
    private var currentDB: DB?
    private var dbList: [DB] = []
    private var script: String = ""
    private var currentValue: String = ""
    private var welcome4: Welcome4?
    
    private init() {}
    
    typealias PerformListNetworkCompletion = (Result<[Performance], NetworkError>) -> Void
    typealias PerformNetworkCompletion = (Result<Performance, NetworkError>) -> Void
    
    // Date 변환을 위한 DateFormatter 설정
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    // MARK: - PerfromList 요청
    // MARK: - URL 생성 후 request 실행
    func fetchPerformList(startDate: String, endDate: String, row: Int, genreCode: String, completion: @escaping PerformListNetworkCompletion) {
        guard let key = Bundle.main.apiKey else {
            print("No KOPIS_API_KEY")
            return
        }
        
        let urlString = "\(PerformList.requestUrl)\(PerformList.service)=\(key)&\(PerformList.stdate)=\(startDate)&\(PerformList.eddate)=\(endDate)&cpage=1&\(PerformList.rows)=\(row)&\(PerformList.shcate)=\(genreCode)&\(PerformList.newsql)=Y"
   
        print("\(urlString)")
        
        performPerformListRequest(with: urlString) { result in
            completion(result)
        }
    }
    
    // MARK: - URLSession을 이용해 request 후 XML parsing
    func performPerformListRequest(with urlString: String, completion: @escaping PerformListNetworkCompletion) {
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        // Networking task (비동기 처리)
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!)
                completion(.failure(.networkingError))
                return
            }
            
            // response data 옵셔널 바인딩
            guard let safeData = data else {
                completion(.failure(.dataError))
                return
            }
            
            //XML parsing
//            if let performs = self.parsePerformXML(safeData) {
//                completion(.success(performs))
//            } else {
//                completion(.failure(.parseError))
//            }
        }
        task.resume()
    }
    
    // MARK: - MyXMLParser 객체를 이용해서 XML 파싱
    private func parsePerformListXML(_ performData: Data) -> Performance? {
        var dbs: [DB] = []
        let parser = XMLParser(data: performData)
        let myParser = MyXMLParser()
        parser.delegate = myParser
        
        if parser.parse() {
            if let parsedData = myParser.getParsedData() {
                dbs = parsedData.dbs.db // 파싱된 DB 배열을 반환
            }
            
            // 여기서 DTO -> entity 변환
            // 그리고 [DB]?가 아닌 [Performance]?를 반환하도록
//            if let performs = convertDBArrayToPerformanceArray(dbs) {
//                return performs
//            }
        }
        return nil
    }
    
    // MARK: - 하나의 공연에 대해 요청
    // MARK: - URL 생성 후 request 실행
    func fetchPerform(id: String, completion: @escaping PerformNetworkCompletion) {
        guard let key = Bundle.main.apiKey else {
            print("No KOPIS_API_KEY")
            return
        }
        
        let urlString = "\(PerformList.requestUrl)/\(id)\(PerformList.service)=\(key)&\(PerformList.newsql)=Y"
   
        print("\(urlString)")
        
        performPerformRequest(with: urlString) { result in
            completion(result)
        }
    }
    
    // MARK: - URLSession을 이용해 request 후 XML parsing
    func performPerformRequest(with urlString: String, completion: @escaping PerformNetworkCompletion) {
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        // Networking task (비동기 처리)
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!)
                completion(.failure(.networkingError))
                return
            }
            
            // response data 옵셔널 바인딩
            guard let safeData = data else {
                completion(.failure(.dataError))
                return
            }
            
            //XML parsing
            if let performs = self.parsePerformXML(safeData) {
                completion(.success(performs))
            } else {
                completion(.failure(.parseError))
            }
        }
        task.resume()
    }
    
    // MARK: - MyXMLParser 객체를 이용해서 XML 파싱
    private func parsePerformXML(_ performData: Data) -> Performance? {
        var detailDB: DetailDB?
        let parser = XMLParser(data: performData)
        let myParser = DetailXMLParser()
        parser.delegate = myParser
        
        if parser.parse() {
            if let parsedData = myParser.getParsedData() {
                detailDB = parsedData // 파싱된 DB 배열을 반환
            }
            
            // 여기서 DTO -> entity 변환
            // 그리고 [DB]?가 아닌 [Performance]?를 반환하도록
            if let perform = convertDetailDBtoPerformance(detailDB) {
                return perform
            }
        }
        return nil
    }
}

extension KopisNetworkingManager {
    func convertStringToDate(_ dateString: String) -> Date {
        return dateFormatter.date(from: dateString) ?? Date() // 기본 값은 현재 날짜
    }
    
    func findGenre(from genrenm: String) -> Genre {
        return Genre(rawValue: genrenm) ?? .All
    }
    
    // [DB]? 배열을 [Performance]? 배열로 변환하는 함수
    func convertDBArrayToPerformanceArray(_ dbArray: [DB]?) -> [Performance]? {
        guard let dbArray = dbArray else { return nil }
        
        let performances: [Performance] = dbArray.map { db in
            return Performance(
                id: db.mt20id,
                title: db.prfnm,
                genre: findGenre(from: db.genrenm), // DB의 genrenm 값을 Genre로 변환
                startDate: convertStringToDate(db.prfpdfrom),
                endDate: convertStringToDate(db.prfpdto),
                showtime: "",
                ageLimit: "",
                salesVolume: 0,
                area: db.area,
                posterUrlList: [db.poster], // 포스터 URL을 배열로 초기화
                reviewList: [], // 리뷰 목록 초기화
                actorList: [], // 배우 목록 초기화
                likeCount: 0,
                starRating: 0
            )
        }
        
        return performances
    }
    
    // MARK: - DetailDB to Performance
    func convertDetailDBtoPerformance(_ detailDB: DetailDB?) -> Performance? {
        guard let detailDB = detailDB else { return nil}
        
        return Performance(id: detailDB.id,
                           title: detailDB.title,
                           genre: findGenre(from: detailDB.genre),
                           startDate: convertStringToDate(detailDB.startDate),
                           endDate: convertStringToDate(detailDB.endDate),
                           showtime: detailDB.runtime,
                           ageLimit: detailDB.ageLimit,
                           salesVolume: 0,
                           posterUrlList: detailDB.imageUrls,
                           reviewList: [],
                           actorList: [])
    }
}
