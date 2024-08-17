//
//  XMLParser.swift
//  MaDang
//
//  Created by LDW on 8/18/24.
//

import Foundation

final class MyXMLParser: NSObject, XMLParserDelegate {
    private var currentElement: String?
    private var currentDB: DB?
    private var dbList: [DB] = []
    private var script: String = ""
    private var currentValue: String = ""
    
    private var welcome4: Welcome4?
    
    // XMLParserDelegate 메서드 중 시작 태그를 만났을 때 호출되는 메서드
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        
        if elementName == "db" {
            currentDB = DB(mt20ID: "", prfnm: "", prfpdfrom: "", prfpdto: "", fcltynm: "", poster: "", area: "", genrenm: "", openrun: "", prfstate: "")
        }
    }
    
    // XMLParserDelegate 메서드 중 태그의 텍스트를 만났을 때 호출되는 메서드
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        currentValue = string.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    // XMLParserDelegate 메서드 중 종료 태그를 만났을 때 호출되는 메서드
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if var currentDB = currentDB {
            switch elementName {
            case "mt20id":
                currentDB.mt20ID = currentValue
            case "prfnm":
                currentDB.prfnm = currentValue
            case "prfpdfrom":
                currentDB.prfpdfrom = currentValue
            case "prfpdto":
                currentDB.prfpdto = currentValue
            case "fcltynm":
                currentDB.fcltynm = currentValue
            case "poster":
                currentDB.poster = currentValue
            case "area":
                currentDB.area = currentValue
            case "genrenm":
                currentDB.genrenm = currentValue
            case "openrun":
                currentDB.openrun = currentValue
            case "prfstate":
                currentDB.prfstate = currentValue
            case "db":
                dbList.append(currentDB)
                self.currentDB = nil
            case "script":
                script = currentValue
            default:
                break
            }
        }
        
        currentElement = nil
    }
    
    // 파싱이 완료되었을 때 호출되는 메서드 (테스트용)
    func parserDidEndDocument(_ parser: XMLParser) {
        let dbs = Dbs(script: script, db: dbList)
        welcome4 = Welcome4(dbs: dbs)
        
        // 파싱 결과 출력 (테스트용)
        if let welcome4 = welcome4 {
            print("script: \(welcome4.dbs.script)")
            for db in welcome4.dbs.db {
                print("mt20ID: \(db.mt20ID)")
                print("prfnm: \(db.prfnm)")
                print("prfpdfrom: \(db.prfpdfrom)")
                print("prfpdto: \(db.prfpdto)")
                print("fcltynm: \(db.fcltynm)")
                print("poster: \(db.poster)")
                print("area: \(db.area)")
                print("genrenm: \(db.genrenm)")
                print("openrun: \(db.openrun)")
                print("prfstate: \(db.prfstate)")
            }
        }
    }
    
    // 파싱된 데이터를 반환하는 메서드
    func getParsedData() -> Welcome4? {
        return welcome4
    }
}
