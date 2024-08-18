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
        currentValue = ""
        
        if elementName == "db" {
            currentDB = DB(mt20id: "", prfnm: "", prfpdfrom: "", prfpdto: "", fcltynm: "", poster: "", area: "", genrenm: "", openrun: "", prfstate: "")
        }
    }
    
    // XMLParserDelegate 메서드 중 태그의 텍스트를 만났을 때 호출되는 메서드
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        currentValue += string.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    // XMLParserDelegate 메서드 중 종료 태그를 만났을 때 호출되는 메서드
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        guard let currentDB = currentDB else { return }
        switch elementName {
        case "mt20id":
            self.currentDB?.mt20id = currentValue
        case "prfnm":
            self.currentDB?.prfnm = currentValue
        case "prfpdfrom":
            self.currentDB?.prfpdfrom = currentValue
        case "prfpdto":
            self.currentDB?.prfpdto = currentValue
        case "fcltynm":
            self.currentDB?.fcltynm = currentValue
        case "poster":
            self.currentDB?.poster = currentValue
        case "area":
            self.currentDB?.area = currentValue
        case "genrenm":
            self.currentDB?.genrenm = currentValue
        case "openrun":
            self.currentDB?.openrun = currentValue
        case "prfstate":
            self.currentDB?.prfstate = currentValue
        case "db":
            dbList.append(currentDB)

            self.currentDB = nil
        case "script":
            script = currentValue
        default:
            break
        }
        
        currentValue = ""
    }
    
    // 파싱이 완료되었을 때 호출되는 메서드 (테스트용)
    func parserDidEndDocument(_ parser: XMLParser) {
        let dbs = Dbs(script: script, db: dbList)
        welcome4 = Welcome4(dbs: dbs)
    
        if let welcome4 = welcome4 {
            print("script: \(welcome4.dbs.script)")
            print("=========================")
            for db in welcome4.dbs.db {
                print("=========================")
                print("mt20id: \(db.mt20id)")
                print("prfnm: \(db.prfnm)")
                print("prfpdfrom: \(db.prfpdfrom)")
                print("prfpdto: \(db.prfpdto)")
                print("fcltynm: \(db.fcltynm)")
                print("poster: \(db.poster)")
                print("area: \(db.area)")
                print("genrenm: \(db.genrenm)")
                print("openrun: \(db.openrun)")
                print("prfstate: \(db.prfstate)")
                print("=========================")
            }
            print("=========================")
        }
    }
    
    // 파싱된 데이터를 반환하는 메서드
    func getParsedData() -> Welcome4? {
        return welcome4
    }
}
