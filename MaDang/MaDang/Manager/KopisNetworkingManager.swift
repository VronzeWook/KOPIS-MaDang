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
    
    typealias PerformListNetworkCompletion = (Result<[DB], NetworkError>) -> Void
    
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
            if let db = self.parsePerformListXML(safeData) {
                completion(.success(db))
            } else {
                completion(.failure(.parseError))
            }
        }
        task.resume()
    }
    
    // MARK: - MyXMLParser 객체를 이용해서 XML 파싱
    private func parsePerformListXML(_ performData: Data) -> [DB]? {
        let parser = XMLParser(data: performData)
        let myParser = MyXMLParser()
        parser.delegate = myParser
        
        if parser.parse() {
            if let parsedData = myParser.getParsedData() {
                return parsedData.dbs.db // 파싱된 DB 배열을 반환
            }
            
            // 여기서 DTO -> entity 변환
            // 그리고 [DB]?가 아닌 [Performance]?를 반환하도록
        }
        
        return nil
    }
}
