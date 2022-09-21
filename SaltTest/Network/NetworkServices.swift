//
//  NetworkServices.swift
//  SaltTest
//
//  Created by Phincon on 20/09/22.
//

import Foundation
import UIKit
import Alamofire

class NetworkServices {
    
    static let instance = NetworkServices()
    
    func getServiceData<T: Codable> (url: String, method: HTTPMethod, parameters: [String:Any], encodingType: ParameterEncoding, headers: [String:String], completion: @escaping (T?, String?) ->()) {
        
        Alamofire.request(url, method: method, parameters: parameters, encoding: encodingType, headers: headers).validate(statusCode: 200...300).responseJSON { (response) in
            
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                do {
                    let jsonData = try JSONDecoder().decode(T.self, from: data)
                    completion(jsonData, nil)
                } catch let error {
                    completion(nil, error.localizedDescription)
                }
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
    
}
