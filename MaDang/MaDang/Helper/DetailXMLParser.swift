//
//  DetailXMLParser.swift
//  MaDang
//
//  Created by LDW on 8/18/24.
//

import Foundation

final class DetailXMLParser : NSObject, XMLParserDelegate {
    private var detailDB: DetailDB?
    private var currentValue: String = ""
    private var imageUrls: [String] = []
    private var relatedLinks: [DetailDbs] = []
    
    // 날짜 변환을 위한 DateFormatter
    let dateFormatter = DateFormatter()
    
    // XMLParserDelegate 메서드 중 시작 태그를 만났을 때 호출되는 메서드
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentValue = ""
        
        if elementName == "db" {
            detailDB = DetailDB(
                id: "", title: "", genre: "", startDate: "", endDate: "", venue: "",
                cast: [], crew: [], runtime: "", ageLimit: "", company: "", ticketPrice: "", posterUrl: "",
                imageUrls: [], area: "", performanceStatus: "", showtimes: "", relatedLinks: []
            )
        }
    }
    
    // XMLParserDelegate 메서드 중 태그의 텍스트를 만났을 때 호출되는 메서드
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        currentValue += string.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    // XMLParserDelegate 메서드 중 종료 태그를 만났을 때 호출되는 메서드
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        guard var detailDB = detailDB else { return }
        
        switch elementName {
        case "mt20id":
            self.detailDB?.id = currentValue
        case "prfnm":
            self.detailDB?.title = currentValue
        case "prfpdfrom":
            self.detailDB?.startDate = currentValue
        case "prfpdto":
            self.detailDB?.endDate = currentValue
        case "fcltynm":
            self.detailDB?.venue = currentValue
        case "prfcast":
            self.detailDB?.cast = currentValue.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
        case "prfcrew":
            detailDB.crew = currentValue.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
        case "prfruntime":
            self.detailDB?.runtime = currentValue
        case "prfage":
            self.detailDB?.ageLimit = currentValue
        case "entrpsnm":
            self.detailDB?.company = currentValue
        case "pcseguidance":
            self.detailDB?.ticketPrice = currentValue
        case "poster":
            self.detailDB?.posterUrl = currentValue
        case "styurl":
            imageUrls.append(currentValue)
        case "area":
            self.detailDB?.area = currentValue
        case "prfstate":
            self.detailDB?.performanceStatus = currentValue
        case "dtguidance":
            self.detailDB?.showtimes = currentValue
        case "relatenm":
            let relatedLink = DetailDbs(name: currentValue, url: "")
            relatedLinks.append(relatedLink)
        case "relateurl":
            if let lastIndex = relatedLinks.indices.last {
                relatedLinks[lastIndex].url = currentValue
            }
        case "db":
            self.detailDB?.imageUrls = imageUrls
            self.detailDB?.relatedLinks = relatedLinks
            self.detailDB = detailDB
        default:
            break
        }
        
        currentValue = ""
    }
    
    // 파싱이 완료되었을 때 호출되는 메서드 (테스트용)
    func parserDidEndDocument(_ parser: XMLParser) {
        if let detailDB = detailDB {
            print("DetailDB: \(detailDB)")
        }
    }
    
    // 파싱된 데이터를 반환하는 메서드
    func getParsedData() -> DetailDB? {
        return detailDB
    }
}
