//
//  Networking.swift
//  Kotob
//
//  Created by Mokhtar on 9/19/18.
//  Copyright © 2018 Mokhtar. All rights reserved.
//

import Foundation

class HindawiAPI {
    
    class func getMostRecent(urlString: String, completionHandler: ((BooksCategory) -> ())?) {
        guard let url = URL(string: urlString) else { return }
        let session = URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data, err == nil else { return }
            do {
                let bookCategory = try JSONDecoder().decode(BooksCategory.self, from: data)
                completionHandler?(bookCategory)
                
            } catch {
                print("error parsing JSON from most recent API")
            }
        }
        session.resume()
    }
    
    class func postBody<T: Codable> (to url : URL, of jsonDict : Any, completionHandler: @escaping ((T)->()))  {
        
        var httpRequest = URLRequest(url: url)
        httpRequest.httpMethod = "POST"
        httpRequest.setValue("application/json;charset=UTF-8", forHTTPHeaderField: "content-type")
        httpRequest.setValue("application/json", forHTTPHeaderField: "accept")
        
        
        if JSONSerialization.isValidJSONObject(jsonDict) {
            print("serialization")
            let data = try? JSONSerialization.data(withJSONObject: jsonDict, options: [])
            httpRequest.httpBody = data
        } else {
            print("can't serialize JSON dict")
        }
        
        
        let session = URLSession.shared.dataTask(with: httpRequest) { (data, response, err) in
            if err != nil {
                print(err ?? "")
                return
            }
            
            guard let data = data else { return }
            
            let json = JSONDecoder()
            
            do {
                
                let loginResponse = try json.decode(T.self, from: data)
                
                completionHandler(loginResponse)
                
                
            } catch let jsonDecoderErr {
                print("Error Decoding JSON from login Data", jsonDecoderErr)
            }
        }
        session.resume()
    }
}

