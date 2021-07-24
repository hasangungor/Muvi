//
//  MuviService.swift
//  Muvi
//
//  Created by HasanEkmob on 19.07.2021.
//

import Foundation
import Alamofire

class MuviService {
    
    private var apiKey: String {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else { return "" }
        return key
    }
    static let shared = MuviService()
    private init() {}
}
