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
    private init() {}
    
    typealias PerformListNetworkCompletion = (Result<[Performance], NetworkError>) -> Void
    
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
    
    func performPerformListRequest(with urlString: String, completion: @escaping PerformListNetworkCompletion) {
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!)
                completion(.failure(.networkingError))
                return
            }
            
            guard let safeData = data else {
                completion(.failure(.dataError))
                return
            }
            
            print(safeData)
            
//          parsePerformListXML 메서드 실행해서, completion으로 결과를 받음

        }
        task.resume()
    }

    private func parsePerformListXML(_ performData: Data) -> [Performance]? {
     return []
    }
    
}
