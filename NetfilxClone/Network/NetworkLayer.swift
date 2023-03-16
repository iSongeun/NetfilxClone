//
//  NetworkLayer.swift
//  NetfilxClone
//
//  Created by 이송은 on 2023/03/15.
//

import Foundation
import UIKit

class NetworkLayer {
    class func request(urlstring : String, completion : @escaping (UIImage?) -> Void){
        guard let url = URL(string: urlstring) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let hasData = data else{
                return
            }
            let image = UIImage(data: hasData)
            completion(image)
        }.resume()
        
    }
    static func request(type : MediaType,completion : @escaping (MovieModel) -> Void){
        let term = URLQueryItem(name: "term", value: type.queryValue)
        let media = URLQueryItem(name: "media", value: type.queryValue)
        
        let querys = [term, media]
        
        var components = URLComponents(string: "https://itunes.apple.com/search")
        components?.queryItems = querys
        guard let hasURL = components?.url else {
            return
        }
        
        URLSession.shared.dataTask(with: hasURL) { data, response, error in
         
            if let hasData = data {
                do{
                    let movieModel = try JSONDecoder().decode(MovieModel.self, from: hasData)
                    completion(movieModel)
                }
                catch {
                    print(error)
                }
            }
             
            
        }.resume()
    }
}

/*
 typeMismatch(Swift.Double, Swift.DecodingError.Context(codingPath: [CodingKeys(stringValue: "results", intValue: nil), _JSONKey(stringValue: "Index 0", intValue: 0), CodingKeys(stringValue: "releaseDate", intValue: nil)], debugDescription: "Expected to decode Double but found a string/data instead.", underlyingError: nil))
 */
