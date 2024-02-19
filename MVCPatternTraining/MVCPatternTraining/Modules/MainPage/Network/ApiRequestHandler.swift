//
//  ApiRequestHandler.swift
//  MVCPatternTraining
//
//  Created by NewMac on 8/9/21.
//

import Foundation

enum TolgaError: Error {
    case no1
    case no2
    case no3
    case no4
}

class ApiRequestHandler {
    
    static func request(completion: @escaping (Result<[User],Error>) -> Void) {
        if let url = URL.init(string: "https://jsonplaceholder.typicode.com/users") {
            var urlRequest = URLRequest.init(url: url)
            
            urlRequest.httpMethod = "GET"
  
            let session = URLSession(configuration: URLSessionConfiguration.default)
            
            let task = session.dataTask(with: urlRequest) { responseData, response, error in
                
                if error == nil && response != nil {
                    
                    if let res = response as? HTTPURLResponse {
                        
                        if res.statusCode == 200 {
                            
                            do {
                                let result = try JSONDecoder().decode([User].self, from: responseData!)
                                completion(.success(result))
                            } catch let error {
                                completion(.failure(TolgaError.no1))
                                print(error.localizedDescription)
                            }
                        } else {
                            completion(.failure(TolgaError.no2))
                        }
                    } else {
                        completion(.failure(TolgaError.no3))
                    }
                } else {
                    completion(.failure(TolgaError.no4))
                }
            }.resume()
        }
        
    }
}
