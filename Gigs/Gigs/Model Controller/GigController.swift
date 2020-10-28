//
//  GigController.swift
//  Gigs
//
//  Created by FGT MAC on 10/28/20.
//

import Foundation


enum HTTPMEthods: String {
    case post = "POST"
}

class GigController {
    
    //MARK: - Properties
    var bearer: Bearer?
    
    private let baseURL = URL(string: "https://lambdagigapi.herokuapp.com/api")!
    
    //Use lazy because we are refering to baseURL which will not init till the class does
    private lazy var signUpURL = URL(string: "/users/signup", relativeTo: baseURL)!
    
    func signUp(user:User,completion: @escaping (Error?) -> (Void))  {
        
        //1.Build the URL
        var request = URLRequest(url: signUpURL )
        
        //2.Request type
        request.httpMethod = HTTPMEthods.post.rawValue
        
        //3.Set the headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //4.Create the content for the body
        let parameters = [
            "username": user.username,
            "password": user.password
        ]
        
        do{
            request.httpBody = try JSONEncoder().encode(parameters)
        }catch{
            print("Cannot encode JSON signup data")
            completion(nil)
        }
   
        
        URLSession.shared.dataTask(with: request) {[weak self] (data, response, error) in
            
            if let error = error {
                print("Error signing up \(error)")
                completion(error)
                return
            }
            
            
            guard let self = self else {
                print("Self error in data task")
                return
            }
            
            //Check the response code
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
            }
            
            guard let data = data else {
                print("No data in the response")
                completion(nil)
                 return
            }
            
            
            do{
                let barrerRequest = try JSONDecoder().decode(Bearer.self, from: data)
                self.bearer = barrerRequest
            }catch{
                print("Error decoding data \(error)")
                completion(error)
            }
            
            completion(nil)
            
        }.resume()
    }
}
