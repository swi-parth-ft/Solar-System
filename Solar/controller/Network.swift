//
//  Network.swift
//  Solar
//
//  Created by Parth Antala on 2022-03-31.
//

import Foundation
class Network {

    static var Shared = Network()
 
   
    func getImagesDataFromURL(completionHandler : @escaping (Result <BodyCollection, Error>)->Void )  {
        
        let url = "https://api.le-systeme-solaire.net/rest/bodies/"
        
        let urlObj = URL(string: url)!
           
        let task = URLSession.shared.dataTask(with: urlObj)
            { data, response, error in
                   guard error == nil else {
                       completionHandler(.failure(error!))
                       return
                   }
                   guard let httpRespons = response as? HTTPURLResponse, (200...299).contains(httpRespons.statusCode) else {
                       print ("Incorrect response ")
                                              return
                   }
                   
        if let jsonData = data {
                           print("jason \(jsonData)")
            let decoder =  JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
                       do {
                           let result = try decoder.decode(BodyCollection.self, from: jsonData)
                           completionHandler(.success(result))
                       }
                       catch {
                           print ("error \(error)")
                       }
                   }
               }
               task.resume()
    }
}
