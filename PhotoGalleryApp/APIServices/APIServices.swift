//
//  APIServices.swift
//  PhotoGalleryApp
//
//  Created by Algazzar on 04/02/2022.
//

import Foundation
import Alamofire

class APIServices {
    
    static let shared = APIServices()
    
    func fetchData<T: Decodable>(url: String, method: HTTPMethod, parameters: Parameters?, encoding: ParameterEncoding, headers: HTTPHeaders?, responseModel: T.Type, completion: @escaping (Result<T?, Error>) -> Void) {
        
        AF.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).validate(statusCode: 200...300).responseJSON { (response) in
            
            switch response.result{
                
            case.success(_):
                
                guard let data = response.data else{return}
                
                do {
                    let jsonResponse = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(jsonResponse))
                }
                catch let jsonError {
                    completion(.failure(jsonError))
                }
                
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }
}
