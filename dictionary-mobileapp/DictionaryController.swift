//
//  DictionaryController.swift
//  dictionary-mobileapp
//
//  Created by Maksim Zlatkin on 11/15/22.
//

import Foundation

public func getData(from url : String) -> [String]?{
    var value : [String]?
    
    print("fetching data")
    URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error in
        guard let data = data, error == nil else {
            print("Error")
            value = []
            return
        }
        
        var result: Response?
        do{
            result = try JSONDecoder().decode(Response.self, from: data).self
        }
        catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        }
        catch{
            print("conversion failed \(error)")
            print(error.localizedDescription)
        }

        guard let json = result else{
            return
        }
        print("reached the end")
        print(json)
        value = json.definitions
        if (value == nil){
            value = []
        }
    }).resume()
    
    while(value == nil){
        //ASYNC???? AWAIT????
    }
    return value
}

struct Response: Codable{
    let definitions: [String]?
    let status: String?
}
