//
//  ApiService.swift
//  MVVMArchitecture
//
//  Created by Mohannad on 15.02.2021.
//

import Foundation


class  ApiService : NSObject  {
   
     static let shared = ApiService()
    
    
    
    
    func getPhotos(completion : @escaping ([Photo]?)->())  {
        
        
        var urlComp = URLComponents(string:"\(Constants.identifiers.photosApi)")!
       
        urlComp.queryItems = [URLQueryItem(name: "page", value: "1" ),
                              URLQueryItem(name: "limit", value: "50")]
       
        var request = URLRequest(url: urlComp.url!)
        
        request.httpMethod = "Get"
       
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
         
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
            
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data , error == nil else {
                print("error while fetching feeds \(error)")
                completion(nil)
                return
            }
            
             let result = try? JSONDecoder().decode([Photo].self, from: data)
           
             completion(result)
        }
        
        task.resume()
    
    
    }
    
 
    
    
}


